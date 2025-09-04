// report 54790 "Blanket Sales Order PP"//T12370-Full Comment
// {
//     UsageCategory = Administration;
//     ApplicationArea = all;

//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/Layout_80003_BlanketSalesOrderReportPP.rdl';
//     Caption = 'Pro Forma Invoice / Blanket Sales Order Preview Report';
//     dataset
//     {
//         dataitem("Sales Header"; "Sales Header")
//         {
//             //DataItemTableView = WHERE ("No." = CONST ('101009'));
//             RequestFilterFields = "No.";
//             //DataItemTableView = where ("Document Type" = const (1));//"Document Type"::Quote));
//             column(No; "No.") { }
//             column(Hide_E_sign; Hide_E_sign) { }
//             column(PostingDate; "Order Date") { }
//             column(BilltoName; "Bill-to Name") { }
//             /*Column(ReportHdr_Txt; ReportHdr_Txt) { }*/


//             column(CompName; CompanyInformation.Name) { }
//             column(CompLogo; CompanyInformation.Picture) { }
//             column(CompPANNO; 'PAN No: ' + CompanyInformation."P.A.N. No.")
//             {

//             }
//             column(PortOflOadCaption; PortOflOadCaption)
//             {

//             }

//             column(CompanyInRegNew; CompanyInformation."Registration No New")
//             {

//             }
//             column(CompGSTRegNo; 'GST No: ' + CompanyInformation."GST Registration No.")
//             {

//             }
//             column(CompaAdress1; CompanyInformation.Address)
//             {

//             }
//             column(CompaAdress2; CompanyInformation."Address 2")
//             {

//             }
//             column(CustomeSatedesc; CustomeSatedesc)
//             {

//             }
//             column(CurrencyCOde; CurrencyCOde)
//             {

//             }
//             column(Compacity; CompanyInformation.City)
//             {

//             }
//             column(CompaPincode; CompanyInformation."Post Code")
//             {

//             }
//             column(CompaContry; ContrrecComapny.Name)
//             {

//             }
//             column(ComptelNo; 'Tel No: ' + CompanyInformation."Phone No.")
//             {

//             }
//             column(ShiptoVar; ShiptoVar)
//             {

//             }

//             column(AmtinWord_GTxt; String + ' ' + CurrencyDescription) { }
//             column(CompAddr1; CompanyInformation.Address) { }
//             column(CompAddr2; CompanyInformation."Address 2") { }
//             column(CompAddr3; CompanyInformation.City) { }
//             column(CompAddr4; CountryRegionRec.Name) { }
//             column(Telephone; CompanyInformation."Phone No.") { }
//             column(TRNNo; CompanyInformation."VAT Registration No.") { }
//             column(CustAddr_Arr1; CustAddr_Arr[1]) { }
//             column(CustAddr_Arr2; CustAddr_Arr[2]) { }
//             column(CustAddr_Arr3; CustAddr_Arr[3]) { }
//             column(CustAddr_Arr4; CustAddr_Arr[4]) { }
//             column(CustAddr_Arr5; CustAddr_Arr[5]) { }
//             column(CustAddr_Arr6; CustAddr_Arr[6]) { }
//             column(CustAddr_Arr7; CustAddr_Arr[7]) { }
//             column(CustAddr_Arr8; CustAddr_Arr[8]) { }
//             column(CustAddr_Arr9; CustAddr_Arr[9]) { }
//             column(CustAddr_Arr10; CustAddr_Arr[10]) { }
//             column(Cust_TRN; Cust_TRN) { }
//             column(CustAddrShipto_Arr1; CustAddrShipto_Arr[1]) { }
//             column(CustAddrShipto_Arr2; CustAddrShipto_Arr[2]) { }
//             column(CustAddrShipto_Arr3; CustAddrShipto_Arr[3]) { }
//             column(CustAddrShipto_Arr4; CustAddrShipto_Arr[4]) { }
//             column(CustAddrShipto_Arr5; CustAddrShipto_Arr[5]) { }
//             column(CustAddrShipto_Arr6; CustAddrShipto_Arr[6]) { }
//             column(CustAddrShipto_Arr7; CustAddrShipto_Arr[7]) { }
//             column(CustAddrShipto_Arr8; CustAddrShipto_Arr[8]) { }
//             //UK::03062020>>
//             //replaced "your reference" with "External Document No"
//             column(YourReferenceNo; "External Document No.") { }
//             //UK::03062020<<
//             column(Validto; "Due Date") { }
//             column(DeliveryTerms; TranSec_Desc) { }
//             column(PaymentTerms; PaymentTerms_Desc) { }
//             column(TotalIncludingCaption; TotalIncludingCaption) { }
//             column(TotalAmt; TotalAmt) { }
//             column(TotalAmountAED; TotalAmountAED) { }
//             column(TotalVatAmtAED; TotalVatAmtAED) { }
//             column(ExchangeRate; ExchangeRate) { }
//             Column(BankName; BankName) { }
//             column(BankADD; BankADD) { }
//             column(BeneficiaryName; BeneficiaryName) { }
//             column(BeneficiaryAddress; BeneficiaryAddress) { }
//             column(Currency_Code; "Currency Code") { }
//             Column(IBANNumber; IBANNumber) { }
//             Column(SWIFTCode; SWIFTCode) { }

//             Column(Branchname; Branchname) { }
//             Column(AccNo; AccNo) { }
//             column(IFSCcode; IFSCcode)
//             {

//             }
//             column(Legalization_Required; "Legalization Required 2") { } //PackingListExtChange
//             column(Inspection_Required; "Inspection Required 2") { } //PackingListExtChange
//             column(PrintVATremark; PrintVATremark) { }
//             column(Inspection_Caption; Inspection_Caption) { }

//             column(SA_Name; "Ship-to Name") //GK
//             { }
//             column(SA_Address; "Ship-to Address")
//             { }
//             column(SA_Address2; "Ship-to Address 2")
//             { }
//             column(SA_City; "Ship-to City")
//             { }
//             column(SA_Region_Code; "Ship-to Country/Region Code")
//             { }
//             column(SNO; SNO) { }

//             column(CustAltAddrBool; CustAltAddrBool)
//             { }
//             column(Duty_Exemption; "Duty Exemption")
//             { }
//             column(PortOfLoding; PortOfLoding) { }

//             column(PortOfLoding2; PortOfLoding2) { }
//             //AW09032020>>

//             column(PI_Validity_Date; "PI Validity Date")
//             { }
//             //AW09032020<<

//             column(HideBank_Detail; HideBank_Detail) { }

//             //SD Term & Conditions GK 04/09/2020
//             column(Condition1; text1) { }

//             column(Condition2; Text21) { }
//             column(Condition31; Text22) { }
//             column(Condition32; Condition32) { }
//             column(Condition33; Condition33) { }
//             column(Condition4; Text23) { }
//             column(Condition5; Text24) { }
//             column(Condition6; Condition6) { }
//             column(Condition7; Text25) { }
//             column(Condition8; Condition8) { }
//             column(Condition91; Condition91) { }
//             column(Condition92; Text26) { }
//             column(Condition1011; Text27) { }
//             column(Condition1011a; Condition1011a) { }
//             column(Condition1011b; Condition1011b) { }
//             column(Condition1011c; Condition1011c) { }
//             column(Condition1012; Text28) { }

//             column(Condition1021; Text29) { }
//             column(Condition1021a; Text30) { }
//             column(Condition1021b; Text31) { }
//             column(Condition103; Condition103) { }
//             column(Condition1041; Text32) { }
//             column(Condition1041a; Condition1041a) { }
//             column(Condition1041b; Condition1041b) { }
//             column(Condition1041c; Condition1041c) { }
//             column(Condition11; Text33) { }
//             column(Condition12; text12) { }
//             column(Condition13; Condition13) { }
//             column(CustomerRecBillPan; 'PAN No: ' + CustomerRecBill."P.A.N. No.")
//             {

