// page 58120 Approval_entries//T12370-Full Comment
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Lists;
//     SourceTable = "Approval Entry";
//     Caption = 'Approval Entries';
//     Editable = false;

//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {
//                 field("Table ID"; rec."Table ID")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Document Type"; rec."Document Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Document No."; rec."Document No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Sender ID"; rec."Sender ID")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Sequence No."; rec."Sequence No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Approver ID"; rec."Approver ID")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Status; rec.Status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date-Time Sent for Approval"; rec."Date-Time Sent for Approval")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Last Date-Time Modified"; rec."Last Date-Time Modified")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Last Modified By User ID"; rec."Last Modified By User ID")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }
//     actions
//     {
//         area(Processing)
//         {
//         }
//     }
//     var
//         myInt: Integer;
// }