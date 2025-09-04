codeunit 74994 subscribe_Codeunit_22
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin
        NewItemLedgEntry."Reason Code" := ItemJournalLine."Reason Code";
    end;

    //ManuChk-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnPostOutputOnAfterInsertCostValueEntries, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnPostOutputOnAfterInsertCostValueEntries"(ItemJournalLine: Record "Item Journal Line"; var CapLedgEntry: Record "Capacity Ledger Entry"; CalledFromAdjustment: Boolean; PostToGL: Boolean)
    var
        ManufacturingSetup_lRec: Record "Manufacturing Setup";
    begin
        ManufacturingSetup_lRec.GET;
        IF (ManufacturingSetup_lRec."Check Consumption Booked") AND (NOT ItemJournalLine.Subcontracting) THEN
            CheckConsumptionBooked_lFnc(ItemJournalLine);
    end;

    procedure CheckConsumptionBooked_lFnc(ItemJnlLine: Record "Item Journal Line")
    var
        ProdOrderComp_lRec: Record "Prod. Order Component";
        ProdOrderLine_lRec: Record "Prod. Order Line";
        ExpectedConsumption_lDec: Decimal;
    begin
        ProdOrderComp_lRec.SETCURRENTKEY(Status, "Prod. Order No.", "Prod. Order Line No.", "Item No.", "Line No.");
        ProdOrderComp_lRec.SETRANGE(Status, ProdOrderComp_lRec.Status::Released);
        ProdOrderComp_lRec.SETRANGE("Prod. Order No.", ItemJnlLine."Order No.");
        ProdOrderComp_lRec.SETRANGE("Prod. Order Line No.", ItemJnlLine."Order Line No.");
        ProdOrderComp_lRec.SETRANGE(ProdOrderComp_lRec."Flushing Method", ProdOrderComp_lRec."Flushing Method"::Manual);
        IF ProdOrderComp_lRec.FINDSET(FALSE, FALSE) THEN BEGIN
            REPEAT
                ProdOrderLine_lRec.GET(ProdOrderComp_lRec.Status, ProdOrderComp_lRec."Prod. Order No.", ProdOrderComp_lRec."Prod. Order Line No.");
                ProdOrderComp_lRec.CALCFIELDS(ProdOrderComp_lRec."Act. Consumption (Qty)");
                ExpectedConsumption_lDec := (ItemJnlLine."Output Quantity" + ProdOrderLine_lRec."Finished Quantity") * ProdOrderComp_lRec."Quantity per";
                IF ExpectedConsumption_lDec > ProdOrderComp_lRec."Act. Consumption (Qty)" THEN
                    ERROR('Operation No. %1 has not been finished. Some consumption is still missing in %2 Line No %3', ItemJnlLine."Operation No.",
                      ItemJnlLine."Order No.", ItemJnlLine."Order Line No.");
            UNTIL ProdOrderComp_lRec.NEXT = 0;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnApplyItemLedgEntryOnBeforeOldItemLedgEntryModify, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnApplyItemLedgEntryOnBeforeOldItemLedgEntryModify"(var ItemLedgerEntry: Record "Item Ledger Entry"; var OldItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    var
        ProdOrderHeader_lRec: Record "Production Order";
        ManufacturingSetup_lRec: Record "Manufacturing Setup";
    begin

        ManufacturingSetup_lRec.Reset();
        ManufacturingSetup_lRec.GET();

        if ManufacturingSetup_lRec."Check Prod Order Status" then begin
            if ItemLedgerEntry."Entry Type" <> ItemLedgerEntry."Entry Type"::Consumption then
                exit;

            if ItemLedgerEntry.Quantity < 1 then
                exit;

            if OldItemLedgerEntry."Entry Type" <> OldItemLedgerEntry."Entry Type"::Output then
                exit;

            ProdOrderHeader_lRec.Reset();
            ProdOrderHeader_lRec.SetRange("No.", OldItemLedgerEntry."Order No.");
            if ProdOrderHeader_lRec.FindFirst() then begin
                if ProdOrderHeader_lRec.Status <> ProdOrderHeader_lRec.Status::Finished then
                    Error('System is trying to Consume Item Ledger Entry No. %1 from Prod. Order No. %2 which is not allowed as the Status of the Prod Order is not Finished. Current Status is %3. Please change and try again.', OldItemLedgerEntry."Entry No.", OldItemLedgerEntry."Order No.", ProdOrderHeader_lRec.Status);
            end;
        end;
    end;
    //ManuChk-NE    

}
