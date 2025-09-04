// pageextension 58034 ReqToApprove extends "Requests to Approve"//T12370-Full Comment
// {
//     layout
//     {
//         addbefore(Amount)
//         {
//             field("Approver Remarks"; Rec."Approver Remarks")
//             {
//                 ApplicationArea = All;
//                 Visible = false;
//             }
//         }
//         modify("Due Date")
//         {
//             Visible = false;
//         }
//         addafter("Sender ID")
//         {
//             field("Last Date-Time Modified"; rec."Last Date-Time Modified")
//             {
//                 Caption = 'Approval Sent on Date-Time';
//                 ApplicationArea = all;
//             }
//         }
//     }
// }
