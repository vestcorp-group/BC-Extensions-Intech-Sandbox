// query 53022 PurchCrMemoPostedWebAPI//T12370-Full Comment
// {
//     QueryType = Normal;
//     Caption = 'BI Purchase Credit Memo Header';

//     elements
//     {
//         dataitem(Purch__Cr__Memo_Hdr_; "Purch. Cr. Memo Hdr.")
//         {
//             column(No_; "No.")
//             {

//             }
//             column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
//             column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
//             //            column(Buy_from_Address; "Buy-from Address") { }
//             //            column(Buy_from_Address_2; "Buy-from Address 2") { }
//             column(Buy_from_City; "Buy-from City") { }
//             column(Buy_from_Country_Region_Code; "Buy-from Country/Region Code") { }
//             column(Buy_from_Post_Code; "Buy-from Post Code") { }
//             //column(Order_Date; "Order Date") { }
//             column(Posting_Date; "Posting Date") { }
//             column(Due_Date; "Due Date") { }

//             column(Payment_Terms_Code; "Payment Terms Code") { }
//             column(Payment_Method_Code; "Payment Method Code") { }
//             column(Ship_to_Code; "Ship-to Code") { }
//             //        column(Ship_to_Name; "Ship-to Name") { }
//             //          column(Ship_to_Address; "Ship-to Address") { }
//             //      column(Ship_to_Address_2; "Ship-to Address 2") { }
//             column(Ship_to_City; "Ship-to City") { }
//             column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
//             column(Ship_to_Post_Code; "Ship-to Post Code") { }
//             //column(Location_Code; "Location Code") { }
//             column(Currency_Code; "Currency Code") { }
//             column(Currency_Factor; "Currency Factor") { }
//             //    column(Purchaser_Code; "Purchaser Code") { }
//             //    column(Return_Order_No_; "Return Order No.") { }
//             //column(Prices_Including_VAT; "Prices Including VAT") { }
//             //     column(Gen__Bus__Posting_Group; "Gen. Bus. Posting Group") { }
//             //    column(VAT_Bus__Posting_Group; "VAT Bus. Posting Group") { }
//             column(Transport_Method; "Transport Method") { }
//             //column(Amount; Amount) { }
//             //column(Amount_Including_VAT; "Amount Including VAT") { }

//             //added by bayas
//             column(Vendor_Cr__Memo_No_; "Vendor Cr. Memo No.") { }
//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnBeforeOpen()
//     begin

//     end;
// }