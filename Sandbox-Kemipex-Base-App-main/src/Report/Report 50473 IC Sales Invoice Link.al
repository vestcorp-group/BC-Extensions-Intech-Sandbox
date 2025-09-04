// report 50473 "IC Sales Invoice Link"//T12370-Full Comment
// {
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/N IC Sales Invoice Link.rdl';

//     dataset
//     {
//         dataitem("Sales Invoice Line"; "Sales Invoice Line")
//         {
//             RequestFilterFields = "Posting Date", "Bill-to Customer No.", "No.";
//             DataItemTableView = where("Location Code" = filter('<>Sample WH'), TYPE = filter('ITEM'), "IC Related SO" = filter(''));
//             column(Order_No_; "Order No.") { }
//             column(Posting_Date; "Posting Date") { }
//             column(Document_No_; "Document No.") { }
//             column(BilltoCustomerCode; BilltoCustomerCode) { }
//             column(BilltoCustomerName; BilltoCustomerName) { }
//             column(Type; Type) { }
//             column(No_; "No.") { }
//             column(Description; Description) { }
//             column(Location_Code; "Location Code") { }
//             column(Base_UOM_2; "Base UOM 2") { }
//             column(Quantity__Base_; "Quantity (Base)") { }
//             column(GetCurrencyCode; SIHRec2."Currency Code") { }
//             column(Unit_Price_Base_UOM_2; "Unit Price Base UOM 2") { }
//             column(ICCompanyName; ICCompanyName) { }
//             column(IC_Related_SO; "IC Related SO") { }
//             column(ICRInvoiceNo; ICRInvoiceNo) { }
//             column(ICRBaseQTY; ICRBaseQTY) { }
//             column(ICRCurrencyCode; ICRCurrencyCode) { }
//             column(ICRBaseUOMPrice; ICRBaseUOMPrice) { }
//             column(ICRelatedInvoiceNo; ICRelatedInvoiceNo) { }

//             trigger OnAfterGetRecord()
//             var
//                 CompanyRec: Record Company;
//                 SIHRec: Record "Sales Invoice Header";
//                 GLS: Record "General Ledger Setup";
//                 GLS2: Record "General Ledger Setup";

//             begin
//                 Clear(BilltoCustomerCode);
//                 Clear(BilltoCustomerName);
//                 SIHRec2.Get("Document No.");
//                 GLS.Get();
//                 if SIHRec2."Currency Code" = '' then SIHRec2."Currency Code" := 'AED';
//                 BilltoCustomerCode := SIHRec2."Bill-to Customer No.";
//                 BilltoCustomerName := SIHRec2."Bill-to Name";

//                 CompanyRec.SetFilter(Name, '<>%1', "Sales Invoice Line".CurrentCompany);
//                 if CompanyRec.FindSet() then begin
//                     Clear(ICRInvoiceNo);
//                     Clear(ICRBaseQTY);
//                     Clear(ICRBaseUOMPrice);
//                     Clear(ICRLocation);
//                     Clear(ICRCurrencyCode);
//                     Clear(ICCompanyName);
//                     repeat
//                         SIHRec.ChangeCompany(CompanyRec.Name);
//                         ICSalesInvoiceLine.Reset();
//                         ICSalesInvoiceLine.ChangeCompany(CompanyRec.Name);
//                         ICSalesInvoiceLine.SetRange("No.", "No.");
//                         ICSalesInvoiceLine.SetRange("IC Related SO", "Order No.");
//                         if ICSalesInvoiceLine.FindFirst() then begin
//                             ICCompanyName := CompanyRec.Name;
//                             SIHRec.Get(ICSalesInvoiceLine."Document No.");
//                             ICRInvoiceNo := ICSalesInvoiceLine."Document No.";
//                             ICRBaseQTY := ICSalesInvoiceLine."Quantity (Base)";
//                             ICRBaseUOMPrice := ICSalesInvoiceLine."Unit Price Base UOM 2";
//                             if SIHRec."Currency Code" = '' then
//                                 ICRCurrencyCode := GLS."Local Currency Symbol"
//                             else
//                                 ICRCurrencyCode := SIHRec."Currency Code";
//                             ICRLocation := ICSalesInvoiceLine."Location Code";
//                         end;
//                     until companyrec.Next() = 0;
//                 end;
//                 if ICRInvoiceNo = '' then CurrReport.Skip();
//             end;
//         }
//     }
//     var
//         ICRelatedInvoiceNo: CODE[20];
//         ICSalesInvoiceLine: Record "Sales Invoice Line";
//         ICRInvoiceNo: Code[20];
//         ICRBaseQTY: Decimal;
//         ICRBaseUOMPrice: Decimal;
//         ICRCurrencyCode: Code[20];
//         ICRLocation: Code[30];
//         SIHRec2: Record "Sales Invoice Header";
//         BilltoCustomerCode: code[20];
//         BilltoCustomerName: Text;
//         ICCompanyName: Text;
// }