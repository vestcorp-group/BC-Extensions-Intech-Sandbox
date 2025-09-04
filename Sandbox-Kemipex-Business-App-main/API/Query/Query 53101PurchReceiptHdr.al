// query 53101 PurchaseReceiptHeader//T12370-Full Comment
// {
//     QueryType = Normal;

//     Caption = 'Purchase Receipt Header';

//     elements
//     {
//         dataitem(Purch__Rcpt__Header; "Purch. Rcpt. Header")
//         {
//             column(No_; "No.")
//             {

//             }
//             column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
//             column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
//             column(Buy_from_City; "Buy-from City") { }
//             column(Buy_from_Country_Region_Code; "Buy-from Country/Region Code") { }
//             column(Buy_from_Post_Code; "Buy-from Post Code") { }
//             column(Order_Date; "Order Date") { }
//             column(Posting_Date; "Posting Date") { }
//             column(Due_Date; "Due Date") { }

//             column(Payment_Terms_Code; "Payment Terms Code") { }
//             column(Payment_Method_Code; "Payment Method Code") { }
//             column(Ship_to_Code; "Ship-to Code") { }
//             column(Ship_to_City; "Ship-to City") { }
//             column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
//             column(Ship_to_Post_Code; "Ship-to Post Code") { }
//             column(Currency_Code; "Currency Code") { }
//             column(Currency_Factor; "Currency Factor") { }
//             column(Order_No_; "Order No.") { }
//             column(Transport_Method; "Transport Method") { }

//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnBeforeOpen()
//     begin

//     end;
// }