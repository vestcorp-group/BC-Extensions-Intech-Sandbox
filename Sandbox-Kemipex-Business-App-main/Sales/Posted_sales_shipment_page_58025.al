pageextension 58025 PostedSalesSh50223 extends "Posted Sales Shipment"//T12370-Full Comment
{
    layout
    {
        //         //27-07-2022-start
        addlast(General)
        {
            //             field("Release Of Shipping Document"; Rec."Release Of Shipping Document")
            //             {
            //                 ApplicationArea = All;
            //             }
            //             field("Courier Details"; Rec."Courier Details")
            //             {
            //                 ApplicationArea = All;
            //                 MultiLine = true;
            //             }
            //             field("Free Time Requested"; Rec."Free Time Requested")
            //             {
            //                 ApplicationArea = All;
            //                 MultiLine = true;
            //             }
            field("Customer Incentive Point (CIP)"; Rec."Customer Incentive Point (CIP)")//Hypercare 07-03-2025
            {
                ApplicationArea = All;
                Editable = false;
            }
            //             field("Transaction Type"; rec."Transaction Type")
            //             {
            //                 ApplicationArea = all;
            //                 Caption = 'Order Type';
            //             }
        }
        //         //27-07-2022-end 
        //         addlast(Shipping)
        //         {
        //             field("Area"; rec."Area")
        //             {
        //                 ApplicationArea = All;
        //                 Caption = 'Port of Discharge';
        //                 Editable = false;
        //             }
        //             field("Exit Point"; rec."Exit Point")
        //             {
        //                 ApplicationArea = all;
        //                 Caption = 'Port of Loading';
        //                 Editable = false;
        //             }
        //             field("Transaction Specification"; rec."Transaction Specification")
        //             {
        //                 Caption = 'Incoterm';
        //                 ApplicationArea = all;
        //                 Editable = false;
        //             }
        //         }
        //         addlast(General)
        //         {
        //             field("Salesperson Name"; Rec."Salesperson Name")
        //             {
        //                 ApplicationArea = All;
        //                 Editable = false;
        //             }
        //             field("Your Reference"; Rec."Your Reference")
        //             {
        //                 ApplicationArea = all;
        //                 Editable = false;
        //                 Caption = 'IC SO Reference';
        //             }
        //         }

        addafter(Shipping)
        {
            group("Additional")
            {
                //                 Caption = 'Additional';
                //                 Enabled = Rec."Sell-to Customer No." <> '';
                //                 group(Control53000)
                //                 {
                //                     ShowCaption = false;
                //                     group(Control53001)
                //                     {
                //                         ShowCaption = false;
                //                         //Visible = NOT (ShipToOptions = ShipToOptions::"Default (Sell-to Address)");
                //                         field("Clearance Ship-to Code"; Rec."Clearance Ship-to Code")
                //                         {
                //                             ApplicationArea = Suite;
                //                             Caption = 'Clearance Ship-to Code';
                //                             //Editable = ShipToOptions = ShipToOptions::"Alternate Shipping Address";
                //                             Importance = Promoted;
                //                             //ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';

                //                         }
                //                         field("Clearance Ship-to Name"; Rec."Clearance Ship-to Name")
                //                         {
                //                             ApplicationArea = Suite;
                //                             Caption = 'Clearance Ship-to Name';
                //                             //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                //                             //ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                //                         }
                //                         field("Clearance Ship-to Address"; Rec."Clearance Ship-to Address")
                //                         {
                //                             ApplicationArea = Suite;
                //                             Caption = 'Clearance Ship-to Address';
                //                             //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                //                             QuickEntry = false;
                //                             //ToolTip = 'Specifies the address that products on the sales document will be shipped to. By default, the field is filled with the value in the Address field on the customer card or with the value in the Address field in the Ship-to Address window.';
                //                         }
                //                         field("Clearance Ship-to Address 2"; Rec."Clearance Ship-to Address 2")
                //                         {
                //                             ApplicationArea = Suite;
                //                             Caption = 'Clearance Ship-to Address 2';
                //                             //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                //                             QuickEntry = false;
                //                             //ToolTip = 'Specifies an additional part of the shipping address.';
                //                         }
                //                         field("Clearance Ship-to Post Code"; Rec."Clearance Ship-to Post Code")
                //                         {
                //                             ApplicationArea = Suite;
                //                             Caption = 'Clearance Ship-to Post Code';
                //                             //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                //                             QuickEntry = false;
                //                             //ToolTip = 'Specifies the postal code of the shipping address.';
                //                         }
                //                         field("Clearance Ship-to City"; Rec."Clearance Ship-to City")
                //                         {
                //                             ApplicationArea = Suite;
                //                             Caption = 'Clearance Ship-to City';
                //                             //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                //                             QuickEntry = false;
                //                             //ToolTip = 'Specifies the city of the shipping address.';
                //                         }
                //                         field("Clear.Ship-to Country/Reg.Code"; Rec."Clear.Ship-to Country/Reg.Code")
                //                         {
                //                             ApplicationArea = Suite;
                //                             Caption = 'Clearance Ship-to Country/Region Code';
                //                             //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                //                             Importance = Additional;
                //                             QuickEntry = false;
                //                             //ToolTip = 'Specifies the country/region of the shipping address.';
                //                         }
                //                     }
                //                     field("Clearance Ship-to Contact"; Rec."Clearance Ship-to Contact")
                //                     {
                //                         ApplicationArea = Suite;
                //                         Caption = 'Clearance Ship-to Contact';
                //                         //ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.';
                //                     }
                //                 }
            }
        }

        addafter(Additional)
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
                field("Agent Rep. Name"; Rec."Agent Rep. Name")
                {
                    ApplicationArea = All;
                }
                field("Agent Rep. Address"; Rec."Agent Rep. Address")
                {
                    ApplicationArea = All;
                }
                field("Agent Rep. Address 2"; Rec."Agent Rep. Address 2")
                {
                    ApplicationArea = All;
                }
                field("Agent Rep. City"; Rec."Agent Rep. City")
                {
                    ApplicationArea = All;
                }
                field("Agent Rep. Post Code"; Rec."Agent Rep. Post Code")
                {
                    ApplicationArea = All;
                }
                field("Agent Rep. Country/Region Code"; Rec."Agent Rep. Country/Region Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    //     trigger OnDeleteRecord(): Boolean
    //     begin
    //         Error('Not allowed to delete the record!');
    //     end;
}