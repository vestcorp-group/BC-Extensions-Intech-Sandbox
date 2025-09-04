// report 58047 Posting_User_Report//T12370-Full Comment
// {
//     UsageCategory = Administration;
//     ApplicationArea = all;
//     RDLCLayout = 'Reports/Posting_user_report.rdl';
//     Caption = 'Posting User Report';

//     dataset
//     {
//         dataitem("Sales Invoice Header"; "Sales Invoice Header")
//         {

//             RequestFilterFields = "Sell-to Customer No.", "User ID", "Salesperson Code";

//             column(Sell_to_Customer_No_; "Sell-to Customer No.")
//             { }
//             column(No_; "No.")
//             {
//                 //30-04-2022 caption is not a valid property
//                 // Caption = 'Invoice No.';
//             }
//             column(Sell_to_Customer_Name; "Sell-to Customer Name")
//             { }
//             column(Posting_Date; "Posting Date")
//             {
//                 //30-04-2022 caption is not a valid property
//                 //Caption = 'Invoice Date';
//             }
//             column(Currency_Code; "Currency Code")
//             { }
//             column(Amount; Amount)
//             { }
//             column(User_ID; "User ID")
//             { }

//             column(Order_No_; "Order No.")
//             { }
//             column(SalesPerson; SP.Name) { }
//             dataitem("Sales Invoice Line"; "Sales Invoice Line")
//             {
//                 DataItemLink = "Document No." = field("No.");
//                 DataItemTableView = where("Type" = filter(Item), "IC Partner Code" = filter(''));
//                 column(Order_No; "Order No.") { }
//                 column(Item_No; "No.") { }
//                 column(Description; Description) { }
//                 column(Unit_of_Measure_Code; "Unit of Measure Code") { }
//                 column(Quantity; Quantity) { }
//                 column(Amount_Including_VAT; "Amount Including VAT") { }
//                 column(Location_Code; "Location Code") { }
//                 dataitem("Sales Header Archive"; "Sales Header Archive")
//                 {
//                     DataItemLink = "No." = field("Order No.");
//                     DataItemTableView = where("Version No." = const(1));
//                     column(Order_Date; "Order Date") { }

//                 }


//                 //   column(SO_date; SOA."Order Date") { }
//                 //      trigger OnAfterGetRecord()
//                 //  begin
//                 //      if SOA.Get("Sales Invoice Line"."Order No.") then;
//                 //    end;


//             }

//             trigger OnAfterGetRecord()
//             begin
//                 if SP.Get("Sales Invoice Header"."Salesperson Code") then;


//             end;
//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {

//             }
//         }
//     }
//     var
//         // Customer: Code[20];
//         SP: Record "Salesperson/Purchaser";
//         SOA: Record "Sales Header Archive";


// }