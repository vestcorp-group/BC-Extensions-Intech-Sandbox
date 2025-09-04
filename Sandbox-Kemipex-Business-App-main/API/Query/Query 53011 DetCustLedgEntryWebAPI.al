// query 53011 DetCustLedgEntryWebAPI//T12370-Full Comment
// {
//     QueryType = Normal;
//     Caption = 'BI Detailed Customer Ledger Entry';

//     elements
//     {
//         dataitem(Detailed_Cust__Ledg__Entry; "Detailed Cust. Ledg. Entry")
//         {
//             column(Entry_No_; "Entry No.")
//             {

//             }
//             column(Document_Type; "Document Type") { }
//             column(Document_No_; "Document No.") { }
//             column(Customer_No_; "Customer No.") { }

//             column(Posting_Date; "Posting Date") { }
//             column(Cust__Ledger_Entry_No_; "Cust. Ledger Entry No.") { }
//             column(Currency_Code; "Currency Code") { }
//             column(Amount; Amount) { }
//             column(Amount__LCY_; "Amount (LCY)") { }


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