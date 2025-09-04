codeunit 85651 SkipcheckIsCyclicalLoop85651
{
    trigger OnRun()
    begin

    end;

    /*  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeCheckIsCyclicalLoop, '', false, false)]
     local procedure "Item Jnl.-Post Line_OnBeforeCheckIsCyclicalLoop"(ItemLedgEntry: Record "Item Ledger Entry"; OldItemLedgEntry: Record "Item Ledger Entry"; var PrevAppliedItemLedgEntry: Record "Item Ledger Entry"; var AppliedQty: Decimal; var IsHandled: Boolean)
     begin
         if ItemLedgEntry."Document No." = 'KMJ/MO/80046' then
             IsHandled := true;
     end; */

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reservation Engine Mgt.", OnBeforeUpdateItemTracking, '', false, false)]
    local procedure "Reservation Engine Mgt._OnBeforeUpdateItemTracking"(var ReservEntry: Record "Reservation Entry"; var TrackingSpecification: Record "Tracking Specification")
    begin
        //Hypercare 06-03-2025
        if ReservEntry."Group GRN Date" <> 0D then
            TrackingSpecification."Group GRN Date" := ReservEntry."Group GRN Date";
        //Hypercare 06-03-2025

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeInsertSetupTempSplitItemJnlLine, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnBeforeInsertSetupTempSplitItemJnlLine"(var TempTrackingSpecification: Record "Tracking Specification" temporary; var TempItemJournalLine: Record "Item Journal Line" temporary; var PostItemJnlLine: Boolean; var ItemJournalLine2: Record "Item Journal Line"; SignFactor: Integer; FloatingFactor: Decimal)
    begin
        //Hypercare 06-03-2025
        if TempTrackingSpecification."Group GRN Date" <> 0D then
            TempItemJournalLine."Group GRN Date" := TempTrackingSpecification."Group GRN Date";
        //Hypercare 06-03-2025
    end;

    //NG-NS 290324 Fix for Ref Ino Issue
    [EventSubscriber(ObjectType::Table, Database::"Reference Invoice No.", 'OnBeforeInsertEvent', '', true, true)]
    local procedure "Reference Invoice No._OnBeforeInsertEvent"
    (
        var Rec: Record "Reference Invoice No.";
        RunTrigger: Boolean
    )
    var
        CheckRefInvNo_lRec: Record "Reference Invoice No.";

    begin
        IF CheckRefInvNo_lRec.GET(Rec."Document No.", Rec."Document Type", Rec."Source No.", Rec."Reference Invoice Nos.", Rec."Journal Template Name", Rec."Journal Batch Name") Then begin
            Rec."Document No." := Rec."Document No." + '_';
        end;
    end;
    //NG-NE 290324 Fix for Ref Ino Issue

    var
        myInt: Integer;
}