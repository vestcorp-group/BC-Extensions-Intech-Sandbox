codeunit 75026 "Subscribe_GSTPurchLia_DetGST"
{

    //GSTPurchLia-NS
    [EventSubscriber(ObjectType::Table, Database::"Detailed GST Ledger Entry", 'OnBeforeInsertEvent', '', true, true)]
    local procedure "Detailed GST Ledger Entry_OnBeforeInsertEvent"
    (
        var Rec: Record "Detailed GST Ledger Entry";
        RunTrigger: Boolean
    )
    var
        GLSetup_lRec: Record "General Ledger Setup";
    begin
        GLSetup_lRec.Get();
        IF NOT GLSetup_lRec."Skip Intetrim Entry RC" then
            Exit;

        IF (Rec."Document Type" = Rec."Document Type"::Invoice) AND (Rec."Transaction Type" = Rec."Transaction Type"::Purchase) AND (Rec."Entry Type" = Rec."Entry Type"::"Initial Entry") Then begin
            IF (Rec."GST Group Type" = Rec."GST Group Type"::Service) AND (Rec."Reverse Charge") THEN BEGIN
                Rec."Orignal GST Group Type" := Rec."GST Group Type";
                Rec."GST Group Type" := "GST Group Type"::Goods;
            END;
        end;
    End;
    //GSTPurchLia-NE


}