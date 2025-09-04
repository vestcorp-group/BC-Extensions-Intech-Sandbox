// codeunit 50480 "KM Notification Dispatcher"//T12370-Full Comment
// {
//     trigger OnRun()
//     begin
//         KemipexNotificationBatch();
//     end;

//     procedure KemipexNotificationBatch()
//     var
//         KMnotificationEntryRec: Record "Kemipex Notification Entry";
//     begin
//         KMnotificationEntryRec.SetRange(Handled, false);
//         if KMnotificationEntryRec.FindSet() then begin
//             repeat
//                 SendNotification(KMnotificationEntryRec);
//             until KMnotificationEntryRec.Next() = 0;
//         end;
//     end;

//     procedure SendNotification(KMNotificationEntry: Record "Kemipex Notification Entry")
//     var
//         Mail: Codeunit "Email Message";
//         Email: Codeunit Email;
//         InS: InStream;
//         OutS: OutStream;
//         UserSetup: Record "User Setup";
//         RecRef: RecordRef;
//         FRef: FieldRef;
//         tempBlob: Codeunit "Temp Blob";
//         Body: Text;
//         KMApprovalEntryRec: Record "Kemipex Approval Entry";
//         Subject: Text;
//     begin
//         KMApprovalEntryRec.Get(KMNotificationEntry."Approval Entry No.");
//         if KMApprovalEntryRec."Approval Type" = "Approval Type"::"Reopen Request" then Subject := 'Reopen Request Sales Order No. ' + KMApprovalEntryRec."Document No.";
//         UserSetup.Get(KMNotificationEntry."Recipient User ID");
//         tempBlob.CreateOutStream(OutS);
//         RecRef.Open(Database::"Kemipex Notification Entry");
//         FRef := RecRef.Field(1);
//         FRef.SetRange(KMNotificationEntry.ID);
//         Report.SaveAs(50478, '', ReportFormat::Html, OutS, RecRef);
//         tempBlob.CreateInStream(InS);
//         InS.ReadText(Body);
//         Mail.Create(UserSetup."E-Mail", Subject, Body, true);
//         Email.Send(Mail);
//         KMNotificationEntry.Handled := true;
//         KMNotificationEntry.Modify();
//     end;

//     // procedure SendReopenRequestEmail2(User_Id: Code[20]; Subject: Text; ApprovalEntryNo: Integer)
//     // var
//     //     Mail: Codeunit "Email Message";
//     //     Email: Codeunit Email;
//     //     InS: InStream;
//     //     OutS: OutStream;
//     //     UserSetup: Record "User Setup";
//     //     RecRef: RecordRef;
//     //     FRef: FieldRef;
//     //     tempBlob: Codeunit "Temp Blob";
//     //     Body: Text;
//     //     Notificatiomail: Report "Notification Email";
//     // begin
//     //     UserSetup.Get(User_Id);
//     //     tempBlob.CreateOutStream(OutS);
//     //     RecRef.Open(Database::"Kemipex Approval Entry");
//     //     FRef := RecRef.Field(29);
//     //     FRef.SetRange(ApprovalEntryNo);
//     //     Report.SaveAs(50478, '', ReportFormat::Html, OutS, RecRef);
//     //     tempBlob.CreateInStream(InS);
//     //     InS.ReadText(Body);
//     //     Mail.Create(UserSetup."E-Mail", Subject, Body, true);
//     //     Email.Send(Mail);
//     // end;

//     var
//         JObq: Codeunit "Job Queue Management";
// }