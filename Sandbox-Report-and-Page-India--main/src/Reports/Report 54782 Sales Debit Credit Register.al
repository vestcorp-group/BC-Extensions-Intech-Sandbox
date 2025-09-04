// report 54782 "Sales Debit/Credit Register"//T12370-Full Comment
// {
//     UsageCategory = Administration;
//     ApplicationArea = all;
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/SalesDebitCreditNote.rdl';

//     dataset
//     {
//         dataitem("SalesCrMemoHeader"; "Sales Cr.Memo Header")
//         {
//             RequestFilterFields = "Posting Date";

//             column(PostingDate; "Posting Date")
//             {
//             }
//             column(No; "No.")
//             {
//             }

//             // column(VendorInvoiceNo; "Vendor Invoice No.")
//             // {
//             // }
//             column(Sell_to_Customer_No_; "Sell-to Customer No.")
//             {
//             }
//             column(Sell_to_Customer_Name; "Sell-to Customer Name")
//             {
//             }
//             column(sellfromCounty; recCLE."Seller State Code")
//             {
//             }
//             column(Customer_Posting_Group; "Customer Posting Group")
//             {
//             }
//             column(CusGSTNo; RecCust."GST Registration No.")
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
//             column(Reportfilter; Reportfilter)
//             {

//             }
//             dataitem("SalesCrMemoLine"; "Sales Cr.Memo Line")
//             {
//                 DataItemLink = "Document No." = Field("No.");
//                 DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter('Item|G/L Account'));
//                 //  RequestFilterFields = "No.";

//                 column(HSN_SAC_Code; "HSN/SAC Code")
//                 {

//                 }
//                 column(Description; Description)
//                 {

//                 }
//                 column(Quantity__Base_; "Quantity (Base)")
//                 {

//                 }
//                 column(quantitysum; quantitysum)
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



//                 column(IGSTPer; IGSTPer) { }
//                 column(IGSTAmt; abs(IGSTAmt)) { }
//                 column(CGSTPer; CGSTPer) { }
//                 column(CGSTAmt; abs(CGSTAmt)) { }
//                 column(SGSTPer; SGSTPer) { }
//                 column(SGSTAmt; abs(SGSTAmt)) { }
//                 column(TotGST; abs(TotGST)) { }
//                 column(Totalvalue; Totalvalue)
//                 {

//                 }

//                 trigger OnAfterGetRecord()
//                 var
//                     recDetGSTEnt: Record "Detailed GST Ledger Entry";
//                 begin
//                     InitGSTVar();
//                     if SalesCrMemoLine.Type = SalesCrMemoLine.Type::Item then begin
//                         quantitysum := quantitysum + SalesCrMemoLine."Quantity (Base)";

//                     end;
//                     if SalesCrMemoLine.Description = 'Round Off' then
//                         CurrReport.Skip();
//                     Totalvalue := 0;


//                     recDetGSTEnt.Reset();
//                     recDetGSTEnt.SetRange("Transaction Type", recDetGSTEnt."Transaction Type"::Sales);
//                     recDetGSTEnt.SetRange("Document Type", recDetGSTEnt."Document Type"::"Credit Memo");
//                     recDetGSTEnt.SetRange("Document No.", SalesCrMemoLine."Document No.");
//                     recDetGSTEnt.SetRange("Document Line No.", SalesCrMemoLine."Line No.");
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
//                 recCompInfo.get();
//                 cdCurrencyCode := SalesCrMemoHeader.GetFilter("Currency Code");

//                 if (dtFromDate <> 0D) or (dtToDate <> 0D) then begin
//                     SalesCrMemoHeader.SetRange("Posting Date");
//                     txtDateFilter := Format(dtFromDate) + '..' + Format(dtToDate);
//                     SalesCrMemoHeader.SetFilter("Posting Date", txtDateFilter);
//                 end;
//             end;

//             trigger OnAfterGetRecord()
//             begin
//                 recCompInfo.get();
//                 RecCust.Get("Sell-to Customer No.");
//                 recCLE.Get("Cust. Ledger Entry No.");
//                 IF StateCode <> '' THEN BEGIN
//                     IF StateCode <> recCLE."Seller State Code" THEN
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
//         Reportfilter := SalesCrMemoHeader.GetFilters;



//     end;

//     var
//         quantitysum: Decimal;
//         Reportfilter: Text[100];
//         //recVend: Record Vendor;
//         RecCust: Record Customer;
//         //recVLE: Record "Vendor Ledger Entry";
//         recCLE: Record "Cust. Ledger Entry";
//         Totalvalue: Decimal;

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
