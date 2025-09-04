// report 58164 "KM UN Format"//T12370-Full Comment
// {
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     Caption = 'UN Proforma Invoice';
//     DefaultLayout = RDLC;
//     RDLCLayout = 'Reports/UN Format.rdl';

//     dataset
//     {
//         dataitem("Sales Header"; "Sales Header")
//         {
//             column(Comp_Info_Name; Comp_Info.Name) { }
//             column(Comp_Info_Pic; Comp_Info.Picture) { }
//             column(Comp_Info_Add; Comp_Info.Address) { }
//             column(Comp_Info_City; Comp_Info.City) { }
//             column(Comp_Info_Country; Comp_Info_Country) { }//Comp_Info."Country/Region Code") { }
//             column(Comp_Info_PhoneNo; Comp_Info."Phone No.") { }
//             column(Comp_Info_FaxNo; Comp_Info."Fax No.") { }
//             column(SaleHeader_DocumnetType; "Document Type") { }
//             column(SaleHeader_No; "No.") { }
//             column(SaleHeader_Customer_No; "Sell-to Customer No.") { }
//             column(SaleHeader_Customer_Name; "Sell-to Customer Name") { }
//             column(SaleHeader_Add1; "Sell-to Address") { }
//             column(SaleHeader_Add2; "Sell-to Address 2") { }
//             column(SaleHeader_PostCode; "Sell-to Post Code") { }
//             column(Customer_Registration_Type; "Customer Registration Type") { }
//             column(Customer_Registration_No_; "Customer Registration No.") { }
//             column(SaleHeader_City; "Sell-to City") { }
//             // column(SaleHeader_Commercial_Card_No; "Commercial Card No") { }
//             column(SaleHeader_Country; SaleHeader_Country) { }//GK
//             column(SaleHeader_Phone; "Sell-to Phone No.") { }
//             column(SaleHeader_Fax; CustomerRec."Fax No.") { }
//             column(SaleHeader_Portoflanding; EntryExitPoint.Description) { }
//             column(SalesHeader_ShippingAdvice; "Shipping Advice") { }
//             column(PaymentTerm_Desc; PaymentTermRec.Description) { }
//             column(SaleHeader_DocumentDate; "Document Date") { }
//             column(SaleHeader_DueDate; "Due Date") { }
//             // column(SaleHeader_CommercialCardNo;CustomerRec. { }
//             column(SaleHeader_PortofDelivery; AreaRec.Text) { }
//             column(SaleHeader_Sellerref; "External Document No.") { }
//             column(SaleHeader_TransportMehod; "Transport Method") { }
//             column(SaleHeader_TransactionCurrency; SaleHeader_TransactionCurrency) { }
//             column(BankName; BankAccountRec.Name) { }
//             column(SwiftCode; BankAccountRec."SWIFT Code") { }
//             column(BankAccountNo; BankAccountRec."Bank Account No.") { }
//             column(IBANCode; BankAccountRec.IBAN) { }
//             column(BankIdentifier; '') { }
//             column(reportCap; reportCap) { }
//             column(Comp_Tag_Cap; Comp_Tag_Cap) { }
//             column(PI_No_cap; PI_No_cap) { }
//             column(Posting_Date; "Posting Date") { }
//             column(PI_Date_Cap; PI_Date_Cap) { }
//             column(PI_Validity_Cap; PI_Validity_Cap) { }
//             column(Commercial_Cap; Commercial_Cap) { }
//             column(CountryofBeneficiary_Cap; CountryofBeneficiary_Cap) { }
//             column(PortofDeliveryCountry_Cap; PortofDeliveryCountry_Cap) { }
//             column(SubTotal_Cap; SubTotal_Cap) { }
//             column(Freight_Cap; Freight_Cap) { }
//             column(Discount_Cap; Discount_Cap) { }
//             column(Tel_Cap; Tel_Cap) { }
//             column(Fax_Cap; Fax_Cap) { }
//             column(VAT_Cap; VAT_Cap) { }
//             column(TotalAmountPayable_Cap; TotalAmountPayable_Cap) { }
//             column(TotalAmountinWord_cap; TotalAmountinWord_cap) { }
//             column(BankDetails_Cap; BankDetails_Cap) { }
//             column(BeneficiaryName_Cap; BeneficiaryName_Cap) { }
//             column(BankName_Cap; BankName_Cap) { }
//             column(SWIFT_Cap; SWIFT_Cap) { }
//             column(AccountNo_Cap; AccountNo_Cap) { }
//             column(IBAN_Cap; IBAN_Cap) { }
//             column(BankIdentifier_Cap; BankIdentifier_Cap) { }
//             column(DateOfIssue_Cap; DateOfIssue_Cap) { }
//             column(Remark_Cap; Remark_Cap) { }
//             column(Seal_Sign_Cap; Seal_Sign_Cap) { }
//             column(TransportMode_cap; TransportMode_cap) { }
//             column(TransactionCurrency_Cap; TransactionCurrency_Cap) { }
//             column(Cust_tag_Cap; Cust_tag_Cap) { }
//             column(Country_Tag_Cap; Country_Tag_Cap) { }
//             column(Partial_Cap; Partial_Cap) { }
//             column(PaymentTerm_Cap; PaymentTerm_Cap) { }
//             column(Order_Date; "Order Date") { }
//             dataitem("Sales Order Remarks"; "Sales Order Remarks")
//             {
//                 DataItemTableView = SORTING("Document Type", "Document No.", "Document Line No.", "Line No.") where("Line No." = filter(<> 0));
//                 DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
//                 column(Remarks_Document_No; "Document No.") { }
//                 column(Remarks_Document_Line_No; "Document Line No.") { }
//                 column(Remark_Line_No; "Line No.") { }
//                 column(Comments; Comments) { }
//                 column(SN3; SN3) { }
//                 trigger OnAfterGetRecord()
//                 var
//                 begin
//                     if "Sales Order Remarks"."Line No." = 0 then
//                         CurrReport.Skip();
//                     SN3 += 1;
//                 end;
//             }
//             dataitem("Sales Line"; "Sales Line")
//             {
//                 DataItemTableView = sorting("Document No.", "Line No.");
//                 DataItemLink = "Document No." = field("No.");
//                 column(Document_No_; "Document No.") { }
//                 column(Sales_Line_Line_No; "Line No.") { }
//                 column(Type; Type) { }
//                 column(Item_No; "No.") { }
//                 column(SN; SN) { }
//                 column(Description; Description) { }
//                 column(ItemRec_GenericName; ItemRec."Generic Description") { }
//                 column(ItemRec_PackingDesc; ItemRec."Description 2") { }
//                 column(ItemHSNCode; HSCode) { }
//                 column(packing; packing) { DecimalPlaces = 0; }
//                 column(UOMCap; UOMCap) { }
//                 column(Origin; OriginCode) { }
//                 column(Base_UOM; "Base UOM 2") { }
//                 column(Quantity__Base_; "Quantity (Base)") { }
//                 column(Line_Amount; "Line Amount") { }
//                 column(Amount_Including_VAT; "Amount Including VAT") { }
//                 column(Unit_of_Measure; "Unit of Measure") { }
//                 column(Unit_Price; "Sales Line"."Unit Price") { }
//                 column(NetWeight; NetWeight) { }
//                 column(GrossWeight; GrossWeight) { }
//                 column(TotalNetWeight; TotalNetWeight) { }
//                 column(TotalGrossWeight; TotalGrossWeight) { }
//                 column(Line_Discount_Amount; "Line Discount Amount") { }
//                 column(VATAmountTotal; VATAmountTotal) { }
//                 column(TotalAmount; TotalAmount) { }
//                 column(SubTotalAmount; SubTotalAmount) { }
//                 column(AmountInWords; AmountInWords) { }

