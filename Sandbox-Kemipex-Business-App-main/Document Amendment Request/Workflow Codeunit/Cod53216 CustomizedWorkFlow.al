// codeunit 53216 "Customized Workflow"//T12370-Full Comment
// {
//     //Workflow demo created by Krishna Kumar 22 Oct 2020
//     Permissions = tabledata "Approval Entry" = RIMD;

//     trigger OnRun()
//     begin

//     end;

//     var
//         WFMngt: Codeunit "Workflow Management";
//         AppMgmt: Codeunit "Approvals Mgmt.";
//         WorkflowEventHandling: Codeunit "Workflow Event Handling";
//         WorkflowResponseHandling: Codeunit "Workflow Response Handling";



//     //**************************Send For Approval Event Start***************************
//     procedure RunWorkflowOnSendApproval_PR(): Code[128]
//     begin
//         exit('RunWorkflowOnSendApproval_PR');
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init Workflow", 'OnSendApproval_PR', '', true, true)]
//     procedure RunWorkflowOnSendApprovalForTO(var RecAmendmentReq: Record "Amendment Request")
//     begin
//         WFMngt.HandleEvent(RunWorkflowOnSendApproval_PR, RecAmendmentReq);
//     end;


//     //************* To set status pending approval *************
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
//     procedure ChangeAssetStatus(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
//     VAR
//         RecAmendmentReq: Record "Amendment Request";
//     begin
//         RecRef.GetTable(Variant);
//         case RecRef.Number of
//             DATABASE::"Amendment Request":
//                 begin
//                     RecRef.SetTable(RecAmendmentReq);
//                     RecAmendmentReq.Validate("Request Status", RecAmendmentReq."Request Status"::"Pending Approval");
//                     RecAmendmentReq.Modify(true);
//                     Variant := RecAmendmentReq;
//                     IsHandled := true;
//                 end;
//         end;
//     end;
//     //****************************************** Send For Approval End ***********************


//     //************ After approval *** Set status to Approved**************
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
//     procedure OnReleaseDocument(RecRef: RecordRef; VAR Handled: Boolean)
//     var
//         RecAmendmentReq: Record "Amendment Request";
//         Variant: Variant;
//         cuChangeReqMgt: Codeunit "Amendment Management";
//     begin
//         CASE RecRef.NUMBER OF
//             DATABASE::"Amendment Request":
//                 BEGIN
//                     RecRef.SetTable(RecAmendmentReq);
//                     RecAmendmentReq."Request Status" := RecAmendmentReq."Request Status"::Approved;
//                     RecAmendmentReq.Modify(true);
//                     Variant := RecAmendmentReq;
//                     RecRef.GetTable(Variant);
//                     Handled := true;
//                     cuChangeReqMgt.ApplyChangeRequest(RecAmendmentReq);
//                 END;
//         end;
//     end;


//     //*******************On Populate Approval Entry *********************
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
//     procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
//     var
//         RecAmendmentReq: Record "Amendment Request";
//     begin
//         case RecRef.Number of
//             database::"Amendment Request":
//                 begin
//                     RecRef.SetTable(RecAmendmentReq);
//                     ApprovalEntryArgument."Table ID" := Database::"Amendment Request";
//                     ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
//                     ApprovalEntryArgument."Document No." := RecAmendmentReq."Amendment No.";
//                     ApprovalEntryArgument."Record ID to Approve" := RecAmendmentReq.RecordId;
//                     ApprovalEntryArgument."Due Date" := WorkDate();
//                     RecRef.GetTable(RecAmendmentReq);
//                 end;
//         end;
//     end;





