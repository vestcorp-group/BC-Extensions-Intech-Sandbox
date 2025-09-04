// pageextension 50359 "User Task List Ext" extends "User Task List"//T12370-Full Comment
// {
//     layout
//     {
//         addbefore(Title)
//         {
//             field("Task Document No"; rec."Task Document No")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Document No.';
//             }
//         }
//         addafter("User Task Group Assigned To")
//         {
//             field("Task Requester"; rec."Task Requester")
//             {
//                 ApplicationArea = all;
//             }
//             field("Approval Status"; rec."Approval Status")
//             {
//                 ApplicationArea = all;
//             }
//         }
//     }
// }