//             }
//             column(Billname; Billname)
//             {

//             }
//             /*  column(BillAdress1; CustomerRecBill.Address)
//              {

//              }
//   */
//             column(Billadress1; Billadress1)
//             {

//             }
//             column(BillAdress2; CustomerRecBill."Address 2")
//             {

//             }
//             column(billadres2; billadres2)
//             {

//             }
//             // column(BillCIty; CustomerRecBill.City)
//             // {

//             // }
//             column(billcity; billcity)
//             {

//             }
//             column(Billteliphone; Billteliphone)
//             {

//             }
//             column(Postcodecaption; Postcodecaption)
//             {

//             }

//             column(CustomerRecBillgstno; 'GST No: ' + CustomerRecBill."GST Registration No.")
//             {

//             }

//             column(ShippName; ShippName)
//             {

//             }
//             column(ShipCaption; ShipCaption)
//             {

//             }
//             // column(Ship_to_Post_Code;)
//             column(ShippAdress1; ShippAdress1)
//             {

//             }

//             column(ShippAddress2; ShippAddress2)
//             {

//             }
//             column(ShippCity; ShippCity)
//             {

//             }
//             column(ShippPostcode; ShippPostcode)
//             {

//             }
//             dataitem("Sales Line"; "Sales Line")
//             {
//                 DataItemLink = "document Type" = Field("Document Type"), "Document No." = FIELD("No.");
//                 column(SrNo; SrNo) { }
//                 column(LineNo; "Line No.") { }
//                 column(Line_Type; Type) { }
//                 column(Document_No_; "Document No.")
//                 {

//                 }
//                 column(ItemNo; "No.")
//                 {
//                     IncludeCaption = true;
//                 }
//                 column(IsItem; IsItem) { }
//                 column(IsComment; IsComment) { }
//                 column(Description; Description)
//                 {
//                     IncludeCaption = true;
//                 }
//                 column(Quantity; "Quantity (Base)")
//                 {
//                     IncludeCaption = true;
//                 }
//                 column(UnitofMeasureCode; "Base UOM 2") { } //PackingListExtChange
//                 column(UnitPrice; "Unit Price Base UOM 2") { }

//                 //  column(Unit_Price;"Unit Price")
//                 column(Line_Amount; SalesLineAmount) { }
//                 column(VatPer; "VAT %")
//                 {
//                     IncludeCaption = true;
//                 }
//                 column(VatAmt; SalesLineVatBaseAmount * "VAT %" / 100)
//                 {
//                 }
//                 column(AmountIncludingVAT; SalesLineAmountincVat)
//                 {
//                     // IncludeCaption = true;
//                 }
//                 column(SearchDesc; SearchDesc)
//                 {

//                 }
//                 column(Origin; Origitext)
//                 {

//                 }
//                 column(HSCode; HSNCode)
//                 {

//                 }
//                 column(Packing; PackingText)
//                 {

//                 }
//                 column(Net_Weight; "Net Weight") { }
//                 column(Gross_Weight; "Gross Weight") { }
//                 column(NoOfLoads; 'No of Loads- Value')
//                 { }
//                 column(SrNo1; SrNo1)
//                 { }
//                 column(SrNo2; SrNo2) { }
//                 column(SrNo3; SrNo3) { }

//                 column(SrNo4; SrNo4) { }

//                 column(GST; GST)
//                 {

//                 }
//                 column(CGST; CGST)
//                 { }
//                 column(IGST; IGST)
//                 { }
//                 column(SGST; SGST) { }
//                 column(CGSTPct; CGSTPct)
//                 { }
//                 column(IGSTPct; IGSTPct)
//                 { }
//                 column(SGSTPct; SGSTPct)
//                 { }
//                 column(GSTAmount; GSTAmount)
//                 { }
//                 column(AmountInclGst; AmountInclGst)
//                 { }
//                 column(AmountExclGST; AmountExclGST)
//                 { }
//                 column(CGSTamount; CGSTamount) { }
//                 column(IGSTamount; IGSTamount) { }
//                 column(SGSTAmount; SGSTAmount) { }

//                 column(AmountInWord; 'Amount In Word: ' + AMountInW)
//                 {

//                 }


//                 trigger OnAfterGetRecord()
//                 var
//                     Item_LRec: Record Item;
//                     CountryRegRec: Record "Country/Region";
//                     ItemAttrb: Record "Item Attribute";
//                     ItemAttrVal: Record "Item Attribute Value";
//                     ItemAttrMap: Record "Item Attribute Value Mapping";
//                     TblGenericName: Record KMP_TblGenericName;
//                     VariantRec: Record "Item Variant";

//                     string1: Text[250];

//                 begin
//                     //-
//                     Clear(IGST);
//                     Clear(GST);
//                     Clear(CGST);
//                     Clear(SGST);
//                     Clear(GSTAmount);
//                     Clear(IGSTamount);
//                     Clear(CGSTamount);
//                     Clear(SGSTAmount);
//                     Clear(IGSTPct);
//                     Clear(CGSTPct);
//                     Clear(SGSTPct);
//                     STPer := 0;
//                     CTPer := 0;
//                     ITPer := 0;

//                     //+
//                     IsItem := FALSE;
//                     IsComment := Type = Type::" ";
//                     SearchDesc := '';
//                     Origitext := '';
//                     // HSNCode := '';
//                     PackingText := '';
//                     If Item_LRec.GET("No.") THEN BEGIN
//                         SrNo += 1;
//                         //HSNCode := Item_LRec."Tariff No.";

//                         if "Variant Code" <> '' then begin // add by bayas
//                             VariantRec.Get("No.", "Variant Code");
//                             if VariantRec."Packing Description" <> '' then begin
//                                 PackingText := VariantRec."Packing Description";
//                             end else begin
//                                 PackingText := Item_LRec."Description 2";
//                             end;
//                         end else begin
//                             PackingText := Item_LRec."Description 2";
//                         end;
//                         //PackingText := Item_LRec."Description 2";
//                         IsItem := TRUE;
//                         CountryRegRec.Reset();
//                         if ShowCustomerCOO then begin
//                             if CountryRegRec.Get(LineCountryOfOrigin) then
//                                 Origitext := CountryRegRec.Name;
//                         end
//                         else begin
//                             if CountryRegRec.Get(Item_LRec."Country/Region of Origin Code") then
//                                 Origitext := CountryRegRec.Name;
//                         end;

//                         SearchDesc := "Item Generic Name";

//                         //added by bayas
//                         if CustomInvoiceG then begin
//                             if "Line Generic Name" <> '' then
//                                 SearchDesc := "Line Generic Name";
//                         end;
//                         // **end by bayas

//                         if "Unit Price Base UOM 2" = 0 then begin
//                             "Unit Price Base UOM 2" := "Unit Price";
//                             "Base UOM 2" := "Unit of Measure Code";
//                             "Quantity (Base)" := Quantity;
//                         end;
//                         AmountExclGST := Quantity * "Unit Price";
//                         if "GST Group Code" <> '' then
//                             CalculateLineGST("Sales Header", "Sales Line");
//                         GSTAmount := IGSTamount + CGSTamount + SGSTAmount;
//                         GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%'; //'18%'
//                         //if GSTAmount > 0 then
//                         //    GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%' //'18%'
//                         //else
//                         //    GST := '0%';
//                         AmountInclGst := GSTAmount + AmountExclGST;
//                         //-
//                     End
//                     else
//                         if "Sales Line".Type = "Sales Line".Type::"G/L Account" then begin
//                             AmountExclGST := Quantity * "Unit Price";
//                             GSTAmount := 0;
//                             //GST := '';
//                             CalculateLineGST("Sales Header", "Sales Line");
//                             GSTAmount := IGSTamount + CGSTamount + SGSTAmount;
//                             GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%'; //'18%'
//                             // if GSTAmount > 0 then
//                             //     GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%' //'18%'
//                             // else
//                             //     GST := '0%';

//                             AmountInclGst := GSTAmount + AmountExclGST;
//                         end
//                         else
//                             if "Sales Line".Type = "Sales Line".Type::"Charge (Item)" then begin
//                                 AmountExclGST := Quantity * "Unit Price";
//                                 GSTAmount := 0;
//                                 //GST := '';
//                                 CalculateLineGST("Sales Header", "Sales Line");
//                                 GSTAmount := IGSTamount + CGSTamount + SGSTAmount;
//                                 GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%'; //'18%'
//                                 // if GSTAmount > 0 then
//                                 //     GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%' //'18%'
//                                 // else
//                                 //     GST := '0%';

//                                 AmountInclGst := GSTAmount + AmountExclGST;
//                             end
//                             else begin
//                                 AmountExclGST := Quantity * "Unit Price";
//                                 CalculateLineGST("Sales Header", "Sales Line");
//                                 GSTAmount := IGSTamount + CGSTamount + SGSTAmount;
//                                 GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%'; //'18%'
//                                 // if GSTAmount > 0 then
//                                 //     GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%' //'18%'
//                                 // else
//                                 //     GST := '0%';
//                                 AmountInclGst := GSTAmount + AmountExclGST;
//                             end;
//                     //+
//                     total := total + AmountInclGst;


//                     // chekReport.InitTextVariable();
//                     //  chekReport.FormatNoText(Notext, total, '');
//                     CheckReportNew.InitTextVariable();
//                     CheckReportNew.FormatNoText(Notext, round(total, 0.01), "Sales Header"."Currency Code");
//                     // AMountInW := DelChr(Notext[1], '<>', '*') + Notext[2];
//                     // AMountInW := CopyStr(String1, 2, StrLen(String1));

//                     // AMountInW := CopyStr(Notext[1], 1, StrPos(Notext[1], '/100') - 1) + ' PAISA ONLY';
//                     AMountInW := Notext[1] + ' ' + Notext[2];



//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     SrNo := 0;

//                     Clear(AmountExclGST);
//                     Clear(AmountInclGst);

//                 end;
//             }
//             dataitem(SCmtline; "Sales Comment Line")
//             {
//                 DataItemLink = "Document Type" = field("Document Type"), "No." = Field("No.");
//                 DataItemTableView = where("Document Line No." = filter(0));
//                 column(Comment; Comment) { }
//                 column(Line_No_; "Line No.") { }
//                 column(Document_Line_No_; "Document Line No.") { }
//                 column(SrNo5; SrNo5) { }

//                 trigger OnAfterGetRecord()
//                 begin
//                     SrNo5 += 1;
//                     SrNoint := SrNo5;
//                 end;

//             }
//             dataitem("Sales Order Remarks"; "Sales Order Remarks")
//             {
//                 DataItemLink = "Document No." = FIELD("No.");
//                 DataItemTableView = WHERE("Document Type" = filter("Blanket Order"), "Document Line No." = const(0));
//                 column(Remark_Document_Type; "Document Type") { }
//                 column(Remark_Document_No_; "Document No.") { }
//                 column(Remark_Document_Line_No_; "Document Line No.") { }
//                 column(Remark_Line_No_; "Line No.") { }
//                 column(Remark_Comments; Comments) { }
//                 column(SNO1; SNO1) { }
//                 trigger OnAfterGetRecord()
//                 begin
//                     SNO1 += 1;
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     SNO1 := SrNo5;

//                 end;

//             }
//             trigger OnPreDataItem()
//             begin
//                 if DocNoFilter <> '' then begin
//                     SetRange("Document Type", DocTypeFilter);
//                     SetRange("No.", DocNoFilter);
//                 end;
//             end;

//             trigger OnAfterGetRecord()
//             var
//                 SalesLine_Lrec: Record "Sales Line";
//                 //Check_LRep: Report Check;
//                 Check_LRep: Report "Reciept Voucher VML";
//                 VatRegNo_Lctxt: Label 'VAT Registration No. %1';
//                 DocumentError: Label 'Document must be released';
//                 PaymentTerms_LRec: Record "Payment Terms";
//                 Bank_LRec: Record "Bank Account";
//                 TranSpec_rec: Record "Transaction Specification";
//                 Area_Rec: Record "Area";
//                 Cust_Lrec: Record Customer;
//                 ShipToAdd: Record "Ship-to Address";
//                 AreaRec: Record "Area";
//                 ExitpointRec: Record 282;
//                 GlSetup: Record "General Ledger Setup";
//                 Currencies: Record Currency;
//             begin
//                 //ReportHdr_Txt := '';
//                 //ReportHdr_Txt := StrSubstNo('Sales %1', "Document Type");

//                 // FormatAddr.SalesHeaderBillTo(CustAddr_Arr, "Sales Header");

//                 Cust_TRN := '';
//                 PrintVATremark := false;
//                 Cust_Lrec.Reset();
//                 IF Cust_Lrec.get("Bill-to Customer No.") then begin
//                     if Cust_Lrec."VAT Registration No." <> '' then
//                         Cust_TRN := 'TRN: ' + Cust_Lrec."VAT Registration No.";
//                     if (Cust_Lrec."VAT Bus. Posting Group" = 'C-LOCAL') AND CompanyisFZE then
//                         PrintVATremark := TRUE;
//                 end;

//                 //if ("Document Type" = "Document Type"::Order) AND (Status <> Status::Released) then
//                 //  Error(DocumentError);

//                 IF "Document Type" = "Document Type"::Quote then
//                     reportText := 'Pro Forma Invoice / Price Quotation'
//                 else
//                     If "Document Type" = "Document Type"::Order then
//                         reportText := 'Pro Forma Invoice / Sales Order';

//                 Clear(CustAddrShipto_Arr);
//                 if "Ship-to Code" <> '' THEN begin
//                     CustAddrShipto_Arr[1] := "Ship-to Name";
//                     CustAddrShipto_Arr[2] := "Ship-to Address";
//                     CustAddrShipto_Arr[3] := "Ship-to Address 2";
//                     CustAddrShipto_Arr[4] := "Ship-to City";
//                     CustAddrShipto_Arr[8] := "Ship-to Post Code";
//                     if CountryRegionL.Get("Ship-to Country/Region Code") then
//                         CustAddrShipto_Arr[5] := CountryRegionL.Name;
//                     //AW09032020>>
//                     if "Ship-to Code" <> '' then begin
//                         if ShipToAdd.Get("Sell-to Customer No.", "Ship-to Code") and (ShipToAdd."Phone No." <> '') then
//                             CustAddrShipto_Arr[6] := 'Tel: ' + ShipToAdd."Phone No.";
//                         // else
//                         //     if "Sell-to Phone No." <> '' then
//                         //         CustAddrShipto_Arr[7] := 'Tel No.: ' + "Sell-to Phone No.";
//                     end;
//                     //  else
//                     //     if "Sell-to Phone No." <> '' then
//                     //         CustAddrShipto_Arr[7] := 'Tel No.: ' + "Sell-to Phone No.";
//                     //AW09032020<<
//                     //CustAddrShipto_Arr[8] := ;
//                 END;

//                 //AW
//                 //AW-06032020>>
//                 if CustAltAddrBool = true then begin
//                     if CustAltAddrRec.Get("Sales Header"."Bill-to Customer No.") then begin
//                         CustAddr_Arr[1] := CustAltAddrRec.Name;
//                         CustAddr_Arr[2] := CustAltAddrRec.Address;
//                         CustAddr_Arr[3] := CustAltAddrRec.Address2;
//                         CustAddr_Arr[4] := CustAltAddrRec.City;
//                         CustAddr_Arr[10] := CustAltAddrRec.PostCode;
//                         if CountryRegionL.Get(CustAltAddrRec."Country/Region Code") then
//                             CustAddr_Arr[5] := CountryRegionL.Name;
//                         if CustAltAddrRec.Get("Bill-to Customer No.") then
//                             if CustAltAddrRec.PhoneNo <> '' then
//                                 CustAddr_Arr[6] := 'Tel: ' + CustAltAddrRec.PhoneNo;
//                         if CustAltAddrRec."Customer TRN" <> '' then
//                             CustAddr_Arr[7] := 'TRN: ' + CustAltAddrRec."Customer TRN"
//                         else
//                             CustAddr_Arr[7] := Cust_TRN;
//                         // if Cust_TRN <> '' then
//                         //     CustAddr_Arr[7] := Cust_TRN;
//                         if CustAltAddrRec."Customer Registration No." <> '' then
//                             CustAddr_Arr[8] := CustAltAddrRec."Customer Registration Type" + ': ' + CustAltAddrRec."Customer Registration No."
//                         else
//                             CustAddr_Arr[8] := '';
//                         // CustAddr_Arr[8] := Fieldcaption("Customer Registration Type") + ': ' + Fieldcaption("Customer Registration No.");
//                         // if CustAltAddrRec."Customer TRN" <> '' then
//                         //     CustAddr_Arr[9] := 'TRN: ' + CustAltAddrRec."Customer TRN";
//                         // CompressArray(CustAddr_Arr);



//                     end
//                     else begin
//                         //if cust alt address not found
//                         CustAddr_Arr[1] := "Bill-to Name";
//                         CustAddr_Arr[2] := "Bill-to Address";
//                         CustAddr_Arr[3] := "Bill-to Address 2";
//                         CustAddr_Arr[4] := "Bill-to City";
//                         CustAddr_Arr[10] := "Bill-to Post Code";
//                         if CountryRegionL.Get("Bill-to Country/Region Code") then
//                             CustAddr_Arr[5] := CountryRegionL.Name;
//                         Cust_Lrec.Reset();
//                         if Cust_Lrec.Get("Bill-to Customer No.") and (Cust_Lrec."Phone No." <> '') then
//                             CustAddr_Arr[6] := 'Tel: ' + Cust_Lrec."Phone No."
//                         else
//                             if "Sell-to Phone No." <> '' then
//                                 CustAddr_Arr[6] := 'Tel: ' + "Sell-to Phone No.";
//                         if Cust_TRN <> '' then
//                             CustAddr_Arr[7] := Cust_TRN;

//                         if CustomInvoiceG then begin
//                             // if CustAltAddrRec.Get("Sales Header"."Bill-to Customer No.") then begin
//                             if "Customer Registration No." <> '' then
//                                 CustAddr_Arr[8] := "Customer Registration Type" + ': ' + "Customer Registration No."
//                             else
//                                 CustAddr_Arr[8] := '';
//                             // CustAddr_Arr[8] := Fieldcaption("Customer Registration Type") + ': ' + Fieldcaption("Customer Registration No.");
//                             //  end;
//                         end;
//                         // else begin

//                         // CustAddr_Arr[8] := FieldCaption("Customer Registration Type") + ': ' + FieldCaption("Customer Registration No.");
//                         // end;
//                         // if Cust_TRN <> '' then
//                         //     CustAddr_Arr[9] := Cust_TRN;
//                         // CompressArray(CustAddr_Arr);
//                     end;
//                 end
//                 // //SJ>>24-02-20
//                 else begin
//                     //if bool false
//                     Clear(CustAddr_Arr);
//                     CustAddr_Arr[1] := "Bill-to Name";
//                     CustAddr_Arr[2] := "Bill-to Address";
//                     CustAddr_Arr[3] := "Bill-to Address 2";
//                     CustAddr_Arr[4] := "Bill-to City";
//                     CustAddr_Arr[10] := "Bill-to Post Code";
//                     if CountryRegionL.Get("Bill-to Country/Region Code") then
//                         CustAddr_Arr[5] := CountryRegionL.Name;
//                     Cust_Lrec.Reset();
//                     if Cust_Lrec.Get("Bill-to Customer No.") and (Cust_Lrec."Phone No." <> '') then
//                         CustAddr_Arr[6] := 'Tel: ' + Cust_Lrec."Phone No."
//                     else
//                         if "Sell-to Phone No." <> '' then
//                             CustAddr_Arr[6] := 'Tel: ' + "Sell-to Phone No.";
//                     if Cust_TRN <> '' then
//                         CustAddr_Arr[7] := Cust_TRN;

//                     if CustomInvoiceG then begin
//                         //if CustAltAddrRec.Get("Sales Header"."Bill-to Customer No.") then begin
//                         if "Customer Registration No." <> '' then
//                             CustAddr_Arr[8] := "Customer Registration Type" + ': ' + "Customer Registration No."
//                         else
//                             CustAddr_Arr[8] := '';
//                         // CustAddr_Arr[8] := Fieldcaption("Customer Registration Type") + ': ' + Fieldcaption("Customer Registration No.");
//                         // end;
//                     end
//                     else begin
//                         if "Customer Registration No." <> '' then
//                             CustAddr_Arr[8] := "Customer Registration Type" + ': ' + "Customer Registration No."
//                         else
//                             CustAddr_Arr[8] := '';
//                         // CustAddr_Arr[8] := FieldCaption("Customer Registration Type") + ': ' + FieldCaption("Customer Registration No.");
//                     end;


//                 end;
//                 //AW-06032020<<

//                 //Message('%1 %2', "Sales Header"."Document Type", "Sales Header"."No.");
//                 PaymentTerms_Desc := '';
//                 If PaymentTerms_LRec.GET("Sales Header"."Payment Terms Code") then
//                     PaymentTerms_Desc := PaymentTerms_LRec.Description;

//                 //SD::GK
//                 if "Sales Header"."Exit Point" <> '' then begin
//                     if ExitpointRec.Get("Sales Header"."Exit Point") then
//                         PortOfLoding2 := ExitpointRec.Description;
//                 end;
//                 //SD::GK

//                 AreaRec.Reset();
//                 IF AreaRec.Get("Sales Header"."Area") then
//                     PortOfLoding := AreaRec.Text;

//                 // PortOfLoding := "Sales Header".CountryOfLoading;  //22
//                 if CustAltAddrBool then begin
//                     clear(PortOfLoding);
//                     IF AreaRec.Get("Sales Header"."Customer Port of Discharge") then
//                         PortOfLoding := AreaRec.Text;
//                 end;

//                 TranSec_Desc := '';
//                 IF TranSpec_rec.GET("Sales Header"."Transaction Specification") then
//                     TranSec_Desc := TranSpec_rec.Text;

//                 if PortOfLoding <> '' then
//                     TranSec_Desc := TranSec_Desc + ', ' + PortOfLoding;
//                 // IF Area_Rec.Get("Sales Header"."Area") And (Area_Rec.Text <> '') then
//                 //     TranSec_Desc := TranSec_Desc + ' ' + Area_Rec.Text;

//                 if Format("Sales Header"."Shipment Term") <> '' then
//                     TranSec_Desc := TranSec_Desc + ', ' + Format("Sales Header"."Shipment Term");

