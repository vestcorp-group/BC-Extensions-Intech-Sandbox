// query 53103 SalesShipmenHeader
// {
//     QueryType = Normal;

//     Caption = 'Sales Shipment Header';

//     elements
//     {
//         dataitem(Sales_Shipment_Header; "Sales Shipment Header")
//         {
//             column(No_; "No.")
//             {

//             }
//             column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
//             column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
//             //        column(Sell_to_Address; "Sell-to Address") { }
//             //       column(Sell_to_Address_2; "Sell-to Address 2") { }
//             //       column(Sell_to_City; "Sell-to City") { }
//             column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code") { }
//             column(Sell_to_Post_Code; "Sell-to Post Code") { }
//             column(Order_Date; "Order Date") { }
//             column(Posting_Date; "Posting Date") { }
//             column(Due_Date; "Due Date") { }
//             column(Shipment_Date; "Shipment Date") { }
//             column(Payment_Terms_Code; "Payment Terms Code") { }
//             column(Payment_Method_Code; "Payment Method Code") { }
//             column(Ship_to_Code; "Ship-to Code") { }
//             //     column(Ship_to_Name; "Ship-to Name") { }
//             //    column(Ship_to_Address; "Ship-to Address") { }
//             //    column(Ship_to_Address_2; "Ship-to Address 2") { }
//             column(Ship_to_City; "Ship-to City") { }
//             column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
//             column(Ship_to_Post_Code; "Ship-to Post Code") { }
//             //  column(Location_Code; "Location Code") { }
//             column(Currency_Code; "Currency Code") { }
//             column(Currency_Factor; "Currency Factor") { }
//             column(Salesperson_Code; "Salesperson Code") { }
//             column(Order_No_; "Order No.") { }
//             //            column(Prices_Including_VAT; "Prices Including VAT") { }
//             //           column(Gen__Bus__Posting_Group; "Gen. Bus. Posting Group") { }
//             //          column(VAT_Bus__Posting_Group; "VAT Bus. Posting Group") { }
//             column(Shipping_Agent_Code; "Shipping Agent Code") { }
//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnBeforeOpen()
//     begin

//     end;
// }