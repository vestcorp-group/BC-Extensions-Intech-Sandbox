tableextension 50131 ItemJournalLineExtended extends "Item Journal Line"
{
    fields
    {
        field(51024; "FPO No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'T51982';
            Editable = false;
        }
        //T51982-NS
        modify("Order No.")
        {
            trigger OnAfterValidate()
            var
                ProdOrder_lRec: Record "Production Order";
            begin
                if Rec."Order Type" = Rec."Order Type"::Production then begin
                    ProdOrder_lRec.Reset();
                    ProdOrder_lRec.SetRange(Status, ProdOrder_lRec.Status::Released);
                    ProdOrder_lRec.SetRange("No.", Rec."Order No.");
                    if ProdOrder_lRec.FindFirst() then
                        Rec."FPO No." := ProdOrder_lRec."Firm Planned Order No.";
                end;
            end;
        }
        //T51982-NE
    }


}