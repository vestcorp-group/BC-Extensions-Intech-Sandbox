pageextension 50433 BSOSubform extends "Blanket Sales Order Subform"//T12370-Full Comment
{//999
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = all;
                Editable = false;
            }

            field("Base UOM 2"; rec."Base UOM 2")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Base UOM';
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
    }
}