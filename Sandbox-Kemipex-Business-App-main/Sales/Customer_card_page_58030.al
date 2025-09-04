pageextension 58030 CustomerCard extends "Customer Card"//T12370-Full Comment
{
    layout
    {
        //         addafter("Customer Registration No.")
        //         {
        //             field("Market Industry Description"; rec."Market Industry Description")
        //             {
        //                 ApplicationArea = all;
        //                 Caption = 'Market Industry';
        //             }
        //             field("Block Email Distribution"; rec."Block Email Distribution")
        //             {
        //                 ApplicationArea = all;
        //             }
        //         }
        //         addafter("IC Partner Code")
        //         {
        //             field("Customer Disc. Group1"; Rec."Customer Disc. Group")
        //             {
        //                 ApplicationArea = All;
        //                 Visible = true;
        //                 Caption = 'Tier Ranking';
        //             }

        //         }
        //         addafter(Blocked)
        //         {
        //             field("Blocked Reason"; rec."Blocked Reason")
        //             {
        //                 ApplicationArea = All;
        //                 MultiLine = true;
        //             }
        //         }
        //         modify("IC Partner Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Document Sending Profile")
        //         {
        //             Visible = false;
        //         }
        //         modify("Disable Search by Name")
        //         {
        //             Visible = false;
        //         }
        //         modify("Language Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Bill-to Customer No.")
        //         {
        //             Visible = false;
        //         }
        //         modify(GLN)
        //         {
        //             Visible = false;
        //         }
        //         modify("Copy Sell-to Addr. to Qte From")
        //         {
        //             Visible = false;
        //         }
        //         modify("Customer Price Group")
        //         {
        //             Visible = false;
        //         }

        //         modify("Allow Line Disc.")
        //         {
        //             Visible = false;
        //         }
        //         modify("Invoice Disc. Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Prices Including VAT")
        //         {
        //             Visible = false;
        //         }
        //         modify("Application Method")
        //         {
        //             Visible = false;
        //         }
        //         modify("Payment Method Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Reminder Terms Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Fin. Charge Terms Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Cash Flow Payment Terms Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Print Statements")
        //         {
        //             Visible = false;
        //         }
        //         modify("Last Statement No.")
        //         {
        //             Visible = false;
        //         }
        //         modify("Block Payment Tolerance")
        //         {
        //             Visible = false;
        //         }
        //         modify("Preferred Bank Account Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Location Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Combine Shipments")
        //         {
        //             Visible = false;
        //         }

        //         modify("Shipping Advice")
        //         {
        //             Visible = false;
        //         }
        //         modify("Primary Contact No.")
        //         {
        //             Visible = false;
        //         }
        //         modify("Partner Type")
        //         {
        //             Visible = false;
        //         }
        //         modify("Base Calendar Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Customized Calendar")
        //         {
        //             Visible = false;
        //         }
        //         modify("Shipment Method Code")
        //         {
        //             Caption = 'Shipment Method Code';
        //         }
        //         modify("Home Page")
        //         {
        //             Caption = 'Website';
        //         }
        //         modify("Ship-to Code")
        //         {
        //             Caption = 'Alternate Shipping Address';
        //         }
        //         modify("Phone No.")
        //         {
        //             Caption = 'Landline';
        //         }
        //         modify("Shipping Agent Code")
        //         {
        //             Caption = 'Shipping Agent';
        //         }
        //         modify("Shipping Agent Service Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Shipping Time")
        //         {
        //             Visible = false;
        //         }
        //         modify("Search Name")
        //         {
        //             Visible = true;
        //             Caption = 'Customer Short Name';
        //         }
        //         moveafter("Phone No."; "Fax No.")

        //         addafter("Shipment Method")
        //         {
        //             group("Additional")
        //             {
        //                 Caption = 'Additional';
        //                 //Enabled = "Sell-to Customer No." <> '';
        //                 group(Control53000)
        //                 {
        //                     ShowCaption = false;
        //                     group(Control53001)
        //                     {
        //                         ShowCaption = false;
        //                         //Visible = NOT (ShipToOptions = ShipToOptions::"Default (Sell-to Address)");
        //                         field("Clearance Ship-To Address"; Rec."Clearance Ship-To Address")
        //                         {
        //                             ApplicationArea = Suite;
        //                             Caption = 'Clearance Ship-to Address';
        //                             //Editable = ShipToOptions = ShipToOptions::"Alternate Shipping Address";
        //                             Importance = Promoted;
        //                             //ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';

        //                         }
        //                     }
        //                 }
        //             }
        //         }

        addafter(Shipping)
        {
            group("Agent Representative")
            {
                Caption = 'Agent Representative';

                field("Agent Rep. Code"; Rec."Agent Rep. Code")
                {
                    ApplicationArea = All;
                    Caption = 'Agent Rep. Code';
                    ToolTip = 'Specifies a link to select Agent Representative.';
                }
            }
        }

        //         //Gross Profit
        //         addlast(General)
        //         {
        //             field("IC Company Code"; Rec."IC Company Code")
        //             {
        //                 ApplicationArea = All;
        //             }
        //             //08-08-2022-start
        //             field("Customer Final Destination"; Rec."Customer Final Destination")
        //             {
        //                 ApplicationArea = All;
        //             }
        //             //08-08-2022-end

        //             field("CRM Code"; Rec."CRM Code")
        //             {
        //                 ApplicationArea = All;
        //                 ShowMandatory = true;
        //             }
        //         }

        //         //12-08-2022-start
        //         addlast(Payments)
        //         {
        //             field("Place of Export"; Rec."Place of Export")
        //             {
        //                 ApplicationArea = All;
        //             }
        //             field("EORI Number_"; Rec."EORI Number")
        //             {
        //                 ApplicationArea = All;
        //                 Caption = 'EORI Number';
        //             }
        //         }
        //         //12-08-2022-end
    }


    actions
    {
        //         // modify("Transfer Record")
        //         // {
        //         //     Visible = false;
        //         //     Enabled = false;
        //         // }

        // T13353-NS 15-01-2025 Action uncommented
        addfirst(Creation)
        {
            action(Release)
            {
                Caption = 'Release to Companies';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                    altCustRec: Record "Customer Alternet Address";
                begin
                    //rec.CopyCust_Reg_type();
                    rec.companytransfer2(xRec, true);
                end;
            }
        }
        // T13353-NE 15-01-2025 Action uncommented
    }

    //     trigger OnDeleteRecord(): Boolean
    //     begin
    //         Error('Not allowed to delete the record!');
    //     end;

    //     var
    //         myInt: Integer;
}