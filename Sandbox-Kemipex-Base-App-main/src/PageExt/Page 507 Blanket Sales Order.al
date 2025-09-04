pageextension 50210 BlanketSOPage extends "Blanket Sales Order"//T12370-Full Comment //T-12855
{
    layout
    {
        //T12724 NS 07112024
        addafter("Responsibility Center")
        {
            //             // field("Seller/Buyer 2"; rec."Seller/Buyer 2")
            //             // {
            //             //     ApplicationArea = all;
            //             //     Caption = 'Seller/Buyer';
            //             // }

            field("Bank on Invoice 2"; rec."Bank on Invoice 2")
            {
                Caption = 'Bank on Invoice';
                ApplicationArea = All;
            }//T-12855-AS

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
            //T12724 NE 07112024
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
        //T52085-NS
        addfirst(factboxes)
        {
            part("Inventory Details"; "Item Company Wise Inventory")
            {
                ApplicationArea = all;
                Provider = SalesLines;
                SubPageLink = "Item No." = field("No.");
            }
        }
        //T52085-NE
    }

    //     actions
    //     {
    //         // Add changes to page actions here
    //         // modify(Print)
    //         // {
    //         //     trigger OnBeforeAction()
    //         //     var
    //         //         myInt: Integer;
    //         //     begin
    //         //         if Rec.Status <> Rec.Status::Released then Error('Blanket Sales Order must approved and released');
    //         //     end;
    //         // }
    //     }

    //     var
    //         myInt: Integer;
}