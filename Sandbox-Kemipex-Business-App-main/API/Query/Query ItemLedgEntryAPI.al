// query 53009 ItemLedgEntryWebAPI//T12370-Full Comment
// {
//     QueryType = Normal;
//     Caption = 'BI Item Ledger Entry';

//     elements
//     {
//         dataitem(Item_Ledger_Entry; "Item Ledger Entry")
//         {
//             column(Entry_No_; "Entry No.")
//             {

//             }
//             column(Item_No_; "Item No.") { }
//             column(Posting_Date; "Posting Date") { }
//             column(Entry_Type; "Entry Type") { }
//             column(Document_Type; "Document Type") { }
//             column(Document_No_; "Document No.") { }
//             column(Source_Type; "Source Type") { }
//             column(Source_No_; "Source No.") { }
//             column(Description; Description) { }
//             column(Location_Code; "Location Code") { }
//             column(Quantity; Quantity) { }
//             column(Remaining_Quantity; "Remaining Quantity") { }
//             column(Invoiced_Quantity; "Invoiced Quantity") { }
//             column(Cost_Amount__Actual_; "Cost Amount (Actual)") { }
//             column(Purchase_Amount__Actual_; "Purchase Amount (Actual)") { }
//             column(Sales_Amount__Actual_; "Sales Amount (Actual)") { }
//             column(Cost_Amount__Non_Invtbl__; "Cost Amount (Non-Invtbl.)") { }
//             column(Positive; Positive) { }
//             column(CustomLotNumber; CustomLotNumber) { }
//             column(CustomBOENumber; CustomBOENumber) { }
//             column(CustomBOENumber2; CustomBOENumber2) { }
//             column(Supplier_Batch_No__2; "Supplier Batch No. 2") { }
//             column(Manufacturing_Date_2; "Manufacturing Date 2") { }
//             column(Expiration_Date; "Expiration Date") { }
//             filter(Entry_No; "Entry No.")
//             {

//             }
//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnBeforeOpen()
//     begin

//     end;
// }