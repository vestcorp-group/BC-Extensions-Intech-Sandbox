codeunit 79649 Table5741TransferLine_50011
{
    //T12084-NS
    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertEventTransferLine(var Rec: Record "Transfer Line"; RunTrigger: Boolean)
    var
        UserSetup_lRec: Record "User Setup";
        TransferHdr_lRec: Record "Transfer Header";
    begin
        Clear(TransferHdr_lRec);
        TransferHdr_lRec.get(Rec."Document No.");
        if TransferHdr_lRec."Short Close Boolean" then begin
            UserSetup_lRec.Get(UserId);
            UserSetup_lRec.TestField("Allow to Update Short Close TO", true);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeleteEventTransferLine(var Rec: Record "Transfer Line"; RunTrigger: Boolean)
    var
        UserSetup_lRec: Record "User Setup";
        TransferHdr_lRec: Record "Transfer Header";
    begin
        Clear(TransferHdr_lRec);
        TransferHdr_lRec.get(Rec."Document No.");
        UserSetup_lRec.Get(UserId);

        if TransferHdr_lRec."Short Close Boolean" then
            UserSetup_lRec.TestField("Allow to Update Short Close TO", true);

        if Rec."Short Close Boolean" then
            UserSetup_lRec.TestField("Allow to Update Short Close TO", true);
    end;
    //T12084-NE
}
