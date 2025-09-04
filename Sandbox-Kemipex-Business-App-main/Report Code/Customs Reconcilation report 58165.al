// Report 58165 CustomsReconciliationreport//T12370-Full Comment
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = all;
//     RDLCLayout = 'Reports/Customs_Reconciliation_report.rdl';
//     Caption = 'Customs Reconciliation Report';
//     dataset
//     {
//         dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
//         {
//             DataItemTableView = where(Quantity = filter('<>0'));
//             column(Order_No_; "Order No.") { }
//             column(Posting_Date; "Posting Date") { }
//             column(Document_No_; "Document No.") { }
//             column(CustomBOENumber; CustomBOENumber) { }
//             column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
//             column(Vendor_Name; vendor.Name) { }
//             column(No_; "No.") { }
//             column(HS_Code; itemRec."Tariff No.") { }
//             column(Description; Description) { }
//             column(Location_Code; "Location Code") { }
//             column("BaseUOM"; itemrec."Base Unit of Measure") { }
//             column("BaseUOMQty"; "Quantity (Base)") { }
//             column(Currency_Code; "Currency Code") { }
//             column(Direct_Unit_Cost; "Direct Unit Cost") { }
//             column(Vendor_invoice_no; Vendor_invoice_no) { }
//             column("Incoterm"; PR_header."Transaction Specification") { }
//             column(Vendor_Invoice_Date; PR_header."Document Date") { }

//             dataitem("Item Ledger Entry"; "Item Ledger Entry")
//             {
//                 DataItemLink = CustomBOENumber = field(CustomBOENumber), "Item No." = field("No.");
//                 DataItemTableView = where("Entry Type" = filter('Sale'));
//                 column(Item_No_; "Item No.") { }
//                 column(BillOfExit; BillOfExit) { }
//                 column(SalesDocumentdate; "Posting Date") { }
//                 column(Quantity; Quantity) { }
//                 column(Source_No_; "Source No.") { }
//                 column(customerName; CustomerRec.Name) { }
//                 column(OutTotalQty; OutTotalQty) { }
//                 column(DO_out_qty; DO_out_qty) { }
//                 column(Balance; Balance) { }
//                 column(Entry_Type; "Entry Type") { }
//                 column(Sales_Invoice_No; Sales_Invoice_No) { }
//                 column(Sales_Invoice_date; Sales_Invoice_date) { }

//                 trigger OnAfterGetRecord()
//                 var
//                     ILE: Record "Item Ledger Entry";
//                     Value_entries: Record "Value Entry";

//                 begin
//                     Clear(Value_entries);
//                     Clear(CustomerRec);
//                     Clear(ILE);

//                     if "Entry Type" = "Entry Type"::Sale then if CustomerRec.get("Source No.") then;

//                     //skiping repeating lines
//                     if PrevDocNo = "Item Ledger Entry"."Document No." then CurrReport.Skip();
//                     PrevDocNo := "Item Ledger Entry"."Document No.";
//                     if "Document Type" = "Document Type"::"Posted Assembly" then CurrReport.Skip();

//                     //calculating Out Document qty for each document
//                     ILE.SetRange("Document No.", "Item Ledger Entry"."Document No.");
//                     ILE.SetRange("Item No.", "Item Ledger Entry"."Item No.");
//                     ILE.SetRange(CustomBOENumber, "Item Ledger Entry".CustomBOENumber);
//                     ILE.CalcSums(Quantity);
//                     DO_out_qty := ILE.Quantity;
//                     Balance := OutTotalQty + "Purch. Rcpt. Line"."Quantity (Base)";

//                     Value_entries.SetRange("Item Ledger Entry No.", "Entry No.");
//                     Value_entries.SetRange("Document Type", Value_entries."Document Type"::"Sales Invoice");
//                     Value_entries.SetRange("Item Charge No.", '');
//                     Value_entries.SetFilter("Invoiced Quantity", '<>0');
//                     if Value_entries.FindFirst() then begin
//                         Sales_Invoice_No := Value_entries."Document No.";
//                         Sales_Invoice_date := Value_entries."Posting Date";
//                     end;

