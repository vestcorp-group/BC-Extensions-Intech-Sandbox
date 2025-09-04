codeunit 80220 Sub_Codeunit_22
{
    //Item Jnl.-Post Line

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    procedure CopyNewFieldstoILEfromIJ(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin
        NewItemLedgEntry."Packaging Code" := ItemJournalLine."Packaging Code";
    end;
}