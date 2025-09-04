pageextension 50218 KMP_PageExtPostedItemTrackLn extends "Posted Item Tracking Lines"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here
        addafter("Lot No.")
        {
            field("Supplier Batch No."; rec."Supplier Batch No. 2")
            {
                ApplicationArea = All;
            }
            field(CustomLotNumber; rec.CustomLotNumber)
            {
                ApplicationArea = all;
            }
            field(CustomBOENumber; rec.CustomBOENumber)
            {
                ApplicationArea = all;
            }
        }
        //         modify("Lot No.")
        //         {
        //             Visible = false;
        //         }
    }
}