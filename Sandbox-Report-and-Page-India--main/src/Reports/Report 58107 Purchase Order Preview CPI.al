// report 58107 "Purchase Order Preview CPI"//T12370-Full Comment
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = 'Layouts/Purchase Order Preview.rdl';
//     UsageCategory = Administration;
//     //ApplicationArea = all;

//     dataset
//     {
//         dataitem("Purchase Header";
//         "Purchase Header")
//         {
//             RequestFilterFields = "No.";
//             column(Comp_Name;
//             CompanyInformation.Name)
//             {
//             }
//             column(CustomeSatedesc; CustomeSatedesc)
//             {

//             }

//             column(CompanyInformation_RegNo; CompanyInformation."Registration No.")
//             {
//             }

//             column(CompanyInformation_LicNo;
//             CompanyInformation."Registration No.")
//             {
//             }
//             column(CompanyInRegNew; CompanyInformation."Registration No New")
//             {

//             }
//             column(Comp_Addr;
//             CompanyInformation.Address)
//             {
//             }
//             column(VendorRecGST; VendorRec."GST Registration No.")
//             {

//             }
//             column(VendorRecPAN; VendorRec."P.A.N. No.")
//             {

//             }
//             column(Comp_Addr2;
//             CompanyInformation."Address 2")
//             {
//             }
//             column(Comp_Logo;
//             CompanyInformation.Picture)
//             {
//             }
//             column(Comp_Phoneno;
//             CompanyInformation."Phone No.")
//             {
//             }
//             column(Comp_GSTRegNo;
//             CompanyInformation."GST Registration No.")
//             {
//             }
//             column(Comp_PANNo; CompanyInformation."P.A.N. No.") { }
//             column(No_;
//             "No.")
//             {
//             }
//             column(Comp_City; CompanyInformation.City + ',' + ContryInfo.Name)
//             {

//             }
//             column(RegNo_CompanyInformation;
//             CompanyInformation."Registration No.")
//             {
//             }
//             column(LicNo_CompanyInformation;
//             CompanyInformation."Registration No.")
//             {
//             }
//             column(Comp_VatRegNo;
//             CompanyInformation."Registration No.")
//             {
//             }
//             column(Registration; CompanyInformation."Registration No.")
//             { }
//             column(Pan_No; CompanyInformation."P.A.N. No.")
//             { }
//             column(GST_Reg; CompanyInformation."GST Registration No.")
//             { }
//             column(PostingDate_;
//             "Document Date")
//             {
//             }
//             column(VendorOrderNo_;
//             "Vendor Order No.")
//             {
//             }
//             column(SupplierRef;
//             "Vendor Order No.")
//             {
//             }
//             column(VendorShipmentNo_;
//             "Vendor Shipment No.")
//             {
//             }
//             column(PaymentTermsCode;
//             PaymentTermsDesc)
//             {
//             }
//             column(VendorGST; Vendor."GST Registration No.") { }
//             column(VendorPANNo; Vendor."P.A.N. No.") { }
//             column(TotalAmt;
//             TotalAmt)
//             {
//             }
//             column(TotalAmountAED;
//             TotalAmountINR)
//             {
//             }
//             column(TotalVatAmtAED;
//             TotalVatAmtAED)
//             {
//             }
//             column(ExchangeRate;
//             ExchangeRate)
//             {
//             }
//             column(CurrencyFactor;
//             CurrencyFactor)
//             {
//             }
//             column(TotalCaption;
//             TotalCaption)
//             {
//             }
//             column(VendAddr1;
//             VendAddr[1])
//             {
//             }
//             column(VendAddr2;
//             VendAddr[2])
//             {
//             }
//             column(VendAddr3;
//             VendAddr[3])
//             {
//             }
//             column(VendAddr4;
//             VendAddr[4])
//             {
//             }
//             column(VendAddr5;
//             VendAddr[5])
//             {
//             }
//             column(VendAddr6;
//             VendAddr[6])
//             {
//             }
//             column(VendAddr7;
//             VendAddr[7])
//             {
//             }
//             column(VendAddr8;
//             VendAddr[8])
//             {
//             }
//             column(Ven_Pan; Vendor."P.A.N. No.")
//             { }
//             column(Ven_Gst; Vendor."GST Registration No.")
//             { }
//             column(AmtinWord_GTxt;
//             AmtinWord_GTxt[1] + ' ' + AmtinWord_GTxt[2])
//             {
//             }
//             column(DeliveryTerms;
//             TranSec_Desc)
//             {
//             }
//             column(Buy_from_Address; "Buy-from Address")
//             { }
//             column(Buy_from_Address_2; "Buy-from Address 2")
//             { }
//             column(Buy_from_City; "Buy-from City") { }
//             column(Buy_from_Contact; "Buy-from Contact") { }
//             column(Buy_from_Country_Region_Code; "Buy-from Country/Region Code") { }
//             column(BuyFrom_AddressG;
//             BuyFrom_AddressG)
//             {
//             }
//             column(BuyFrom_Address2G;
//             BuyFrom_Address2G)
//             {
//             }
//             column(BuyFrom_CityG;
//             BuyFrom_CityG)
//             {
//             }
//             column(BuyFrom_PostCodeG;
//             BuyFrom_PostCodeG)
//             {
//             }
//             column(BuyFrom_CountryRegionG; BuyFrom_CountryRegionG)
//             {
//             }
//             dataitem("Purchase Line"; "Purchase Line")
//             {
//                 DataItemTableView = sorting("Document Type") where("No." = FILTER(<> ''));
//                 DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");

