// pageextension 50330 SalesteamRole extends "User Tasks Activities"//T12370-Full Comment
// {
//     layout
//     {
//         modify("UserTaskManagement.GetMyPendingUserTasksCount")
//         {
//             Visible = false;
//         }

//         addfirst(content)
//         {
//             cuegroup("My Task")
//             {
//                 field(MyPendingApprovalTask; KMUserTaskCode.GetMyPendingApprovaltask(UserId))
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Approval Pending Tasks';
//                     trigger OnDrillDown()
//                     var
//                         UserTaskListPage: Page "User Task List";
//                         Usertask: Record "User Task";
//                     begin
//                         Usertask.SetRange("Assigned To User Name", UserId);
//                         Usertask.SetFilter("Approval Status", '%1|%2', Usertask."Approval Status"::Delegated, Usertask."Approval Status"::"Pending Approval");
//                         Page.Run(Page::"User Task List", Usertask);
//                     end;
//                 }
//                 field(MyApprovedTask; KMUserTaskCode.GetMyApprovedtask(UserId))
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Approved Task';
//                     DrillDownPageId = "User Task List";
//                     trigger OnDrillDown()
//                     var
//                         Usertask: Record "User Task";
//                     begin
//                         Usertask.SetRange("Assigned To User Name", UserId);
//                         Usertask.SetRange("Approval Status", Usertask."Approval Status"::Approved);
//                         Page.Run(Page::"User Task List", Usertask);
//                     end;
//                 }
//             }
//         }
//     }

//     actions
//     {

//     }

//     var
//         KMUserTaskCode: Codeunit KMUserTaskCodeunit;
// }