// pageextension 50424 RequestToaApproceExt extends "Requests to Approve"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here  
//         addafter(ToApprove)
//         {
//             field("Document No."; rec."Document No.")
//             {
//                 Visible = true;
//                 ApplicationArea = all;
//             }
//         }
//         addafter(Details)
//         {
//             field("Short Name"; rec."Short Name")
//             {
//                 ApplicationArea = all;
//             }
//         }
//     }
//     actions
//     {
//         modify(Record)
//         {
//             trigger OnAfterAction()
//             var
//                 myInt: Integer;
//                 UserTaskRec: Record "User Task";
//                 UserTaskCard: Page "User Task Card";
//             begin
//                 if rec."Table ID" = 1170 then begin
//                     UserTaskRec.SetRange("Task Document No", rec."Document No.");
//                     if UserTaskRec.FindFirst() then
//                         page.RunModal(Page::"User Task Card", UserTaskRec);
//                 end;
//             end;
//         }
//     }
// }