//     //******************To cancel approval in case of 2nd level***************** 
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Management", 'OnBeforeHandleEventWithxRec', '', false, false)]
//     procedure OnBeforeHandleEventWithxRec(FunctionName: Code[128]; Variant: Variant; xVariant: Variant; VAR IsHandled: Boolean)
//     Var
//         RecAmendmentReq: Record "Amendment Request";
//         RecRef: RecordRef;
//         RecApprovalEntry: Record "Approval Entry";
//         ActionableWorkflowStepInstance: Record "Workflow Step Instance";
//         WorkFlowMgmt: Codeunit "Workflow Management";
//     begin
//         RecRef.GetTable(Variant);
//         if (RecRef.Number = Database::"Amendment Request") AND (FunctionName = RunWorkflowOnCancelApproval_PR()) Then begin
//             IF NOT WorkFlowMgmt.FindEventWorkflowStepInstance(ActionableWorkflowStepInstance, FunctionName, Variant, xVariant) THEN BEGIN
//                 RecAmendmentReq := Variant;
//                 Clear(RecApprovalEntry);
//                 RecApprovalEntry.SetRange("Table ID", Database::"Amendment Request");
//                 RecApprovalEntry.SetRange("Document No.", RecAmendmentReq."Amendment No.");
//                 RecApprovalEntry.SetRange("Record ID to Approve", RecAmendmentReq.RecordId);
//                 RecApprovalEntry.SetFilter(Status, '%1|%2', RecApprovalEntry.Status::Created, RecApprovalEntry.Status::Open);
//                 if RecApprovalEntry.FindSet() then
//                     RecApprovalEntry.ModifyAll(Status, RecApprovalEntry.Status::Canceled);
//                 RecAmendmentReq.Validate("Request Status", RecAmendmentReq."Request Status"::Open);
//                 RecAmendmentReq.Modify();
//                 Variant := RecAmendmentReq;
//                 Message('Amendment approval request has been cancelled.');
//             END;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
//     procedure AddEventsToLibrary()
//     begin
//         WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendApproval_PR(), Database::"Amendment Request", 'Amendment Request approval required', 0, false);
//         WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApproval_PR(), Database::"Amendment Request", 'Amendment cancel request', 0, false);
//     end;

//     //****************Reject***************
//     procedure RunWorkflowOnReject_PR(): Code[128]
//     begin
//         exit('RunWorkflowOnReject_PR');
//     end;
//     //****************Reject End***************



//     //***********************Cancel For Approval Event  Start******************
//     procedure RunWorkflowOnCancelApproval_PR(): Code[128]
//     begin
//         exit('RunWorkflowOnCancelApproval_PR');
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Init Workflow", 'OnCancelApproval_PR', '', true, true)]
//     procedure RunWorkflow_OnCancelApproval_PR(var RecAmendmentReq: Record "Amendment Request")
//     begin
//         WFMngt.HandleEvent(RunWorkflowOnCancelApproval_PR, RecAmendmentReq);
//     end;
//     //***********************End***********************************


//     //*******************************In case of Reject and cancel Approval request**********************
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
//     procedure OnOpenDocument(RecRef: RecordRef; VAR Handled: Boolean)
//     VAR
//         RecAmendmentReq: Record "Amendment Request";
//         Variant: Variant;
//     begin
//         CASE RecRef.NUMBER OF
//             DATABASE::"Amendment Request":
//                 BEGIN
//                     RecRef.SetTable(RecAmendmentReq);
//                     RecAmendmentReq."Request Status" := RecAmendmentReq."Request Status"::Open;
//                     RecAmendmentReq.Modify(true);
//                     Variant := RecAmendmentReq;
//                     RecRef.GetTable(Variant);
//                     Handled := true;
//                 END;
//         end;
//     end;

//     //Code to Open Record from Request to Appprove page//Krishna
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnConditionalCardPageIDNotFound', '', false, false)]
//     local procedure OnConditionalCardPageIDNotFound(RecordRef: RecordRef; VAR CardPageID: Integer)
//     begin
//         CASE RecordRef.NUMBER OF
//             DATABASE::"Amendment Request":
//                 CardPageID := Page::"Amendment Request";
//         end;
//     end;


