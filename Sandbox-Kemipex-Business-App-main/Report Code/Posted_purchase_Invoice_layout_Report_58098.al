// report 58098 purchaseinvoice_layout//T12370-Full Comment
// {
//     UsageCategory = Administration;
//     //  ApplicationArea = all;
//     RDLCLayout = 'Reports/Posted_purchase_invoice.rdl';
//     Caption = 'Posted Purchase Invoice';
//     DefaultLayout = RDLC;
//     dataset
//     {
//         dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
//         {

//             RequestFilterFields = "No.";

//             column(ReportHeader; ReportHeader) { }
//             column(Company_Name; company.Name) { }
//             column(GST; company."Enable GST Caption") { }
//             column(company_Address; company.Address) { }
//             column(company_address2; company."Address 2") { }
//             column(company_city; company.City) { }
//             column(company_country; CompanyCountry.Name) { }
//             column(company_telno; company."Phone No.") { }
//             column(companyTRN; company."VAT Registration No.") { }
//             column(company_logo; company.Picture) { }
//             column(company_email; company."E-Mail") { }
//             column(company_website; company."Home Page") { }
//             column(Pay_to_Name; "Pay-to Name") { }
//             column(Pay_to_Address; "Pay-to Address") { }
//             column(Pay_to_Address_2; "Pay-to Address 2") { }
//             column(Pay_to_City; "Pay-to City") { }
//             column(Pay_to_Country_Region_Code; vendorcountry.Name) { }
//             column(Pay_to_Vendor_No_; "Pay-to Vendor No.") { }
//             column(No_; "No.") { }
//             column(Posting_Date; "Posting Date") { }
//             column(Document_Date; "Document Date") { }
//             column(Due_Date; "Due Date") { }
//             column(Payment_Terms_Code; paymentterm.Description) { }
//             column(Payment_Method_Code; paymentmethod.Description) { }
//             column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
//             column(Currency_Code; "Currency Code") { }
//             column(Posting_Description; "Posting Description") { }
//             column(User_ID; "User ID") { }
//             column(Amount_Including_VT; "Amount Including VAT") { }
//             column(VAT_Registration_No_; "VAT Registration No.") { }
//             dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
//             {
//                 DataItemLink = "Document No." = field("No.");
//                 //  DataItemTableView = where("Type" = filter(Item));
//                 column(Line; "No.") { }
//                 column(Description; Description) { }
//                 column(Unit_of_Measure_Code; "Base UOM") { }
//                 column(Quantity; "Quantity (Base)") { DecimalPlaces = 0 : 3; }
//                 column(Direct_Unit_Cost; "Unit Price Base UOM") { }
//                 column(Amount; Amount) { }
//                 column(VAT__; "VAT %") { }
//                 column(Amount_Including_VAT; "Amount Including VAT") { }
//                 column(VAT_Calculation_Type; "VAT Calculation Type") { }
//                 column(line_vat_amount; line_vat_amount) { }
//                 trigger OnAfterGetRecord()
//                 var
//                     myInt: Integer;
//                 begin
//                     SetFilter(Type, '<>%1', Type::" ");
//                     Clear(line_vat_amount);
//                     line_vat_amount := Amount / 100 * "VAT %";
//                     if "Unit Price Base UOM" = 0 then begin
//                         "Unit Price Base UOM" := "Direct Unit Cost";
//                         "Base UOM" := "Unit of Measure Code";
//                         "Quantity (Base)" := Quantity;
//                     end;
//                 end;
//             }
//             trigger OnAfterGetRecord()
//             var
//                 myInt: Integer;
//                 GLS: Record "General Ledger Setup";
//             begin
//                 Clear(header_vat_amount);
//                 gls.Get();
//                 if "Currency Code" = '' then "Currency Code" := gls."LCY Code";
//                 if vendorcountry.Get("Purch. Inv. Header"."Pay-to Country/Region Code") then;
//                 if paymentterm.Get("Purch. Inv. Header"."Payment Terms Code") then;
//                 if paymentmethod.Get("Purch. Inv. Header"."Payment Method Code") then;

//                 if "Purch. Inv. Header"."Prepayment Invoice" then ReportHeader := 'Prepayment Invoice' else ReportHeader := 'Posted Purchase Invoice';
//             end;

//             trigger OnPreDataItem()
//             var
//                 myInt: Integer;
//             begin
//                 company.get();
//                 company.CalcFields(Picture);
//                 CompanyCountry.Get(company."Country/Region Code");
//             end;
//         }

//     }

//     labels
//     {

//     }
//     var
//         company: Record "Company Information";
//         line_vat_amount: Decimal;
//         header_vat_amount: Decimal;
//         CompanyCountry: Record "Country/Region";
//         vendorcountry: Record "Country/Region";
//         paymentterm: Record "Payment Terms";
//         paymentmethod: Record "Payment Method";
//         ReportHeader: Text[100];
// }