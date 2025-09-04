pageextension 58075 PurchasereceiptSubform extends "Posted Purchase Rcpt. Subform"//T12370-Full Comment
{
    layout
    {
        addafter(Description)
        {
            // field("Variant Code1"; rec."Variant Code")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Variant Code';
            // }
            // field("Item COO"; rec.Item_COO)
            // {
            //     ApplicationArea = all;
            // }
            // field(Item_Manufacturer_Description; rec.Item_Manufacturer_Description)
            // {
            //     ApplicationArea = all;
            // }
            field(Item_short_name; rec.Item_short_name)//T13700
            {
                ApplicationArea = all;
            }
            field("Item HS Code"; rec."Item HS Code")
            {
                ApplicationArea = all;
            }
        }
        addbefore("Quantity Invoiced")
        {
            field("Base UOM"; rec."Base UOM")
            {
                ApplicationArea = all;
            }
            field("Quantity (Base)"; rec."Quantity (Base)")
            {
                ApplicationArea = all;
                Caption = 'Base UOM Qty.';
            }
            field("Unit Price Base UOM"; rec."Unit Price Base UOM")
            {
                ApplicationArea = all;
            }
        }
        addlast(Control1)
        {
            field("Transaction Type"; rec."Transaction Type")
            {
                ApplicationArea = all;
                Caption = 'Order Type';
            }
            field("Container Size"; rec."Container Size")
            {
                ApplicationArea = All;
            }
            field("Shipping Remarks"; rec."Shipping Remarks")
            {
                ApplicationArea = All;
            }
            field("In-Out Instruction"; rec."In-Out Instruction")
            {
                ApplicationArea = All;
            }
            field("Shipping Line"; rec."Shipping Line")
            {
                ApplicationArea = All;
            }
            field("BL-AWB No."; rec."BL-AWB No.")
            {
                ApplicationArea = All;
            }
            field("Vessel-Voyage No."; rec."Vessel-Voyage No.")
            {
                ApplicationArea = all;
            }
            field("Freight Forwarder"; rec."Freight Forwarder")
            {
                ApplicationArea = all;
            }
            field("Freight Charge"; rec."Freight Charge")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Unit of Measure Code"; Quantity)
    }
}