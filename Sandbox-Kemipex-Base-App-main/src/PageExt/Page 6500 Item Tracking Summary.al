pageextension 50343 KMP_PagExtItemTrackingSummary extends "Item Tracking Summary"//T12370-Full Comment
{
    layout
    {
        addafter("Lot No.")
        {
            field(CustomLotNumber; rec.CustomLotNumber)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(CustomBOENumber; rec.CustomBOENumber)
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        /*  modify("Lot No.")
         {
             Visible = false;
         } */
        addafter("Total Quantity")
        {
            field("Supplier Batch No. 2"; rec."Supplier Batch No. 2")
            {
                ApplicationArea = All;
                Caption = 'Supplier Batch No.';
            }
            field("Manufacturing Date 2"; rec."Manufacturing Date 2")
            {
                ApplicationArea = All;
                Caption = 'Manufacturing Date';
            }
            field("Expiry Period 2"; rec."Expiry Period 2")
            {
                ApplicationArea = All;
                Caption = 'Expiry Period';
            }
            field("Gross Weight 2"; rec."Gross Weight 2")
            {
                ApplicationArea = All;
                Caption = 'Gross Weight';
            }
            field("Net Weight 2"; rec."Net Weight 2")
            {
                ApplicationArea = All;
                Caption = 'Net Weight';
            }
        }
    }
}