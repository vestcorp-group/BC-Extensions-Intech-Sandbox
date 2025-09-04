pageextension 58009 BSO extends "Blanket Sales Order"//T12370-Full Comment //T12724
{
    layout
    {
        // //27-07-2022-start
        addlast(General)
        {
            //     field("Release Of Shipping Document"; Rec."Release Of Shipping Document")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Courier Details"; Rec."Courier Details")
            //     {
            //         ApplicationArea = All;
            //         MultiLine = true;
            //     }
            //     field("Free Time Requested"; Rec."Free Time Requested")
            //     {
            //         ApplicationArea = All;
            //         MultiLine = true;
            //     }
            field("Customer Incentive Point (CIP)"; Rec."Customer Incentive Point (CIP)")//Hypercare 07-03-2025
            {
                ApplicationArea = All;
                Editable = false;
            }
            //     field("Proposed Delivery Date"; Rec."Promised Delivery Date")
            //     {
            //         Caption = 'Proposed Delivery Date';
            //         ApplicationArea = all;
            //         Editable = true;
            //     }
            //     field("Shipping Advice"; rec."Shipping Advice")
            //     {
            //         ApplicationArea = all;
            //         Visible = true;
            //     }
        }
        //27-07-2022-end
        // addfirst(factboxes)
        // {
        //     part("SO Details"; SalesdocumentDetailFactbox)
        //     {
        //         ApplicationArea = all;
        //         SubPageLink = "No." = field("No.");
        //         SubPageView = sorting();
        //     }
        //     part("Inventory Details"; "Item Company Wise Inventory")
        //     {
        //         ApplicationArea = all;
        //         Provider = SalesLines;
        //         SubPageLink = "Item No." = field("No.");
        //     }
        // }
        // addafter("Payment Terms Code")
        // {
        //     field("Advance Payment"; rec."Advance Payment")
        //     {
        //         ApplicationArea = all;
        //         Visible = false;
        //     }
        //     field("Management Approval"; rec."Management Approval")
        //     {
        //         ApplicationArea = all;
        //         Visible = false;
        //     }
        // }
        // modify("Transaction Specification")
        // {
        //     Caption = 'Incoterm';
        //     trigger OnAfterValidate()
        //     var
        //         comp_info: Record "Company Information";
        //     begin
        //         rec.TestStatusOpen();
        //         if rec."Transaction Specification" = 'DDP-DE' then
        //             Error('DDP-DE is not a Valid Incoterm');
        //         //comp_info.get();
        //         //if comp_info.Company_Classification = 'UAE-FZ' then rec.DDP_validation();
        //     END;
        // }

        addlast(General)
        {
            group(ApprovalDetails)
            {
                Caption = 'Approval Reason & Details';


                field("Item Description Approval"; Rec."Item Description Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Description Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("HSN Code Approval"; Rec."HSN Code Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HSN Code Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Country Of Origin Approval"; Rec."Country Of Origin Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country Of Origin Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Minimum Initial Price Approval"; Rec."Minimum Initial Price Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Initial Price Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Minimum Selling Price Approval"; Rec."Minimum Selling Price Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Selling Price Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Payment Terms Approval"; Rec."Payment Terms Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Terms Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Shipping Address Approval"; Rec."Shipping Address Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Address Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Shipment Method Approval"; Rec."Shipment Method Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipment Method Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Shorter Delivery Date Approval"; Rec."Shorter Delivery Date Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shorter Delivery Date Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Advance Payment Approval"; Rec."Advance Payment Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Advance Payment Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
            }
        }
        modify("Exit Point")
        {
            Caption = 'Port of Loading';
        }
        modify("Area")
        {
            Caption = 'Port of Discharge';
        }
        // modify("Campaign No.")
        // {
        //     Visible = false;
        // }
        // modify("Assigned User ID")
        // {
        //     Visible = false;
        // }
        // modify("Transaction Type")
        // {
        //     Visible = true;
        //     Caption = 'Order Type';
        // }
        // moveafter(Status; "Transaction Type")
        // modify("Shortcut Dimension 2 Code")
        // {
        //     Visible = false;
        // }
        // modify("Pmt. Discount Date")
        // {
        //     Visible = false;
        // }
        // modify("Payment Discount %")
        // {
        //     Visible = false;
        // }
        // modify("Location Code")
        // {
        //     Visible = false;
        // }
        // modify("Your Reference")
        // {
        //     Caption = 'IC SO Reference';
        // }
        // modify("External Document No.")
        // {
        //     Caption = 'Customer Purchase Ref';
        // }
        // modify("Payment Method Code")
        // {
        //     Visible = false;
        // }
        // modify("Shortcut Dimension 1 Code")
        // {
        //     Visible = false;
        // }
        // modify("Prices Including VAT")
        // {
        //     Visible = false;
        // }
        // modify("Shipment Date")
        // {
        //     Visible = false;
        // }
        // modify("EU 3-Party Trade")
        // {
        //     Visible = false;
        // }

        // modify(Control1902018507)
        // {
        //     Visible = false;
        // }
        // moveafter(Status; "Currency Code")
        // moveafter("Currency Code"; "Payment Terms Code")
        //T12724 NS 07112024
        addafter("Shipping and Billing")
        {
            group("Additional")
            {
                Caption = 'Additional';
                Enabled = Rec."Sell-to Customer No." <> '';
                group(Control53000)
                {
                    ShowCaption = false;
                    group(Control53001)
                    {
                        ShowCaption = false;
                        //Visible = NOT (ShipToOptions = ShipToOptions::"Default (Sell-to Address)");
                        field("Clearance Ship-to Code"; Rec."Clearance Ship-to Code")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Clearance Ship-to Code';
                            //Editable = ShipToOptions = ShipToOptions::"Alternate Shipping Address";
                            Importance = Promoted;
                            //ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';

                        }
                        field("Clearance Ship-to Name"; Rec."Clearance Ship-to Name")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Clearance Ship-to Name';
                            //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                            //ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                        }
                        field("Clearance Ship-to Address"; Rec."Clearance Ship-to Address")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Clearance Ship-to Address';
                            //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                            QuickEntry = false;
                            //ToolTip = 'Specifies the address that products on the sales document will be shipped to. By default, the field is filled with the value in the Address field on the customer card or with the value in the Address field in the Ship-to Address window.';
                        }
                        field("Clearance Ship-to Address 2"; Rec."Clearance Ship-to Address 2")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Clearance Ship-to Address 2';
                            //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                            QuickEntry = false;
                            //ToolTip = 'Specifies an additional part of the shipping address.';
                        }
                        field("Clearance Ship-to Post Code"; Rec."Clearance Ship-to Post Code")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Clearance Ship-to Post Code';
                            //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                            QuickEntry = false;
                            //ToolTip = 'Specifies the postal code of the shipping address.';
                        }
                        field("Clearance Ship-to City"; Rec."Clearance Ship-to City")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Clearance Ship-to City';
                            //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                            QuickEntry = false;
                            //ToolTip = 'Specifies the city of the shipping address.';
                        }
                        field("Clear.Ship-to Country/Reg.Code"; Rec."Clear.Ship-to Country/Reg.Code")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Clearance Ship-to Country/Region Code';
                            //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                            Importance = Additional;
                            QuickEntry = false;
                            //ToolTip = 'Specifies the country/region of the shipping address.';
                        }
                    }
                    field("Clearance Ship-to Contact"; Rec."Clearance Ship-to Contact")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Clearance Ship-to Contact';
                        //ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.';
                    }
                }
            }
        }
        //T12724 NE 07112024

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

        //+
        // addlast(General)
        // {
        //     field("Salesperson Name"; Rec."Salesperson Name")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
        //     }
        //     field("Sub Status"; Rec."Sub Status")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
        //     }
        //     field("Payment Terms Changed"; Rec."Payment Terms Changed")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Price Changed"; Rec."Price Changed")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Price Change %"; Rec."Price Change %")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Price Change % 1st Range"; Rec."Price Change % 1st Range")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Price Change % 2nd Range"; Rec."Price Change % 2nd Range")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Price Change % 3rd Range"; Rec."Price Change % 3rd Range")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Excess Payment Terms Days"; Rec."Excess Payment Terms Days")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Advance Payment__"; Rec."Advance Payment")
        //     {
        //         ApplicationArea = All;
        //         Caption = 'Advance Payment';
        //         Editable = false;
        //         Visible = false;
        //     }
        // }
        // modify("Salesperson Code")
        // {
        //     Editable = SalespersonEditable;
        //     trigger OnAfterValidate()
        //     begin
        //         CurrPage.Update(true);
        //     end;

        // }
        // //-

        // //08-08-2022-start
        // addafter("Exit Point")
        // {
        //     field("Customer Final Destination"; Rec."Customer Final Destination")
        //     {
        //         ApplicationArea = All;
        //     }
        // }
        // //08-08-2022-end
    }
    actions
    {

        // //+
        // addlast(processing)
        // {
        //     action("Refresh")
        //     {
        //         ApplicationArea = All;
        //         Image = Refresh;
        //         Promoted = true;
        //         PromotedOnly = true;
        //         PromotedCategory = Process;
        //         trigger OnAction()
        //         var
        //             Utility: Codeunit Events;
        //         begin
        //             Utility.UpdatePriceChangeRange(Rec);
        //             CurrPage.Update(false);
        //         end;
        //     }
        // }
        // //-
        // modify(MakeOrder)
        // {
        //     trigger OnBeforeAction()
        //     var
        //     begin
        //         rec.TestField("Salesperson Code");
        //     end;
        // }
        // modify(Print)
        // {
        //     trigger OnBeforeAction()
        //     var
        //         myInt: Integer;
        //     begin
        //         if Rec.Status <> Rec.Status::Released then Error('Blanket Sales Order must approved and released');
        //     end;
        // }
        // modify(SendApprovalRequest)
        // {
        //     trigger OnBeforeAction()
        //     var
        //         myInt: Integer;
        //         Sales_line: Record "Sales Line";
        //     begin
        //         clear(Sales_line);
        //         Sales_line.SetRange("Document Type", rec."Document Type");
        //         Sales_line.SetRange("Document No.", rec."No.");
        //         Sales_line.SetRange(Type, Sales_line.Type::Item);
        //         if Sales_line.FindSet() then
        //             repeat
        //                 Sales_line.TestField("Unit of Measure Code");
        //                 //if Sales_line."Unit of Measure Code" = '' then Error('Unit of Measure Code Cannot be empty');
        //                 if Sales_line."Location Code" = '' then Error('Location Code Cannot be Empty for Item %1', Sales_line.Description);
        //             until Sales_line.Next() = 0;
        //     end;
        // }

        addafter(Print)
        {
            action("Print Preview1")
            {
                ApplicationArea = all;
                Caption = 'Print Preview';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;
                trigger OnAction()
                var
                    salesHeader: Record "Sales Header";
                begin
                    salesHeader.Reset();
                    salesHeader.SetRange("No.", Rec."No.");
                    if salesHeader.FindSet() then
                        Report.RunModal(Report::"BS PI Preview Clearance", true, true, salesHeader);
                end;
            }
            action("Proforma Invoice Export UAE")
            {
                ApplicationArea = all;
                Caption = 'Proforma Invoice Export R3 UAE';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;
                Visible = false;  //T53930-N
                trigger OnAction()
                var
                    salesHeader: Record "Sales Header";
                begin
                    salesHeader.Reset();
                    salesHeader.SetRange("No.", Rec."No.");
                    if salesHeader.FindSet() then
                        Report.RunModal(Report::"Proforma Invoice_Export UAE", true, true, salesHeader);
                end;
            }
            // action("Proforma Invoice Local UAE")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Proforma Invoice Local R3 UAE';
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     PromotedCategory = Category6;
            //     trigger OnAction()
            //     var
            //         salesHeader: Record "Sales Header";
            //     begin
            //         salesHeader.Reset();
            //         salesHeader.SetRange("No.", Rec."No.");
            //         if salesHeader.FindSet() then
            //             Report.RunModal(Report::"Proforma Invoice_Local UAE", true, true, salesHeader);
            //     end;
            // }


        }
        //18-10-2022-start
        // modify(AttachAsPDF)
        // {
        //     trigger OnBeforeAction()
        //     begin
        //         Rec.TestField(Status, Rec.Status::Released);
        //     end;
        // }
        //18-10-2022-end
    }
    // local procedure DDP_validation()
    // var
    //     customer: Record Customer;
    // Begin
    //     if (rec."Transaction Specification" = 'DDP') and (rec."VAT Bus. Posting Group" = 'C-LOCAL')
    //                            then
    //         rec.Validate("VAT Bus. Posting Group", 'C-LOCAL-DDP')
    //     else
    //         if rec."Transaction Specification" <> 'DDP'
    //        then begin
    //             customer.get(rec."Bill-to Customer No.");
    //             // rec.Validate("VAT Bus. Posting Group", customer."VAT Bus. Posting Group")
    //         end;


    // End;

    // trigger OnAfterGetRecord()
    // begin
    //     CurrPage.Update(false);
    //     SPEditable();
    // end;

    // trigger OnOpenPage()
    // begin
    //     SPEditable();
    // end;

    // local procedure SPEditable()
    // var
    //     RecCustomer: Record Customer;
    //     RecUsersetup: Record "Custom User Setup";
    // begin
    //     SalespersonEditable := false;
    //     if Rec."Bill-to Customer No." <> '' then
    //         RecCustomer.Get(Rec."Bill-to Customer No.");

    //     If RecCustomer."IC Company Code" <> '' then
    //         SalespersonEditable := true
    //     else
    //         SalespersonEditable := false;

    //     If RecUsersetup.Get(UserId) then
    //         If RecUsersetup."Allow Salesperson Modification" then
    //             SalespersonEditable := true;
    // end;

    // var
    //     SalespersonEditable: Boolean;
}