pageextension 79653 PurchCrMemoSubformExt_50096 extends "Purch. Cr. Memo Subform"
{
    layout
    {

        modify("Variant Code")
        {
            Editable = EditableFields_gBln;
            Visible = true;
        }
    }


    trigger OnAfterGetCurrRecord()
    var

    begin
        ShortCloseEditable();//T12084-N
    end;

    trigger OnAfterGetRecord()
    var
    begin
        ShortCloseEditable(); //T12084-N       
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ShortCloseEditable(); //T12084-N
    end;

    local procedure ShortCloseEditable()
    var
        PurchHdr_lRec: Record "Purchase Header";
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