//                 TotalAmt := 0;
//                 TotalVatAmtAED := 0;
//                 TotalAmountAED := 0;
//                 SalesLine_Lrec.Reset;
//                 SalesLine_Lrec.SetRange("Document Type", "Document Type");
//                 SalesLine_Lrec.SetRange("Document No.", "No.");
//                 if SalesLine_Lrec.FindSet(false) then
//                     repeat
//                         //SD::GK
//                         if CustomInvoiceG then begin
//                             TotalAmt += Round((SalesLine_Lrec."Quantity (Base)" * SalesLine_Lrec."Customer Requested Unit Price") + ((SalesLine_Lrec."Quantity (Base)" * SalesLine_Lrec."Customer Requested Unit Price") * SalesLine_Lrec."VAT %" / 100), 0.01, '=');
//                             TotalVatAmtAED += ((SalesLine_Lrec."Quantity (Base)" * SalesLine_Lrec."Customer Requested Unit Price") * SalesLine_Lrec."VAT %" / 100);
//                         end
//                         //SD::GK
//                         else begin
//                             TotalAmt += SalesLine_Lrec."Amount Including VAT";
//                             TotalVatAmtAED += SalesLine_Lrec."VAT Base Amount" * SalesLine_Lrec."VAT %" / 100;
//                         end;
//                     until SalesLine_Lrec.Next = 0;

//                 TotalAmt := Round(TotalAmt, 0.01);//SD::GK 5/25/2020

//                 TotalIncludingCaption := '';
//                 ExchangeRate := 0;
//                 TotalAmountAED := TotalAmt;
//                 If "Currency Factor" <> 0 then begin
//                     TotalIncludingCaption := StrSubstNo('Total Amount Including VAT in %1', "Currency Code");
//                     ExchangeRate := ROUND(1 / "Currency Factor", 0.00001, '=');
//                     TotalVatAmtAED := TotalVatAmtAED / "Currency Factor";
//                     TotalAmountAED := TotalAmt / "Currency Factor";
//                 End ELSe begin
//                     GlSetup.Get();
//                     TotalIncludingCaption := StrSubstNo('Total Amount Including VAT in %1', GlSetup."LCY Code");
//                     ExchangeRate := 1.0000;
//                     // end;
//                     // ExchangeRate := '';
//                 End;
//                 // if "Currency Code" = '' then
//                 //     ExchangeRate := '';
//                 Clear(AmtinWord_GTxt);
//                 Clear(Check_LRep);
//                 Check_LRep.InitTextVariable;
//                 Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, "Sales Header"."Currency Code");
//                 String := DelChr(AmtinWord_GTxt[1], '<>', '*') + AmtinWord_GTxt[2];
//                 String := CopyStr(String, 2, StrLen(String));
//                 Clear(Check_LRep);

//                 clear(CurrencyDescription);
//                 GeneralLedgerSEtup.get();
//                 IF CurrencyRec.get("Sales Header"."Currency Code") then
//                     CurrencyDescription := CurrencyRec.Description
//                 else
//                     IF CurrencyRec.get(GeneralLedgerSEtup."LCY Code") then
//                         CurrencyDescription := CurrencyRec.Description;


//                 SrNo := 0;
//                 //Message('No. %1', "No.");
//                 if Cust_Lrec.get("Sell-to Customer No.") and (Cust_Lrec."seller Bank Detail" = true) then
//                     HideBank_Detail := true
//                 else
//                     if Cust_Lrec.get("Sell-to Customer No.") and (Cust_Lrec."seller Bank Detail" = false) then begin
//                         HideBank_Detail := false;
//                         If Bank_LRec.GET("Sales Header"."Bank on Invoice 2") then begin //PackingListExtChange
//                             BankName := Bank_LRec.Name;
//                             if Bank_LRec.Address <> '' then
//                                 BankADD := Bank_LRec.Address;
//                             if Bank_LRec."Address 2" <> '' then
//                                 BankADD := BankADD + ',' + Bank_LRec."Address 2";
//                             if Bank_LRec.City <> '' then
//                                 BankADD := BankADD + ', ' + Bank_LRec.City;
//                             if Bank_LRec."Country/Region Code" <> '' then
//                                 BankADD := BankADD + ', ' + Bank_LRec."Country/Region Code";

//                             BeneficiaryName := CompanyInformation.Name;
//                             if CompanyInformation.Address <> '' then
//                                 BeneficiaryAddress := CompanyInformation.Address + ', ';
//                             if CompanyInformation."Address 2" <> '' then
//                                 BeneficiaryAddress := BeneficiaryAddress + CompanyInformation."Address 2" + ', ';
//                             if CompanyInformation.City <> '' then
//                                 BeneficiaryAddress := BeneficiaryAddress + CompanyInformation.City + ', ';
//                             if CompanyInformation."Country/Region Code" <> '' then
//                                 BeneficiaryAddress := BeneficiaryAddress + CompanyInformation."Country/Region Code";
//                             SWIFTCode := Bank_LRec."SWIFT Code";
//                             IBANNumber := Bank_LRec."Bank Account No.";
//                             Branchname := Bank_LRec."Branch Name";
//                             // AccNo := Bank_LRec."Bank Account No.";
//                             IFSCcode := Bank_LRec."IFSC CODE";
//                         ENd;
//                     end;

//                 IF "Seller/Buyer 2" then
//                     Inspection_Caption := 'Inspection will be provided by nominated third party at the Buyer’s cost'
//                 Else
//                     Inspection_Caption := 'Inspection will be provided by nominated third party at the Seller’s cost';


//                 SerialNo := 4;
//                 if "Inspection Required 2" then begin //PackingListExtChange
//                     SerialNo += 1;
//                     SrNo1 := SerialNo;
//                 end;
//                 if "Legalization Required 2" then begin //PackingListExtChange
//                     SerialNo += 1;
//                     SrNo2 := SerialNo;
//                 end;
//                 if PrintVATremark then begin
//                     SerialNo += 1;
//                     SrNo3 := SerialNo;
//                 end;
//                 if "Sales Header"."Duty Exemption" = true then begin
//                     SerialNo += 1;
//                     SrNo4 := SerialNo;
//                 end;

//                 SrNo5 := SerialNo;

//                 if "Bill-to Customer No." = "Sell-to Customer No." then
//                     ShiptoVar := true
//                 else
//                     ShiptoVar := false;

//                 if CustomerRecBill.get("Sell-to Customer No.") then;
//                 // if CustomerRecBill.get("Bill-to Customer No.") then;
//                 if CustomerRecShipp.get("Ship-to Code") then;
//                 if ContrrecCustomer.get(CustomerRecBill."Country/Region Code") then;
//                 if ContrrecComapny.get(CompanyInformation."Country/Region Code") then;
//                 StateRec.Reset();
//                 StateRec.SetRange(Code, CustomerRecBill."State Code");
//                 if StateRec.FindFirst() then
//                     CustomeSatedesc := StateRec.Description;
//                 if "Currency Code" = '' then
//                     CurrencyCOde := 'INR'
//                 else
//                     CurrencyCOde := "Currency Code";
//                 if CustomerRecBill."Country/Region Code" = 'IND' then
//                     PortOflOadCaption := 'Place of Loading: '
//                 else
//                     PortOflOadCaption := 'Port of Loading: ';

//                 //PKM
//                 if CustomerRecBill.get("Sell-to Customer No.") then;

//                 if Billing = true then begin
//                     Billname := "Bill-to Name";
//                     Billadress1 := "Bill-to Address";
//                     billadres2 := "Bill-to Address 2";
//                     billcity := "Bill-to City";
//                     Billteliphone := "Bill-to Post Code";

//                 end
//                 else begin
//                     Billname := CustomerRecBill.Name;
//                     Billadress1 := CustomerRecBill.Address;
//                     billadres2 := CustomerRecBill."Address 2";
//                     billcity := CustomerRecBill.City;
//                     Billteliphone := CustomerRecBill."Post Code";
//                 end;
//                 if Shipping = true then begin
//                     ShippName := "Ship-to Name";
//                     ShippAdress1 := "Ship-to Address";
//                     ShippAddress2 := "Ship-to Address 2";
//                     ShippCity := "Ship-to City";
//                     ShippPostcode := "Ship-to Post Code";
//                     ShipCaption := 'Ship To';


