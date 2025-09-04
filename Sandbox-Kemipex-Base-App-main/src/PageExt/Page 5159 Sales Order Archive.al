pageextension 50429 SOHdrArchive extends "Sales Order Archive"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("Bank on Invoice 2"; rec."Bank on Invoice 2")
            {
                Caption = 'Bank on Invoice';
                ApplicationArea = All;
            }
            field("Inspection Required 2"; rec."Inspection Required 2")
            {
                ApplicationArea = All;
                Caption = 'Inspection Required';
                // Visible = false;
            }
            field("Legalization Required 2"; rec."Legalization Required 2")
            {
                ApplicationArea = All;
                Caption = 'Legalization Required';
                // Visible = false;
            }
            field("Seller/Buyer 2"; rec."Seller/Buyer 2")
            {
                ApplicationArea = all;

                Caption = 'Seller/Buyer';
            }
            field("LC No. 2"; rec."LC No. 2")
            {
                ApplicationArea = All;
                Caption = 'LC No.';
            }
            field("LC Date 2"; rec."LC Date 2")
            {
                ApplicationArea = all;
                Caption = 'LC Date';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}