//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCreateApprovalRequestsOnElseCase', '', false, false)]
//     local procedure OnCreateApprovalRequestsOnElseCase(WorkflowStepArgument: Record "Workflow Step Argument"; var ApprovalEntryArgument: Record "Approval Entry");
//     var
//         ApprovalSetup: Record "Amendment Approval Setup";
//         UserSetup: Record "User Setup";
//         NoWFUserGroupMembersErr: Label 'A workflow user group with at least one member must be set up.';
//         WFUserGroupNotInSetupErr: Label 'The workflow user group member with user ID %1 does not exist in the Approval User Setup window.', Comment = 'The workflow user group member with user ID NAVUser does not exist in the Approval User Setup window.';
//         UserIdNotInSetupErr: Label 'User ID %1 does not exist in the Approval User Setup window.', Comment = 'User ID NAVUser does not exist in the Approval User Setup window.';
//         ApproverId: Code[50];
//         ApprovalMgmt: Codeunit "Approvals Mgmt.";
//         SequenceNo: Integer;
//         ChangeRequest: Record "Amendment Request";
//         SInvHeader: Record "Sales Invoice Header";
//     begin
//         if not (ApprovalEntryArgument."Table ID" = Database::"Amendment Request") then exit;
//         ChangeRequest.GET(ApprovalEntryArgument."Document No.");
//         SInvHeader.GET(ChangeRequest."Document No.");
//         case WorkflowStepArgument."Approver Type" of
//             WorkflowStepArgument."Approver Type"::"Customized Sales Approval":
//                 begin
//                     UserSetup.GET(UserId);
//                     ApprovalSetup.Reset();
//                     ApprovalSetup.SetCurrentKey("Approver Level");
//                     ApprovalSetup.SetRange("Document type", ChangeRequest."Document Type");
//                     ApprovalSetup.SetRange("Amendment Type", ChangeRequest."Amendment Type");
//                     if ApprovalSetup.FindSet() then
//                         repeat
//                             ApprovalSetup.TestField("Approver Type");
//                             if ApprovalSetup."Approver Type" = ApprovalSetup."Approver Type"::User then
//                                 ApproverId := ApprovalSetup."Approver Name"
//                             else
//                                 if ApprovalSetup."Approver Type" = ApprovalSetup."Approver Type"::Salesperson then
//                                     ApproverId := GetSalesPersonUserId(SInvHeader)
//                                 else
//                                     if ApprovalSetup."Approver Type" = ApprovalSetup."Approver Type"::Manager then
//                                         ApproverId := GetManagerUserId(SInvHeader)
//                                     else
//                                         if ApprovalSetup."Approver Type" = ApprovalSetup."Approver Type"::"Posted User" then
//                                             ApproverId := SInvHeader."User ID";

//                             if not UserSetup.Get(ApproverId) then
//                                 Error(WFUserGroupNotInSetupErr, ApproverId);

//                             SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);

//                             if not IsSameApproverId(ApprovalEntryArgument, ApproverId) then
//                                 ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, ApproverId, WorkflowStepArgument);
//                         until ApprovalSetup.Next() = 0;
//                 end;
//         end;
//     end;

//     procedure IsSameApproverId(ApprovalEntryArgument: Record "Approval Entry"; ApproverId: Code[20]) Result: Boolean
//     var
//         ApprovalEntry: Record "Approval Entry";
//     begin
//         Result := false;
//         ApprovalEntry.SetCurrentKey("Record ID to Approve", "Workflow Step Instance ID", "Sequence No.");
//         ApprovalEntry.SetRange("Table ID", ApprovalEntryArgument."Table ID");
//         ApprovalEntry.SetRange("Record ID to Approve", ApprovalEntryArgument."Record ID to Approve");
//         ApprovalEntry.SetRange("Workflow Step Instance ID", ApprovalEntryArgument."Workflow Step Instance ID");
//         ApprovalEntry.SetRange("Approver ID", ApproverId);
//         if ApprovalEntry.FindFirst() then
//             Result := true;
//     end;

//     //To show a popup for approver remarks 

//     [EventSubscriber(ObjectType::Page, Page::"Amendment Request", 'OnBeforeActionEvent', 'Approve', false, false)]
//     local procedure OnBeforeAprove(var Rec: Record "Amendment Request")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         ApproverRemarks: Page "Approver Remarks";
//     begin
//         if not Confirm('Do you want to add Approver Remarks?', false) then exit;
//         clear(ApprovalEntry);
//         ApprovalEntry.SetRange("Table ID", Rec.RecordId.TableNo);
//         ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordID);
//         ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
//         ApprovalEntry.SetRange("Approver ID", UserId);
//         if ApprovalEntry.FindFirst() then begin
//             clear(ApproverRemarks);
//             ApproverRemarks.LookupMode(true);
//             ApproverRemarks.Editable := true;
//             if ApproverRemarks.RunModal() IN [Action::OK, Action::LookupOK] then begin
//                 ApprovalEntry."Approver Remarks" := ApproverRemarks.GetRemarks();
//                 ApprovalEntry.Modify();
//             end else
//                 Error('');
//         end;
//     end;

//     [EventSubscriber(ObjectType::Page, Page::"Amendment Request", 'OnBeforeActionEvent', 'Reject', false, false)]
//     local procedure OnBeforeReject(var Rec: Record "Amendment Request")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         ApproverRemarks: Page "Approver Remarks";
//     begin
//         if not Confirm('Do you want to add Approver Remarks?', false) then exit;
//         clear(ApprovalEntry);
//         ApprovalEntry.SetRange("Table ID", Rec.RecordId.TableNo);
//         ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordID);
//         ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
//         ApprovalEntry.SetRange("Approver ID", UserId);
//         if ApprovalEntry.FindFirst() then begin
//             clear(ApproverRemarks);
//             ApproverRemarks.LookupMode(true);
//             ApproverRemarks.Editable := true;
//             if ApproverRemarks.RunModal() IN [Action::OK, Action::LookupOK] then begin
//                 ApprovalEntry."Approver Remarks" := ApproverRemarks.GetRemarks();
//                 ApprovalEntry.Modify();
//             end else
//                 Error('');
//         end;
//     end;


