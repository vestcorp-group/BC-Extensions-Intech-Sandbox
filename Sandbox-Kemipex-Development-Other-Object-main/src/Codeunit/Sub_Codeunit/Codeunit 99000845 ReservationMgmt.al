//T12068-NS
codeunit 50006 "Sub CU99000845 ReservatMgmt"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reservation Management", OnBeforeAutoReserveProdOrderLine, '', false, false)]
    local procedure "Reservation Management_OnBeforeAutoReserveProdOrderLine"(ReservSummEntryNo: Integer; var RemainingQtyToReserve: Decimal; var RemainingQtyToReserveBase: Decimal; Description: Text[100]; AvailabilityDate: Date; var IsReserved: Boolean; Search: Text[1]; NextStep: Integer; CalcReservEntry: Record "Reservation Entry")
    var
        Usersetup_lRec: Record "User Setup";
    begin
        Usersetup_lRec.Get(UserId);
        if not Usersetup_lRec."Allow to Reserve" then
            Error('You are not allowed to do reservation for summary type "Released Production Order Line" for User %1. Kindly contact to Administrator', Usersetup_lRec."User ID");
    end;

    [EventSubscriber(ObjectType::Page, Page::"Available - Prod. Order Lines", OnBeforeActionEvent, 'Reserve', false, false)]
    local procedure "Reservation Management_OnBeforeCreateReservation"(var Rec: Record "Prod. Order Line")
    var
        Usersetup_lRec: Record "User Setup";
    begin
        Usersetup_lRec.Get(UserId);
        if not Usersetup_lRec."Allow to Reserve" then
            Error('You are not allowed to do reservation for summary type "Released Production Order Line" for User %1. Kindly contact to Administrator', Usersetup_lRec."User ID");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reservation Engine Mgt.", OnBeforeCancelReservation, '', false, false)]
    local procedure "Reservation Engine Mgt._OnBeforeCancelReservation"(var ReservEntry: Record "Reservation Entry"; var IsHandled: Boolean)
    var
        Usersetup_lRec: Record "User Setup";
        ProdorderLine_lRec: Record "Prod. Order Line";
        ReservaEntry_lrec: Record "Reservation Entry";
    begin
        if ReservaEntry_lrec.Get(ReservEntry."Entry No.", true) then begin
            ProdorderLine_lRec.Reset();
            ProdorderLine_lRec.SetRange(Status, ProdorderLine_lRec.Status::Released);
            ProdorderLine_lRec.SetRange("Line No.", ReservaEntry_lrec."Source Prod. Order Line");
            ProdorderLine_lRec.SetRange("Prod. Order No.", ReservaEntry_lrec."Source ID");
            if ProdorderLine_lRec.FindFirst() then begin
                Usersetup_lRec.Get(UserId);
                if not Usersetup_lRec."Allow to Reserve" then
                    Error('You are not allowed to do reservation for summary type "Released Production Order Line" for User %1. Kindly contact to Administrator', Usersetup_lRec."User ID");
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Demand Forecast Variant Matrix", OnMatrixOnDrillDownOnBeforePageRun, '', false, false)]
    local procedure "Demand Forecast Variant Matrix_OnMatrixOnDrillDownOnBeforePageRun"(var ForecastItemVariantLoc: Record "Forecast Item Variant Loc" temporary; var ProductionForecastEntry: Record "Production Forecast Entry")
    var
        UserSetup_lRec: Record "User Setup";
    begin
        UserSetup_lRec.Get(UserId);
        if UserSetup_lRec."Salespers./Purch. Code" <> '' then
            ProductionForecastEntry.SetRange("Salesperson Code", UserSetup_lRec."Salespers./Purch. Code");
    end;

    [EventSubscriber(ObjectType::Page, Page::"Demand Forecast Variant Matrix", OnAfterLoad, '', false, false)]
    local procedure "Demand Forecast Variant Matrix_OnAfterLoad"(var ForecastItemVariantLoc: Record "Forecast Item Variant Loc" temporary; ProductionForecastName: Code[10]; ForecastType: Enum "Demand Forecast Type")

    var
        UserSetup_lRec: Record "User Setup";
    begin
        UserSetup_lRec.Get(UserId);
        if UserSetup_lRec."Salespers./Purch. Code" <> '' then
            ForecastItemVariantLoc.SetRange("Salesperson filter", UserSetup_lRec."Salespers./Purch. Code");

    end;

    [EventSubscriber(ObjectType::Page, Page::"Demand Forecast Variant Matrix", OnAfterMATRIX_OnAfterGetRecord, '', false, false)]
    local procedure "Demand Forecast Variant Matrix_OnAfterMATRIX_OnAfterGetRecord"(var Sender: Page "Demand Forecast Variant Matrix"; var ForecastItemVariantLoc: Record "Forecast Item Variant Loc" temporary; var MATRIXCellDataColumnOrdinal: Decimal)
    begin
        ForecastItemVariantLoc.CalcFields("Prod. Forecast Quantity Base_");
        MATRIXCellDataColumnOrdinal := ForecastItemVariantLoc."Prod. Forecast Quantity Base_";
        //ForecastItemVariantLoc.Setfilter("Prod. Forecast Quantity Base_", '<>0');
    end;

    // [EventSubscriber(ObjectType::Page, Page::"Demand Forecast Variant Matrix", OnLoadDataOnBeforeRecFindFirst, '', false, false)]
    // local procedure "Demand Forecast Variant Matrix_OnLoadDataOnBeforeRecFindFirst"(var ForecastItemVariantLoc: Record "Forecast Item Variant Loc" temporary; ItemFilter: Text; LocationFilter: Text; UseLocation: Boolean; UseVariant: Boolean; VariantFilter: Text)

    // begin
    //     ForecastItemVariantLoc.SetFilter("Prod. Forecast Quantity Base_", '<>0');
    // end;

}
//T12068-NE