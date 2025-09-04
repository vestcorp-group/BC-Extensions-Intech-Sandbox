// report 54781 "Purchase Debit/Credit Register"//T12370-Full Comment
// {
//     UsageCategory = Administration;
//     ApplicationArea = all;
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/PurchaseDebitCreditNote.rdl';

//     dataset
//     {
//         dataitem("PurchCrMemoHdr"; "Purch. Cr. Memo Hdr.")
//         {
//             RequestFilterFields = "Posting Date";
//             column(PostingDate; "Posting Date")
//             {

//             }
//             column(No; "No.")
//             {

//             }
//             column(VendorInvoiceNo; "Vendor Cr. Memo No.")
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
//             column(Reportfilter; Reportfilter)
//             {

//             }
//             column(User_ID; USERID)
//             {

//             }
//             column(cdCurrencyCode; cdCurrencyCode)
//             {

//             }
//             column(GRNNO; GRNNO)
//             {

//             }
//             column(GRNDATE; GRNDATE)
//             {

//             }

//             dataitem("PurchCrMemoLine"; "Purch. Cr. Memo Line")
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

//                     if PurchCrMemoLine.Description = 'Round Off' then
//                         CurrReport.Skip();
//                     TotalValue := 0;

//                     if PurchCrMemoLine.Type = PurchCrMemoLine.Type::Item then begin

//                         quantitysum := quantitysum + PurchCrMemoLine."Quantity (Base)";
//                         //  Message('%1', quantitysum);

//                     end;


//                     recDetGSTEnt.Reset();
//                     recDetGSTEnt.SetRange("Transaction Type", recDetGSTEnt."Transaction Type"::Purchase);
//                     recDetGSTEnt.SetRange("Document Type", recDetGSTEnt."Document Type"::"Credit Memo");
//                     recDetGSTEnt.SetRange("Document No.", PurchCrMemoLine."Document No.");
//                     recDetGSTEnt.SetRange("Document Line No.", PurchCrMemoLine."Line No.");
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





//             end;

//             trigger OnAfterGetRecord()
//             begin
//                 recVend.Get("Buy-from Vendor No.");
//                 recVLE.Get("Vendor Ledger Entry No.");
//                 recCompInfo.get();

//                 IF StateCode <> '' THEN BEGIN
//                     IF StateCode <> recVLE."Buyer State Code" THEN
//                         CurrReport.Skip();
//                 END;

//                 RefernceInvNoRec.Reset();
//                 RefernceInvNoRec.SetRange("Document No.", "No.");
//                 //  RefernceInvNoRec.SetRange("Document Type", RefernceInvNoRec."Document Type"::"Credit Memo");
//                 if RefernceInvNoRec.FindFirst() then;

//                 PIL.Reset();
//                 PIL.SetRange("Document No.", RefernceInvNoRec."Reference Invoice Nos.");
//                 PIL.SetFilter("Receipt No.", '<>%1', '');
//                 if PIL.FindFirst() then
//                     GRNNO := PIL."Receipt No.";

//                 PurReceHeade.Reset();
//                 PurReceHeade.SetRange("No.", GRNNO);
//                 if PurReceHeade.FindFirst() then
//                     GRNDATE := "Posting Date";


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
//         Reportfilter := PurchCrMemoHdr.GetFilters;



//     end;

//     var
//         quantitysum: Decimal;
//         Reportfilter: Text[100];
//         PurReceHeade: Record "Purch. Rcpt. Header";
//         RefernceInvNoRec: Record "Reference Invoice No.";
//         TotalValue: Decimal;
//         PIL: Record "Purch. Inv. Line";
//         GRNNO: Code[20];
//         GRNDATE: Date;
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
