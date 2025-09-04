pageextension 79649 PurchaseOrderSubExt_50008 extends "Purchase Order Subform"
{
    layout
    {
        modify(Type)
        {

            Editable = EditableFields_gBln;

        }
        modify("No.")
        {

            Editable = EditableFields_gBln;
        }
        modify(Quantity)
        {
            Editable = EditableFields_gBln;

        }
        modify(Description)
        {
            Editable = EditableFields_gBln;

        }
        modify("Location Code")
        {
            Editable = EditableFields_gBln;

        }
        modify("Bin Code")
        {
            Editable = EditableFields_gBln;

            Visible = true;
        }
        modify("Unit of Measure Code")
        {
            Editable = EditableFields_gBln;

        }
        modify("Line Discount %")
        {
            Editable = EditableFields_gBln;

        }
        modify("Total Amount Incl. VAT")
        {
            Editable = EditableFields_gBln;

        }
        modify("GST Group Code")
        {
            Editable = EditableFields_gBln;

        }
        modify("HSN/SAC Code")
        {
            Editable = EditableFields_gBln;

        }
        modify("GST Jurisdiction Type")
        {
            Editable = EditableFields_gBln;

        }
        modify("GST Group Type")
        {
            Editable = EditableFields_gBln;

        }
        modify(Exempted)
        {
            Editable = EditableFields_gBln;

        }
        modify("Qty. to Receive")
        {
            Editable = EditableFields_gBln;

        }
        modify("Qty. to Invoice")
        {
            Editable = EditableFields_gBln;

        }
        modify("Planned Receipt Date")
        {
            Editable = EditableFields_gBln;

        }
        modify("Requested Receipt Date")
        {
            Editable = EditableFields_gBln;

        }
        modify("Shortcut Dimension 1 Code")
        {
            Editable = EditableFields_gBln;

        }
        modify("Shortcut Dimension 2 Code")
        {
            Editable = EditableFields_gBln;

        }


        addlast(Control1)
        {
            //T12084-NS
            field("Short Close Boolean"; Rec."Short Close Boolean")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Short Close Boolean field.';

                // Visible = SalesFieldVisibility_gBln;
            }
            field("Short Closed Qty"; Rec."Short Closed Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Short Closed Qty field.';

                // Visible = SalesFieldVisibility_gBln;
            }
            field("Short Close Reason"; Rec."Short Close Reason")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Short Close Reason field.';

                // Visible = SalesFieldVisibility_gBln;
            }

            field("Short Close Approval Required"; Rec."Short Close Approval Required")
            {
                ApplicationArea = All;
                Description = 'T50306';
            }
        }
        //T12084-NE             
    }

    actions
    {
        addlast("&Line")
        {
            //T12084-NS
            action("ForeClose")
            {
                ApplicationArea = All;
                Caption = 'Short Close';
                Image = Close;
                Ellipsis = true;
                ToolTip = 'Executes the Short Close Current Purchase Line action.';
                // Visible = SalesFieldVisibility_gBln;

                trigger OnAction();
                var
                    ShortCloseFun_lCdu: Codeunit "Short Close Functionality";
                begin
                    ShortCloseFun_lCdu.InsertPurchaeForeCloseLine_gFnc(Rec);
                end;
            }
            //T12084-NE
        }
    }

    trigger OnAfterGetCurrRecord()
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
