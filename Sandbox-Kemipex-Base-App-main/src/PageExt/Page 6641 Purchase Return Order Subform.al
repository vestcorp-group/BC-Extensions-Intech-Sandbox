pageextension 50302 KMP_PagExtPurchRetOrderSubform extends "Purchase Return Order Subform"//T12370-Full Comment T13620-N
{
    layout
    {
        // addafter(Quantity)
        // {
        //     field(CustomBOENumber; rec.CustomBOENumber)
        //     {
        //         Caption = 'Custom BOE No.';
        //         ApplicationArea = All;
        //         Editable = false;
        //     }
        // }
        addafter("Quantity Invoiced")
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