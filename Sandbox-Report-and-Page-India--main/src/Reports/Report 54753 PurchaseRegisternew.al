// report 54753 PurchaseRegisternew//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'Purchase_Register';
//     UsageCategory = ReportsAndAnalysis;
//     RDLCLayout = './Layouts/54751_PurchaseRegister.rdl';

//     dataset
//     {
//         dataitem(PurchInvHeader; "Purch. Inv. Header")
//         {
//             RequestFilterFields = "Posting Date", "Buy-from Vendor No.";

//             column(PostingDate; "Posting Date")
//             {
//             }
//             column(No; "No.")
//             {
//             }
//             column(VendorInvoiceNo; "Vendor Invoice No.")
//             {
//             }

//             column(Order_Date; "Order Date")
//             {

//             }
//             column(Document_Date; "Document Date")
//             {

//             }
//             column(BuyfromVendorNo; "Buy-from Vendor No.")
//             {
//             }
//             column(BuyfromVendorName; "Buy-from Vendor Name")
//             {
//             }
//             column(BuyfromCounty; recVLE."Buyer State Code")
//             {
//             }
//             column(VendorPostingGroup; "Vendor Posting Group")
//             {
//             }
//             column(VendGSTNo; recVend."GST Registration No.")
//             {

//             }
//             column(dtFromDate; dtFromDate)
//             {

//             }
//             column(dtToDate; dtToDate)
//             {

//             }
//             column(CompName; recCompInfo.Name)
//             {

//             }
//             column(User_ID; USERID)
//             {

//             }
//             column(cdCurrencyCode; cdCurrencyCode)
//             {

//             }
//             dataitem(PurchInvLine; "Purch. Inv. Line")
//             {
//                 DataItemLink = "Document No." = Field("No.");
//                 DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter('Item|G/L Account'));
//                 RequestFilterFields = "No.";

//                 column(Order_No_; "Order No.")
//                 {

//                 }
//                 column(Blanket_Order_No_; "Blanket Order No.")
//                 {

//                 }

//                 column(HSN_SAC_Code; "HSN/SAC Code")
//                 {

//                 }
//                 column(Description; Description)
//                 {

//                 }
//                 column(Quantity__Base_; "Quantity (Base)")
//                 {

//                 }
//                 column(Unit_of_Measure_Code; "Unit of Measure Code")
//                 {

//                 }
//                 column(Unit_Cost__LCY_; "Unit Cost (LCY)")
//                 {

//                 }
//                 column(VAT_Base_Amount; abs("VAT Base Amount"))
//                 {

//                 }
//                 column(Line_Amount; "Line Amount")
//                 {

//                 }
//                 column(IGSTPer; abs(IGSTPer)) { }
//                 column(IGSTAmt; abs(IGSTAmt)) { }
//                 column(CGSTPer; abs(CGSTPer)) { }
//                 column(CGSTAmt; abs(CGSTAmt)) { }
//                 column(SGSTPer; SGSTPer) { }
//                 column(SGSTAmt; abs(SGSTAmt)) { }
//                 column(TotGST; abs(TotGST)) { }
//                 column(TotalValue; TotalValue)
//                 {

//                 }

//                 trigger OnAfterGetRecord()
//                 var
//                     recDetGSTEnt: Record "Detailed GST Ledger Entry";
//                 begin
//                     InitGSTVar();
//                     if PurchInvLine."GST Reverse Charge" = true then
//                         CurrReport.Skip();


//                     if PurchInvLine.Description = 'Round Off' then
//                         CurrReport.Skip();
//                     TotalValue := 0;


//                     recDetGSTEnt.Reset();
//                     recDetGSTEnt.SetRange("Transaction Type", recDetGSTEnt."Transaction Type"::Purchase);
//                     recDetGSTEnt.SetRange("Document Type", recDetGSTEnt."Document Type"::Invoice);
//                     recDetGSTEnt.SetRange("Document No.", PurchInvLine."Document No.");
//                     recDetGSTEnt.SetRange("Document Line No.", PurchInvLine."Line No.");
//                     if recDetGSTEnt.FindSet() then
//                         repeat
//                             case recDetGSTEnt."GST Component Code" of
//                                 'IGST':
//                                     begin
//                                         IGSTPer := recDetGSTEnt."GST %";
//                                         IGSTAmt := recDetGSTEnt."GST Amount";
//                                     end;
//                                 'CGST':
//                                     begin
//                                         CGSTPer := recDetGSTEnt."GST %";
//                                         CGSTAmt := recDetGSTEnt."GST Amount";
//                                     end;
//                                 'SGST':
//                                     begin
//                                         SGSTPer := recDetGSTEnt."GST %";
//                                         SGSTAmt := recDetGSTEnt."GST Amount";
//                                     end;
//                             end;
//                         until recDetGSTEnt.Next() = 0;
//                     TotGST := IGSTAmt + CGSTAmt + SGSTAmt;

//                     TotalValue := TotalValue + abs("VAT Base Amount") + abs(TotGST);
//                 end;

//             }
//             trigger OnPreDataItem()
//             begin
//                 if recCompInfo.get() then;
//                 cdCurrencyCode := PurchInvHeader.GetFilter("Currency Code");

//                 if (dtFromDate <> 0D) or (dtToDate <> 0D) then begin
//                     PurchInvHeader.SetRange("Posting Date");
//                     txtDateFilter := Format(dtFromDate) + '..' + Format(dtToDate);
//                     PurchInvHeader.SetFilter("Posting Date", txtDateFilter);
//                 end;
//             end;

//             trigger OnAfterGetRecord()
//             begin
//                 recCompInfo.get();
//                 recVend.Get("Buy-from Vendor No.");
//                 recVLE.Get("Vendor Ledger Entry No.");

//                 IF StateCode <> '' THEN BEGIN
//                     IF StateCode <> recVLE."Buyer State Code" THEN
//                         CurrReport.Skip();
//                 END;








//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 group(Filters)
//                 {
//                     Caption = 'Filters';
//                     field(dtFromDate; dtFromDate)
//                     {
//                         Caption = 'From Date';
//                         ApplicationArea = all;
//                     }
//                     field(dtToDate; dtToDate)
//                     {
//                         Caption = 'To Date';
//                         ApplicationArea = all;
//                     }
//                     // field(Statecode; recVLE."Buyer State Code")
//                     field(Statecode; StateCode)
//                     {
//                         Caption = 'State code';
//                         ApplicationArea = All;
//                     }
//                 }
//             }
//         }
//         actions
//         {
//             area(processing)
//             {
//             }
//         }
//     }

//     var
//         TotalValue: Decimal;
//         recVend: Record Vendor;
//         recVLE: Record "Vendor Ledger Entry";
//         dtFromDate: Date;

//         dtToDate: Date;
//         cdCurrencyCode: Code[10];
//         txtDateFilter: Text;
//         recCompInfo: Record "Company Information";
//         IGSTPer: Decimal;
//         IGSTAmt: Decimal;
//         CGSTPer: Decimal;
//         CGSTAmt: Decimal;
//         SGSTPer: Decimal;
//         SGSTAmt: Decimal;
//         TotGST: Decimal;
//         StateCode: Code[50];

//     local procedure InitGSTVar()
//     begin
//         IGSTPer := 0;
//         IGSTAmt := 0;
//         CGSTPer := 0;
//         CGSTAmt := 0;
//         SGSTPer := 0;
//         SGSTAmt := 0;
//         TotGST := 0;
//     end;
// }
