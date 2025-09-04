// query 53030 DetailedVendLedgEntryWebAPI//T12370-Full Comment
// {
//     QueryType = Normal;
//     Caption = 'BI Detailed Vendor Ledger Entry';

//     elements
//     {
//         dataitem(Detailed_Vendor_Ledg__Entry; "Detailed Vendor Ledg. Entry")
//         {
//             column(Entry_No_; "Entry No.")
//             {

//             }
//             column(Document_Type; "Document Type") { }
//             column(Document_No_; "Document No.") { }
//             column(Vendor_No_; "Vendor No.") { }

//             column(Posting_Date; "Posting Date") { }
//             column(Vendor_Ledger_Entry_No_; "Vendor Ledger Entry No.") { }
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