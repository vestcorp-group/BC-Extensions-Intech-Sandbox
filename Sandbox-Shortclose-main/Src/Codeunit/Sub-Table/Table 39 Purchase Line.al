codeunit 79648 Table39PurchLine_50009
{
    //T12084-NS
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertEventPurchLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    var
        UserSetup_lRec: Record "User Setup";
        PurchaseHdr_lRec: Record "Purchase Header";
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            Clear(PurchaseHdr_lRec);
            if PurchaseHdr_lRec.get(Rec."Document Type", Rec."Document No.") then begin
                if PurchaseHdr_lRec."Short Close Boolean" then begin
                    UserSetup_lRec.Get(UserId);
                    UserSetup_lRec.TestField("Allow to Update Short Close PO", true);
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeleteEventPurchLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    var
        UserSetup_lRec: Record "User Setup";
        PurchaseHdr_lRec: Record "Purchase Header";
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            Clear(PurchaseHdr_lRec);
            if PurchaseHdr_lRec.get(Rec."Document Type", Rec."Document No.") then begin
                UserSetup_lRec.Get(UserId);

                if PurchaseHdr_lRec."Short Close Boolean" then
                    UserSetup_lRec.TestField("Allow to Update Short Close PO", true);

                if Rec."Short Close Boolean" then
                    UserSetup_lRec.TestField("Allow to Update Short Close PO", true);

            end;
        end;
    end;
    //T12084-NE  
}
