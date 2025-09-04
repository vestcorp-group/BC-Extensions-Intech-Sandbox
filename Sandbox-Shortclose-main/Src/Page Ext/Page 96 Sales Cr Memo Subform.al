pageextension 79652 SalesCrMemoSubformExt_50020 extends "Sales Cr. Memo Subform"
{
    layout
    {
        modify("Variant Code")
        {

            Editable = EditableFields_gBln;
            Visible = true;

            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;

        }
    }
    trigger OnAfterGetRecord()
    var
    begin
        ShortCloseEditable(); //T12084-N       
    end;

    trigger OnAfterGetCurrRecord()
    var
        ItemVariant: Record "Item Variant";
    begin
        ShortCloseEditable(); //T12084-N       
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ShortCloseEditable(); //T12084-N
    end;

    local procedure ShortCloseEditable()
    var
        SalesHdr_lRec: Record "Sales Header";
    begin
        //T12084-NS       
        if Rec."Short Close Boolean" then
            EditableFields_gBln := false
        else
            EditableFields_gBln := true;
        //T12084-NE
    END;

    var
        [InDataSet]
        EditableFields_gBln: Boolean;


}
