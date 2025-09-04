// report 58054 Sales_Inv_line_Report//T12370-Full Comment
// {
//     UsageCategory = Administration;
//     ApplicationArea = all;
//     RDLCLayout = 'Reports/Sales_Inv_line_report.rdl';
//     Caption = 'Sales Invoice Line Report';
//     dataset
//     {
//         dataitem("Sales Invoice Line"; "Sales Invoice Line")
//         {
//             RequestFilterFields = "Sell-to Customer No.";
//             DataItemTableView = where("Type" = filter(item), "Posting Group" = filter(<> 'Sample'));
//             column(comp; comp.Name) { }
//             column(Posting_Date; "Posting Date") { }
//             column(Posting_Group; "Posting Group") { }
//             column(Document_No_; "Document No.") { }
//             column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
//             //  column(Customer_name; customer.Name) { }
//             column(No_; "No.") { }
//             column(Description; Description) { }
//             column(Base_UOM; "Base UOM 2") { } //PackingListExtChange
//             column(Quantity__Base_; "Quantity (Base)") { }
//             column(Unit_Price_Base_UOM; "Unit Price Base UOM 2") { } //PackingListExtChange
//             column(POD; pod.Text) { }
//             column(POL; POL.Description) { }
//             column(Transaction_Specification; "Transaction Specification") { }
//             column(Location_Code; "Location Code") { }
//             column(Drop_Shipment; "Drop Shipment") { }
//             column(Order_No_; "Order No.") { }
//             column(Blanket_Order_No_; "Blanket Order No.") { }
//             column(Amount_Including_VAT; "Amount Including VAT") { }
//             dataitem("Sales Invoice Header";
//             "Sales Invoice Header")
//             {
//                 DataItemLink = "No." = field("Document No.");
//                 column(Salesperson_Code; "Salesperson Code") { }
//                 // column(spcode; sp."Short Name") { }
//                 column(Sales_person; sp."Short Name") { }
//                 column("Customer_name"; "Bill-to Name") { }
//                 column(CountryRegionName; CountryRegionName) { }
//                 column(Currency_Code; "Currency Code") { }
//                 column(Payment_Terms_Code; "Payment Terms Code") { }
//                 trigger OnAfterGetRecord()
//                 var
//                     CountrRegionRec: Record "Country/Region";
//                 begin
//                     Clear(sp);
//                     Clear(CountryRegionName);
//                     if sp.Get("Sales Invoice Header"."Salesperson Code") then;
//                     if "Currency Code" = '' then "Currency Code" := 'AED';
//                     if CountrRegionRec.Get("Bill-to Country/Region Code") then CountryRegionName := CountrRegionRec.Name;

//                 end;
//             }
//             trigger OnPreDataItem()
//             var

//             begin
//                 comp.Get();
//                 SetFilter("Posting Date", '%1..%2', FromDate, ToDate);

//             end;

//             trigger OnAfterGetRecord()
//             begin
//                 Clear(POD);
//                 Clear(POL);
//                 if POD.Get("Sales Invoice Line"."Area") then;
//                 if pol.Get("Sales Invoice Line"."Exit Point") then;
//                 If customer.Get("Bill-to Customer No.") and (customer."IC Partner Code" > '') and (not Showintercompany) then CurrReport.Skip();
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
//                     ApplicationArea = all;
//                 }
//                 field(ToDate; ToDate)
//                 {
//                     ApplicationArea = all;
//                 }

//                 field(Showintercompa; Showintercompany)
//                 {
//                     Caption = 'Show Intercompany Purchase';
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }
//     var
//         sp: Record "Salesperson/Purchaser";
//         POD: Record "Area";
//         POL: Record "Entry/Exit Point";
//         customer: Record Customer;
//         comp: Record "Company Information";
//         datevar: Date;
//         FromDate: Date;
//         ToDate: date;
//         Showintercompany: Boolean;
//         CountryRegionName: Text;
// }