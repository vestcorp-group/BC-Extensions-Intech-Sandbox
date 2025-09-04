pageextension 50219 KMP_PageExtPostedPurInvLine extends "Posted Purch. Invoice Subform"//T12370-Full Comment //T13620-N
{

    layout
    {
        // Add changes to page layout here       

        addafter("Job No.")
        {
            field(CustomETD; rec.CustomETD)
            {
                ApplicationArea = All;
                Caption = 'ETD';
            }
            field(CustomETA; rec.CustomETA)
            {
                ApplicationArea = All;
                Caption = 'ETA';
            }
            field(CustomR_ETD; rec.CustomR_ETD)
            {
                ApplicationArea = All;
                Caption = 'R-ETD';
            }
            field(CustomR_ETA; rec.CustomR_ETA)
            {
                ApplicationArea = All;
                Caption = 'R-ETA';
            }
            // field("Container No. 2"; rec."Container No. 2")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Container No.';
            // }
        }

        // modify("Order Date")
        // {
        //     Visible = false;
        //     ApplicationArea = All;
        // }

        // modify("Requested Receipt Date")
        // {
        //     Visible = false;
        //     ApplicationArea = All;
        // }

        // modify("Promised Receipt Date")
        // {
        //     Visible = false;
        //     ApplicationArea = All;
        // }
        // modify("Expected Receipt Date")
        // {
        //     Visible = false;
        //     ApplicationArea = All;
        // }

    }
}