//                 column(SrNo;
//                 SrNo)
//                 { }
//                 column(LineNo_PurchaseLine;
//                 "Line No.")
//                 { }

//                 column(No; "No.") { }
//                 column(Description; Description) { }
//                 column(Description2; "Description 2")
//                 {
//                 }
//                 column(Document_No_; "Document No.")
//                 {

//                 }


//                 column(Quantity; "Quantity (Base)")
//                 {
//                 }
//                 column(UnitofMeasureCode; "Base UOM")
//                 {
//                 }
//                 column(UnitCost; "Unit Price Base UOM")
//                 {
//                 }
//                 column(AmountIncludingVAT; "Amount Including VAT")
//                 {
//                     IncludeCaption = true;
//                 }
//                 column(GST_Group_Code; "GST Group Code")
//                 {
//                     IncludeCaption = true;
//                     //Caption = 'GST%';
//                 }
//                 column(Amount;
//                 Amount)
//                 {
//                 }
//                 column(SearchDesc;
//                 SearchDesc)
//                 {
//                 }
//                 column(Origin;
//                 Origitext)
//                 {
//                 }
//                 column(HSCode;
//                 HSNCode)
//                 {
//                 }
//                 column(Packing;
//                 PackingText)
//                 {
//                 }
//                 column(IsItem;
//                 IsItem)
//                 {
//                 }
//                 column(IsComment;
//                 IsComment)
//                 {
//                 }
//                 column(GST; GST)
//                 {

//                 }
//                 column(CGST; CGST)
//                 { }
//                 column(IGST; IGST)
//                 { }
//                 column(SGST; SGST)
//                 { }
//                 column(GSTAmount; abs(GSTAmount))
//                 { }
//                 column(AmountInclGst; abs(AmountInclGst))
//                 { }
//                 column(AmountExclGST; abs(AmountExclGST))
//                 { }
//                 column(CGSTamount; abs(CGSTamount)) { }
//                 column(IGSTamount; abs(IGSTamount)) { }
//                 column(SGSTAmount; abs(SGSTAmount)) { }
//                 column(AmountInWord; 'Amount in Words: ' + AMountInW)
//                 {

//                 }
//                 //  column(AMountInW;)ss

//                 trigger OnAfterGetRecord()
//                 var
//                     Item_LRec: Record Item;
//                     CountryRegRec: Record "Country/Region";
//                     ItemAttrb: Record "Item Attribute";
//                     ItemAttrVal: Record "Item Attribute Value";
//                     ItemAttrMap: Record "Item Attribute Value Mapping";
//                     TblGenericName: Record KMP_TblGenericName;
//                     VariantRec: Record "Item Variant";
//                     VariantDetailsRec: Record "Item Variant Details";
//                     //-
//                     FixedAssetLocRec: Record "Fixed Asset";
//                     GlAccLocRec: Record "G/L Account";
//                     ItemChargeLocRec: Record "Item Charge";
//                 //+
//                 begin

