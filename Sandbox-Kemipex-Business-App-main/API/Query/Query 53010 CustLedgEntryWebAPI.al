// query 53010 CustLedgEntryWebAPI//T12370-Full Comment
// {
//     QueryType = Normal;
//     Caption = 'BI Customer Ledger Entry';

//     elements
//     {
//         dataitem(Cust__Ledger_Entry; "Cust. Ledger Entry")
//         {
//             column(Entry_No_; "Entry No.")
//             {

//             }
//             column(Document_Type; "Document Type") { }
//             column(Document_No_; "Document No.") { }
//             column(Customer_No_; "Customer No.") { }
//             column(Customer_Name; "Customer Name") { }
//             column(Posting_Date; "Posting Date") { }
//             column(Due_Date; "Due Date") { }
//             column(Description; Description) { }
//             column(Currency_Code; "Currency Code") { }
//             column(Amount; Amount) { }
//             column(Amount__LCY_; "Amount (LCY)") { }
//             column(Remaining_Amount; "Remaining Amount") { }
//             column(Remaining_Amt___LCY_; "Remaining Amt. (LCY)") { }

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