// report 70108 TransferOfOwnership//T12370-Full Comment
// {
//     Caption = 'Transfer Of Ownership Certificate';
//     DefaultLayout = RDLC;
//     RDLCLayout = './layouts/B Transfer of Ownership 70108.rdl';

//     dataset
//     {
//         dataitem("Sales Invoice Header"; "Sales Invoice Header")
//         {
//             column(Posting_Date; "Posting Date") { }
//             column(Bill_to_Name; "Bill-to Name") { }
//             column(InvoiceNo; "No.") { }
//             column(Bill_to_Address; "Bill-to Address") { }
//             column(Bill_to_Address_2; "Bill-to Address 2") { }
//             column(Bill_to_City; "Bill-to City") { }
//             column(Bill_to_County; "Bill-to County") { }

//             column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
//             column(Sell_to_Address; "Sell-to Address") { }
//             column(Sell_to_Address_2; "Sell-to Address 2") { }
//             column(Sell_to_City; "Sell-to City") { }
//             column(Sell_to_County; "Sell-to County") { }

//             column(Ship_to_Name; "Ship-to Name") { }
//             column(Ship_to_Address; "Ship-to Address") { }
//             column(Ship_to_Address_2; "Ship-to Address 2") { }
//             column(Ship_to_City; "Ship-to City") { }
//             column(Ship_to_County; "Ship-to County") { }


//             column(CompanyName; Companyinformation.Name) { }
//             column(CompanyAddress1; Companyinformation.Address) { }
//             column(CompanyAddress2; Companyinformation."Address 2") { }

//             column(CompanyCity; Companyinformation.City) { }
//             column(CompanyCountry; CountryregionCode.name) { }
//             column(CompanyLogo; Companyinformation.Picture) { }

//             column(CompanyPhoneNo; Companyinformation."Phone No.") { }

//             column(CompanyTRN; Companyinformation."VAT Registration No.") { }

//             column(HeaderStmtText; HeaderStmtText) { }
//             column(TransfererCompanyNameSignText; TransfererCompanyNameSignText) { }
//             column(FooterStmtText; FooterStmtText) { }
//             column(TransfereeCompanyNameSignText; TransfereeCompanyNameSignText) { }

//             dataitem("Sales Invoice Line"; "Sales Invoice Line")
//             {
//                 DataItemLink = "Document No." = field("No.");

//                 column(No_; "No.") { }
//                 column(Description; Description) { }
//                 column(Description_2; "Description 2") { }
//                 column(CountryOfOrigin; CountryOfOrigin) { }
//                 column(HSNCode; HSNCode) { }
//                 column(Net_Weight; "Net Weight") { }
//                 column(Gross_Weight; "Gross Weight") { }
//                 column(Packing; Packing) { }
//                 column(Item_Generic_Name; "Item Generic Name") { }
//                 column(SN1; SN1) { }

//                 trigger OnAfterGetRecord()
//                 var
//                     myInt: Integer;
//                     item: Record item;
//                     ItemUOM: Record "Item Unit of Measure";
//                     UOM: Record "Unit of Measure";
//                     LowestQty: Decimal;
//                     StringProper: Codeunit "String Proper";
//                     SalesInvoiceLine2: Record "Sales Invoice Line";
//                 begin
//                     Clear(Packing);
//                     Clear(LowestQty);

//                     SalesInvoiceLine2.Reset();
//                     SalesInvoiceLine2.SetRange("Document No.", "Document No.");
//                     SalesInvoiceLine2.SetRange(Type, Type::Item);
//                     SalesInvoiceLine2.SetFilter("Line No.", '<%1', "Line No.");
//                     SalesInvoiceLine2.SetRange("No.", "No.");
//                     SalesInvoiceLine2.SetRange("Unit of Measure Code", "Unit of Measure Code");
//                     SalesInvoiceLine2.SetRange("Unit Price", "Unit Price");

//                     if SalesInvoiceLine2.FindFirst() then
//                         CurrReport.Skip();
//                     SalesInvoiceLine2.Reset();
//                     SalesInvoiceLine2.SetRange("Document No.", "Document No.");
//                     SalesInvoiceLine2.SetFilter("Line No.", '>%1', "Line No.");
//                     SalesInvoiceLine2.SetRange("No.", "No.");
//                     if SalesInvoiceLine2.FindSet() then begin

//                         repeat
//                             if ("Unit Price" = SalesInvoiceLine2."Unit Price") and ("Unit of Measure Code" = SalesInvoiceLine2."Unit of Measure Code") then begin
//                                 "Quantity (Base)" += SalesInvoiceLine2."Quantity (Base)";
//                                 "Net Weight" += SalesInvoiceLine2."Net Weight";
//                                 "Gross Weight" += SalesInvoiceLine2."Gross Weight";
//                             end;
//                         until SalesInvoiceLine2.Next() = 0;
//                     end;


//                     if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then begin
//                         SN1 += 1;
//                         item.Get("Sales Invoice Line"."No.");
//                         ItemUOM.Reset();
//                         ItemUOM.SetRange("Item No.", "Sales Invoice Line"."No.");
//                         ItemUOM.SetFilter(Code, '<>%1', item."Base Unit of Measure");
//                         ItemUOM.Ascending(true);
//                         if itemuom.FindFirst() then begin
//                             UOM.Get(ItemUOM.Code);
//                             if uom."Decimal Allowed" then begin

