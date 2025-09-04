pageextension 58082 Salesshipmentlist extends "Posted Sales Shipments"//T12370-Full Comment //T13796
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Order No."; rec."Order No.")
            {
                ApplicationArea = all;
                Caption = 'Sales Order No.';

            }
            field("Order Date"; rec."Order Date")
            {
                ApplicationArea = all;
                Caption = 'Sales Order Date';
            }
            // field("Transaction Type"; rec."Transaction Type")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Order Type';
            // }
        }
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