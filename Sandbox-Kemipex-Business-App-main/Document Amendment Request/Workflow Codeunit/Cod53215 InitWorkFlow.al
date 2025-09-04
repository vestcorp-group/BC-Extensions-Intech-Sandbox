// codeunit 53215 "Init Workflow"//T12370-Full Comment
// {
//     trigger OnRun()
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     procedure OnSendApproval_PR(var RecAmendmentReq: Record "Amendment Request")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     procedure OnCancelApproval_PR(var RecAmendmentReq: Record "Amendment Request")
//     begin
//     end;
//     //Event Creation End

//     local procedure IsWFEnabled_PR(Var RecAmendmentHeader: Record "Amendment Request"): Boolean
//     var
//         WFMngt: Codeunit "Workflow Management";
//         WFCode: Codeunit "Customized Workflow";
//     begin
//         exit(WFMngt.CanExecuteWorkflow(RecAmendmentHeader, WFCode.RunWorkflowOnSendApproval_PR))
//     end;

//     procedure CheckWorkflowEnabled(var RecAmendmentHeader: Record "Amendment Request"): Boolean
//     var
//         NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
//     begin
//         if not IsWFEnabled_PR(RecAmendmentHeader) then
//             Error(NoWorkflowEnb);
//         exit(true);
//     end;


//     var
//         WFMngt: Codeunit "Workflow Management";
//         Text001: TextConst ENU = 'No Workflows Enabled';

// }