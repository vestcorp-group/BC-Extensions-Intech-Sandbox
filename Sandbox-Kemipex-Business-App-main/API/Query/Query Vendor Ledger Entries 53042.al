// query 53042 VendorLedgerEntriesWebAPI//T12370-Full Comment
// {
//     QueryType = Normal;

//     Caption = 'BI Vendor Ledger Entries';

//     elements
//     {
//         dataitem(Vendor_Ledger_Entry; "Vendor Ledger Entry")
//         {
//             column(Vendor_No_; "Vendor No.") { }
//             column(Vendor_Name; "Vendor Name") { }
//             column(Posting_Date; "Posting Date") { }
//             column(Document_Type; "Document Type") { }
//             column(Document_No_; "Document No.") { }
//             column(Currency_Code; "Currency Code") { }
//             column(Document_Date; "Document Date") { }
//             column(External_Document_No_; "External Document No.") { }
//             column(Description; Description) { }
//             column(Original_Amount; "Original Amount") { }
//             column(Original_Amt___LCY_; "Original Amt. (LCY)") { }
//             column(Original_Currency_Factor; "Original Currency Factor") { }
//             column(Amount; Amount) { }
//             column(Amount__LCY_; "Amount (LCY)") { }
//             column(Remaining_Amount; "Remaining Amount") { }
//             column(Remaining_Amt___LCY_; "Remaining Amt. (LCY)") { }
//             column(Due_Date; "Due Date") { }
//             column(Open; Open) { }
//             column(Source_Code; "Source Code") { }
//             column(IC_Partner_Code; "IC Partner Code") { }
//             column(Closed_by_Entry_No_; "Closed by Entry No.") { }
//             column(Closed_at_Date; "Closed at Date") { }
//             column(Closed_by_Amount; "Closed by Amount") { }
//             column(Closed_by_Amount__LCY_; "Closed by Amount (LCY)") { }
//             Column(Closed_by_Currency_Amount; "Closed by Currency Amount") { }
//             column(Closed_by_Currency_Code; "Closed by Currency Code") { }
//             Column(Entry_No_; "Entry No.") { }

//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnBeforeOpen()
//     begin

//     end;
// }