//                     IsItem := FALSE;
//                     IsComment := Type = Type::" ";
//                     SearchDesc := '';
//                     Origitext := '';
//                     HSNCode := '';
//                     PackingText := '';
//                     IGSTamount := 0;
//                     CGSTamount := 0;
//                     SGSTamount := 0;
//                     IGSTPct := 0;
//                     CGSTPct := 0;
//                     SGSTPct := 0;
//                     if "Purchase Line".Type <> "Purchase Line".Type::" " then
//                         SrNo += 1;
//                     if "Purchase Line".Type = "Purchase Line".Type::Item then
//                         If Item_LRec.GET("No.") THEN BEGIN

//                             // HSNCode := Item_LRec."Tariff No.";
//                             HSNCode := "Item HS Code";

//                             if "Variant Code" <> '' then begin // add by bayas
//                                 VariantRec.Get("No.", "Variant Code");
//                                 if VariantRec."Packing Description" <> '' then begin
//                                     PackingText := VariantRec."Packing Description";
//                                 end else begin
//                                     PackingText := Item_LRec."Description 2";
//                                 end;
//                             end else begin
//                                 PackingText := Item_LRec."Description 2";
//                             end;
//                             //PackingText := Item_LRec."Description 2";
//                             IsItem := TRUE;
//                             CountryRegRec.Reset();
//                             if ShowVendorCOO then begin
//                                 if "Variant Code" <> '' then begin // add by bayas
//                                     VariantRec.Get("No.", "Variant Code");
//                                     if VariantRec."Variant Details" <> '' then
//                                         VariantDetailsRec.Get("No.", "Variant Code");
//                                     if VariantDetailsRec."Vendor Country of Origin" <> '' then begin
//                                         VendorCountryofOrigin := VariantDetailsRec."Vendor Country of Origin";
//                                     end else begin
//                                         VendorCountryofOrigin := Item_LRec."Vendor Country of Origin";
//                                     end;
//                                 end else begin
//                                     VendorCountryofOrigin := Item_LRec."Vendor Country of Origin";
//                                 end;

//                                 if CountryRegRec.Get(VendorCountryofOrigin) then
//                                     Origitext := CountryRegRec.Name;
//                             end else begin
//                                 if CountryRegRec.Get(Item_COO) then
//                                     Origitext := CountryRegRec.Name;
//                             end;

//                             SearchDesc := Item_LRec."Generic Description";

//                             if "Unit Price Base UOM" = 0 then begin
//                                 "Unit Price Base UOM" := "Direct Unit Cost";
//                                 "Base UOM" := "Unit of Measure Code";
//                                 "Quantity (Base)" := Quantity;
//                             end;
//                             AmountExclGST := Quantity * "Direct Unit Cost";
//                             CalculateLineGST("Purchase Header", "Purchase Line");
//                             GSTAmount := IGSTamount + CGSTamount + SGSTAmount;
//                             GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%';
//                             /* if GSTAmount > 0 then
//                                 GST := '18%'
//                             else
//                                 GST := '0%'; */
//                             AmountInclGst := GSTAmount + AmountExclGST;
//                         End;
//                     if "Purchase Line".Type = "Purchase Line".Type::"Fixed Asset" then
//                         If FixedAssetLocRec.GET("No.") THEN BEGIN
//                             // SrNo += 1;
//                             HSNCode := FixedAssetLocRec."HSN/SAC Code";
//                             PackingText := FixedAssetLocRec."Description 2";
//                             IsItem := TRUE;
//                             CountryRegRec.Reset();
//                             /* if ShowVendorCOO then begin
//                                 if CountryRegRec.Get(FixedAssetLocRec."Vendor Country of Origin") then
//                                     Origitext := CountryRegRec.Name;
//                             end
//                             else begin
//                                 if CountryRegRec.Get(FixedAssetLocRec."Country/Region of Origin Code") then
//                                     Origitext := CountryRegRec.Name;
//                             end; */

//                             SearchDesc := FixedAssetLocRec."Search Description";

//                             if "Unit Price Base UOM" = 0 then begin
//                                 "Unit Price Base UOM" := "Direct Unit Cost";
//                                 "Base UOM" := "Unit of Measure Code";
//                                 "Quantity (Base)" := Quantity;
//                             end;
//                             AmountExclGST := Quantity * "Direct Unit Cost";
//                             CalculateLineGST("Purchase Header", "Purchase Line");
//                             GSTAmount := IGSTamount + CGSTamount + SGSTAmount;
//                             GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%';
//                             /* if GSTAmount > 0 then
//                                 GST := '18%'
//                             else
//                                 GST := '0%'; */
//                             AmountInclGst := GSTAmount + AmountExclGST;
//                         End;
//                     if "Purchase Line".Type = "Purchase Line".Type::"G/L Account" then
//                         If GlAccLocRec.GET("No.") THEN BEGIN
//                             //  SrNo += 1;
//                             HSNCode := GlAccLocRec."HSN/SAC Code";
//                             PackingText := GlAccLocRec.Name;
//                             IsItem := TRUE;
//                             CountryRegRec.Reset();
//                             /* if ShowVendorCOO then begin
//                                 if CountryRegRec.Get(GlAccLocRec."Vendor Country of Origin") then
//                                     Origitext := CountryRegRec.Name;
//                             end
//                             else begin
//                                 if CountryRegRec.Get(GlAccLocRec."Country/Region of Origin Code") then
//                                     Origitext := CountryRegRec.Name;
//                             end; */

//                             SearchDesc := GlAccLocRec."Search Name";

//                             if "Unit Price Base UOM" = 0 then begin
//                                 "Unit Price Base UOM" := "Direct Unit Cost";
//                                 "Base UOM" := "Unit of Measure Code";
//                                 "Quantity (Base)" := Quantity;
//                             end;
//                             AmountExclGST := Quantity * "Direct Unit Cost";
//                             CalculateLineGST("Purchase Header", "Purchase Line");
//                             GSTAmount := IGSTamount + CGSTamount + SGSTAmount;
//                             GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%';
//                             /* if GSTAmount > 0 then
//                                 GST := '18%'
//                             else
//                                 GST := '0%'; */
//                             AmountInclGst := GSTAmount + AmountExclGST;
//                         End;

//                     if "Purchase Line".Type = "Purchase Line".Type::"Charge (Item)" then
//                         If ItemChargeLocRec.GET("No.") THEN BEGIN
//                             // SrNo += 1;
//                             HSNCode := ItemChargeLocRec."HSN/SAC Code";
//                             PackingText := "Purchase Line"."Base UOM";
//                             IsItem := TRUE;
//                             CountryRegRec.Reset();
//                             /* if ShowVendorCOO then begin
//                                 if CountryRegRec.Get(GlAccLocRec."Vendor Country of Origin") then
//                                     Origitext := CountryRegRec.Name;
//                             end
//                             else begin
//                                 if CountryRegRec.Get(GlAccLocRec."Country/Region of Origin Code") then
//                                     Origitext := CountryRegRec.Name;
//                             end; */

//                             SearchDesc := ItemChargeLocRec."No.";

//                             if "Unit Price Base UOM" = 0 then begin
//                                 "Unit Price Base UOM" := "Direct Unit Cost";
//                                 "Base UOM" := "Unit of Measure Code";
//                                 "Quantity (Base)" := Quantity;
//                             end;
//                             AmountExclGST := Quantity * "Direct Unit Cost";
//                             CalculateLineGST("Purchase Header", "Purchase Line");
//                             GSTAmount := IGSTamount + CGSTamount + SGSTAmount;
//                             GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%';
//                             /* if GSTAmount > 0 then
//                                 GST := '18%'
//                             else
//                                 GST := '0%'; */
//                             AmountInclGst := GSTAmount + AmountExclGST;
//                         End;

//                     total := total + AmountInclGst;


//                     // chekReport.InitTextVariable();
//                     //  chekReport.FormatNoText(Notext, total, '');
//                     CheckReportNew.InitTextVariable();
//                     CheckReportNew.FormatNoText(Notext, round(total, 0.01), "Purchase Header"."Currency Code");
//                     // AMountInW := DelChr(Notext[1], '<>', '*') + Notext[2];
//                     // AMountInW := CopyStr(String1, 2, StrLen(String1));

//                     // AMountInW := CopyStr(Notext[1], 1, StrPos(Notext[1], '/100') - 1) + ' PAISA ONLY';
//                     AMountInW := Notext[1];

//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     SrNo := 0;
//                     Clear(IGST);
//                     Clear(GST);
//                     Clear(CGST);
//                     Clear(SGST);
//                     Clear(IGSTPct);
//                     Clear(CGSTPct);
//                     Clear(SGSTPct);
//                     Clear(GSTAmount);
//                     Clear(IGSTamount);
//                     Clear(CGSTamount);
//                     Clear(SGSTAmount);
//                     Clear(AmountExclGST);
//                     //  Clear(AmountInclGst);

//                 end;
//             }
//             dataitem(Hdrcomment;
//             "Purch. Comment Line")
//             {
//                 DataItemLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
//                 DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Line No." = CONST(0));

//                 column(DocumentLineNo_Hdrcomment;
//                 "Document Line No.")
//                 {
//                 }
//                 column(LineNo_Hdrcomment;
//                 "Line No.")
//                 {
//                 }
//                 column(Comment_Hdrcomment;
//                 Comment)
//                 {
//                 }
//             }
//             dataitem(LineCmt;
//             "Purch. Comment Line")
//             {
//                 DataItemLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
//                 DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Line No." = filter(<> 0));

//                 column(DocumentLineNo_LineCmt;
//                 "Document Line No.")
//                 {
//                 }
//                 column(LineNo_LineCmt;
//                 "Line No.")
//                 {
//                 }
//                 column(Comment_LineCmt;
//                 Comment)
//                 {
//                 }
//             }
//             trigger OnAfterGetRecord()
//             var
//                 FormatAddress_LCU: Codeunit "Format Address";
//                 PurchaseLine_LRec: Record "Purchase Line";
//                 PaymentTerms_LRec: Record "Payment Terms";
//                 //Check_LRep: Report Check;
//                 Check_LRep: Report "Reciept Voucher VML";
//                 TranSpec_rec: Record "Transaction Specification";
//                 Area_Rec: Record "Area";
//                 CountryL: Record "Country/Region";
//             begin

//                 Clear(VendAddr);
//                 // "Purchase Header".TestField(Status, Status::Released);
//                 // if (("Purchase Header".Status = "Purchase Header".Status::Open) OR ("Purchase Header".Status = "Purchase Header".Status::"Pending Approval")) then
//                 //    Error('Purchase order status should be released!');
//                 FormatAddress_LCU.PurchHeaderBuyFrom(VendAddr, "Purchase Header");
//                 PaymentTermsDesc := '';
//                 If PaymentTerms_LRec.GET("Payment Terms Code") then PaymentTermsDesc := PaymentTerms_LRec.Description;
//                 TranSec_Desc := '';
//                 IF TranSpec_rec.GET("Purchase Header"."Transaction Specification") then TranSec_Desc := TranSpec_rec.Text;
//                 IF Area_Rec.Get("Purchase Header"."Area") then TranSec_Desc := TranSec_Desc + ' ' + Area_Rec.Text;
//                 TotalAmt := 0;
//                 TotalVatAmtAED := 0;
//                 TotalAmountINR := 0;
//                 CurrencyFactor := 0;
//                 PurchaseLine_LRec.RESET;
//                 PurchaseLine_LRec.SetRange("Document Type", "Document Type");
//                 PurchaseLine_LRec.SetRange("Document No.", "No.");
//                 If PurchaseLine_LRec.FindSet(FALSE) then
//                     repeat
//                         TotalAmt += PurchaseLine_LRec."Amount Including VAT";
//                         TotalVatAmtAED += PurchaseLine_LRec."VAT Base Amount" * PurchaseLine_LRec."VAT %" / 100 UNTil PurchaseLine_LRec.Next = 0;
//                 TotalCaption := '';
//                 //TotalCaption := StrSubstNo('Total %1 Amount Payable Incl. GST:', "Currency Code");
//                 ExchangeRate := '';
//                 TotalAmountINR := TotalAmt;
//                 If "Currency Factor" <> 0 then begin
//                     TotalCaption := StrSubstNo('Total %1 Amount Payable', "Currency Code");
//                     ExchangeRate := StrSubstNo(' Currency exchange rate for INR calculation: %1 %2', "Currency Code", ROUND(1 / "Currency Factor", 0.00001, '='));
//                     TotalVatAmtAED := TotalVatAmtAED / "Currency Factor";
//                     TotalAmountINR := TotalAmt / "Currency Factor";
//                     CurrencyFactor := ROUND(1 / "Currency Factor", 0.00001, '=');
//                 End
//                 ELSe begin
//                     TotalCaption := 'Total INR Amount Payable';
//                     ExchangeRate := '';
//                 End;
//                 if "Currency Code" = '' then ExchangeRate := '';
//                 Clear(AmtinWord_GTxt);
//                 Clear(Check_LRep);
//                 Check_LRep.InitTextVariable;
//                 Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, "Currency Code");
//                 Clear(Check_LRep);
//                 SrNo := 0;
//                 //Message('%1 >> %2', "Document Type", "No.");
//                 BuyFrom_AddressG := "Buy-from Address";
//                 BuyFrom_Address2G := "Buy-from Address 2";
//                 BuyFrom_CityG := "Buy-from City";
//                 BuyFrom_PostCodeG := "Buy-from Post Code";
//                 if "Buy-from Country/Region Code" > '' then CountryL.Get("Buy-from Country/Region Code");
//                 BuyFrom_CountryRegionG := CountryL.Name;

