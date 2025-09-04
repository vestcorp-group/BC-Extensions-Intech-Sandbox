pageextension 50421 SalesCrMemoSubFormPageExt extends "Sales Cr. Memo Subform"//T12370-Full Comment
{
    //     // version NAVW113.00

    layout
    {
        addafter(Quantity)
        {
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = all;
                Editable = false;
            }

            field("Base UOM"; rec."Base UOM 2") //PackingListExtChange
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Unit Price Base UOM"; rec."Unit Price Base UOM 2") //PackingListExtChange
            {
                ApplicationArea = All;
                //Editable = false;
            }

            field("Base UOM 2"; rec."Base UOM 2")
            {
                ApplicationArea = all;
            }
            field("Unit Price Base UOM 2"; rec."Unit Price Base UOM 2")
            {
                ApplicationArea = All;
                Caption = 'Unit Price Base UOM';
            }

            field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
            {
                Editable = false;
                ApplicationArea = All;
            }

            //PackingListExtChange
            // field("Shipment Method"; rec."Shipment Method")
            // {
            //     ApplicationArea = All;
            // }
            // field("Shipment Packing"; rec."Shipment Packing")
            // {
            //     ApplicationArea = All;
            // }
            // field("Packing Qty"; rec."Packing Qty")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            // field("No. of Load"; rec."No. of Load")
            // {
            //     ApplicationArea = All;
            // }
            // field("Packing Gross Weight"; rec."Packing Gross Weight")
            // {
            //     ApplicationArea = All;
            // }
            // field("Packing Net Weight"; rec."Packing Net Weight")
            // {
            //     ApplicationArea = All;
            // }

        }
        addafter("Line Amount")
        {
            field("Container No. 2"; rec."Container No. 2")
            {
                ApplicationArea = all;
                Caption = 'Container No.';
            }
        }
    }
}