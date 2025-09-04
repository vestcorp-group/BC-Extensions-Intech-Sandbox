pageextension 58126 PostedPurchaseReceiptListpage extends "Posted Purchase Receipts"//T12370-Full Comment
{
    layout
    {

        addafter("Buy-from Vendor Name")
        {
            field("Purchase Order No."; Rec."Order No.")
            {
                ApplicationArea = all;
            }
            field("Transaction Type"; rec."Transaction Type")
            {
                ApplicationArea = all;
                Caption = 'Order Type';
            }
        }
        movebefore("Buy-from Vendor No."; "Buy-from Vendor Name")
        moveafter("No."; "Posting Date")
        addafter("No. Printed")
        {
            field("User ID"; rec."User ID")
            {
                ApplicationArea = all;
            }
        }
        // Add changes to page layout here
    }
    actions
    {
        // Add changes to page actions here
    }
    trigger OnDeleteRecord(): Boolean
    begin
        Error('Not allowed to delete the record!');
    end;

    var
        myInt: Integer;
}