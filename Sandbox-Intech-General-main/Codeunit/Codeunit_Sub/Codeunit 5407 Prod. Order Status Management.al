Codeunit 75030 "Prod Order Status Mgt Sub"
{
    //ManuChk-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", OnBeforeChangeStatusOnProdOrder, '', false, false)]
    local procedure "Prod. Order Status Management_OnBeforeChangeStatusOnProdOrder"(var ProductionOrder: Record "Production Order"; NewStatus: Option; var IsHandled: Boolean; NewPostingDate: Date; NewUpdateUnitCost: Boolean)
    var
        ManufacturingSetup_lRec: Record "Manufacturing Setup";
    begin
        ManufacturingSetup_lRec.Reset();
        ManufacturingSetup_lRec.GET();
        if ManufacturingSetup_lRec."Check Consumption Booked" then begin
            if NewStatus = 4 then begin
                CheckConsumptionBooked_lFnc(ProductionOrder)
            End;
        end;
    end;

    LOCAL PROCEDURE CheckConsumptionBooked_lFnc(ProductionOrder_iRec: Record "Production Order");
    VAR
        ProdOrderComp_lRec: Record "Prod. Order Component";
        ProdOrderLine_lRec: Record "Prod. Order Line";
        ExpectedConsumption_lDec: Decimal;
    begin
        ProdOrderComp_lRec.RESET;
        ProdOrderComp_lRec.SETCURRENTKEY(Status, "Prod. Order No.", "Prod. Order Line No.", "Item No.", "Line No.");
        ProdOrderComp_lRec.SETRANGE(Status, ProductionOrder_iRec.Status);
        ProdOrderComp_lRec.SETRANGE("Prod. Order No.", ProductionOrder_iRec."No.");
        IF ProdOrderComp_lRec.FINDSET(FALSE, FALSE) THEN BEGIN
            REPEAT
                ProdOrderLine_lRec.GET(ProdOrderComp_lRec.Status, ProdOrderComp_lRec."Prod. Order No.", ProdOrderComp_lRec."Prod. Order Line No.");
                ProdOrderComp_lRec.CALCFIELDS(ProdOrderComp_lRec."Act. Consumption (Qty)");
                ExpectedConsumption_lDec := (ProdOrderLine_lRec."Finished Quantity") * ProdOrderComp_lRec."Quantity per";
                IF ExpectedConsumption_lDec > ProdOrderComp_lRec."Act. Consumption (Qty)" THEN
                    ERROR('Production Order %1 cannot been finished. Consumption is pending for Item No. %2', ProdOrderComp_lRec."Prod. Order No.", ProdOrderComp_lRec."Item No.");
            UNTIL ProdOrderComp_lRec.NEXT = 0;
        END;
    END;
    //ManuChk-NE
}

