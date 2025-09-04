pageextension 50254 KMP_PageExtPurOrdArchSubForm extends "Purchase Order Archive Subform"//T12370-Full Comment //T13620-N
{
    layout
    {
        // Add changes to page layout here       

        // addafter(Quantity)
        // {
        //     field(CustomBOENumber; rec.CustomBOENumber)
        //     {
        //         ApplicationArea = All;
        //         Caption = 'Custom BOE No.';
        //         Editable = false;
        //     }

        // }
        addafter("Quantity Received")
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

    }

}