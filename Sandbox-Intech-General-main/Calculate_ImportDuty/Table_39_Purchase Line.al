codeunit 74987 Subscribe_Codeunit_39
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure T39_OnAfterValidate_NoField(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        GLAccount: Record "G/L Account";
        Item: Record Item;
        PurchaseHeader: Record "Purchase Header";
    begin
        IF Rec.IsTemporary then
            Exit;

        if Rec.Type = Rec.Type::"G/L Account" then begin
            if Rec."No." <> '' then begin
                GLAccount.Get(Rec."No.");
                Rec."GST Import Duty Code" := GLAccount."GST Import Duty Code";   //GSTImport-N
            end;
        end;

        if Rec.Type = Rec.Type::Item then begin
            if Rec."No." <> '' then begin
                Item.Get(Rec."No.");
                PurchaseHeader.Get(Rec."Document Type", Rec."Document No.");
                if not PurchaseHeader.Subcontracting then
                    Rec."GST Import Duty Code" := Item."GST Import Duty Code";   //GSTImport-N
            end;
        end;
    end;

    var
        myInt: Integer;
}