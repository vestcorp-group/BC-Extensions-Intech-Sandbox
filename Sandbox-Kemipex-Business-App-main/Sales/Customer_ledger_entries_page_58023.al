// pageextension 58023 CustomerLedger extends "Customer Ledger Entries"//T12370-Full Comment
// {
//     layout
//     {
//         modify(Amount)
//         {
//             Visible = false;
//         }

//         modify("Payment Method Code")
//         {
//             Visible = false;
//         }
//         modify("On Hold")
//         {
//             Visible = false;

//         }
//         modify("Pmt. Discount Date")
//         {
//             Visible = false;
//         }
//         modify("Pmt. Disc. Tolerance Date")
//         {
//             Visible = false;
//         }
//         modify("Max. Payment Tolerance")
//         {
//             Visible = false;
//         }
//         modify("Remaining Pmt. Disc. Possible")
//         {
//             Visible = false;
//         }
//         modify("Original Pmt. Disc. Possible")
//         {
//             Visible = false;
//         }
//         modify("Salesperson Code")
//         {
//             Visible = true;
//         }
//         modify("Credit Amount")
//         {
//             Visible = false;
//         }
//         modify("Debit Amount")
//         {
//             Visible = false;
//         }
//         modify("Exported to Payment File")
//         {
//             Visible = true;
//         }

//         moveafter("Customer Name"; "Salesperson Code")

//         addafter("Due Date")
//         {
//             field("Closed at Date1"; rec."Closed at Date")
//             {
//                 ApplicationArea = all;
//                 Visible = true;
//                 Caption = 'Closed at Date';
//             }
//             field("Closed by Amount (LCY)"; rec."Closed by Amount (LCY)")
//             {
//                 ApplicationArea = all;
//                 Visible = true;
//             }
//             field(Prepayment; rec.Prepayment)
//             {
//                 ApplicationArea = all;
//                 Visible = false;
//             }
//         }

//     }
// }