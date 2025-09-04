codeunit 79647 Table37SalesLine_50005
{
    //T12084-NS
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertEventSalesLine(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        UserSetup_lRec: Record "User Setup";
        SalesHdr_lRec: Record "Sales Header";
    begin
        Clear(SalesHdr_lRec);
        if SalesHdr_lRec.get(Rec."Document Type", Rec."Document No.") then
            Exit;

        if Rec."Document Type" = Rec."Document Type"::Order then begin
            if SalesHdr_lRec."Short Close Boolean" then begin
                UserSetup_lRec.Get(UserId);
                UserSetup_lRec.TestField("Allow to Update Short Close SO", true);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeleteEventSalesLine(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        UserSetup_lRec: Record "User Setup";
        SalesHdr_lRec: Record "Sales Header";
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            Clear(SalesHdr_lRec);
            IF SalesHdr_lRec.get(Rec."Document Type", Rec."Document No.") then begin
                UserSetup_lRec.Get(UserId);

                if SalesHdr_lRec."Short Close Boolean" then
                    UserSetup_lRec.TestField("Allow to Update Short Close SO", true);

                if Rec."Short Close Boolean" then
                    UserSetup_lRec.TestField("Allow to Update Short Close SO", true);
            end;
        end;
    end;
    //T12084-NE
    


}


