//T07350-NS
codeunit 75376 Table_Subscribe_87
{
    [EventSubscriber(ObjectType::Table, Database::"Date Compr. Register", 'OnAfterInsertEvent', '', True, True)]
    local procedure OnAfterInsertEvent(var Rec: Record "Date Compr. Register"; RunTrigger: Boolean)
    begin
        Error('Data Compress Not allow - Contact to Intech Systems');
    end;


    [EventSubscriber(ObjectType::Table, Database::"Date Compr. Register", 'OnAfterModifyEvent', '', True, True)]
    local procedure OnAfterModifyEvent(var Rec: Record "Date Compr. Register"; RunTrigger: Boolean)
    begin
        Error('Data Compress Not allow - Contact to Intech Systems');
    end;

}