//                 end
//                 else begin
//                     ShippName := '';
//                     ShippAdress1 := '';
//                     ShippAddress2 := '';
//                     ShippCity := '';
//                     ShippPostcode := '';
//                     ShipCaption := '';

//                 end;
//                 //EDN

//                 if Billteliphone = '' then
//                     Postcodecaption := ''
//                 else
//                     Postcodecaption := 'Post Code: ';




//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(Options)
//                 {
//                     field("Print Customer Invoice"; CustomInvoiceG)
//                     {
//                         ApplicationArea = ALL;
//                     }
//                     field("Customer Alternate Address"; CustAltAddrBool)
//                     {
//                         ApplicationArea = All;
//                     }
//                     field(Hide_E_sign; Hide_E_sign)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Hide E-Signature';
//                     }
//                     field("SalesLine Merge"; SalesLineMerge)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'SalesLine UnMerge';
//                     }
//                     field(ShowCustomerCOO; ShowCustomerCOO)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Show Customer COO';
//                     }

//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//         RepHeader = 'Pro Forma Invoice';
//         Ref_Lbl = 'P/I No.:';
//         Date_Lbl = 'P/I Date:';
//         NewRemark1 = 'General terms and conditions of sales given on last page of this pro Forma invoice will apply';
//         NewRemark2 = 'This Pro Forma invoice is subject to availability of the material and provision of force majeure conditions';
//         NewRemark3 = 'Prices given in this Pro Forma invoice are the actual value the goods and services as described and there is no other transaction between the buyer and the seller in regard to this business.';

//         YourReference_Lbl = 'Customer Ref.:';
//         ValidTo_Lbl = 'P/I Validity:';
//         DeliveryTerms_Lbl = 'Delivery Terms:';
//         PaymentTerms_Lbl = 'Payment Terms:';
//         Fix_Remark_lbl = 'The buyer agreed to provide duty exemption documents to the seller, otherwise the selling price should be revised.';
//         VatAmt_Lbl = 'VAT Amount';
//         TotalPayableinwords_Lbl = 'Total Payable in words';
//         ExchangeRate_Lbl = 'Currency exchange rate for VAT calculation:';
//         Terms_Condition_Lbl = 'Terms & Condition:';
//         HideBank_lbl = 'Bank Information will be provided upon request.';
//         BankDetails_Lbl = 'Bank Details';
//         BeneficiaryName_Lbl = 'Beneficiary Name:';
//         BankName_Lbl = 'Bank Name: ';


//         IBANNumber_Lbl = 'Bank Account No:';
//         SwiftCode_Lbl = 'Branch Name:';
//         IFSCCode_Lbl = 'IFSC CODE:';

//         PortofLoading_Lbl = 'Port Of Loading:';
//         PortofDischarge_Lbl = 'Port of Discharge:';
//         AmountinAed_Lbl = 'Total Invoice amount in AED:';
//         TotalAmtExcVat_Cap = 'Total Amount Excluding VAT:';
//         TotalAmtIncVat_Cap = 'Total Amount Including VAT:';
//         VATAmountinAED_Lbl = 'Total VAT Amount:';
//         Origin_Lbl = 'Origin: ';
//         HSCode_Lbl = 'HS Code: ';
//         Packing_Lbl = 'Packing: ';
//         NoOfLoads_Lbl = 'No. Of Loads: ';
//         BillTo_Lbl = 'Bill To';
//         ShipTo_Lbl = 'Ship To';
//         Inspection_lbl1 = 'Inspection will be provided by nominated third party at the seller’s/Buyer’s cost';
//         Inspection_lbl2 = 'One original Invoice and one original certificate of origin will be Legalized by consulate at the seller’s cost.';
//         remarks_lbl = 'Remarks:';
//         remark_1_lbl = 'General sale conditions are provided on the last page of this Pro Forma Invoice';
//         //remark_2_lbl = 
//         Qty_lbl = 'Quantity';
//         UnitPrice_Lbl = 'Unit Price';
//         VATPurpose_Lbl = 'VAT use only';
//         VAT_Attention_Lbl = 'Attention is drawn to Article 48 of the Federal Decree-Law No (8) of 2017 of UAE on Value Added Tax (VAT) where the recipient of goods is required to account for VAT.';
//         CustAltAddr = 'Customer Alternate Address';

//         //GK
//         GeneralTermsandConditionsofSale_lbl = 'General Terms and Conditions of Sale';
//         ScopeofApplication_lbl = 'Scope of Application';
//         OfferandAcceptance_lbl = 'Offer and Acceptance';
//         Productquality_lbl = 'Product quality, specimens, samples and guarantees';
//         Advice_lbl = 'Advice';
//         Prices_lab = 'Prices';
//         Delivery_lbl = 'Delivery';
//         DamagesinTransit_lbl = 'Damages in transit';
//         Compiance_lbl = 'Compliance with legal requirements';
//         Delay_lbl = 'Delay in Payment';
//         BuyerRight_lbl = 'Buyer’s rights regarding defective goods';
//         ForceMajeure_lbl = 'Force Majeure';
//     }

//     trigger OnPreReport()
//     var
//         Bank_LRec: Record "Bank Account";

//     begin
//         CompanyInformation.Get;
//         CompanyInformation.CalcFields(Picture);
//         if CountryRegionRec.Get(CompanyInformation."Country/Region Code") then;

//         // UK::04062020>>
//         spacePosition := StrPos(CompanyInformation.Name, ' ');
//         CompanyFirstWord := CopyStr(CompanyInformation.Name, 1, spacePosition - 1);

//         Text1 := StrSubstNo(Condition1, CompanyInformation.Name, CompanyFirstWord);

//         Text12 := StrSubstNo(Condition12, CompanyInformation.Name, CompanyInformation."Registered in", CompanyInformation."License No.", CompanyInformation."Registration No.");
//         Text21 := StrSubstNo(Condition2, CompanyFirstWord);
//         Text22 := StrSubstNo(Condition31, CompanyFirstWord);
//         Text23 := StrSubstNo(Condition4, CompanyFirstWord);
//         Text24 := StrSubstNo(Condition5, CompanyFirstWord);
//         Text25 := StrSubstNo(Condition7, CompanyFirstWord);
//         Text26 := StrSubstNo(Condition92, CompanyFirstWord);
//         Text27 := StrSubstNo(Condition1011, CompanyFirstWord);
//         Text28 := StrSubstNo(Condition1012, CompanyFirstWord);
//         Text29 := StrSubstNo(Condition1021, CompanyFirstWord);
//         Text30 := StrSubstNo(Condition1021a, CompanyFirstWord);
//         Text31 := StrSubstNo(Condition1021b, CompanyFirstWord);
//         Text32 := StrSubstNo(Condition1041, CompanyFirstWord);
//         Text33 := StrSubstNo(Condition11, CompanyFirstWord);

//         //UK::04062020<<

//         CompanyisFZE := false;
//         IF (StrPos(CompanyInformation.Name, 'FZE') <> 0) OR
//             (StrPos(CompanyInformation.Name, 'fze') <> 0) OR
//             (StrPos(CompanyInformation.Name, 'FZCO') <> 0) OR
//             (StrPos(CompanyInformation.Name, 'fzco') <> 0) then
//             CompanyisFZE := TRUE;

//         HideBank_Detail := false;

//         //BankNo := 'WWB-EUR';
//         // If Bank_LRec.GET(BankNo) then begin
//         //     BankName := Bank_LRec.Name;
//         //     SWIFTCode := Bank_LRec."SWIFT Code";
//         //     IBANNumber := Bank_LRec.IBAN;
//         // ENd Else
//         //     Error('Bank No. Must not be blank');

//     end;


//     //GST