//                 trigger OnPreDataItem()
//                 begin
//                 end;

//                 trigger OnAfterGetRecord()
//                 var
//                     ItemUnitOfMeasyreRec: Record "Item Unit of Measure";
//                     QPUM: Decimal;
//                 begin
//                     Clear(NetWeight);
//                     Clear(PackingWeight);
//                     Clear(GrossWeight);
//                     Clear(Packing);
//                     clear(HSCode);
//                     Clear(OriginCode);
//                     if "Sales Line".Type = "Sales Line".Type::Item then begin
//                         ItemRec.Get("Sales Line"."No.");
//                         if CustomerInvoice = true then begin
//                             HSCode := "Sales Line".LineHSNCode;
//                             OriginCode := "Sales Line".LineCountryOfOrigin
//                         end
//                         else begin
//                             OriginCode := ItemRec."Country/Region of Origin Code";
//                             HSCode := ItemRec."Tariff No.";
//                         end;
//                         // KMP_TblGenericName.Get(ItemRec.GenericName);
//                         NetWeight := "Sales Line"."Net Weight"; //"Sales Line".Quantity * ItemUnitOfMeasure."Qty. per Unit of Measure";
//                         GrossWeight := "Sales Line"."Gross Weight";
//                         TotalGrossWeight += "Gross Weight";
//                         TotalNetWeight += "Net Weight";
//                         SN2 += 1;
//                         SN := SN2;
//                         VATAmountTotal += "Amount Including VAT" - "Line Amount";
//                         SubTotalAmount += "Line Amount";
//                         ItemUnitOfMeasure.Reset();
//                         if ItemUnitOfMeasure.Get(ItemRec."No.", ItemRec."Sales Unit of Measure") then Begin
//                             QPUM := ItemUnitOfMeasure."Qty. per Unit of Measure";
//                             ItemUnitOfMeasyreRec.Reset();
//                             ItemUnitOfMeasyreRec.SetRange("Item No.", ItemRec."No.");
//                             if ItemUnitOfMeasyreRec.FindSet() then
//                                 repeat
//                                     if QPUM > ItemUnitOfMeasyreRec."Qty. per Unit of Measure" then begin
//                                         Clear(QPUM);
//                                         Clear(Packing);
//                                         Clear(UOMCap);
//                                         QPUM := ItemUnitOfMeasyreRec."Qty. per Unit of Measure";
//                                         Packing := Abs("Sales Line"."Quantity (Base)" / ItemUnitOfMeasyreRec."Qty. per Unit of Measure");
//                                         UOMCap := ItemUnitOfMeasyreRec.Code;
//                                     end;
//                                 until ItemUnitOfMeasyreRec.Next() = 0;
//                         End;
//                     end else
//                         if "Sales Line".Type <> "Sales Line".Type::Item then begin
//                             SN := 0;
//                         end;
//                     TotalAmount += "Amount Including VAT";
//                     TotalAmount := Round(TotalAmount, 0.01);
//                     RepCheck.InitTextVariable();
//                     RepCheck.FormatNoText(NoText, TotalAmount, SaleHeader_TransactionCurrency);
//                     AmountInWords := NoText[1];
//                 end;

