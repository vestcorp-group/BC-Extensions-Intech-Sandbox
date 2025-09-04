// codeunit 50351 KMUserTaskCodeunit//T12370-Full Comment
// {
//     trigger OnRun()
//     begin
//     end;

//     [EventSubscriber(ObjectType::Table, Database::"User Task", 'OnAfterInsertEvent', '', true, true)]
//     local procedure ValidateID2(var Rec: Record "User Task")
//     var
//         // userremark: Record "Sales Remark";
//         Salescomments: Record "Sales Comment Line";
//         salesCommentpage: Page "Sales Comment Sheet";
//         NoSeriesMngmt: Codeunit NoSeriesManagement;
//         UsertaskSetup: Record "User Task Setup";
//     begin
//         rec.ID2 := Format(rec.ID);
//         Rec.Modify();
//         UsertaskSetup.Get();
//         if UsertaskSetup."User Task No Series" <> '' then begin
//             NoSeriesMngmt.SetDefaultSeries(Rec."Task Document No", UsertaskSetup."User Task No Series");
//             Rec."Task Document No" := NoSeriesMngmt.GetNextNo(UsertaskSetup."User Task No Series", WorkDate(), true);
//         end
//         else
//             Error('User Task No. Series required in User Task Setup');

//     end;

//     procedure GetMyPendingApprovaltask(User: Code[50]) MyCount: Integer;
//     var
//         Usertask: Record "User Task";
//     begin
//         Usertask.SetRange("Assigned To User Name", User);
//         Usertask.SetFilter("Approval Status", '%1|%2', Usertask."Approval Status"::Delegated, Usertask."Approval Status"::"Pending Approval");
//         if Usertask.FindSet() then
//             MyCount := Usertask.Count;
//         exit(MyCount);
//     end;

//     procedure GetMyApprovedtask(User: Code[50]) MyCount: Integer;
//     var
//         Usertask: Record "User Task";
//     begin
//         Usertask.SetRange("Assigned To User Name", User);
//         Usertask.SetRange("Approval Status", Usertask."Approval Status"::Approved);
//         if Usertask.FindSet() then
//             MyCount := Usertask.Count;
//         exit(MyCount);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', true, true)]
//     local procedure Substitute(ReportId: Integer; var NewReportId: Integer)
//     begin
//         if ReportId = 1320 then NewReportId := 50425;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Notification Management", 'OnGetDocumentTypeAndNumber', '', true, true)]
//     local procedure GetUserTaskDocNoforNotification(var DocumentNo: Text; var DocumentType: Text; var RecRef: RecordRef; var IsHandled: Boolean)
//     var
//         FRef: FieldRef;
//     begin

//         case RecRef.Number of
//             database::"User Task":
//                 begin
//                     IsHandled := true;
//                     DocumentType := RecRef.Caption;
//                     FRef := RecRef.Field(50105);
//                     DocumentNo := Format(FRef.Value);
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Report, Report::"Notification Email 2", 'OnBeforeGetDocumentTypeAndNumber', '', true, true)]
//     local procedure SetDocumentTypeforNotificationMail(var DocumentNo: Text; var DocumentType: Text; var IsHandled: Boolean; var RecRef: RecordRef)
//     var
//         FRef: FieldRef;
//     begin
//         if RecRef.Number = Database::"User Task" then begin
//             IsHandled := true;
//             DocumentType := RecRef.Caption;
//             FRef := RecRef.Field(50105);
//             DocumentNo := Format(FRef.Value);
//         end;
//     end;
// }