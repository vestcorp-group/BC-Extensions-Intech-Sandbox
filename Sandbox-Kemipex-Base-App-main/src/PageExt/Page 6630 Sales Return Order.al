pageextension 50307 KMP_PagExtSalesReturnOrder extends "Sales Return Order"//T12370-Full Comment //T-12855 Uncommented
{
    layout
    {
        addafter(Status)
        {
            // field(CustomBOENumber; rec.CustomBOENumber)
            // {
            //     ApplicationArea = all;
            // }
            field(CustomBOENumber; rec.CustomBOENumber)
            {
                ApplicationArea = all;
                Description = '//Hypercare 26-02-2025-N';
                Caption = 'Custom BOE No.';
                Editable = rec."Sales Type" = rec."Sales Type"::BOE;
            }
            field("Sales Type"; Rec."Sales Type")
            {
                ApplicationArea = All;
                Description = '//Hypercare 26-02-2025-N';
            }
        }
        addafter("Responsibility Center")
        {
            field("Bank on Invoice 2"; rec."Bank on Invoice 2")
            {
                Caption = 'Bank on Invoice';
                ApplicationArea = All; //T-12855
            }
            //             field("Inspection Required 2"; rec."Inspection Required 2")
            //             {
            //                 ApplicationArea = All;
            //                 Caption = 'Inspection Required';
            //                 // Visible = false;
            //             }
            //             field("Legalization Required 2"; rec."Legalization Required 2")
            //             {
            //                 ApplicationArea = All;
            //                 Caption = 'Legalization Required';
            //                 // Visible = false;
            //             }
            //             field("Seller/Buyer 2"; rec."Seller/Buyer 2")
            //             {
            //                 ApplicationArea = all;
            //                 Caption = 'Seller/Buyer';
            //             }
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

}