//                 trigger OnPostDataItem()
//                 begin

//                 end;
//             }
//             trigger OnPreDataItem()
//             begin
//                 VATAmountTotal := 0;
//                 TotalAmount := 0;
//                 AmountInWords := '';
//                 SN2 := 0;
//                 SN := 0;
//                 SN3 := 5;
//             end;

//             trigger OnAfterGetRecord()
//             Var
//                 GeneralLedgerSetup: Record "General Ledger Setup";
//             begin
//                 GeneralLedgerSetup.Get();
//                 if CustomerRec.Get("Sell-to Customer No.") then;
//                 if PaymentTermRec.Get("Payment Terms Code") then;
//                 if BankAccountRec.Get("Bank on Invoice 2") then; //PackingListExtChange
//                 if EntryExitPoint.Get("Exit Point") then;
//                 if AreaRec.Get("Sales Header"."Area") then;
//                 CountryRegion.Reset();
//                 if CountryRegion.Get("Sales Header"."Sell-to Country/Region Code") then
//                     SaleHeader_Country := CountryRegion."County Name";
//                 SaleHeader_TransactionCurrency := '';
//                 if "Sales Header"."Currency Code" = '' then
//                     SaleHeader_TransactionCurrency := GeneralLedgerSetup."LCY Code"
//                 else
//                     SaleHeader_TransactionCurrency := "Sales Header"."Currency Code";
//             end;