//                     if "Entry Type" = "Entry Type"::Transfer then CurrReport.Skip();
//                     if "Document Type" = "Document Type"::"Posted Assembly" then CurrReport.Skip();

//                 end;
//             }
//             trigger OnAfterGetRecord()
//             var
//                 GLS: Record "General Ledger Setup";
//                 postedPurchaseInvoiceheader: Record "Purch. Inv. Header";
//                 PostedPurchaseInvoiceLine: Record "Purch. Inv. Line";
//                 ILE: Record "Item Ledger Entry";
//                 item: Record Item;

//             begin
//                 Clear(TotalAmt);
//                 Clear(PR_header);
//                 Clear(vendor);
//                 Clear(TotalAmt);
//                 Clear(Purch_header_archive);
//                 Clear(itemRec);
//                 Clear(DO_out_qty);
//                 Clear(Balance);
//                 Clear(OutTotalQty);
//                 Clear(Vendor_invoice_no);

//                 if vendor.Get("Purch. Rcpt. Line"."Buy-from Vendor No.") then;
//                 if itemRec.Get("Purch. Rcpt. Line"."No.") then;

//                 if PR_header.Get("Purch. Rcpt. Line"."Document No.") then;

//                 PostedPurchaseInvoiceLine.SetRange("Receipt No.", "Purch. Rcpt. Line"."Document No.");
//                 if PostedPurchaseInvoiceLine.FindFirst() then begin
//                     postedPurchaseInvoiceheader.SetRange("No.", PostedPurchaseInvoiceLine."Document No.");
//                     if postedPurchaseInvoiceheader.FindFirst() then
//                         Vendor_invoice_no := postedPurchaseInvoiceheader."Vendor Invoice No.";
//                 end;

//                 //Empty Currency to Local Currency
//                 gls.Get();
//                 if "Currency Code" = '' then "Currency Code" := gls."LCY Code";

//                 //calculate Total Out qty for Bill of entry 
//                 ILE.SetRange("Entry Type", ILE."Entry Type"::Sale);
//                 ILE.SetRange(CustomBOENumber, CustomBOENumber);
//                 ILE.SetRange("Item No.", "No.");
//                 ILE.CalcSums(Quantity);
//                 OutTotalQty := ILE.Quantity;



//             end;

//             trigger OnPreDataItem()
//             var
//             begin
//                 SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
//                 SetFilter("No.", Item);
//                 if not ShowLGP then "Purch. Rcpt. Line".SetFilter(CustomBOENumber, '<>LGP');
//                 SetFilter(CustomBOENumber, BOEFilter);
//             end;
//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 field(FromDate; FromDate)
//                 {
//                     Caption = 'From Date:';
//                     ApplicationArea = all;
//                 }
//                 field(ToDate; ToDate)
//                 {
//                     Caption = 'To Date:';
//                     ApplicationArea = all;
//                 }
//                 field(BOEFilter; BOEFilter)
//                 {
//                     Caption = 'Bill of Entry No.';
//                     ApplicationArea = all;
//                 }
//                 field(Item; Item)
//                 {
//                     Caption = 'Item';
//                     TableRelation = Item;
//                     ApplicationArea = all;
//                 }
//                 field(Showintercompa; ShowLGP)
//                 {
//                     Caption = 'Show LGP';
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }
//     var
//         vendor: Record Vendor;
//         PR_header: Record "Purch. Rcpt. Header";
//         Purch_header_archive: Record "Purchase Header Archive";
//         TotalAmt: Decimal;
//         FromDate: Date;
//         ToDate: date;
//         ShowLGP: Boolean;
//         Item: Code[20];
//         VendorVar: Code[20];
//         itemRec: Record Item;
//         PrevDocNo: Code[30];
//         OutTotalQty: Decimal;
//         Balance: Decimal;
//         DO_out_qty: Decimal;
//         Cur_Inventory: Decimal;
//         BOEFilter: Text[50];
//         Vendor_invoice_no: Text[50];
//         Sales_Invoice_No: Text[50];
//         Sales_Invoice_date: Date;
//         CustomerRec: Record Customer;

// }
