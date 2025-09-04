codeunit 79650 Page5741TOSubform_50012
{
    //T12084-NS
    [EventSubscriber(ObjectType::Page, Page::"Transfer Order Subform", 'OnModifyRecordEvent', '', false, false)]
    local procedure OnBeforeModifyEventTransferOdrSubfrm(var Rec: Record "Transfer Line"; var xRec: Record "Transfer Line"; var AllowModify: Boolean)
    var
        UserSetup_lRec: Record "User Setup";
        TransferHdr_lRec: Record "Transfer Header";
    begin
        Clear(TransferHdr_lRec);
        TransferHdr_lRec.get(Rec."Document No.");
        if TransferHdr_lRec."Short Close Boolean" then begin
            UserSetup_lRec.Get(UserId);
            UserSetup_lRec.TestField("Allow to Update Short Close TO", true);
            // Error('Transfer Order Header is Short Close.Line can''t be modify.');
        end;
        if Rec."Short Close Boolean" then begin
            Error('Short Close Line can''t be modify.');
        end;
    end;
    //T12084-NE
}