//             trigger OnPostDataItem()
//             begin
//             end;
//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group("Proforma Invoice")
//                 {
//                 }
//             }
//         }
//         actions
//         {
//             area(processing)
//             {
//                 action(ActionName)
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }
//     var
//         Comp_Info: Record "Company Information";
//         CustomerRec: Record Customer;
//         SaleHeader_TransactionCurrency: Code[20];
//         PaymentTermRec: Record "Payment Terms";
//         BankAccountRec: Record "Bank Account";
//         CountryRegion: Record "Country/Region";
//         CustomerInvoice: Boolean;
//         HSCode: Code[20];
//         OriginCode: code[20];
//         ItemRec: Record Item;
//         AreaRec: Record "Area";
//         ItemUnitOfMeasure: Record "Item Unit of Measure";
//         EntryExitPoint: Record "Entry/Exit Point";
//         RepCheck: Report Check;
//         NoText: array[2] of Text[250];
//         Comp_Info_Country: Text[80];
//         SaleHeader_Country: Text[80];
//         AmountInWords: Text[250];
//         SubTotalAmount: Decimal;
//         VATAmountTotal: Decimal;
//         NetWeight: Decimal;
//         GrossWeight: Decimal;
//         TotalNetWeight: Decimal;
//         TotalGrossWeight: Decimal;
//         Packing: Decimal;
//         PackingWeight: Decimal;
//         SN: Integer;
//         SN2: Integer;
//         SN3: Integer;
//         TotalAmount: Decimal;
//         ReportCap: Label 'Proforma Invoice';
//         Comp_Tag_Cap: Label 'Seller/Consignor/Exporter';
//         PI_No_cap: Label 'P/I No:';
//         PI_Date_Cap: Label 'P/I Date:';
//         PI_Validity_Cap: Label 'P/I Validity:';
//         Commercial_Cap: Label 'Commercial Card No:';
//         CountryofBeneficiary_Cap: Label 'Country of Beneficiary';
//         PortofDeliveryCountry_Cap: Label 'Terms and Port of Delivery / Country';
//         UOMCap: Code[10];
//         // SellerReference_Caap : Label 'Seller's Reference';
//         SubTotal_Cap: Label 'Sub Total:';
//         Freight_Cap: Label 'Freight:';
//         Discount_Cap: Label 'Discount:';
//         Tel_Cap: Label 'Tel:';
//         Fax_Cap: Label 'Fax:';
//         VAT_Cap: Label 'VAT:';
//         TotalAmountPayable_Cap: Label 'Total Amount Payable:';
//         TotalAmountinWord_cap: Label 'Total Amount in Word:';
//         BankDetails_Cap: Label 'Bank Details';
//         BeneficiaryName_Cap: Label 'Beneficiary Name:';
//         BankName_Cap: Label 'Bank Name:';
//         SWIFT_Cap: Label 'SWIFT Code:';
//         AccountNo_Cap: Label 'Account No:';
//         IBAN_Cap: Label 'IBAN No:';
//         BankIdentifier_Cap: Label 'Bank Identifier Code:';
//         DateOfIssue_Cap: Label 'Date of Issue';
//         Remark_Cap: Label 'Remark';
//         Seal_Sign_Cap: Label 'Seal & Signature';
//         TransportMode_cap: Label 'Transport Mode';
//         TransactionCurrency_Cap: Label 'Transaction Currency';
//         Cust_tag_Cap: Label 'Buyer / Consignee:';
//         Country_Tag_Cap: Label 'Country / Port of Loading';
//         Partial_Cap: Label 'Partial Shipment';
//         PaymentTerm_Cap: Label 'Payment Term';
//         Char10: Char;
//         Char13: Char;
//         Test: Text[20];

//     trigger OnInitReport()
//     begin
//     end;

//     trigger OnPreReport()
//     begin
//         Comp_Info.Get();
//         Comp_Info.CalcFields(Picture);
//         SN := 0;
//         CountryRegion.Reset();
//         if CountryRegion.Get(Comp_Info."Country/Region Code") then
//             Comp_Info_Country := CountryRegion."County Name";
//     end;

//     trigger OnPostReport()
//     begin
//     end;
// }