codeunit 79652 Page46SOSubform_50017
{
    //T12084-NS
    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnModifyRecordEvent', '', false, false)]
    local procedure OnBeforeModifyEventSalesOdrSubfrm(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; var AllowModify: Boolean)
    var
        UserSetup_lRec: Record "User Setup";
        SalesHdr_lRec: Record "Sales Header";
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            Clear(SalesHdr_lRec);
            SalesHdr_lRec.get(Rec."Document Type", Rec."Document No.");
            if SalesHdr_lRec."Short Close Boolean" then begin
                UserSetup_lRec.Get(UserId);
                UserSetup_lRec.TestField("Allow to Update Short Close SO", true);
                // Error('Sales Order Header is Short Close.Line can''t be modify.');
            end;
            if Rec."Short Close Boolean" then begin
                Error('Short Close Line can''t be modify.');
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterValidateEvent', 'Short Close Boolean', false, false)]
    local procedure OnBeforeModifySalesOrder(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var

    begin
        if Rec."Short Close Boolean" then begin
            Error('Short Close Boolean can''t be True.');
        end;
    end;
    //T12084-NE
}