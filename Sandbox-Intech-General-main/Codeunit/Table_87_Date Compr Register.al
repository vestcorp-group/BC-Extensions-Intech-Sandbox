codeunit 74982 Subscribe_Table_87
{

    [EventSubscriber(ObjectType::Table, Database::"Date Compr. Register", 'OnBeforeInsertEvent', '', true, true)]
    local procedure "Date Compr. Register_OnBeforeInsertEvent"
    (
        var Rec: Record "Date Compr. Register";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not insert any record in this %1 table.', Rec.TableCaption);
    end;

}