codeunit 80221 Sub_Codeunit_6501
{
    //Item Tracking Data Collection
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnTransferItemLedgToTempRecOnBeforeInsert', '', false, false)]
    local procedure OnTransferItemLedgToTempRecOnBeforeInsert(var TempGlobalReservEntry: Record "Reservation Entry"; ItemLedgerEntry: Record "Item Ledger Entry"; TrackingSpecification: Record "Tracking Specification"; var IsHandled: Boolean);
    begin
        TempGlobalReservEntry."Packaging Code" := ItemLedgerEntry."Packaging Code";
        TempGlobalReservEntry."Unit of Measure Code" := ItemLedgerEntry."Unit of Measure Code";
        TempGlobalReservEntry."Gross Weight 2" := ItemLedgerEntry."Gross Weight 2";
        TempGlobalReservEntry."Net Weight 2" := ItemLedgerEntry."Net Weight 2";
    end;
}