//                 VendorRec.Reset();
//                 VendorRec.SetRange("No.", "Buy-from Vendor No.");
//                 if VendorRec.FindFirst() then;
//                 StateRec.Reset();
//                 StateRec.SetRange(Code, "Buy-from Country/Region Code");
//                 if StateRec.FindFirst() then
//                     CustomeSatedesc := StateRec.Description;

//                 ContryInfo.Get(CompanyInformation."Country/Region Code");



//             end;

//             trigger OnPreDataItem()
//             begin
//                 "Purchase Header".SetFilter("Document Type", 'Order|Blanket Order');

//             end;
//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 field(ShowVendorCOO; ShowVendorCOO)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Show Vendor COO';
//                 }
//             }

//         }
//         actions
//         {
//         }
//     }
//     labels
//     {
//         PurchaseOrder_Lbl = 'Purchase Order Preview';
//         PORef_Lbl = 'P.O. Ref.:';
//         Date_Lbl = 'Date :';
//         Supplier_Lbl = 'Supplier';
//         SupplierRef_Lbl = 'Supplier Ref.';
//         PaymentTerms_Lbl = 'Payment Terms';
//         DeliveryTerms_Lbl = 'Delivery Terms';
//         No_Lbl = 'No.';
//         Desc_Lbl = 'Description';
//         Qty_Lbl = 'Quantity';
//         UOM_Lbl = 'UOM';
//         UnitPrice_Lbl = 'Unite Price';
//         AmtIncGST_Lbl = 'Amount Incl. GST';
//         DeliverySchedule_Lbl = 'Delivery Schedule:';
//         OtherTerms_Lbl = 'Documents Required';
//         OtherTerms1_Lbl = '1)   Commercial Invoice and Packing list duly signed and stamped by supplier - 2 original and 1 copy ';
//         OtherTerms2_Lbl = '2)   Original Bill of Lading/Airway Bill - 3 original and 3 copy';
//         OtherTerms3_Lbl = '3)   Certificate of Origin - 3 original and 3 copy (not required in case of local purchase)';
//         OtherTerms4_Lbl = '4)   Batch-Wise loading details of each container';
//         OtherTerms5_Lbl = '5)   Certificate of Analysis for all batches ';
//         OtherTerms6_Lbl = '6)   Waybill required in case of local purchase';
//         OtherTerms7_Lbl = '7)   If material booked in any transport then please provide LR copy';
//         OtherTerms8_Lbl = '8)   Photos of loading to be provided';
//         OtherTerms_Lbl1 = 'In the case of Local purchase following document required for our records';
//         OtherTerms1_Lbl1 = '1)  Commercial Invoice and Packing list in 2 originals and 1 copy duly signed and stamped by supplier';
//         OtherTerms2_Lbl1 = '2)  Waybill ';
//         OtherTerms3_Lbl1 = '3)  Certificate of Analysis for all batches';
//         OtherTerms4_Lbl1 = '4)  Technical Specification of all material';
//         OtherTerms5_Lbl1 = '5)  If material booked in any transport then please provide LR copy ';
//         OtherTerms6_Lbl1 = '6)  Technical Specification of all material';