//                                 LowestQty := ROUND("Sales Invoice Line"."Quantity (Base)" / ItemUOM."Qty. per Unit of Measure", 0.01, '=');
//                                 packing := Format(LowestQty) + ' ' + ItemUOM.Code;

//                             end else begin
//                                 LowestQty := ROUND("Sales Invoice Line"."Quantity (Base)" / ItemUOM."Qty. per Unit of Measure", 1, '>');
//                                 packing := Format(LowestQty) + ' ' + uom.Description;
//                             end;
//                         end else begin
//                             // Packing := Format("Sales Invoice Line"."Quantity (Base)") + ' ' + StringProper.ConvertString(ItemUOM.Code);
//                             Packing := Format("Sales Invoice Line"."Quantity (Base)") + ' ' + "Sales Invoice Line"."Base UOM 2";
//                         end;
//                     end else
//                         CurrReport.Skip();

//                 end;

//             }
//             trigger OnAfterGetRecord()
//             var
//                 CompanyAddressString: Text;
//                 CustomerAddressString: Text;
//                 CustomerCountryRegionCode: Record "Country/Region";
//             // ShipCustomerCountryRegionCode: Record "Country/Region";
//             begin
//                 Companyinformation.get();
//                 Companyinformation.CalcFields(Picture);
//                 CountryregionCode.Get(Companyinformation."Country/Region Code");
//                 CustomerCountryRegionCode.Get("Bill-to Country/Region Code");
//                 // ShipCustomerCountryRegionCode.Get("Ship-to Country/Region Code");

//                 CompanyAddressString := Companyinformation.Address + ', ' + Companyinformation."Address 2" + ', ' + Companyinformation.City + ', ' + CountryregionCode.Name;
//                 CustomerAddressString := "Bill-to Address" + ', ' + "Bill-to Address 2" + ', ' + "Bill-to City" + ', ' + CustomerCountryRegionCode.Name;
//                 // CustomerAddressString := "Ship-to Address" + ', ' + "Ship-to Address 2" + ', ' + "Ship-to City" + ', ' + ShipCustomerCountryRegionCode.Name;
//                 if CompanyAddressString.Contains(', ,') then CompanyAddressString := CompanyAddressString.Replace(', ,', ',');
//                 if CustomerAddressString.Contains(', ,') then CustomerAddressString := CustomerAddressString.Replace(', ,', ',');
//                 HeaderStmtText := StrSubstNo(HeaderStmtLbl, Companyinformation.Name, CompanyAddressString, "Bill-to Name", CustomerAddressString);
//                 TransfererCompanyNameSignText := StrSubstNo(TransfererCompanyNameSignLbl, Companyinformation.Name);
//                 FooterStmtText := StrSubstNo(FooterStmtLbl, "Bill-to Name", CustomerAddressString);
//                 TransfereeCompanyNameSignText := StrSubstNo(TransfereeCompanyNameSignLbl, "Bill-to Name");


//             end;
//         }

//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {

//                 }
//             }
//         }


//     }
//     labels
//     {
//         DateLbl = 'Date: ';
//         InvoiceNoLbl = 'Invoice No.: ';
//         // HeaderStmtLbl = 'Please note that we, %1, have on this day transferred the ownership of the below mentioned goods to %2 .';
//         ProductNameLbl = 'Product Name: ';
//         DescriptionLbl = 'Description: ';
//         CountryofOriginLbl = 'Origin: ';
//         HSCodeLbl = 'HS Code: ';
//         NetWeightLbl = 'Net Weight: ';
//         GrossWeightLbl = 'Gross Weight: ';
//         PackingLbl = 'Packing: ';
//         PageNoLbl = 'Page ';
//         CompTelNoLbl = 'Tel No.: ';
//         CompTRNNoLbl = 'TRN: ';
//         //TransfererCompanyNameSignLbl = '%1 Authorized Signatory';
//         //FooterStmtLbl = 'We, %1, hereby certify that as of this date we are the owner of the above-mentioned goods and we undertake to pay, when called upon to do so, all port storage and other charges that are and accruing thereon.';
//         //TransfereeCompanyNameSignLbl = '%1 Authorized Signatory';


//     }

//     var
//         Packing: Text;
//         Companyinformation: Record "Company Information";
//         CountryregionCode: Record "Country/Region";
//         HeaderStmtText: Text;
//         TransfererCompanyNameSignText: Text;
//         FooterStmtText: Text;
//         TransfereeCompanyNameSignText: Text;
//         HeaderStmtLbl: TextConst ENU = 'Please note that we, %1, %2 have on this day transferred the ownership of the below mentioned goods to %3, %4.';
//         TransfererCompanyNameSignLbl: TextConst ENU = '%1 Authorized Signatory';
//         FooterStmtLbl: TextConst ENU = 'We, %1, %2 hereby certify that as of this date we are the owner of the above-mentioned goods and we undertake to pay, when called upon to do so, all port storage and other charges that are and accruing thereon.';
//         TransfereeCompanyNameSignLbl: TextConst ENU = '%1 Authorized Signatory';
//         SN1: Integer;

//         Packing_txt: Text;


// }