//     [EventSubscriber(ObjectType::Page, Page::"Requests to Approve", 'OnBeforeActionEvent', 'Approve', false, false)]
//     local procedure OnBeforeApprove_ReqToApprove(var Rec: Record "Approval Entry")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         ApproverRemarks: Page "Approver Remarks";
//     begin
//         if Rec."Table ID" <> Database::"Amendment Request" then exit;
//         if not Confirm('Do you want to add Approver Remarks?', false) then exit;
//         Clear(ApprovalEntry);
//         ApprovalEntry.SetRange("Entry No.", Rec."Entry No.");
//         If ApprovalEntry.FindFirst() then begin
//             clear(ApproverRemarks);
//             ApproverRemarks.LookupMode(true);
//             ApproverRemarks.Editable := true;
//             if ApproverRemarks.RunModal() IN [Action::OK, Action::LookupOK] then begin
//                 ApprovalEntry."Approver Remarks" := ApproverRemarks.GetRemarks();
//                 ApprovalEntry.Modify();
//             end else
//                 Error('');
//         end;
//     end;

//     [EventSubscriber(ObjectType::Page, Page::"Requests to Approve", 'OnBeforeActionEvent', 'Reject', false, false)]
//     local procedure OnBeforeReject_ReqToApprove(var Rec: Record "Approval Entry")
//     var
//         ApprovalEntry: Record "Approval Entry";
//         ApproverRemarks: Page "Approver Remarks";
//     begin
//         if Rec."Table ID" <> Database::"Amendment Request" then exit;
//         if not Confirm('Do you want to add Approver Remarks?', false) then exit;
//         Clear(ApprovalEntry);
//         ApprovalEntry.SetRange("Entry No.", Rec."Entry No.");
//         If ApprovalEntry.FindFirst() then begin
//             clear(ApproverRemarks);
//             ApproverRemarks.LookupMode(true);
//             ApproverRemarks.Editable := true;
//             if ApproverRemarks.RunModal() IN [Action::OK, Action::LookupOK] then begin
//                 ApprovalEntry."Approver Remarks" := ApproverRemarks.GetRemarks();
//                 ApprovalEntry.Modify();
//             end else
//                 Error('');
//         end;
//     end;

//     local procedure GetManagerUserId(var RecSalesHeader: Record "Sales Invoice Header"): Text
//     var
//         RecTeams: Record Team;
//         RecTeamSalesPerson: Record "Team Salesperson";
//         TeamManagerSalesPerson: Record "Team Salesperson";
//         UserSetup: Record "User Setup";
//     begin
//         Clear(RecteamSalesPerson);
//         RecteamSalesPerson.SetRange("Salesperson Code", RecSalesHeader."Salesperson Code");
//         RecteamSalesPerson.FindFirst();
//         Clear(TeamManagerSalesPerson);
//         TeamManagerSalesPerson.SetRange("Team Code", RecTeamSalesPerson."Team Code");
//         TeamManagerSalesPerson.SetRange(Manager, true);
//         TeamManagerSalesPerson.FindFirst();
//         Clear(UserSetup);
//         UserSetup.SetRange("Salespers./Purch. Code", TeamManagerSalesPerson."Salesperson Code");
//         UserSetup.SetFilter("E-Mail", '<>%1', '');
//         if UserSetup.FindFirst() then;
//         exit(UserSetup."User ID");
//     end;

//     local procedure GetSalesPersonUserId(var RecSalesHeader: Record "Sales Invoice Header"): Text
//     var
//         RecTeams: Record Team;
//         RecTeamSalesPerson: Record "Team Salesperson";
//         TeamManagerSalesPerson: Record "Team Salesperson";
//         UserSetup: Record "User Setup";
//     begin
//         RecSalesHeader.TestField("Salesperson Code");
//         Clear(UserSetup);
//         UserSetup.SetRange("Salespers./Purch. Code", RecSalesHeader."Salesperson Code");
//         UserSetup.SetFilter("E-Mail", '<>%1', '');
//         if UserSetup.FindFirst() then;
//         exit(UserSetup."User ID");
//     end;
// }