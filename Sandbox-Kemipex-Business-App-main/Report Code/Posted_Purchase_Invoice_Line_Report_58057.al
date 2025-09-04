// report 58069 Purch_inv_line_report2//T12370-Full Comment
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = all;
//     RDLCLayout = 'Reports/Purch_Inv_Line_report.rdl';
//     Caption = 'Purchase Invoice Line Report';
//     dataset
//     {
//         dataitem(Company; Company)
//         {
//             DataItemTableView = where(Name = filter('<>Consolidate All companies&<>Consolidate Caspian&<>Consolidate Kemipex'));
//             column(company_short_name; company_short_name."Short Name") { }
//             dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
//             {
//                 DataItemTableView = where("Prepayment Invoice" = filter(false));
//                 column(Posting_Date; "Posting Date") { }
//                 column(Invoice_o; "No.") { }
//                 column(Currency_Code; "Currency Code") { }
//                 column(Currency_Factor; "Currency Factor") { }
//                 column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
//                 column(Document_Date; "Document Date") { }
//                 column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
//                 column(Vendorname; ven_name.Name) { }
//                 column(Prepayment_Invoice; "Prepayment Invoice") { }
//                 dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
//                 {
//                     DataItemLink = "Document No." = field("No.");
//                     RequestFilterFields = "Buy-from Vendor No.", "Location Code";
//                     DataItemTableView = where("Type" = filter(<> ''));
//                     column(No_; "No.") { }
//                     column(Type; Type) { }
//                     column(LineDescription; LineDescription) { }
//                     column(Unit_of_Measure_Code; "Unit of Measure Code") { }
//                     column(Quantity; Quantity) { }
//                     column(GetCurrencyCode; GetCurrencyCode) { }
//                     column(Direct_Unit_Cost; "Direct Unit Cost") { }
//                     column(Amount; Amount) { }
//                     column(Transport_Method; "Transport Method") { }
//                     column(Transaction_Specification; "Transaction Specification") { }
//                     column(Entry_Point; "Entry Point") { }
//                     column(POL; pol.Description) { }
//                     column(POD; POD.Text) { }
//                     column(Order_No_; "Order No.") { }
//                     column(Amount_lcy; Amount_lcy) { }
//                     column(Vat_amount; Vat_amount) { }

//                     trigger OnAfterGetRecord()
//                     var
//                         G_LAccounts: Record "G/L Account";
//                         ItemCharge: Record "Item Charge";
//                     begin
//                         Clear(LineDescription);
//                         Clear(Amount_lcy);
//                         Clear(POL);
//                         Clear(POD);
//                         Clear(Vat_amount);
//                         Clear(ven_name);
//                         POL.ChangeCompany(Company.Name);
//                         POD.ChangeCompany(Company.Name);

//                         if ven_name.Get("Purch. Inv. Line"."Buy-from Vendor No.") then;
//                         case Type of
//                             Type::Item:
//                                 begin
//                                     if item.Get("Purch. Inv. Line"."No.") then
//                                         LineDescription := item.Description;
//                                 end;
//                             Type::"G/L Account":
//                                 begin
//                                     if G_LAccounts.Get("Purch. Inv. Line"."No.") then
//                                         LineDescription := G_LAccounts.Name;
//                                 end;
//                             Type::"Charge (Item)":
//                                 begin
//                                     if ItemCharge.Get("Purch. Inv. Line"."No.") then
//                                         LineDescription := ItemCharge.Description;
//                                 end;
//                         end;
//                         if item.Get("Purch. Inv. Line"."No.") then;
//                         if pol.Get("Purch. Inv. Line"."Entry Point") then;
//                         if pod.Get("Purch. Inv. Line"."Area") then;
//                         if "Unit Cost (LCY)" <> 0 then Amount_lcy := "Unit Cost (LCY)" * Quantity;
//                         if "VAT %" <> 0 then
//                             Vat_amount := Amount_lcy / 100 * "VAT %" else
//                             Vat_amount := 0;

//                     end;

//                     trigger OnPreDataItem()
//                     var
//                     begin
//                         ChangeCompany(Company.Name);

//                     end;
//                 }

//                 trigger OnPreDataItem()
//                 var
//                 begin
//                     ChangeCompany(Company.Name);
//                     SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
//                     SetFilter("Buy-from Vendor No.", VendorVar);
//                 end;

//                 trigger OnAfterGetRecord()
//                 var
//                     myInt: Integer;
//                 begin
//                     if "Currency Code" = '' then "Currency Code" := 'AED';
//                 end;
//             }

//             trigger OnPreDataItem()
//             var
//                 myInt: Integer;
//             begin
//                 ven_name.ChangeCompany(Company.Name);
//                 ChangeCompany(Company.Name);
//                 SetFilter(Name, selectCompany);

//             end;

//             trigger OnAfterGetRecord()
//             var
//                 myInt: Integer;
//             begin
//                 company_short_name.Get(Name);

//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;
//         layout
//         {
//             area(Content)
//             {
//                 field(FromDate; FromDate)
//                 {
//                     Caption = 'From Date:';
//                     ApplicationArea = all;
//                 }
//                 field(ToDate; ToDate)
//                 {
//                     Caption = 'To Date:';
//                     ApplicationArea = all;
//                 }
//                 field(VendorVar; VendorVar)
//                 {
//                     Caption = 'Vendor';
//                     TableRelation = Vendor;
//                     ApplicationArea = all;
//                 }
//                 field(selectCompany; selectCompany)
//                 {
//                     Caption = 'Select Company';
//                     ApplicationArea = all;
//                     TableRelation = Company;
//                 }
//             }
//         }
//     }
//     var
//         ven_name: Record Vendor;
//         item: Record Item;
//         POL: Record "Entry/Exit Point";
//         POD: Record "Area";
//         Amount_lcy: Decimal;
//         Vat_amount: Decimal;
//         LineDescription: Text[100];
//         FromDate: Date;
//         ToDate: date;
//         Showintercompa: Boolean;
//         ItemVar: Code[20];
//         VendorVar: Code[20];
//         company_short_name: Record "Company Short Name";
//         selectCompany: Text;
// }