pageextension 58005 PSIPage extends "Posted Sales Invoice"//T12370-Full Comment
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
            //             field("Salesperson Name"; Rec."Salesperson Name")
            //             {
            //                 ApplicationArea = All;
            //                 Editable = false;
            //             }
            field("Customer Incentive Point (CIP)"; Rec."Customer Incentive Point (CIP)") //Hypercare 07-03-2025
            {
                ApplicationArea = All;
                Editable = false;
            }
            //             field("Transaction Type"; rec."Transaction Type")
            //             {
            //                 ApplicationArea = all;
            //                 Caption = 'Order Type';
            //             }
            //         }
            //         //27-07-2022-end
            //         // Add changes to page layout here
            //         modify("Transaction Specification")
            //         {
            //             Caption = 'Incoterm';
        }
        modify("Area")
        {
            Caption = 'Port of Discharge';
        }

        //         modify("Shipment Date")
        //         {
        //             Visible = false;
        //         }
        modify("Exit Point")
        {
            Caption = 'Port of Loading';
        }
        //         modify("External Document No.")
        //         {
        //             Caption = 'Customer Purchase Ref.';
        //         }
        //         modify("Shortcut Dimension 1 Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Shipping Agent Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Package Tracking No.")
        //         {
        //             Visible = false;
        //         }
        //         modify("Pmt. Discount Date")
        //         {
        //             Visible = false;
        //         }
        //         modify("Payment Discount %")
        //         {
        //             Visible = false;
        //         }
        //         modify("Direct Debit Mandate ID")
        //         {
        //             Visible = false;
        //         }
        //         modify("No. Printed")
        //         {
        //             Visible = false;
        //         }
        //         modify("Shortcut Dimension 2 Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Your Reference")
        //         {
        //             Caption = 'IC SO Reference';
        //         }
        //         modify(BillOfExit)
        //         {
        //             Caption = 'Declaration No.';
        //             Editable = true;
        //             Enabled = BOE_boolean;
        //             trigger OnAfterValidate()
        //             var
        //             begin
        //                 if rec.BillOfExit <> '' then BOE_boolean := false;
        //             end;
        //         }
        //         addbefore(BillOfExit)
        //         {
        //             field("Custom Declaration Type"; rec."Declaration Type")
        //             {
        //                 ApplicationArea = all;
        //                 Enabled = BOE_boolean;
        //                 trigger OnValidate()
        //                 var
        //                     YesUpdate: Boolean;
        //                 begin
        //                     if (rec."Declaration Type" = rec."Declaration Type"::Direct) then
        //                         rec.Validate(BillOfExit, Format(rec."Declaration Type"));
        //                     if rec.BillOfExit = 'Direct' then BOE_boolean := false;
        //                 end;
        //             }
        //         }
        //         addafter("Due Date")
        //         {
        //             field("Actual Shipment Date"; rec."Actual Shipment Date")
        //             {
        //                 ApplicationArea = all;
        //             }
        //         }

        addafter("Shipping and Billing")
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
                //                }
            }
        }
        //T13797-NS
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

        //T13797-NE


        //         //08-08-2022-start
        //         addafter("Exit Point")
        //         {
        //             field("Customer Final Destination"; Rec."Customer Final Destination")
        //             {
        //                 ApplicationArea = All;
        //                 Editable = false;
        //             }
        //         }
        //         //08-08-2022-end
        //     }
        //     actions
        //     {
        //         addafter(Print)
        //         {
        //             action("Print Delivery Advice")
        //             {
        //                 ApplicationArea = all;
        //                 Image = PrintChecklistReport;
        //                 Promoted = true;
        //                 PromotedIsBig = true;
        //                 PromotedCategory = Category6;

        //                 trigger OnAction()
        //                 var
        // // deliveryadvice: Report "Posted Delivery Advice Report";
        //                     SIheader: Record "Sales Invoice Header";
        //                 begin
        //                     SIheader.Reset();

        //                     CurrPage.SetSelectionFilter(SIheader);

        //                     if SIheader.FindFirst() then
        //                         Report.RunModal(Report::"53010 Posted Delivery Adv Clr.", true, true, SIheader)
        //                     // deliveryadvice.Run();
        //                 end;
        //             }

        //             action("Transfer of Ownership1")
        //             {
        //                 ApplicationArea = all;
        //                 Caption = 'Transfer of Ownership Certificate';
        //                 Promoted = true;
        //                 PromotedCategory = Category6;
        //                 trigger onaction()
        //                 var
        //                     SalesInvoiceHeader: Record "Sales Invoice Header";
        //                 begin
        //                     SalesInvoiceHeader.Reset();
        //                     SalesInvoiceHeader.SetRange("No.", Rec."No.");
        //                     if SalesInvoiceHeader.FindFirst() then
        //                         Report.RunModal(53009, true, false, SalesInvoiceHeader);

        //                 end;

        //             }
        //             action("Print Sample Invoice")
        //             {
        //                 ApplicationArea = all;
        //                 Image = PrintReport;
        //                 Caption = 'Print Sample Invoice';
        //                 Promoted = true;
        //                 PromotedCategory = Category6;
        //                 Enabled = EnableSamplePrint;
        //                 trigger onaction()
        //                 var
        //                     SalesInvoiceHeader: Record "Sales Invoice Header";
        //                 begin
        //                     SalesInvoiceHeader.Reset();
        //                     SalesInvoiceHeader.SetRange("No.", Rec."No.");
        //                     if SalesInvoiceHeader.FindFirst() then
        //                         Report.RunModal(53014, true, false, SalesInvoiceHeader);
        //                 end;
        //             }
        //         }
        //         // modify("Posted Delivery Advice")
        //         // {
        //         //     Visible = false;
        //         //     Enabled = false;
        //         // }
        //         addfirst(processing)
        //         {
        //             action("Update Declaration")
        //             {
        //                 ApplicationArea = all;
        //                 RunObject = page Billofexitupdatewindow;
        //                 RunPageLink = "No." = field("No.");
        //                 Caption = 'Update Declaration & Shipment Date';
        //                 RunPageOnRec = true;
        //                 Promoted = true;
        //                 PromotedIsBig = true;
        //                 PromotedCategory = Process;
        //                 Image = UpdateDescription;
        //                 RunPageMode = Edit;

        //             }
        //         }
        //         addlast(processing)
        //         {
        //             action("Update Customer Sales Declaration")
        //             {
        //                 ApplicationArea = all;
        //                 RunObject = page "Customer Sales Declaration";
        //                 //RunPageLink = "No." = field("No.");
        //                 Caption = 'Update ETD & ETA';
        //                 RunPageOnRec = true;
        //                 Promoted = true;
        //                 PromotedIsBig = true;
        //                 PromotedCategory = Process;
        //                 Image = UpdateDescription;
        //                 RunPageMode = Edit;

        //             }
        //             //18-10-2022-start-Document Amendment
        //             action(RaiseChangeRequest)
        //             {
        //                 Caption = 'Create Document Amendment Request';
        //                 ApplicationArea = all;
        //                 Image = Change;
        //                 Promoted = true;
        //                 PromotedCategory = Process;
        //                 PromotedIsBig = true;
        //                 PromotedOnly = true;

        //                 trigger OnAction()
        //                 begin
        //                     CreateAndOpenChangeRequest();
        //                 end;
        //             }
        //             action(ChangeRequestList)
        //             {
        //                 Caption = 'Document Amendment Request List';
        //                 ApplicationArea = all;
        //                 Image = ChangeBatch;
        //                 Promoted = true;
        //                 PromotedCategory = Process;
        //                 PromotedIsBig = true;
        //                 PromotedOnly = true;

        //                 trigger OnAction()
        //                 begin
        //                     OpenChangeRequestList();
        //                 end;
        //             }
        //             //18-10-2022-end
        //         }
        //     }

        //     trigger OnAfterGetCurrRecord()
        //     var
        //         myInt: Integer;
        //     begin
        //         if rec.BillOfExit = '' then
        //             BOE_boolean := true
        //         else
        //             BOE_boolean := false;
        //     end;

        //     local procedure CreateAndOpenChangeRequest()
        //     var
        //         recChangeRequest: Record "Amendment Request";
        //         SLine: Record "Sales Invoice Line";
        //         SShipmentLine: Record "Sales Shipment Line";
        //         SShipmentHdr: Record "Sales Shipment Header";
        //         SalesOrderRemarks: Record "Sales Order Remarks";
        //         AmendmentRemarks: Record "Amendment Remarks";
        //         TempSalesShptLine: Record "Sales Shipment Line" temporary;
        //         checkList: List of [Text];
        //     begin
        //         Clear(recChangeRequest);
        //         recChangeRequest.SetRange("Document Type", recChangeRequest."Document Type"::"Posted Sales Invoice");
        //         recChangeRequest.SetRange("Document No.", Rec."No.");
        //         recChangeRequest.SetRange("Request Status", recChangeRequest."Request Status"::Open);
        //         if recChangeRequest.FindSet() then
        //             Error('An open Amendment Request already exists for Posted Sales Invoice No. %1', Rec."No.");


        //         Clear(recChangeRequest);
        //         recChangeRequest."Document Type" := recChangeRequest."Document Type"::"Posted Sales Invoice";
        //         recChangeRequest."Document No." := Rec."No.";
        //         recChangeRequest."Customer Name" := Rec."Sell-to Customer Name";
        //         recChangeRequest."Invoice Date" := Rec."Posting Date";
        //         recChangeRequest."Amendment Type" := recChangeRequest."Amendment Type"::"Invoice Modification";
        //         recChangeRequest.Insert(true);

        //         //comments
        //         clear(SalesOrderRemarks);
        //         SalesOrderRemarks.SetRange("Document Type", SalesOrderRemarks."Document Type"::Invoice);
        //         SalesOrderRemarks.SetRange("Document No.", Rec."No.");
        //         if SalesOrderRemarks.FindSet() then begin
        //             repeat
        //                 AmendmentRemarks.Init();
        //                 AmendmentRemarks.TransferFields(SalesOrderRemarks, true);
        //                 AmendmentRemarks."New Remarks" := SalesOrderRemarks.Comments;
        //                 AmendmentRemarks."Amendment No." := recChangeRequest."Amendment No.";
        //                 AmendmentRemarks.Insert(true);
        //             until SalesOrderRemarks.Next() = 0;
        //         end;
        //         Clear(checkList);
        //         Clear(SLine);
        //         SLine.SetRange("Document No.", Rec."No.");
        //         if SLine.FindSet() then begin
        //             repeat
        //                 SLine.GetSalesShptLines(TempSalesShptLine);
        //                 if TempSalesShptLine.FindSet() then begin
        //                     repeat
        //                         if not checkList.Contains(TempSalesShptLine."Document No.") then begin
        //                             checkList.Add(TempSalesShptLine."Document No.");
        //                             clear(SalesOrderRemarks);
        //                             SalesOrderRemarks.SetRange("Document Type", SalesOrderRemarks."Document Type"::Shipment);
        //                             SalesOrderRemarks.SetRange("Document No.", TempSalesShptLine."Document No.");
        //                             if SalesOrderRemarks.FindSet() then begin
        //                                 repeat
        //                                     AmendmentRemarks.Init();
        //                                     AmendmentRemarks.TransferFields(SalesOrderRemarks, true);
        //                                     AmendmentRemarks."New Remarks" := SalesOrderRemarks.Comments;
        //                                     AmendmentRemarks."Amendment No." := recChangeRequest."Amendment No.";
        //                                     AmendmentRemarks.Insert(true);
        //                                 until SalesOrderRemarks.Next() = 0;
        //                             end;
        //                         end;
        //                     until TempSalesShptLine.Next() = 0;
        //                 end;
        //             until SLine.Next() = 0;
        //         end;
        //         Page.Run(Page::"Amendment Request", recChangeRequest);
        //     end;

        //     local procedure OpenChangeRequestList()
        //     var
        //         recChangeRequest: Record "Amendment Request";
        //     begin
        //         Clear(recChangeRequest);
        //         recChangeRequest.SetRange("Document Type", recChangeRequest."Document Type"::"Posted Sales Invoice");
        //         recChangeRequest.SetRange("Document No.", Rec."No.");
        //         if recChangeRequest.FindSet() then;

        //         Page.Run(Page::"Amendment Request List", recChangeRequest);
        //     end;

        //     trigger OnOpenPage()
        //     var
        //         SalesInvoiceLine: Record "Sales Invoice Line";
        //     begin
        //         EnableSamplePrint := false;
        //         SalesInvoiceLine.SetRange("Document No.", Rec."No.");
        //         if SalesInvoiceLine.FindSet() then begin
        //             repeat
        //                 If SalesInvoiceLine."Posting Group" = 'SAMPLE' then
        //                     EnableSamplePrint := true;
        //             until SalesInvoiceLine.Next() = 0;
        //         end;
        //     end;

        //     trigger OnDeleteRecord(): Boolean
        //     begin
        //         Error('Not allowed to delete the record!');
        //     end;

        //     var
        //         BOE_boolean: Boolean;
        //         EnableSamplePrint: Boolean;
    }
    actions
    {
        addafter(Print)
        {

            action("Sample - Commercial Invoice")
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                var
                    SIH_lRec: Record "Sales Invoice Header";
                    _KemipexInvoiceSamples_lRpt: Report "11_Invoice - Samples";
                begin
                    SIH_lRec.Reset();
                    SIH_lRec.SetRange("No.", Rec."No.");
                    Clear(_KemipexInvoiceSamples_lRpt);
                    _KemipexInvoiceSamples_lRpt.SetTableView(SIH_lRec);
                    _KemipexInvoiceSamples_lRpt.RunModal();
                end;
            }
            action("Print Delivery Advice")
            {
                ApplicationArea = all;
                Image = PrintChecklistReport;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;

                trigger OnAction()
                var
                    SIheader: Record "Sales Invoice Header";
                begin
                    SIheader.Reset();

                    CurrPage.SetSelectionFilter(SIheader);

                    if SIheader.FindFirst() then
                        Report.RunModal(Report::"53010 Posted Delivery Adv Clr.", true, true, SIheader)
                end;
            }
            action("Transfer of Ownership1")
            {
                ApplicationArea = all;
                Caption = 'Transfer of Ownership Certificate';
                Promoted = true;
                Image = Print;
                PromotedCategory = Category6;
                trigger onaction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("No.", Rec."No.");
                    if SalesInvoiceHeader.FindFirst() then
                        Report.RunModal(53014, true, false, SalesInvoiceHeader);

                end;

            }
        }
    }
}