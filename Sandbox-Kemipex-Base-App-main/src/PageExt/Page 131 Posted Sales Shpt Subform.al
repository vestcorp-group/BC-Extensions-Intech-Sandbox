pageextension 50427 SSSubform extends "Posted Sales Shpt. Subform"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field("Base UOM 2"; rec."Base UOM 2")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Base UOM';
            }
            field("Qty. per Unit of Measure 2"; rec."Qty. per Unit of Measure")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Unit Price Base UOM 2"; rec."Unit Price Base UOM 2")
            {
                ApplicationArea = All;
                Caption = 'Unit Price Base UOM';
            }
        }
        addafter("Quantity Invoiced")
        {
            field("Net Weight1"; rec."Net Weight")
            {
                ApplicationArea = all;
            }
            field("Gross Weight1"; rec."Gross Weight")
            {
                ApplicationArea = all;
            }
            field("Container No. 2"; rec."Container No. 2")
            {
                ApplicationArea = all;
                Caption = 'Container No.';
            }
        }
        addbefore(Description)
        {
            field("IMCO Code"; rec."IMCO Class")
            {
                ApplicationArea = all;

            }
        }

        modify("Planned Delivery Date")
        {
            Visible = false;
        }
        modify("Planned Shipment Date")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[3]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[4]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[5]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[6]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[7]")
        {
            Visible = false;
        }
        modify("ShortcutDimCode[8]")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}