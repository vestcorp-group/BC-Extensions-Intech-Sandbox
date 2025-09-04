codeunit 79651 Page54POSubform_50013
{
    //T12084-NS
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", 'OnModifyRecordEvent', '', false, false)]
    local procedure OnBeforeModifyEventPurchaseOdrSubfrm(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; var AllowModify: Boolean)
    var
        UserSetup_lRec: Record "User Setup";
        PurchaseHdr_lRec: Record "Purchase Header";
    begin
        // Error('Page Event');
        // Message('Page Event');
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            Clear(PurchaseHdr_lRec);
            PurchaseHdr_lRec.get(Rec."Document Type", Rec."Document No.");
            if PurchaseHdr_lRec."Short Close Boolean" then begin
                UserSetup_lRec.Get(UserId);
                UserSetup_lRec.TestField("Allow to Update Short Close PO", true);
                // Error('Purchase Order Header is Short Close.Line can''t be modify.');
            end;
            if Rec."Short Close Boolean" then begin
                Error('Short Close Line can''t be modify.');
            end;
        end;
    end;
    //T12084-NE
}