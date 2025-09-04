// codeunit 50467 "Kemipex Approval Codeunit"//T12370-Full Comment
// {
//     trigger OnRun()
//     begin

//     end;

//     var
//         myInt: Integer;

//     procedure SendReopenRequest(SalesHeader: Record "Sales Header"; NoteId: Integer; note: Text)
//     var
//         KemipexSetup: Record "Kemipex Setup";
//         KemipexApprovalEntry: Record "Kemipex Approval Entry";
//         OutS: OutStream;

//     begin
//         KemipexApprovalEntry.SetRange("Record ID to Approve", SalesHeader.RecordId);
//         KemipexApprovalEntry.SetRange(Status, KemipexApprovalEntry.Status::Open);
//         if KemipexApprovalEntry.FindFirst() then
//             Error('Reopen Request Sent Already ')
//         else begin
//             KemipexSetup.Get(SalesHeader.CurrentCompany);
//             KemipexApprovalEntry.Init();
//             KemipexApprovalEntry."Document No." := SalesHeader."No.";
//             KemipexApprovalEntry."Document Type" := SalesHeader."Document Type";
//             KemipexApprovalEntry."Table ID" := SalesHeader.RecordId.TableNo;
//             KemipexApprovalEntry."Sequence No." := 1;
//             KemipexApprovalEntry."Sender ID" := UserId;
//             KemipexApprovalEntry."Salespers./Purch. Code" := SalesHeader."Salesperson Code";
//             KemipexApprovalEntry."Approver ID" := KemipexSetup."Sales Order Reopen Approver";
//             KemipexApprovalEntry."Date-Time Sent for Approval" := CurrentDateTime();
//             KemipexApprovalEntry."Last Date-Time Modified" := CurrentDateTime();
//             KemipexApprovalEntry."Last Modified By User ID" := UserId;
//             KemipexApprovalEntry.Status := KemipexApprovalEntry.Status::Open;
//             KemipexApprovalEntry."Approver Type" := KemipexSetup."Sales Doc. Reopen User Type";
//             KemipexApprovalEntry."Record ID to Approve" := SalesHeader.RecordId;
//             // KemipexApprovalEntry."Approval Type" := KemipexApprovalEntry."Approval Type"::"Reopen Request";
//             KemipexApprovalEntry."Related Note" := NoteId;
//             KemipexApprovalEntry."Approval Note".CreateOutStream(OutS, TextEncoding::UTF8);
//             OutS.WriteText(note);
//             KemipexApprovalEntry.Insert();
//             SalesHeader."Reopen Status" := SalesHeader."Reopen Status"::"Reopen Request Pending";
//             SalesHeader.Modify();
//             CreateNotificationEntry(KemipexApprovalEntry);
//             Message('Reopen Request sent');
//         end;
//     end;

//     procedure CancelReopenRequest(SalesHeaderRec: Record "Sales Header")
//     var
//         KMApproval: Record "Kemipex Approval Entry";
//         KMNotification: Record "Kemipex Notification Entry";
//     begin
//         KMApproval.SetRange("Record ID to Approve", SalesHeaderRec.RecordId);
//         KMApproval.SetRange("Approval Type", KMApproval."Approval Type"::"Reopen Request");
//         KMApproval.SetRange(Status, KMApproval.Status::Open);
//         if KMApproval.FindSet() then begin
//             repeat
//                 KMApproval.Status := KMApproval.Status::Canceled;
//                 KMApproval."Last Modified By User ID" := UserId;
//                 if KMApproval.Modify() then begin
//                     KMNotification.SetRange("Approval Entry No.", KMApproval."Entry No.");
//                     KMNotification.SetRange(Handled, false);
//                     if KMNotification.FindSet() then begin
//                     end;
//                 end;
//             until KMApproval.Next() = 0;
//             SalesHeaderRec."Reopen Status" := SalesHeaderRec."Reopen Status"::" ";
//             SalesHeaderRec.Modify();
//         end;
//     end;

//     procedure ApproveSalesDocumentReopen(KMApproval: Record "Kemipex Approval Entry")
//     var
//         // KemipexApprovalEntry: Record "Kemipex Approval Entry";
//         ReleaseSalesDoc: Codeunit "Release Sales Document";
//         SalesHeaderRec: Record "Sales Header";
//     begin
//         SalesHeaderRec.Get(KMApproval."Record ID to Approve");
//         ReleaseSalesDoc.PerformManualReopen(SalesHeaderRec);
//         SalesHeaderRec."Reopen Status" := SalesHeaderRec."Reopen Status"::"Reopen Request Approved";
//         SalesHeaderRec.Modify();
//         KMApproval.Status := KMApproval.Status::Approved;
//         KMApproval."Last Modified By User ID" := UserId;
//         KMApproval.Modify();
//     end;

//     procedure RejectSalesDocumentReopen(KMApproval: Record "Kemipex Approval Entry")
//     var
//         ReleaseSalesDoc: Codeunit "Release Sales Document";
//         SalesHeaderRec: Record "Sales Header";
//     begin
//         SalesHeaderRec.Get(KMApproval."Record ID to Approve");
//         SalesHeaderRec."Reopen Status" := SalesHeaderRec."Reopen Status"::"Reopen Request Rejected";
//         SalesHeaderRec.Modify();
//         KMApproval.Status := KMApproval.Status::Rejected;
//         KMApproval."Last Modified By User ID" := UserId;
//         KMApproval.Modify();
//     end;

//     procedure GetuserGroupFilter() FilterString: Text;
//     var
//         WorkflowUsergroupMember: Record "Workflow User Group Member";
//     begin

//         WorkflowUsergroupMember.SetRange("User Name", UserId);
//         if WorkflowUsergroupMember.FindSet() then begin
//             repeat
//                 FilterString += WorkflowUsergroupMember."Workflow User Group Code";
//                 FilterString += '|';
//             until WorkflowUsergroupMember.Next() = 0;
//         end;
//         FilterString += UserId;
//         exit(FilterString);
//     end;

//     procedure CanSendKMapproval(RecID: RecordId; ApprovalType: Enum "Approval Type") Result: Boolean;
//     var
//         KMapprovalEntry: Record "Kemipex Approval Entry";
//     begin
//         KMapprovalEntry.SetRange("Record ID to Approve", RecID);
//         KMapprovalEntry.SetRange(Status, KMapprovalEntry.Status::Open);
//         KMapprovalEntry.SetRange("Approval Type", ApprovalType);
//         Result := not KMapprovalEntry.FindFirst();
//     end;

//     procedure CanCancelKMApproval(RecID: RecordId; ApprovalTypeenum: Enum "Approval Type") Result: Boolean
//     var
//         KMapprovalEntry: Record "Kemipex Approval Entry";
//     begin
//         KMapprovalEntry.SetRange("Record ID to Approve", RecID);
//         KMapprovalEntry.SetRange(Status, KMapprovalEntry.Status::Open);
//         KMapprovalEntry.SetRange("Approval Type", ApprovalTypeenum);
//         Result := KMapprovalEntry.FindFirst();
//     end;

//     procedure ApprovalSender(RecId: RecordId) UserID: Code[50];
//     var
//         KMapproval: Record "Kemipex Approval Entry";
//     begin
//         KMapproval.SetRange("Record ID to Approve", RecId);
//         KMapproval.SetRange(Status, KMapproval.Status::Open);
//         if KMapproval.FindFirst() then UserID := KMapproval."Sender ID";
//     end;

//     procedure OpenApprovalExists(recID: RecordId; ApprovalTypeenum: Enum "Approval Type") result: Boolean;
//     var
//         KemipexApprovalEntry: Record "Kemipex Approval Entry";
//     begin
//         KemipexApprovalEntry.SetRange("Record ID to Approve", recID);
//         KemipexApprovalEntry.SetRange("Approval Type", ApprovalTypeenum);
//         KemipexApprovalEntry.SetRange(Status, KemipexApprovalEntry.Status::Open);
//         result := KemipexApprovalEntry.FindFirst();
//     end;

//     procedure CreateNotificationEntry(var KMApprovalEntry: Record "Kemipex Approval Entry")
//     var
//         WorkflowusergroupRec: Record "Workflow User Group Member";
//         KMNotificationEntryRec: Record "Kemipex Notification Entry";
//         IDNo: Integer;
//     begin
//         if KMApprovalEntry."Approver Type" = KMApprovalEntry."Approver Type"::"User Group" then begin
//             WorkflowusergroupRec.SetRange("Workflow User Group Code", KMapprovalEntry."Approver ID");
//             if WorkflowusergroupRec.FindSet() then
//                 repeat
//                     KMNotificationEntryRec.Ascending();
//                     if KMNotificationEntryRec.FindLast() then begin
//                         IDNo := KMNotificationEntryRec.ID;
//                     end;
//                     KMNotificationEntryRec.Reset();
//                     KMNotificationEntryRec.Init();
//                     KMNotificationEntryRec.ID := IDNo + 1;
//                     KMNotificationEntryRec."Recipient User ID" := WorkflowusergroupRec."User Name";
//                     KMNotificationEntryRec."Triggered By Record" := KMApprovalEntry."Record ID to Approve";
//                     KMNotificationEntryRec."Sender User ID" := KMApprovalEntry."Sender ID";
//                     KMNotificationEntryRec."Approval Entry No." := KMApprovalEntry."Entry No.";
//                     KMNotificationEntryRec.Insert();
//                 until WorkflowusergroupRec.Next() = 0;
//         end
//         else begin
//             KMNotificationEntryRec.Init();
//             KMNotificationEntryRec."Recipient User ID" := KMApprovalEntry."Approver ID";
//             KMNotificationEntryRec."Triggered By Record" := KMApprovalEntry."Record ID to Approve";
//             KMNotificationEntryRec."Sender User ID" := KMApprovalEntry."Sender ID";
//             KMNotificationEntryRec."Approval Entry No." := KMApprovalEntry."Entry No.";
//             KMNotificationEntryRec.Insert();
//         end;
//     end;









// }

// // procedure SendKemipexApprovalNotification(var KMapprovalEntry: Record "Kemipex Approval Entry")
// // var
// //     WorkflowusergroupRec: Record "Workflow User Group Member";
// //     Subject: Text;
// // begin
// //     Subject := 'Reopen Request for Sales Order No. ' + KMapprovalEntry."Document No.";
// //     if KMapprovalEntry."Approver Type" = KMapprovalEntry."Approver Type"::User then begin
// //         SendReopenRequestEmail(KMapprovalEntry."Approver ID", Subject, KMapprovalEntry."Entry No.");
// //     end
// //     else
// //         if KMapprovalEntry."Approver Type" = KMapprovalEntry."Approver Type"::"User Group" then begin
// //             WorkflowusergroupRec.SetRange("Workflow User Group Code", KMapprovalEntry."Approver ID");
// //             if WorkflowusergroupRec.FindSet() then
// //                 repeat
// //                     SendReopenRequestEmail(WorkflowusergroupRec."User Name", Subject, KMapprovalEntry."Entry No.");
// //                 until WorkflowusergroupRec.Next() = 0;
// //         end;
// // end;
// // procedure SendReopenRequestEmail(User_Id: Code[20]; Subject: Text; ApprovalEntryNo: Integer)
// // var
// //     Mail: Codeunit "Email Message";
// //     Email: Codeunit Email;
// //     InS: InStream;
// //     OutS: OutStream;
// //     UserSetup: Record "User Setup";
// //     RecRef: RecordRef;
// //     FRef: FieldRef;
// //     tempBlob: Codeunit "Temp Blob";
// //     Body: Text;
// //     Notificatiomail: Report "Notification Email";
// // begin
// //     UserSetup.Get(User_Id);
// //     tempBlob.CreateOutStream(OutS);
// //     RecRef.Open(Database::"Kemipex Approval Entry");
// //     FRef := RecRef.Field(29);
// //     FRef.SetRange(ApprovalEntryNo);
// //     Report.SaveAs(50478, '', ReportFormat::Html, OutS, RecRef);
// //     tempBlob.CreateInStream(InS);
// //     InS.ReadText(Body);
// //     Mail.Create(UserSetup."E-Mail", Subject, Body, true);
// //     Email.Send(Mail);
// // end;