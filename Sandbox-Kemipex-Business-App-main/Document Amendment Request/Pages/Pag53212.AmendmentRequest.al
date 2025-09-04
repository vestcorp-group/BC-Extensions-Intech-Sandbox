// page 53212 "Amendment Request"//T12370-Full Comment
// {
//     Caption = 'Amendment Request';
//     PageType = Card;
//     SourceTable = "Amendment Request";
//     PromotedActionCategories = 'New,Process,Report,Request Approval,Print/Send,Approve,Related';

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("Request No."; Rec."Amendment No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Request No. field.';
//                 }
//                 field("Document Type"; Rec."Document Type")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Document Type field.';
//                 }
//                 field("Document No."; Rec."Document No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Document No. field.';
//                 }
//                 field("Customer Name"; Rec."Customer Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Invoice Date"; Rec."Invoice Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Amendment Type"; Rec."Amendment Type")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Amendment Type field.';
//                     Editable = false;
//                 }
//                 field("Request Status"; Rec."Request Status")
//                 {
//                     ApplicationArea = All;
//                     StyleExpr = StyleText;
//                     Editable = false;
//                     ToolTip = 'Specifies the value of the Request Status field.';
//                 }
//                 field(Requester; Rec.Requester)
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Requester field.';
//                 }
//                 field("Requested DateTime"; Rec."Requested DateTime")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Requested DateTime field.';
//                 }
//                 group(AmendmentRemarks)
//                 {
//                     Caption = 'User Comment';
//                     field(AmendmentRemark; AmendmentRemarks)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Importance = Additional;
//                         MultiLine = true;
//                         ShowCaption = false;
//                         Enabled = UserRemarks;
//                         //Editable =;
//                         ToolTip = 'Specifies the products or service being offered.';
//                         trigger OnValidate()
//                         begin
//                             Rec.SetAmendmentRemarks(AmendmentRemarks);
//                         end;
//                     }
//                 }
//                 group(ApprovalRemarks)
//                 {
//                     Visible = false;
//                     Caption = 'Approval Remarks';
//                     field(ApprovalRemark; ApprovalRemarks)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Importance = Additional;
//                         MultiLine = true;
//                         ShowCaption = false;
//                         ToolTip = 'Specifies the products or service being offered.';
//                         // Enabled = HasOpenEntriesForCurrUser;
//                         Visible = false;
//                         trigger OnValidate()
//                         begin
//                             Rec.SetApprovalRemarks(ApprovalRemarks);
//                         end;
//                     }
//                 }
//             }
//             part(RequestLines; "Amendment Request Line")
//             {
//                 Caption = 'Request Lines';
//                 ApplicationArea = all;
//                 SubPageLink = "Amendment No." = field("Amendment No."), "Document Type" = field("Document Type"), "Document No." = field("Document No.");
//                 Enabled = (Rec."Request Status" = Rec."Request Status"::Open) AND IsRequester;
//                 Editable = (Rec."Request Status" = Rec."Request Status"::Open) AND IsRequester;
//             }

//             part(Remarks; "Amendment Remarks")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Remarks';
//                 SubPageLink = "Amendment No." = field("Amendment No.");
//                 Enabled = (Rec."Request Status" = Rec."Request Status"::Open) AND IsRequester;
//                 Editable = (Rec."Request Status" = Rec."Request Status"::Open) AND IsRequester;
//             }
//         }
//     }
//     actions
//     {
//         area(Processing)
//         {
//             // group(Approval)
//             // {
//             //     Caption = 'Approval';
//             // action(SendApprovalRequest)
//             // {
//             //     Caption = 'Send Approval Request';
//             //     Image = SendApprovalRequest;
//             //     ApplicationArea = all;
//             //     Enabled = IsRequester;
//             //     Visible = IsRequester;

//             //     trigger OnAction()
//             //     var
//             //         cuChangeApprovalMgt: Codeunit "Amendment Approval Mgt";
//             //     begin
//             //         Rec.TestField("Request Status", Rec."Request Status"::Open);
//             //         if not Confirm('Do you want to send approval request?', false) then exit;
//             //         cuChangeApprovalMgt.SendApprovalRequest(Rec);
//             //         Message('Approval request sent successfully.');
//             //         CurrPage.Update();
//             //     end;
//             // }
//             // action(ApproveRequest)
//             // {
//             //     Caption = 'Approve';
//             //     Image = Approve;
//             //     ApplicationArea = all;
//             //     Visible = HasOpenEntriesForCurrUser;

//             //     trigger OnAction()
//             //     var
//             //         cuChangeApprovalMgt: Codeunit "Amendment Approval Mgt";
//             //     begin
//             //         Rec.TestField("Request Status", Rec."Request Status"::"Sent for Approval");
//             //         if not Confirm('Do you want to approve request?', false) then exit;
//             //         cuChangeApprovalMgt.ApproveRequest(Rec);
//             //         Message('Request approved successfully.');
//             //         CurrPage.Update();
//             //     end;
//             // }
//             // action(RejectRequest)
//             // {
//             //     Caption = 'Reject';
//             //     Image = Reject;
//             //     ApplicationArea = all;
//             //     Visible = HasOpenEntriesForCurrUser;

//             //     trigger OnAction()
//             //     var
//             //         cuChangeApprovalMgt: Codeunit "Amendment Approval Mgt";
//             //     begin
//             //         Rec.TestField("Request Status", Rec."Request Status"::"Sent for Approval");
//             //         if not Confirm('Do you want to reject request?', false) then exit;
//             //         cuChangeApprovalMgt.RejectRequest(Rec);
//             //         Message('Request rejected successfully.');
//             //         CurrPage.Update();
//             //     end;
//             // }
//             // action(CancelApproveRequest)
//             // {
//             //     Caption = 'Cancel Approval Request';
//             //     Image = CancelApprovalRequest;
//             //     ApplicationArea = all;
//             //     Enabled = IsRequester;
//             //     Visible = IsRequester;

//             //     trigger OnAction()
//             //     var
//             //         cuChangeApprovalMgt: Codeunit "Amendment Approval Mgt";
//             //     begin
//             //         Rec.TestField("Request Status", Rec."Request Status"::"Sent for Approval");
//             //         if not Confirm('Do you want to cancel approval request?', false) then exit;
//             //         cuChangeApprovalMgt.CancelRequest(Rec);
//             //         Message('Approval request cancelled successfully.');
//             //         CurrPage.Update();
//             //     end;
//             // }
//             // }

//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 action("Send Approval Request")
//                 {
//                     Caption = 'Send Approval Request';
//                     Enabled = IsSendRequest;
//                     Image = SendApprovalRequest;
//                     ApplicationArea = All;
//                     Promoted = true;
//                     PromotedCategory = New;
//                     PromotedOnly = true;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         WfInitCode: Codeunit "Init Workflow";
//                         AdvanceWorkflowCUL: Codeunit "Customized Workflow";
//                     begin
//                         Rec.TestField("Request Status", Rec."Request Status"::Open);
//                         if WfInitCode.CheckWorkflowEnabled(Rec) then begin
//                             WfInitCode.OnSendApproval_PR(Rec);
//                         end;
//                         //SetControl();
//                     end;
//                 }

//                 action("Cancel Approval Request")
//                 {
//                     Caption = 'Cancel Approval Request';
//                     Enabled = (IsCancel AND IsRequester AND (NOT OpenApprovalEntriesExistForCurrUser));
//                     ApplicationArea = All;
//                     Image = CancelApprovalRequest;
//                     Promoted = true;
//                     PromotedOnly = true;
//                     PromotedCategory = New;

//                     trigger OnAction()
//                     var
//                         InitWf: Codeunit "Init Workflow";
//                     begin
//                         Rec.TestField("Request Status", Rec."Request Status"::"Pending Approval");
//                         InitWf.OnCancelApproval_PR(Rec);
//                         //SetControl();
//                     end;
//                 }
//             }
//             group(Approval)
//             {
//                 Caption = 'Approval';
//                 action(Approve)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Approve';
//                     Image = Approve;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     PromotedOnly = true;
//                     ToolTip = 'Approve the requested changes.';
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
//                     end;
//                 }
//                 action(Reject)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Reject';
//                     Image = Reject;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     PromotedOnly = true;
//                     ToolTip = 'Reject to approve the incoming document.';
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
//                     end;
//                 }
//                 action(Delegate)
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedOnly = true;
//                     ToolTip = 'Delegate the approval to a substitute approver.';
//                     Visible = false;// OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
//                     end;
//                 }

//                 action(Approvals)
//                 {
//                     AccessByPermission = TableData "Approval Entry" = R;
//                     ApplicationArea = Suite;
//                     Caption = 'Approvals';
//                     Image = Approvals;
//                     Promoted = true;
//                     PromotedOnly = true;
//                     PromotedCategory = Process;
//                     ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.RunWorkflowEntriesPage(Rec.RecordId(), DATABASE::"Amendment Request", Enum::"Approval Document Type"::" ", Rec."Amendment No.");
//                     end;
//                 }
//             }
//             action(ApplyChanges)
//             {
//                 Caption = 'Apply Changes';
//                 Image = Apply;
//                 ApplicationArea = all;

//                 trigger OnAction()
//                 var
//                     cuChangeReqMgt: Codeunit "Amendment Management";
//                 begin
//                     Rec.TestField(Requester, UserId);
//                     if Rec."Request Status" IN [Rec."Request Status"::Approved, Rec."Request Status"::Closed] then
//                         if Rec."Amendment Type" <> Rec."Amendment Type"::"Invoice Modification" then
//                             Error('Amendment Request has been approved successfully. Please do the %1', Rec."Amendment Type");

//                     Rec.TestField(Rec."Request Status", Rec."Request Status"::Approved);
//                     if not Confirm('Do you want to apply the changes?', false) then exit;
//                     cuChangeReqMgt.ApplyChangeRequest(Rec);
//                     CurrPage.Update();
//                     Message('Changes applied successfully.');
//                     CurrPage.Update();
//                 end;
//             }
//         }
//         area(Navigation)
//         {
//             action(ApprovalEntries)
//             {
//                 Caption = 'Approval Entries';
//                 Image = Approvals;
//                 Visible = false;
//                 ApplicationArea = all;
//                 RunObject = page "Amendment Approval Entries";
//                 RunPageLink = "Amendment No." = field("Amendment No."), "Document Type" = const("Posted Sales Invoice"), "Document No." = field("Document No.");
//                 RunPageMode = View;
//             }
//         }
//     }
//     var
//         recGenLedSetup: Record "General Ledger Setup";
//         recChangeLine: Record "Amendment Request Line";
//         AmendmentRemarks: Text;
//         ApprovalRemarks: Text;
//         ReadingDataSkippedMsg: Label 'Loading field %1 will be skipped because there was an error when reading the data.\To fix the current data, contact your administrator.\Alternatively, you can overwrite the current data by entering data in the field.', Comment = '%1=field caption';
//         //HasOpenEntriesForCurrUser: Boolean;
//         //ApprovalMgmt: Codeunit "Amendment Approval Mgt";
//         IsRequester: Boolean;
//         //New Variables
//         IsSendRequest: Boolean;
//         PageEditable: Boolean;
//         IsCancel: Boolean;
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         StyleText: Text;
//         SetEditable: Boolean;
//         UserRemarks: Boolean;

//     trigger OnOpenPage()
//     begin
//         recGenLedSetup.Get();
//         recGenLedSetup.TestField("Enable Amendment Request Mgmt");
//         //HasOpenEntriesForCurrUser := ApprovalMgmt.HasOpenApprovalEntries(Rec);
//         //IsRequester := Rec.Requester = UserId;
//         SetControl();
//         if (Rec."Request Status" = Rec."Request Status"::Approved) OR (Rec."Request Status" = Rec."Request Status"::Closed) then begin
//             CurrPage.Editable := false;
//             // IsRequester := false;
//             // HasOpenEntriesForCurrUser := false;
//         end else
//             if Rec."Request Status" = Rec."Request Status"::"Pending Approval" then begin
//                 if Rec.Requester = UserId then begin
//                     CurrPage.Editable := true;
//                 end
//                 else begin
//                     CurrPage.Editable := false;
//                 end;

//             end else
//                 if Rec."Request Status" = Rec."Request Status"::Open then begin
//                     if Rec.Requester = UserId then begin
//                         CurrPage.Editable := true;
//                     end
//                     else begin
//                         CurrPage.Editable := false;
//                     end;

//                 end;
//         // else
//         //     CurrPage.Editable := false;

//     end;

//     trigger OnAfterGetRecord()
//     begin
//         AmendmentRemarks := Rec.GetAmendmentRemarks();
//         ApprovalRemarks := Rec.GetApprovalRemarks();
//         SetControl();
//     end;





//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         SetControl();
//     end;


//     local procedure SetControl()
//     var
//         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     begin
//         OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
//         if (Rec."Request Status" = Rec."Request Status"::Open) AND (Rec.Requester = UserId) then begin
//             IsSendRequest := true;
//             IsCancel := false;
//             PageEditable := true;
//             StyleText := '';
//             IsRequester := Rec.Requester = UserId;
//             UserRemarks := true;
//         end else
//             if Rec."Request Status" = Rec."Request Status"::"Pending Approval" then begin
//                 IsSendRequest := false;
//                 UserRemarks := false;
//                 IsCancel := true;
//                 PageEditable := false;
//                 StyleText := 'Ambiguous';
//                 IsRequester := Rec.Requester = UserId;
//             end else begin
//                 IsSendRequest := false;
//                 IsCancel := false;
//                 PageEditable := false;
//                 StyleText := 'Favorable';
//                 IsRequester := false;
//                 UserRemarks := false;
//             end;
//         CurrPage.Update(false);
//     end;
// }
