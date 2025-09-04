// report 54783 "RCM Report"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     UsageCategory = ReportsAndAnalysis;
//     RDLCLayout = './Layouts/RCMREPORT.rdl';

//     dataset
//     {
//         dataitem(PurchInvHeader; "Purch. Inv. Header")
//         {
//             RequestFilterFields = "Posting Date";

//             column(PostingDate; "Posting Date")
//             {
//             }
//             column(No; "No.")
//             {
//             }
//             column(Reportfilter; Reportfilter)
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
//                 DataItemTableView = sorting("Document No.", "Line No.") where("GST Reverse Charge" = filter(true));


//                 column(HSN_SAC_Code; "HSN/SAC Code")
//                 {

//                 }
//                 column(Description; Description)
//                 {

//                 }
//                 column(Receipt_No_; "Receipt No.")
//                 {

//                 }
//                 column(Quantity__Base_; "Quantity (Base)")
//                 {

//                 }
//                 column(GRNDATE; GRNDATE)
//                 {

//                 }
//                 column(GRNNO; "Receipt Line No.")
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
//                 column(GST_Reverse_Charge; "GST Reverse Charge")
//                 {

//                 }
//                 column(Document_No_; "Document No.")
//                 {

//                 }

//                 trigger OnAfterGetRecord()
//                 var
//                     recDetGSTEnt: Record "Detailed GST Ledger Entry";
//                 begin
//                     if PurchInvLine."GST Reverse Charge" = false then
//                         CurrReport.Skip();
//                     if PurchInvLine.Type = PurchInvLine.Type::Item then
//                         CurrReport.Skip();


//                     InitGSTVar();


//                     if PurchInvLine.Description = 'Round Off' then
//                         CurrReport.Skip();

//                     TotalValue := 0;

//                     PIL.Reset();

//                     // PIL.SetFilter("Receipt No.", '<>%1', '');
//                     // if PIL.FindFirst() then
//                     //  GRNNO := PIL."Receipt No.";
//                     PurReceHeade.Reset();
//                     PurReceHeade.SetRange("No.", "Receipt No.");
//                     if PurReceHeade.FindFirst() then
//                         GRNDATE := "Posting Date";



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
//                     if IGSTPer = 0 then
//                         CurrReport.Skip();

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
//                     /*  field(dtFromDate; dtFromDate)
//                      {
//                          Caption = 'From Date';
//                          ApplicationArea = all;
//                      }
//                      field(dtToDate; dtToDate)
//                      {
//                          Caption = 'To Date';
//                          ApplicationArea = all;
//                      } */
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
//     trigger OnPreReport()

//     begin
//         Reportfilter := PurchInvHeader.GetFilters;



//     end;

//     var
//         PIL: Record "Purch. Inv. Line";
//         //  GRNNO: Code[50];
//         Reportfilter: Text[100];
//         TotalValue: Decimal;
//         PurReceHeade: Record "Purch. Rcpt. Header";
//         recVend: Record Vendor;
//         recVLE: Record "Vendor Ledger Entry";
//         GRNDATE: Date;
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
