// pageextension 50377 GLEntryExt extends "General Ledger Entries"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("User ID")
//         {
//             field("System-Created Entry"; rec."System-Created Entry")
//             {
//                 ApplicationArea = all;
//                 Visible = true;
//             }

//         }
//         addafter("Document No.")
//         {
//             field("Upload Document No."; Rec."Upload Document No.")
//             {
//                 ApplicationArea = all;
//             }
//         }
//         // Add changes to page layout here
//     }

//     actions
//     {
//         // Add changes to page actions here
//         addfirst(Navigation)
//         {
//             action("Print Voucher")
//             {
//                 ApplicationArea = all;
//                 Image = Report;
//                 trigger OnAction();
//                 var
//                     GLEntry_LRec: Record "G/L Entry";
//                 begin
//                     GLEntry_LRec.Reset;
//                     GLEntry_LRec.SetCurrentKey("Document No.", "Posting Date");
//                     GLEntry_LRec.SetRange("Document No.", rec."Document No.");
//                     GLEntry_LRec.SetRange("Posting Date", rec."Posting Date");
//                     If GLEntry_LRec.FindSet() then
//                         Report.Run(Report::"New Posted Voucher", TRUE, FALSE, GLEntry_LRec);
//                 end;
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }