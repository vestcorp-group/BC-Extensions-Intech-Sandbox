pageextension 58007 BPOPage extends "Blanket Purchase Order"//T12370-Full Comment
{
    layout
    {
        //         addfirst(factboxes)
        //         {
        //             part("Item wise Consol Inventory"; "Item Company Wise Inventory")
        //             {
        //                 ApplicationArea = all;
        //                 Provider = PurchLines;
        //                 SubPageLink = "Item No." = field("No.");
        //             }
        //         }
        //         // Add changes to page layout here
        //         modify("Transaction Specification")
        //         {
        //             Caption = 'Incoterm';
        //         }
        addlast(General)
        {
            //T50306-NS-NB
            field("Payment Worsen"; rec."Payment Worsen")
            {
                ApplicationArea = all;
                Caption = 'Payment Worsen';
                Editable = false;
            }
            field("Price Comparison"; rec."Price Comparison")
            {
                ApplicationArea = all;
                Caption = 'Price Comparison';
                Editable = false;
            }
            field("New Product"; rec."New Product")
            {
                ApplicationArea = all;
                Caption = 'New Product';
                Editable = false;
            }
            field("Limit Payable"; rec."Limit Payable")
            {
                ApplicationArea = all;
                Caption = 'Limit Payable';
                Editable = false;
            }
            field("Short Close Qty < 5"; rec."Short Close Qty < 5")
            {
                ApplicationArea = all;
                Caption = 'Short Close Qty < 5';
                Editable = false;
            }
            field("Short Close Qty > 5"; rec."Short Close Qty > 5")
            {
                ApplicationArea = all;
                Caption = 'Short Close Qty > 5';
                Editable = false;
            }
            field(OverDue; rec.OverDue)
            {
                ApplicationArea = all;
                Caption = 'OverDue';
                Editable = false;
            }
            //T50306-NS-NB
        }
        modify("Entry Point")
        {
            Caption = 'Port of Loading';
        }
        modify("Area")
        {
            Caption = 'Port of Discharge';
        }
        //         modify("Transaction Type")
        //         {
        //             Visible = true;
        //             Caption = 'Order Type';
        //         }
        //         moveafter(Status; "Transaction Type")
        //         modify("Order Address Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Campaign No.")
        //         {
        //             Visible = false;
        //         }
        //         modify("Assigned User ID")
        //         {
        //             Visible = false;
        //         }
        //         modify("Shortcut Dimension 1 Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Shortcut Dimension 2 Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Payment Discount %")
        //         {
        //             Visible = false;
        //         }
        //         modify("Location Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Shipment Method Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("On Hold")
        //         {
        //             Visible = false;
        //         }
        //         moveafter("Responsibility Center"; "Currency Code")
        //         moveafter("Responsibility Center"; "Payment Terms Code")
        //     }
        //     actions
        //     {
        //         modify(SendApprovalRequest)
        //         {
        //             trigger OnBeforeAction()
        //             var
        //                 purchaseLine: Record "Purchase Line";
        //                 item: Record Item;
        //             begin
        //                 if rec."Payment Terms Code" = '' then Error('Payment Terms Code cannot be empty');
        //                 if rec."Transaction Specification" = '' then Error('Incoterm cannot be empty');
        //                 if rec."Purchaser Code" = '' then Error('Purchaser Code Cannot be Empty');
        //                 purchaseLine.SetRange("Document No.", Rec."No.");
        //                 purchaseLine.SetRange("Document Type", Rec."Document Type");
        //                 purchaseLine.SetRange(Type, purchaseLine.Type::Item);
        //                 if purchaseLine.FindSet() then
        //                     repeat
        //                         item.Get(purchaseLine."No.");
        //                         if item.Type = item.Type::Inventory then begin
        //                             if purchaseLine."Location Code" = '' then
        //                                 Error('Location Code is Mandatory for %1', purchaseLine.Description)
        //                         end

        //                     until purchaseLine.Next() = 0;
        //             end;
        //         }
        //         modify(MakeOrder)
        //         {
        //             trigger OnBeforeAction()
        //             var
        //                 myInt: Integer;
        //             begin
        //                 if rec.Status <> rec.Status::Released then Error('Blanket Purchase Order Must be approved Before Making Order');
        //             end;
        //         }
        //         modify(Approvals)
        //         {
        //             Visible = true;
        //         }
        //         addafter(Statistics)
        //         {
        //             action("Approval 2")
        //             {
        //                 ApplicationArea = all;
        //                 Caption = 'View - Approvals';
        //                 Image = Approvals;
        //                 Promoted = true;
        //                 PromotedCategory = Category8;
        //                 PromotedOnly = true;
        //                 Visible = false; // Added by bayas
        //                 trigger OnAction()
        //                 var
        //                     approval_entries: Page Approval_entries;
        //                     approval_entry: Record "Approval Entry";
        //                 begin
        //                     approval_entry.SetRange("Document Type", rec."Document Type");
        //                     approval_entry.SetRange("Document No.", rec."No.");
        //                     approval_entries.SetTableView(approval_entry);
        //                     approval_entries.Run();
        //                 end;
        //             }
        //         }
        //         addafter(Print)
        //         {
        //             action("Print Preview")
        //             {
        //                 ApplicationArea = All;
        //                 Image = PrintChecklistReport;
        //                 Promoted = true;
        //                 PromotedIsBig = true;
        //                 PromotedCategory = Category6;
        //                 trigger OnAction()
        //                 var
        //                     Purc_header: Record "Purchase Header";
        //                 begin
        //                     Purc_header.Reset();
        //                     Purc_header.SetRange("No.", Rec."No.");

        //                     if Purc_header.FindSet() then
        //                         report.RunModal(58127, true, true, Purc_header);
        //                 end;
        //             }
        //         }
        //         modify(Print)
        //         {
        //             trigger OnBeforeAction()
        //             var
        //                 myInt: Integer;
        //             begin
        //                 if rec.Status = rec.Status::Released then exit else Error('Blanket Purchase Order must be release before printing');
        //             end;
        //         }
        //         //18-10-2022-start
        //         modify(AttachAsPDF)
        //         {
        //             trigger OnBeforeAction()
        //             begin
        //                 Rec.TestField(Status, Rec.Status::Released);
        //             end;
        //         }
        //         //18-10-2022-end
    }
    actions
    {
        //T50306-NS-NB
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                Vendor_lRec: Record Vendor;
                PaymentTerms_lRec: Record "Payment Terms";
                DueDateCalculationVendor_lDt: Date;
                DueDatecalculationOrder_lDt: Date;
                PurchaseHdr_lRec: Record "Purchase Header";
                Amount1_lDec: Decimal;
                Amount2_lDec: Decimal;
                HighAmount_lBln: Boolean;
                ItemVendor_lRec: Record "Item Vendor";
                PurchaseLine_lRec: Record "Purchase Line";
                NewProduct_lBln: Boolean;
                Percent_lDec: Decimal;
                PurchaseInvoiceLine_lRec: Record "Purch. Inv. Line";
            begin

                clear(PaymentTerms_lRec);
                PurchaseLine_lRec.Reset();
                PurchaseLine_lRec.SetRange("Document Type", Rec."Document Type");
                PurchaseLine_lRec.SetRange("Document No.", rec."No.");
                if PurchaseLine_lRec.FindSet() then
                    PurchaseLine_lRec.CalcSums(Quantity, "Short Closed Qty");

                if rec."Short Close Boolean" then begin
                    Percent_lDec := (PurchaseLine_lRec."Short Closed Qty" / PurchaseLine_lRec.Quantity) * 100;

                    if Percent_lDec <= 5 then begin
                        rec."Short Close Qty < 5" := true;
                        rec."Short Close Qty > 5" := false;
                    end else begin
                        rec."Short Close Qty < 5" := false;
                        rec."Short Close Qty > 5" := true;
                    end;
                end;
                if rec."ShortClose Approval" then
                    exit;
                if Vendor_lRec.get(rec."Buy-from Vendor No.") then
                    //if PaymentTerms_lRec.Get(Vendor_lRec."Payment Terms Code") then
                    // DueDateCalculationVendor_lDt := CalcDate(PaymentTerms_lRec."Due Date Calculation", WorkDate());

                    //if PaymentTerms_lRec.Get(rec."Payment Terms Code") then
                    //DueDatecalculationOrder_lDt := CalcDate(PaymentTerms_lRec."Due Date Calculation", WorkDate());

                    if Vendor_lRec."Payment Terms Code" <> rec."Payment Terms Code" then
                        rec."Payment Worsen" := true
                    else
                        rec."Payment Worsen" := false;
                rec.CalcFields("Amount Including VAT");
                Amount1_lDec := rec."Amount Including VAT";
                PurchaseHdr_lRec.Reset();
                PurchaseHdr_lRec.SetFilter("No.", '<>%1', rec."No.");
                PurchaseHdr_lRec.SetRange("Buy-from Vendor No.", rec."Buy-from Vendor No.");
                if PurchaseHdr_lRec.FindSet() then
                    repeat
                        PurchaseHdr_lRec.CalcFields("Amount Including VAT");
                        Amount2_lDec := PurchaseHdr_lRec."Amount Including VAT";
                        if Amount1_lDec > Amount2_lDec then
                            HighAmount_lBln := true

                    until (PurchaseHdr_lRec.Next() = 0) or (HighAmount_lBln = true);

                if HighAmount_lBln then
                    rec."Price Comparison" := true
                else
                    rec."Price Comparison" := false;

                PurchaseLine_lRec.Reset();
                PurchaseLine_lRec.SetRange("Document Type", rec."Document Type");
                PurchaseLine_lRec.SetRange("Document No.", rec."No.");
                if PurchaseLine_lRec.FindSet() then
                    repeat
                        PurchaseInvoiceLine_lRec.Reset();
                        PurchaseInvoiceLine_lRec.SetRange("No.", PurchaseLine_lRec."No.");
                        PurchaseInvoiceLine_lRec.SetRange("Buy-from Vendor No.", PurchaseLine_lRec."Buy-from Vendor No.");
                        if not PurchaseInvoiceLine_lRec.FindFirst() then
                            NewProduct_lBln := true
                        else
                            NewProduct_lBln := false;
                    until (PurchaseLine_lRec.Next() = 0) or (NewProduct_lBln = true);

                if NewProduct_lBln then
                    rec."New Product" := true
                else
                    Rec."New Product" := false;

                if IsOverdue(rec."Buy-from Vendor No.") then
                    rec.OverDue := true
                else
                    rec.OverDue := false;
                rec.Modify();

            end;
        }
        //T50306-NE-NB
        //T52426-NS
        addafter(Print)
        {
            action("Print Preview")
            {
                ApplicationArea = All;
                Image = PrintChecklistReport;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;
                Visible = false;//T53930-N
                trigger OnAction()
                var
                    Purc_header: Record "Purchase Header";
                begin
                    Purc_header.Reset();
                    Purc_header.SetRange("No.", Rec."No.");

                    if Purc_header.FindSet() then
                        report.RunModal(58127, true, true, Purc_header);
                end;
            }
        }
        modify(Print)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                if rec.Status = rec.Status::Released then exit else Error('Blanket Purchase Order must be release before printing');
            end;
        }
        //T52426-NE
    }
    local procedure IsOverdue(Vendor_lCod: Code[20]): Boolean//T50306-NS-NB
    var
        VendorLedgerEntry_lRec: Record "Vendor Ledger Entry";
    begin
        Clear(VendorLedgerEntry_lRec);
        VendorLedgerEntry_lRec.SetRange("Vendor No.", Vendor_lCod);
        VendorLedgerEntry_lRec.SetRange(Open, true);
        VendorLedgerEntry_lRec.SetRange("Document Type", VendorLedgerEntry_lRec."Document Type"::Invoice);
        VendorLedgerEntry_lRec.SetFilter("Due Date", '..%1', Today());
        exit(VendorLedgerEntry_lRec.FindFirst())
    end;
}