//     local procedure CalculateLineGST(recSalesHdr: Record "Sales Header"; recSaleLine: Record "Sales Line")
//     var
//         recTaxRates: Record "Tax Rate";
//         recTaxConfig: Record "Tax Rate Value";
//         recTaxComponent: Record "Tax Component";
//         TaxRates: Page "Tax Rates";
//         intCGST: Integer;
//         intIGST: Integer;
//         intSGST: Integer;
//         TaxRateID: Text;
//         ConfigID: Text;
//     Begin
//         intCGST := 0;
//         intSGST := 0;
//         intIGST := 0;

//         // if "Purchase Header"."Location State Code" <> '' then
//         //     TaxRateID := StrSubstNo('%1|%2|%3|%4|No|No|', recPurchLine."GST Group Code", recPurchLine."HSN/SAC Code", recPurchHdr.State, recPurchHdr."Location State Code")
//         // else
//         //     TaxRateID := StrSubstNo('%1|%2|%3|%4|No|No|', recPurchLine."GST Group Code", recPurchLine."HSN/SAC Code", recPurchHdr.State, CompanyInformation."State Code");

//         recTaxComponent.Reset();
//         recTaxComponent.SetRange("Tax Type", 'GST');
//         recTaxComponent.FindSet();
//         repeat
//             case recTaxComponent.Name of
//                 'IGST':
//                     intIGST := recTaxComponent.ID;
//                 'CGST':
//                     intCGST := recTaxComponent.ID;
//                 'SGST':
//                     intSGST := recTaxComponent.ID;
//             end;
//         until recTaxComponent.Next() = 0;

//         ConfigID := StrSubstNo('%1|%2|%3', intIGST, intCGST, intSGST);

//         GetLineGSTAmount(recSaleLine, ConfigID, intIGST, intCGST, intSGST);

//         // recTaxRates.Reset();
//         // recTaxRates.SetRange("Tax Type", 'GST');
//         // recTaxRates.SetRange("Tax Rate ID", TaxRateID);
//         // recTaxRates.FindFirst();

//         // recTaxConfig.Reset();
//         // recTaxConfig.SetRange("Config ID", recTaxRates.ID);
//         // recTaxConfig.SetRange("Tax Type", 'GST');
//         // recTaxConfig.FindSet();
//         // repeat
//         //     case recTaxConfig."Column ID" of
//         //         intIGST:
//         //             begin
//         //                 IGSTPer := recTaxConfig.Value + '%';
//         //             end;
//         //         intCGST:
//         //             begin
//         //                 CGSTPer := recTaxConfig.Value + '%';
//         //             end;
//         //         intSGST:
//         //             begin
//         //                 SGSTPer := recTaxConfig.Value + '%';
//         //             end;
//         //     end;
//         // until recTaxConfig.Next() = 0;

//         // if IGSTPer <> '0%' then begin
//         //     CGSTPer := '';
//         //     SGSTPer := '';
//         //     CGSTamount := 0;
//         //     SGSTAmount := 0;
//         //     IGSTamount := decTotGstAmt;
//         // end else begin
//         //     IGSTPer := '';
//         //     IGSTamount := 0;
//         //     CGSTamount := decTotGstAmt / 2;
//         //     SGSTAmount := decTotGstAmt / 2;
//         // end;
//     End;

//     local procedure GetLineGSTAmount(gSalesLine: Record "Sales Line"; FilterID: Text; IGSTID: Integer; CGSTID: Integer; SGSTID: Integer)
//     var
//         lSalesLine: Record "Sales Line";
//         TaxTransactionValue: Record "Tax Transaction Value";
//         GSTSetup: Record "GST Setup";
//         decTotTaxAmt: Decimal;
//     begin
//         lSalesLine.Get(gSalesLine."Document Type", gSalesLine."Document No.", gSalesLine."Line No.");
//         decTotTaxAmt := 0;
//         if not GSTSetup.Get() then
//             exit;

//         TaxTransactionValue.SetRange("Tax Record ID", lSalesLine.RecordId);
//         TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
//         if GSTSetup."Cess Tax Type" <> '' then
//             TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
//         else
//             TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
//         TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
//         TaxTransactionValue.SetFilter("Value ID", FilterID);
//         // if not TaxTransactionValue.IsEmpty() then
//         //     TaxTransactionValue.CalcSums(Amount);

//         if TaxTransactionValue.FindSet() then
//             repeat
//                 case TaxTransactionValue."Value ID" of
//                     IGSTID:
//                         begin
//                             IGST := Format(TaxTransactionValue.Percent) + '%';
//                             IGSTPct := TaxTransactionValue.Percent;
//                             IGSTamount := TaxTransactionValue.Amount;
//                         end;
//                     CGSTID:
//                         begin
//                             CGST := Format(TaxTransactionValue.Percent) + '%';
//                             CGSTPct := TaxTransactionValue.Percent;
//                             CGSTamount := TaxTransactionValue.Amount;
//                         end;
//                     SGSTID:
//                         begin
//                             SGST := Format(TaxTransactionValue.Percent) + '%';
//                             SGSTPct := TaxTransactionValue.Percent;
//                             SGSTamount := TaxTransactionValue.Amount;
//                         end;
//                 end;
//                 decTotTaxAmt += TaxTransactionValue.Amount;
//             until TaxTransactionValue.Next() = 0;
//         // exit(TaxTransactionValue.Amount);
//         //exit(decTotTaxAmt);
//     end;

//     procedure SetDocFilter(DocType: Enum "Sales Document Type"; DocNo: Code[20])
//     var
//         SalesHeader: Record "Sales Header";
//     begin
//         DocTypeFilter := DocType;
//         DocNoFilter := DocNo;
//     end;

//     var
//         DocTypeFilter: Enum "Sales Document Type";
//         DocNoFilter: Code[20];
//         chekReport: Report Check;
//         chekReport1: Report Check;
//         ShippName: text[100];
//         ShipCaption: text[50];
//         ShippAdress1: text[100];
//         ShippAddress2: text[100];
//         ShippCity: Text[100];
//         ShippPostcode: text[100];
//         Billname: Text[250];
//         Billadress1: Text[250];
//         billadres2: Text[250];
//         billcity: Text[100];
//         Billteliphone: text[100];
//         Postcodecaption: text[100];

//         //CheckReportNew: report Check;
//         CheckReportNew: Report "Reciept Voucher VML";
//         Notext: array[2] of Text[100];
//         AMountInW: text[200];
//         CompanyInformation: Record "Company Information";
//         PaymentTerms_Desc: Text[100];
//         TranSec_Desc: Text[150];
//         AmtinWord_GTxt: array[2] of Text[80];


//         CustAddr_Arr: array[10] of Text[90];
//         ShowCustomerCOO: Boolean;


//         CustAddrShipto_Arr: array[8] of Text[90];
//         GeneralLedgerSEtup: Record "General Ledger Setup";
//         CurrencyRec: Record Currency;
//         CurrencyDescription: Text;

//         FormatAddr: Codeunit "Format Address";
//         String: Text;
//         SrNo: Integer;
//         CurrencyCOde: Text[100];
//         SNO: Integer;
//         SNO1: Integer;
//         Customeunitprice: Decimal;
//         SalesLineAmount: Decimal;
//         SalesLineAmountincVat: Decimal;
//         SalesLineVatBaseAmount: Decimal;
//         TotalAmt: Decimal;
//         ExchangeRate: Decimal;
//         ShiptoVar: boolean;

//         PortOfLoding2: Text[250];
//         TotalAmountAED: Decimal;
//         TotalVatAmtAED: Decimal;
//         SearchDesc: Text[250];
//         TotalIncludingCaption: Text[80];
//         BankNo: Code[20];
//         BeneficiaryName: Text[50];
//         BeneficiaryAddress: Text[250];
//         BankName: Text[50];
//         IFSCcode: code[50];
//         StateRec: Record State;
//         CustomeSatedesc: Text[50];
//         BankADD: Text[250];
//         IBANNumber: Text[50];
//         Branchname: Text[50];
//         SWIFTCode: Text[20];
//         AccNo: code[50];


