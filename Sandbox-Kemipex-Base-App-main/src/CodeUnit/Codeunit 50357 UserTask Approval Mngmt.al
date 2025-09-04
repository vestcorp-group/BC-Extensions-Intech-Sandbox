// codeunit 50357 "UserTask Approval Mngmt"//T12370-Full Comment
// {
//     trigger OnRun()
//     var
//         myInt: Integer;
//     begin

//     end;

//     var
//         Workflowmgmt: Codeunit "Workflow Management";
//         UserTaskRec: Record "User Task";
//         ApprovalEntryrec: Record "Approval Entry";
//         Error1: TextConst ENU = ' No Work Flow Enabled';

//     // On Send 
//     procedure RunWorkflowUserTaskOnsendApprovalCode(): code[128]
//     begin
//         exit(UpperCase('RunworkflowonSendUserTaskApproval'));
//     end;

//     //[IntegrationEvent(true, true)]////30-04-2022
//     [IntegrationEvent(false, false)]//30-04-2022
//     procedure OnSendUserTaskApproval(var Usertask: Record "User Task")
//     begin

//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"UserTask Approval Mngmt", 'OnSendUserTaskApproval', '', true, true)]
//     procedure RunworkflowUserTaskApproval(var Usertask: Record "User Task")
//     begin
//         Workflowmgmt.HandleEvent(RunWorkflowUserTaskOnsendApprovalCode(), Usertask);

//         Usertask."Approval Status" := Usertask."Approval Status"::"Pending Approval";
//         Usertask.Modify(true);
//     end;

//     //On Approve
//     procedure RunWorkflowOnApproveApprovalRequestforUserTaskCode(): code[128]
//     begin
//         exit(UpperCase('RunworkflowonApproveUsertaskApprovalRequest'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', true, true)]
//     procedure RunWorkFlowOnApproveApprovalRequestforUserTask(var ApprovalEntry: Record "Approval Entry")
//     begin
//         Workflowmgmt.HandleEventOnKnownWorkflowInstance(RunworkflowOnApproveApprovalRequestforUserTaskCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
//         UserTaskRec.Reset();
//         UserTaskRec.SetRange("Task Document No", ApprovalEntry."Document No.");
//         if UserTaskRec.FindFirst() then begin
//             UserTaskRec."Approval Status" := UserTaskRec."Approval Status"::Approved;
//             UserTaskRec.Modify(true);
//         end;
//     end;

//     //On Reject
//     procedure RunWorkflowOnRejectApprovalRequestforUsertaskcode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnRejectApprovalRequestforUserTask'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', true, true)]
//     procedure RunWorkflowOnRejectApprovalRequestforUsertask(var ApprovalEntry: Record "Approval Entry")
//     begin
//         Workflowmgmt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprovalRequestforUsertaskcode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
//         UserTaskRec.Reset();
//         UserTaskRec.SetRange("Task Document No", ApprovalEntry."Document No.");
//         if UserTaskRec.FindFirst() then begin
//             UserTaskRec."Approval Status" := UserTaskRec."Approval Status"::Rejected;
//             UserTaskRec.Modify(true);
//         end;
//     end;

//     //On Delegate
//     procedure RunWorkflowOnDelegateApprovalRequestforUsertaskcode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnDelegateApprovalRequestforUserTask'));
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', true, true)]
//     procedure RunWorkflowOnDelegateApprovalRequestforUsertask(var ApprovalEntry: Record "Approval Entry")
//     begin
//         Workflowmgmt.HandleEventOnKnownWorkflowInstance(RunWorkflowOndelegateApprovalRequestforUsertaskcode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
//         UserTaskRec.Reset();
//         UserTaskRec.SetRange("Task Document No", ApprovalEntry."Document No.");
//         if UserTaskRec.FindFirst() then begin
//             UserTaskRec."Approval Status" := UserTaskRec."Approval Status"::Delegated;
//             UserTaskRec.Modify(true);
//         end;
//     end;

//     // //On Cancel
//     //[IntegrationEvent(true, true)]//30-04-2022
//     [IntegrationEvent(false, false)]//30-04-2022
//     procedure OnCancelApprovalRequestforUsertaskcode(var Usertask: Record "User Task")
//     begin

//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"UserTask Approval Mngmt", 'OnCancelApprovalRequestforUsertaskcode', '', true, true)]
//     procedure RunWorkflowOnCancelApprovalRequestforUsertask(var Usertask: Record "User Task")
//     var
//         SHP: Page "Sales Order";
//     begin

//     end;

//     //Add event to Workflow Library
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
//     procedure AddWorkflowevenToLibrary()
//     var
//         WorkfloweventHandle: Codeunit "Workflow Event Handling";
//     begin
//         WorkfloweventHandle.AddEventToLibrary(RunWorkflowUserTaskOnsendApprovalCode(), Database::"User Task", 'KM Send User Task for Approval', 0, false);
//         WorkfloweventHandle.AddEventToLibrary(RunworkflowOnApproveApprovalRequestforUserTaskCode(), Database::"Approval Entry", 'KM Approve Approval Request for User Task', 0, false);
//         WorkfloweventHandle.AddEventToLibrary(RunWorkflowOnRejectApprovalRequestforUsertaskcode(), Database::"Approval Entry", 'KM Reject Approval Request for User Task', 0, false);
//         WorkfloweventHandle.AddEventToLibrary(RunWorkflowOnDelegateApprovalRequestforUsertaskcode(), Database::"Approval Entry", 'KM Delegate Approval Request for User Task', 0, false);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowTableRelationsToLibrary', '', true, true)]
//     local procedure AddWorkflowtableRelationsToLibrary()
//     var
//         WorkflowSetup: Codeunit "Workflow Setup";
//     begin
//         WorkflowSetup.InsertTableRelation(Database::"User Task", 0, Database::"Approval Entry", 22);
//     end;

//     // Workflow Response to  Library

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
//     local procedure OnAddworkflowResposetoLibrary(ResponseFunctionName: Code[128])
//     var
//         WorkflowResponseHandling: Codeunit "Workflow Response Handling";
//     begin
//     end;

//     //Enable Workflow for Usertask
//     procedure IsuserTaskApprovalWorkflowEnabled(UserTask: Record "User Task"): Boolean
//     begin
//         exit(Workflowmgmt.CanExecuteWorkflow(UserTask, RunWorkflowUserTaskOnsendApprovalCode()));
//     end;

//     procedure CheckUserTaskApprovalWorkflowisEnabled(var Rec: Record "User Task"): Boolean
//     begin
//         if not IsuserTaskApprovalWorkflowEnabled(Rec) then
//             Error(Error1);
//         exit(true);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
//     local procedure UpdateApprovalEntry(var ApprovalEntryArgument: Record "Approval Entry"; var RecRef: RecordRef)
//     var
//         UserTask: Record "User Task";
//         Description: Text;
//         approval: Page "Approval Entries";
//     begin
//         case RecRef.Number of
//             database::"User Task":
//                 begin
//                     RecRef.SetTable(UserTask);
//                     ApprovalEntryArgument."Document No." := UserTask."Task Document No";

//                 end;
//         end;
//     end;
// }
