// pageextension 50351 UsersTaskCarPg extends "User Task Card"//T12370-Full Comment
// {
//     layout
//     {
//         addlast(content)
//         {
//             part(Remarks; UserTaskRemarks)
//             {
//                 SubPageLink = "Document Type" = const("User Task"), "No." = field("Task Document No");
//                 ApplicationArea = all;
//             }
//         }
//         addfirst(General)
//         {
//             field("Task Document No"; rec."Task Document No")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Task No.';
//             }
//         }
//         addafter(ObjectName)
//         {
//             field("Task Requester"; rec."Task Requester")
//             {
//                 ApplicationArea = all;
//                 Visible = true;

//             }
//             field("Task Document Type"; rec."Task Document Type")
//             {
//                 ApplicationArea = all;
//                 Visible = true;
//                 trigger OnValidate()
//                 var
//                 begin
//                     Enable_Ref_Doc := SetEnable();
//                     if not Enable_Ref_Doc then rec."Task Reference Document" := '';
//                 end;
//             }
//             field("Task Reference Document"; rec."Task Reference Document")
//             {
//                 ApplicationArea = all;
//                 Enabled = Enable_Ref_Doc;
//             }
//             field("Approval Status"; rec."Approval Status")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Approval Status';
//             }
//         }
//     }
//     actions
//     {
//         addafter("Go To Task Item")
//         {
//             action("Send Approval")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Send Approval Request';
//                 Image = SendApprovalRequest;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     UserTaskApprovalCodeUn: Codeunit "UserTask Approval Mngmt";
//                 begin
//                     rec."Approval Status" := rec."Approval Status"::"Pending Approval";
//                     if UserTaskApprovalCodeUn.CheckUserTaskApprovalWorkflowisEnabled(rec) then begin
//                         UserTaskApprovalCodeUn.OnSendUserTaskApproval(Rec);
//                         CurrPage.Update();
//                     end;
//                 end;
//             }
//             // action("Cancel Approval")
//             // {
//             //     ApplicationArea = all;
//             //     Caption = 'Cancel Approval Request';
//             //     Image = CancelApprovalRequest;
//             //     Promoted = true;
//             //     PromotedCategory = Process;

//             //     trigger OnAction()
//             //     var
//             //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//             //         WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
//             //         WorkflowStepRecord: Record "Workflow Step Instance";
//             //         WorkflowMgmnt: Codeunit "Workflow Management";
//             //     begin
//             //         // ApprovalsMgmt.workflow
//             //         // // ApprovalsMgmt.CancelApprovalRequestsForRecord();

//             //         WorkflowWebhookMgt.FindAndCancel(RecordId);
//             //     end;
//             // }
//         }
//     }
//     procedure SetEnable() OutBoolean: Boolean;
//     var

//     begin
//         if (Rec."Task Document Type" = Rec."Task Document Type"::"Blanket Order") or (Rec."Task Document Type" = Rec."Task Document Type"::Order) then
//             OutBoolean := true
//         else
//             OutBoolean := false;
//         exit(OutBoolean);
//     end;

//     trigger OnOpenPage()
//     var
//         myInt: Integer;
//     begin
//         Enable_Ref_Doc := SetEnable();
//         CurrPage.Update();
//     end;

//     var
//         Enable_Ref_Doc: Boolean;
//         Salespost: Codeunit 80;
// }
