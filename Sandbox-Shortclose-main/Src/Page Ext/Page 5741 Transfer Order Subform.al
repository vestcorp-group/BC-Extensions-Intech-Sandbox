pageextension 79651 TransferOrderSubExt_50010 extends "Transfer Order Subform"
{
    layout
    {
        modify("Item No.")
        {
            Editable = EditableFields_gBln;
        }

        modify(Description)
        {
            Editable = EditableFields_gBln;
        }

        modify("Description 2")
        {
            Editable = EditableFields_gBln;

        }

        modify("Transfer-from Bin Code")
        {
            Editable = EditableFields_gBln;

        }

        modify("Transfer-To Bin Code")
        {
            Editable = EditableFields_gBln;

        }

        modify(Quantity)
        {
            Editable = EditableFields_gBln;

        }
        modify("Reserved Quantity Shipped")
        {
            Editable = EditableFields_gBln;

        }
        modify("Reserved Quantity Outbnd.")
        {
            Editable = EditableFields_gBln;

        }
        modify("Unit of Measure Code")
        {
            Editable = EditableFields_gBln;

        }
        modify("Qty. to Ship")
        {
            Editable = EditableFields_gBln;

        }
        modify("Qty. to Receive")
        {
            Editable = EditableFields_gBln;

        }
        modify(Amount)
        {
            Editable = EditableFields_gBln;

        }
        modify("Transfer Price")
        {
            Editable = EditableFields_gBln;

        }
        modify("GST Credit")
        {
            Editable = EditableFields_gBln;

        }
        modify("Custom Duty Amount")
        {
            Editable = EditableFields_gBln;

        }
        modify("GST Assessable Value")
        {
            Editable = EditableFields_gBln;

        }
        modify("HSN/SAC Code")
        {
            Editable = EditableFields_gBln;

        }
        modify("GST Group Code")
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
        }
        modify("Variant Code")
        {
            Editable = EditableFields_gBln;
            Visible = true;
        }
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
                ToolTip = 'Executes the Short Close Current Transfer Line action.';
                // Visible = SalesFieldVisibility_gBln;

                trigger OnAction();
                var
                    ShortCloseFun_lCdu: Codeunit "Short Close Functionality";
                begin
                    ShortCloseFun_lCdu.InsertTransferForeCloseLine_gFnc(Rec);
                end;
            }
            //T12084-NE
        }
        addlast("F&unctions")
        {
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ShortCloseEditable(); //T12084-N
    end;

    trigger OnAfterGetRecord()
    var
    begin
        ShortCloseEditable(); //T12084-N
    end;

    trigger OnAfterGetCurrRecord()
    var
    begin
        ShortCloseEditable(); //T12084-N
    end;

    var
        [InDataSet]
        EditableFields_gBln: Boolean;

    local procedure ShortCloseEditable()
    begin
        //T12084-NS
        if Rec."Short Close Boolean" then
            EditableFields_gBln := false
        else
            EditableFields_gBln := true;
        //T12084-NE
    END;
}