//         IsItem: Boolean;
//         IsComment: Boolean;
//         CountryRegionRec: Record "Country/Region";
//         Origitext: Text[50];
//         HSNCode: Text[50];
//         PackingText: Text[100];
//         reportText: Text[100];
//         Cust_TRN: Text[50];
//         CompanyisFZE: Boolean;
//         PrintVATremark: Boolean;
//         Inspection_Caption: Text[250];
//         LineHSNCodeText: Text[20];
//         LineCountryOfOriginText: Text[100];
//         PortOflOadCaption: text[100];
//         CustomInvoiceG: Boolean;
//         CustAltAddrBool: Boolean;
//         CustAltAddr_Arr: array[10] of Text[100];
//         CustAltAddrRec: Record "Customer Alternet Address";
//         CountryRegionL: Record "Country/Region";
//         HideBank_Detail: Boolean;
//         PortOfLoding: Text[50];
//         SerialNo: Integer;
//         SrNo1: Integer;
//         SrNo2: Integer;
//         SrNo3: Integer;
//         SrNo4: Integer;
//         SrNo5: Integer;
//         SrNoint: Integer;

//         //Gk
//         // UK::04062020>>
//         Text21: Text[500];
//         Text22: Text[400];
//         Text23: Text[400];
//         Text24: Text[450];
//         Text25: Text[400];
//         Text26: Text[400];
//         Text27: Text[400];
//         total: Decimal;
//         Text28: Text[450];
//         Text29: Text[400];
//         Text30: Text[450];
//         Text31: Text[450];
//         Text32: Text[400];
//         Text33: Text[450];
//         CustomerRecBill: Record Customer;

//         CustomerRecShipp: Record Customer;
//         // CustomeShipREc:Record customer
//         GST: text[50];
//         IGST: Text;
//         SGST: Text;
//         CGST: Text;
//         IGSTPct: Decimal;
//         CGSTPct: Decimal;
//         SGSTPct: Decimal;
//         ContrrecCustomer: Record "Country/Region";
//         ContrrecComapny: Record "Country/Region";

//         AmountInclGst: Decimal;
//         AmountExclGST: Decimal;
//         GSTAmount: Decimal;
//         IGSTamount: Decimal;
//         SGSTAmount: Decimal;
//         CGSTamount: Decimal;
//         STPer: decimal;
//         CTPer: decimal;
//         ITPer: decimal;
//         SalesLineMerge: Boolean;
//         spacePosition: Integer;
//         CompanyFirstWord: Text[50];
//         //UK::04062020<<
//         Text1: text[500];
//         Text12: text[250];
//         Condition1: TextConst ENU = 'All supplies and services associated with this Quotation/ Offer Letter/Proforma Invoice, shall be provided exclusively based on these General Terms and Conditions of Sale. These General Terms and Conditions of Sale shall also apply to all future business. Deviation from these General Terms and Conditions of Sale require the explicit written approval of %1 (hereinafter referred to as “%2”).';
//         Condition2: TextConst ENU = '%1’s quotations, Offer Letters and Proforma Invoices are not binding offers but must be seen as invitations to the Buyer to submit a binding offer. The contract is concluded after that the Buyer’s order (offer) is received and %1 issues a written approval. In case %1’s acceptance differs from the offer, such acceptance will be treated as a new non-binding offer of %1.';
//         Condition31: TextConst ENU = 'Unless otherwise agreed, the quality of the goods is exclusively determined by %1’s product specifications. Identified uses relevant for the goods shall neither represent an agreement on the corresponding contractual quality of the goods nor the designated use under this contract.';
//         Condition32: TextConst ENU = 'The properties of specimens and samples are binding only insofar as they have been explicitly agreed to define the quality of the goods.';
//         Condition33: TextConst ENU = 'Quality and expiry data as well as other data constitute a guarantee only if they have been agreed and designated as such.';
//         Condition4: TextConst ENU = 'Any advice rendered by %1 is given to the best of their knowledge. Any advice and information with respect to suitability and application of the goods shall not relieve the Buyer from undertaking their own investigations and tests.';
//         Condition5: TextConst ENU = 'If %1’s prices or terms of payment are generally altered between the date of contract and dispatch, %1 may apply the price or the terms of payment in effect on the day of dispatch. In the event of a price increase, Buyer is entitled to withdraw from the contract by giving notice to %1 within 14 days after notification of the price increase.';
//         Condition6: TextConst ENU = 'Delivery shall be affected as agreed on the contract. General Commercial Terms shall be interpreted in accordance with the terms in force on the date the contract is concluded.';
//         Condition7: TextConst ENU = 'Notice of claims arising out of damage in transit must be logged by the Buyer directly with the carrier within the period specified in the contract of carriage and %1 shall be provided with a copy thereof.';
//         Condition8: TextConst ENU = 'Unless specifically agreed otherwise, the Buyer is responsible for compliance with all laws and regulations regarding import, transport, storage and use of the goods';
//         Condition91: TextConst ENU = 'Failure to pay the purchase by the due date constitutes a fundamental breach of contractual obligations.';
//         Condition92: TextConst ENU = 'In the event of a default in payment by the Buyer, %1 is entitled to charge interest.';
//         Condition1011: TextConst ENU = '%1 must be notified of any defects that are discovered during routine inspection within four weeks of receipt of the goods; other defects must be notified within four weeks after they are discovered but not after:';
//         Condition1011a: TextConst ENU = 'The expiry of the shelf life of the products, or,';
//         Condition1011b: TextConst ENU = 'The products are applied in the manufacturing process, or,';
//         Condition1011c: TextConst ENU = 'It is further sold to a third party.';
//         Condition1012: TextConst ENU = 'Notification must be in writing and must precisely describe the nature and extent of the defects. %1 will not be responsible for any defects arising due to incorrect or inappropriate handling of the products, and/or, storage conditions.';
//         Condition1021: TextConst ENU = 'If the goods are defective and the Buyer has duly notified %1 in accordance with item 10.1, Buyer has its rights provided that:';
//         Condition1021a: TextConst ENU = '%1 has the right to choose whether to remedy the Buyer with replacement of goods with non-defective product or give the buyer an appropriate discount in the purchase price, and';
//         Condition1021b: TextConst ENU = 'Such defects are authenticated by an independent test report of a reputed international testing agency nominated by %1.';
//         Condition103: TextConst ENU = 'In any case, the Buyer’s claims for defective goods are subject to a period of limitation of one year from receipt of goods.';
//         Condition1041: TextConst ENU = 'Subject to clauses 10.1, 10.2 & 10.3 above, %1 shall under no circumstances be liable for:';
//         Condition1041a: TextConst ENU = 'Any indirect, special or consequential loss.';
//         Condition1041b: TextConst ENU = 'Any loss of anticipated profit or loss of business or';
//         Condition1041c: TextConst ENU = 'Any third-party claims against the buyer whether such liability would otherwise arise in contract, tort (including negligence) or breach of statutory duty or otherwise.';
//         Condition11: TextConst ENU = '%1 shall not be liable to the Buyer for any loss or damage suffered by the buyer as a direct or indirect result of the supply of goods by %1 being prevented, restricted, hindered or delayed by reason of any circumstances outside the control of %1.';

//         Condition12: TextConst ENU = '%1 is registered in %2 with License No. %3 and Registration No. %4';
//         Condition13: TextConst ENU = 'The General Terms and Conditions of Sale was reviewed and updated on April 2019 and remains valid until further notification';
//         Hide_E_sign: Boolean;
// }

