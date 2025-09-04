pageextension 58001 SO extends "Sales Order"//T12370-Full Comment
{
    layout
    {
        //27-07-2022-start
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
            //     field("Amount LCY"; Rec."Amount LCY")
            //     {
            //         ApplicationArea = All;
            //         Editable = false;
            //         Enabled = false;
            //     }
            field("Customer Incentive Point (CIP)"; Rec."Customer Incentive Point (CIP)")//Hypercare 07-03-2025
            {
                ApplicationArea = All;
                Editable = false;
            }
            //     field("Proposed Delivery Date"; Rec."Promised Delivery Date")
            //     {
            //         Caption = 'Proposed Delivery Date';
            //         ApplicationArea = All;
            //         Editable = true;
            //     }
        }
        //27-07-2022-end
        // addafter("Currency Code")
        // {
        //     field("Shipping No."; rec."Shipping No.")
        //     {
        //         ApplicationArea = all;
        //     }

        //     field("Prepmt. Cr. Memo No."; rec."Prepmt. Cr. Memo No.")
        //     {
        //         ApplicationArea = all;
        //     }
        // }
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
        // modify("Payment Terms Code")
        // {
        //     Editable = false;
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
        //         // comp_info.get();
        //         // if comp_info.Company_Classification = 'UAE-FZ' then rec.DDP_validation();
        //     END;
        // }
        // modify("Bank on Invoice 2") //PackingListExtChange
        // {
        //     trigger OnAfterValidate()
        //     var
        //         myInt: Integer;
        //     begin
        //         rec.TestStatusOpen();
        //     end;
        // }
        // modify("Sell-to Customer Name")
        // {
        //     Caption = 'Customer Full Name';
        // }
        // modify("Bill-to Contact No.")
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
        // modify("Sell-to Contact No.")
        // {
        //     Visible = false;
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

        modify("Area")
        {
            Caption = 'Port of Discharge';
            //     trigger OnAfterValidate()
            //     var
            //         myInt: Integer;
            //     begin
            //         rec.TestStatusOpen();
            //     end;
        }
        modify("Exit Point")
        {
            Caption = 'Port of Loading';
            // trigger OnAfterValidate()
            // var
            //     myInt: Integer;
            // begin
            //     rec.TestStatusOpen();
            // end;
        }
        //08-08-2022-start
        // addafter("Exit Point")
        // {
        //     field("Customer Final Destination"; Rec."Customer Final Destination")
        //     {
        //         ApplicationArea = All;
        //     }
        // }
        // //08-08-2022-end
        // modify("Transport Method")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         myInt: Integer;
        //     begin
        //         rec.TestStatusOpen();
        //     end;
        // }

        // modify("Campaign No.")
        // {
        //     Visible = false;
        // }
        // modify("Opportunity No.")
        // {
        //     Visible = false;
        // }
        // modify("Assigned User ID")
        // {
        //     Visible = false;
        // }
        // modify("Payment Method Code")
        // {
        //     Visible = false;
        // }
        // modify("Pmt. Discount Date")
        // {
        //     Visible = false;
        // }
        // modify("Direct Debit Mandate ID")
        // {
        //     Visible = false;
        // }
        // modify("Prepmt. Pmt. Discount Date")
        // {
        //     Visible = false;
        // }
        // modify("Transaction Type")
        // {
        //     Visible = true;
        //     Caption = 'Order Type';
        // }
        // modify("Requested Delivery Date")
        // {
        //     Visible = false;
        // }

        // modify("Prices Including VAT")
        // {
        //     Visible = false;
        // }
        // modify("EU 3-Party Trade")
        // {
        //     Visible = false;
        // }
        // modify(SelectedPayments)
        // {
        //     Visible = false;
        // }
        // modify("Shortcut Dimension 2 Code")
        // {
        //     Visible = false;
        // }
        // modify("Order Date")
        // {
        //     Editable = false;
        // }
        // modify("Shortcut Dimension 1 Code")
        // {
        //     Visible = false;
        // }
        // modify("Payment Discount %")
        // {
        //     Visible = false;
        // }
        // modify("Shipment Date")
        // {
        //     Visible = false;
        // }
        // modify("Shipping Advice")
        // {
        //     Visible = false;
        // }
        // modify("Late Order Shipping")
        // {
        //     Visible = false;
        // }
        // modify("Outbound Whse. Handling Time")
        // {
        //     Visible = false;
        // }
        // modify("Shipping Time")
        // {
        //     Visible = false;
        // }
        // modify("Combine Shipments")
        // {
        //     Visible = false;
        // }
        // modify("Shipping Agent Code")
        // {
        //     Visible = false;
        // }
        // modify("Shipping Agent Service Code")
        // {
        //     Visible = false;
        // }
        // modify("Package Tracking No.")
        // {
        //     Visible = false;
        // }
        // modify("Prepayment %")
        // {
        //     Visible = false;
        // }
        // modify("Prepayment Due Date")
        // {
        //     Visible = false;
        // }
        // modify("Compress Prepayment")
        // {
        //     Visible = false;
        // }
        // modify("Prepmt. Payment Discount %")
        // {
        //     Visible = false;
        // }
        // modify("Prepmt. Payment Terms Code")
        // {
        //     Visible = false;
        // }
        // modify("Shipment Method")
        // {
        //     Visible = false;
        // }

        // modify("Shipment Method Code")
        // {
        //     Visible = false;
        // }

        // modify(Control1901314507)
        // {
        //     Visible = false;
        // }
        // moveafter(Status; "Currency Code")
        // moveafter("Currency Code"; "Payment Terms Code")
        // moveafter("SO Details"; Control1900316107)
        // moveafter("Transaction Specification"; "Customer Port of Discharge")
        // moveafter(Status; "Transaction Type")

        addafter("Shipping and Billing")
        {
            group("Additional")
            {
                //         Caption = 'Additional';
                //         Enabled = Rec."Sell-to Customer No." <> '';
                //         group(Control53000)
                //         {
                //             ShowCaption = false;
                //             group(Control53001)
                //             {
                //                 ShowCaption = false;
                //                 //Visible = NOT (ShipToOptions = ShipToOptions::"Default (Sell-to Address)");
                //                 field("Clearance Ship-to Code"; Rec."Clearance Ship-to Code")
                //                 {
                //                     ApplicationArea = Suite;
                //                     Caption = 'Clearance Ship-to Code';
                //                     //Editable = ShipToOptions = ShipToOptions::"Alternate Shipping Address";
                //                     Importance = Promoted;
                //                     //ToolTip = 'Specifies the code for another shipment address than the customer''s own address, which is entered by default.';

                //                 }
                //                 field("Clearance Ship-to Name"; Rec."Clearance Ship-to Name")
                //                 {
                //                     ApplicationArea = Suite;
                //                     Caption = 'Clearance Ship-to Name';
                //                     //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                //                     //ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                //                 }
                //                 field("Clearance Ship-to Address"; Rec."Clearance Ship-to Address")
                //                 {
                //                     ApplicationArea = Suite;
                //                     Caption = 'Clearance Ship-to Address';
                //                     //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                //                     QuickEntry = false;
                //                     //ToolTip = 'Specifies the address that products on the sales document will be shipped to. By default, the field is filled with the value in the Address field on the customer card or with the value in the Address field in the Ship-to Address window.';
                //                 }
                //                 field("Clearance Ship-to Address 2"; Rec."Clearance Ship-to Address 2")
                //                 {
                //                     ApplicationArea = Suite;
                //                     Caption = 'Clearance Ship-to Address 2';
                //                     //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                //                     QuickEntry = false;
                //                     //ToolTip = 'Specifies an additional part of the shipping address.';
                //                 }
                //                 field("Clearance Ship-to Post Code"; Rec."Clearance Ship-to Post Code")
                //                 {
                //                     ApplicationArea = Suite;
                //                     Caption = 'Clearance Ship-to Post Code';
                //                     //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                //                     QuickEntry = false;
                //                     //ToolTip = 'Specifies the postal code of the shipping address.';
                //                 }
                //                 field("Clearance Ship-to City"; Rec."Clearance Ship-to City")
                //                 {
                //                     ApplicationArea = Suite;
                //                     Caption = 'Clearance Ship-to City';
                //                     //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                //                     QuickEntry = false;
                //                     //ToolTip = 'Specifies the city of the shipping address.';
                //                 }
                //                 field("Clear.Ship-to Country/Reg.Code"; Rec."Clear.Ship-to Country/Reg.Code")
                //                 {
                //                     ApplicationArea = Suite;
                //                     Caption = 'Clearance Ship-to Country/Region Code';
                //                     //Editable = ShipToOptions = ShipToOptions::"Custom Address";
                //                     Importance = Additional;
                //                     QuickEntry = false;
                //                     //ToolTip = 'Specifies the country/region of the shipping address.';
                //                 }
                //             }
                //             field("Clearance Ship-to Contact"; Rec."Clearance Ship-to Contact")
                //             {
                //                 ApplicationArea = Suite;
                //                 Caption = 'Clearance Ship-to Contact';
                //                 //ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.';
                //             }
                //         }
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
        //     field("Credit Limit Percentage"; Rec."Credit Limit Percentage")
        //     {
        //         ApplicationArea = All;
        //         Enabled = false;
        //         Visible = false;
        //     }
        //     field("Credit Limit 1st Range"; Rec."Credit Limit 1st Range")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Credit Limit 2nd Range"; Rec."Credit Limit 2nd Range")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Credit Limit 3rd Range"; Rec."Credit Limit 3rd Range")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Advance Payment__"; Rec."Advance Payment")
        //     {
        //         ApplicationArea = All;
        //         Enabled = false;
        //         Caption = 'Advance Payment';
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
    }
    actions
    {
        //additional customization +
        addlast(processing)
        {
            action("Refresh")
            {
                ApplicationArea = All;
                Image = Refresh;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Utility: Codeunit Events;
                begin
                    Utility.UpdatePriceChangeRange(Rec);
                    CurrPage.Update();
                end;
            }
        }
        //-

        addafter("Print Confirmation")
        {
            /*  action("Print Commercial Invoice")
              {
                  Image = PrintVoucher;
                  Promoted = true;
                  PromotedCategory = Category11;
                  PromotedIsBig = true;
                  ApplicationArea = all;
                  trigger OnAction()
                  var
                      Sales_Header: Record "Sales Header";
                  begin
                      Sales_Header.Reset();
                      CurrPage.SetSelectionFilter(Sales_Header);

                      if Sales_Header.FindFirst then
                          Report.RunModal(Report::Commercial_invoice_SO, true, true, Sales_Header);
                  end;
              }
              */
        }



        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                Sales_line: Record "Sales Line";
                item_charge: Record "Item Charge Assignment (Sales)";
            begin
                if rec."Payment Terms Code" <> 'FOC SAMPLE' then begin
                    rec.TestField("Salesperson Code");
                    emptyfield();
                    clear(Sales_line);
                    Sales_line.SetRange("Document Type", rec."Document Type");
                    Sales_line.SetRange("Document No.", rec."No.");
                    Sales_line.SetFilter(Type, '%1|%2', Sales_line.Type::"Charge (Item)", Sales_line.Type::Item);
                    if Sales_line.FindSet() then
                     //comment
                     begin
                        repeat
                            if Sales_line.Type = Sales_line.Type::Item then begin
                                Sales_line.TestField("Unit of Measure Code");
                                Sales_line.TestField("Location Code");
                            end;
                        /* if rec."Bill-to IC Partner Code" = '' then //UAT 12-11-2024
                            Sales_line.TestField("Blanket Order No."); */
                        until Sales_line.Next() = 0;
                    end;

                    clear(Sales_line);
                    Sales_line.SetRange("Document Type", Rec."Document Type");
                    Sales_line.SetRange("Document No.", Rec."No.");
                    Sales_line.SetRange(Type, Sales_line.Type::"Charge (Item)");
                    Sales_line.Setfilter("Qty. to Ship", '<>0');
                    if Sales_line.FindSet() then begin
                        Sales_line.CalcSums("Qty. to Ship");
                        clear(item_charge);
                        item_charge.SetRange("Document Type", Rec."Document Type");
                        item_charge.SetRange("Document No.", Rec."No.");
                        if item_charge.FindSet() then begin
                            item_charge.CalcSums("Qty. to Assign");
                            if Sales_line."Qty. to Ship" <> item_charge."Qty. to Assign" then
                                Error('Item Charges Must be completely Assigned')
                        end;
                    end;
                end;


                // //item charge assignment
                // begin
                //     if item_charge.FindSet() then
                //         item_charge.SetRange("Document No.", Rec."No.");
                //     item_charge.CalcSums("Qty. to Assign");
                //     if Sales_line.FindSet() then
                //         Sales_line.SetRange("Document No.", Rec."No.");
                //     Sales_line.SetRange(Type, Sales_line.Type::"Charge (Item)");
                //     Sales_line.CalcSums("Qty. to Ship");
                //     if Sales_line."Qty. to Ship" = item_charge."Qty. to Assign" then exit else Error('Item Charges Must be completely Assigned');
                // end;
            end;
        }
        // modify(Release)
        // {
        //     trigger OnBeforeAction()
        //     var
        //         Sales_Line: Record "Sales Line";
        //         Usersetup: Record "User Setup";
        //     begin
        //         emptyfield();
        //         Sales_line.SetRange("Document No.", rec."No.");
        //         Sales_line.SetRange("Document Type", rec."Document Type");
        //         Sales_line.SetRange(Type, Sales_line.Type::Item);
        //         if Sales_line.FindSet() then
        //             repeat
        //                 if Sales_line.Type = Sales_line.Type::Item then if Sales_line."Unit of Measure Code" = '' then Error('Unit of Measure Code Cannot be empty');
        //                 if Sales_line.Type = Sales_line.Type::Item then if Sales_line."Location Code" = '' then Error('Location Code Cannot be Empty for Item %1', Sales_line.Description);
        //                 if Usersetup.Get(UserId) then
        //                     if Usersetup."Allow IC Docs Without Relation" = false then begin
        //                         if rec."Bill-to IC Partner Code" <> '' then if Sales_line."IC Related SO" = '' then Error('Item %1 does not have IC related Sales Order No.', Sales_line.Description);
        //                     end;
        //             until Sales_line.Next() = 0;
        //         exit
        //     end;
        // }
        // modify(Post)
        // {
        //     trigger OnBeforeAction()
        //     var
        //         Sales_line: Record "Sales Line";
        //         Usersetup: Record "User Setup";
        //         Err_label: Label 'IC Related SO Field is empty for item %1 Please verify before posting';
        //     begin
        //         rec."Document Date" := rec."Posting Date";
        //         rec.Validate("Payment Terms Code");

        //         Sales_line.SetRange("Document No.", rec."No.");
        //         Sales_line.SetRange("Document Type", rec."Document Type");
        //         Sales_line.SetRange(Type, Sales_line.Type::Item);
        //         if Sales_line.FindSet() then
        //             repeat
        //                 //  if Sales_line.Type = Sales_line.Type::Item then if Sales_line."Unit of Measure Code" = '' then Error('Unit of Measure Code Cannot be empty');
        //                 //if Sales_line.Type = Sales_line.Type::Item then if Sales_line."Location Code" = '' then Error('Location Code Cannot be Empty for Item %1', Sales_line.Description);
        //                 if Usersetup.Get(UserId) then
        //                     if Usersetup."Allow IC Docs Without Relation" = false then begin
        //                         if rec."Bill-to IC Partner Code" <> '' then if Sales_line."IC Related SO" = '' then Error('Item %1 does not have IC related Sales Order No.', Sales_line.Description);
        //                     end;
        //             until Sales_line.Next() = 0;

        //     end;
        // }
        // addafter(Dimensions)
        // {
        //     action(Approvals_)
        //     {
        //         AccessByPermission = TableData "Approval Entry" = R;
        //         ApplicationArea = Suite;
        //         Caption = 'Approvals';
        //         Image = Approvals;
        //         Promoted = true;
        //         PromotedCategory = Category8;
        //         ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

        //         trigger OnAction()
        //         var
        //             ApprovalEntry: Record "Approval Entry";
        //             ApprovalEntries: Page "Approval Entries";
        //         begin
        //             clear(ApprovalEntry);
        //             ApprovalEntry.SetRange("Table ID", Database::"Sales Header");
        //             ApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type"::Order);
        //             ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordId);
        //             if ApprovalEntry.FindSet() then;
        //             ApprovalEntries.SetTableView(ApprovalEntry);
        //             ApprovalEntries.Run();
        //         end;
        //     }

        // }
        // modify(Approvals)
        // {
        //     Visible = false;
        // }
    }
    // local procedure DDP_validation()
    // var
    //     customer: Record Customer;
    // Begin
    //     if (rec."Transaction Specification" = 'DDP') and (rec."VAT Bus. Posting Group" = 'C-LOCAL')
    //                            then
    //         rec.Validate("VAT Bus. Posting Group", 'C-Local-DDP')
    //     else
    //         if rec."Transaction Specification" <> 'DDP'
    //        then begin
    //             customer.get(rec."Bill-to Customer No.");
    //             rec.Validate("VAT Bus. Posting Group", customer."VAT Bus. Posting Group")
    //         end;
    // End;

    local procedure emptyfield()
    var
    begin
        // if rec."Transaction Specification" = '' then Error('Incoterm Cannot be empty'); //T12724
        // Rec.TestField("Transport Method");  //T12724
        //if rec."Area" = '' then Error('Port of Discharge Cannot be empty'); //T12724
        // if rec."Exit Point" = '' then Error('Port of Loading Cannot be empty'); //T12724
        if rec."External Document No." = '' then Error('Customer Purchase Ref. Cannot be Empty');

        //if rec."Transport Method" = '' then Error('Transport Method Cannot be empty');
        // TestField("External Document No.");
    end;

    /*  trigger OnAfterGetRecord()
      var
          SalesPrec: Record "Salesperson/Purchaser";
      begin
          if SalesPrec.get("Salesperson Code") then;
          SP := SalesPrec.Name;
      end;
  */
    //+
    // trigger OnAfterGetRecord()
    // begin
    //     CurrPage.Update(false);
    //     SPEditable();
    // end;
    // //-
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

    var
        SP: Text[100];
        SalespersonEditable: Boolean;
}