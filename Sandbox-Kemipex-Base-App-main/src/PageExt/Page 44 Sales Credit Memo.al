pageextension 50422 SalesCrMemoPageExt extends "Sales Credit Memo"//T12370-Full Comment
{
    //     // version NAVW113.00

    layout
    {
        addafter(Status)
        {
            //             //PackingListExtChange
            field("Bank on Invoice"; rec."Bank on Invoice 2")
            {
                ApplicationArea = All;
            }
            //             field("Inspection Required"; rec."Inspection Required 2")
            //             {
            //                 ApplicationArea = All;
            //                 // Visible = false;
            //             }
            //             field("Legalization Required"; rec."Legalization Required 2")
            //             {
            //                 ApplicationArea = All;
            //                 // Visible = false;
            //             }
            //             field("Seller/Buyer 2"; rec."Seller/Buyer 2")
            //             {
            //                 ApplicationArea = all;
            //                 Caption = 'Seller/Buyer';
            //             }
            field("LC No."; rec."LC No. 2")
            {
                ApplicationArea = All;
            }
            field("LC Date"; rec."LC Date 2")
            {
                ApplicationArea = all;
            }
        }
    }
    //     actions
    //     {

    //     }
}
