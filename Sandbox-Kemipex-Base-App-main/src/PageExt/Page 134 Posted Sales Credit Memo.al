pageextension 50400 "PostdSalesCreditMemoPageExt" extends "Posted Sales Credit Memo"//T12370-Full Comment
{
    // version NAVW113.00

    layout
    {
        addafter("Responsibility Center")
        {
            field("Bank on Invoice 2"; rec."Bank on Invoice 2")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Bank on Invoice';
            }
            // field("Inspection Required 2"; rec."Inspection Required 2")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            //     Caption = 'Inspection Required';
            //     // Visible = false;
            // }
            // field("Legalization Required 2"; rec."Legalization Required 2")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            //     Caption = 'Legalization Required';
            //     // Visible = false;
            // }
            // field("Seller/Buyer 2"; rec."Seller/Buyer 2")
            // {
            //     Caption = 'Seller/Buyer';
            //     ApplicationArea = All;
            // }
            field("LC No. 2"; rec."LC No. 2")
            {
                ApplicationArea = All;
                Caption = 'LC No.';
                Editable = false;
            }
            field("LC Date 2"; rec."LC Date 2")
            {
                ApplicationArea = all;
                Caption = 'LC Date';
                Editable = false;
            }
        }
    }
    actions
    {
        addafter("Co&mments")
        {

        }
    }
}