//         Remarks_Lbl = 'Remarks:';
//         Origin_Lbl = 'Origin: ';
//         HSCode_Lbl = 'HS Code: ';
//         Packing_Lbl = 'Packing: ';
//         VATAmountinAED_Lbl = 'Total GST Amount (INR):';
//         GSTAmt_Lbl = 'GST Amount';
//         Remark_1_LBL = '* In all related documents and correspondences, please quote our Purchase Order number for easy tracking';
//         Remark_2_LBL = '* It is compulsory to share product COA before loading the material';
//         Remark_3_LBL = '* Acknowledge the receipt of our Purchase Order and provide your acceptance';
//         Remark_5_LBL = '* We reserve quality inspection rights of certain batches by third party at our own cost';
//         Remark_6_LBL = '* Requested to ship only those batches which complies with the define standard and approved by our technical team';
//         Remark_4_LBL = '* Please inform us in advance if there is any deviation from the specified ETD';

//     }
//     trigger OnPreReport()
//     begin
//         CompanyInformation.Get;
//         CompanyInformation.CalcFields(Picture);
//     end;

//     local procedure CalculateLineGST(recPurchHdr: Record "Purchase Header"; recPurchLine: Record "Purchase Line")
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

//         GetLineGSTAmount(recPurchLine, ConfigID, intIGST, intCGST, intSGST);

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

//     local procedure GetLineGSTAmount(gPurchLine: Record "Purchase Line"; FilterID: Text; IGSTID: Integer; CGSTID: Integer; SGSTID: Integer)
//     var
//         lPurchaseLine: Record "Purchase Line";
//         TaxTransactionValue: Record "Tax Transaction Value";
//         GSTSetup: Record "GST Setup";
//         decTotTaxAmt: Decimal;
//     begin
//         lPurchaseLine.Get(gPurchLine."Document Type", gPurchLine."Document No.", gPurchLine."Line No.");
//         decTotTaxAmt := 0;
//         if not GSTSetup.Get() then
//             exit;

//         TaxTransactionValue.SetRange("Tax Record ID", lPurchaseLine.RecordId);
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

//     var
//         ContryInfo: Record "Country/Region";
//         AmountInWord: Text[200];
//         total: Decimal;
//         string1: Text[250];


//         chekReport: Report Check;
//         chekReport1: Report Check;
//         //CheckReportNew: report Check;
//         CheckReportNew: Report "Reciept Voucher VML";
//         Notext: array[2] of Text[100];
//         AMountInW: text[200];
//         CompanyInformation: Record "Company Information";
//         Vendor: Record Vendor;
//         VendorRec: Record Vendor;
//         VendAddr: array[8] of Text[90];
//         SrNo: Integer;
//         TotalAmt: Decimal;
//         TotalVatAmtAED: Decimal;
//         CurrencyFactor: Decimal;
//         TotalCaption: Text[120];
//         AmtinWord_GTxt: array[2] of Text[80];
//         PaymentTermsDesc: Text;
//         SearchDesc: Text[250];
//         Origitext: Text[50];
//         HSNCode: Text[50];
//         StateRec: Record State;
//         CustomeSatedesc: Text[50];
//         PackingText: Text[50];
//         IsItem: Boolean;
//         IsComment: Boolean;
//         ExchangeRate: Text;
//         TotalAmountINR: Decimal;
//         TranSec_Desc: Text[100];
//         BuyFrom_AddressG: Text;
//         BuyFrom_Address2G: Text;
//         BuyFrom_CityG: Text;
//         BuyFrom_PostCodeG: Text;
//         BuyFrom_CountryRegionG: Text;
//         ShowVendorCOO: Boolean;
//         VendorCountryofOrigin: Text[100];
//         GST: text[50];
//         IGST: Text;
//         SGST: Text;
//         CGST: Text;

//         IGSTPct: Decimal;
//         CGSTPct: Decimal;
//         SGSTPct: Decimal;
//         AmountInclGst: Decimal;
//         AmountExclGST: Decimal;
//         GSTAmount: Decimal;
//         IGSTamount: Decimal;
//         SGSTAmount: Decimal;
//         CGSTamount: Decimal;


// }
