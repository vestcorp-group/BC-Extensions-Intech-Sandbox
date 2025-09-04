// codeunit 53211 "Amendment Approval Mgt"//T12370-Full Comment
// {
//     procedure SendApprovalRequest(var Rec: Record "Amendment Request")
//     var
//     begin
//         TestApprovalSetup(Rec);
//         CreateApprovalRequestEntries(Rec);
//         SendForApprovalMail(Rec);

//         Rec."Request Status" := Rec."Request Status"::"Pending Approval";
//         Rec.Modify(true);
//     end;

//     procedure ApproveRequest(var Rec: Record "Amendment Request")
//     var
//         cuChangeReqMgt: Codeunit "Amendment Management";
//     begin
//         CheckOpenApprovalEntriesforApprover(Rec);
//         ApproveRequestEntries(Rec);

//         if CompletelyApproved(Rec) then begin
//             Rec."Request Status" := rec."Request Status"::Approved;
//             Rec."Approved Date Time" := CurrentDateTime;
//             Rec.Modify(true);
//             cuChangeReqMgt.ApplyChangeRequest(Rec);//to automate the aply changes
//         end;
//     end;

//     procedure RejectRequest(var Rec: Record "Amendment Request")
//     begin
//         CheckOpenApprovalEntriesforApprover(Rec);
//         //ApproveRequestEntries(Rec);
//         RejectRequestEntries(Rec);

//         Rec."Request Status" := rec."Request Status"::Open;
//         Rec.Modify(true);
//     end;

//     procedure CancelRequest(var Rec: Record "Amendment Request")
//     begin
//         CancelequestEntries(Rec);

//         Rec."Request Status" := Rec."Request Status"::Open;
//         Rec.Modify(true);
//     end;

//     local procedure CompletelyApproved(ChangeRequest: Record "Amendment Request"): Boolean
//     var
//         ApprovalEntries: Record "Amendment Approval Entries";
//     begin
//         ApprovalEntries.Reset();
//         ApprovalEntries.SetRange("Amendment No.", ChangeRequest."Amendment No.");
//         ApprovalEntries.SetRange("Document Type", ChangeRequest."Document Type");
//         ApprovalEntries.SetRange("Document No.", ChangeRequest."Document No.");
//         ApprovalEntries.SetRange("Approval Request Status", ApprovalEntries."Approval Request Status"::Open);
//         exit(ApprovalEntries.IsEmpty);
//     end;

//     local procedure TestApprovalSetup(ChangeRequest: Record "Amendment Request")
//     var
//         ApprovalSetup: Record "Amendment Approval Setup";
//         userSetup: Record "User Setup";
//     begin
//         userSetup.GET(UserId);
//         userSetup.TestField("E-Mail");

//         ApprovalSetup.Reset();
//         ApprovalSetup.SetRange("Document type", ChangeRequest."Document Type");
//         ApprovalSetup.SetRange("Amendment Type", ChangeRequest."Amendment Type");
//         //ApprovalSetup.SetRange("Requester Name", UserId);
//         if ApprovalSetup.FindSet() then
//             repeat
//                 //ApprovalSetup.TestField("Requester E-Mail");
//                 ApprovalSetup.TestField("Approver Name");
//                 ApprovalSetup.TestField("Approver E-Mail");
//                 ApprovalSetup.TestField("Approver Level");
//             until ApprovalSetup.Next() = 0
//         else
//             Error('There is no approval setup defined for Document Type %1', ApprovalSetup."Document type"::"Posted Sales Invoice");

//         // begin
//         //     ApprovalSetup.SetRange("Requester Name");
//         //     ApprovalSetup.SetRange("Requester Name", '');
//         //     if ApprovalSetup.FindSet() then
//         //         repeat
//         //             ApprovalSetup.TestField("Approver Name");
//         //             ApprovalSetup.TestField("Approver E-Mail");
//         //             ApprovalSetup.TestField("Approver Level");
//         //         until ApprovalSetup.Next() = 0
//         //     else
//         //         Error('There is no approval setup defined for Document Type %1', ApprovalSetup."Document type"::"Posted Sales Invoice");
//         // end;
//     end;

//     local procedure CreateApprovalRequestEntries(ChangeRequest: Record "Amendment Request")
//     var
//         ApprovalSetup: Record "Amendment Approval Setup";
//         recApprovalReqEntries: record "Amendment Approval Entries";
//         UserSetup: Record "User Setup";
//     begin
//         UserSetup.GET(UserId);
//         ApprovalSetup.Reset();
//         ApprovalSetup.SetCurrentKey("Approver Level");
//         ApprovalSetup.SetRange("Document type", ChangeRequest."Document Type");
//         ApprovalSetup.SetRange("Amendment Type", ChangeRequest."Amendment Type");
//         //ApprovalSetup.SetRange("Requester Name", UserId);
//         if ApprovalSetup.FindSet() then
//             repeat
//                 recApprovalReqEntries.Init();
//                 recApprovalReqEntries."Entry No." := recApprovalReqEntries.GetNextEntryNo();
//                 recApprovalReqEntries."Document Type" := ChangeRequest."Document Type";
//                 recApprovalReqEntries."Document No." := ChangeRequest."Document No.";
//                 recApprovalReqEntries."Amendment No." := ChangeRequest."Amendment No.";
//                 recApprovalReqEntries."Requester Name" := UserId;// ApprovalSetup."Requester Name";
//                 recApprovalReqEntries."Approver Name" := ApprovalSetup."Approver Name";
//                 recApprovalReqEntries."Approval Submit DateTime" := CurrentDateTime;
//                 recApprovalReqEntries."Approval Sequence" := ApprovalSetup."Approver Level";
//                 recApprovalReqEntries."Requester E-Mail" := UserSetup."E-Mail";// ApprovalSetup."Requester E-Mail";
//                 recApprovalReqEntries."Approver E-Mail" := ApprovalSetup."Approver E-Mail";
//                 recApprovalReqEntries."Approval Request Status" := recApprovalReqEntries."Approval Request Status"::Open;
//                 recApprovalReqEntries."Amendment Type" := ChangeRequest."Amendment Type";
//                 recApprovalReqEntries.Insert(true);
//             until ApprovalSetup.Next() = 0
//         // else begin
//         //     ApprovalSetup.SetRange("Requester Name");
//         //     ApprovalSetup.SetRange("Requester Name", '');
//         //     ApprovalSetup.FindSet();
//         //     repeat
//         //         recApprovalReqEntries.Init();
//         //         recApprovalReqEntries."Entry No." := recApprovalReqEntries.GetNextEntryNo();
//         //         recApprovalReqEntries."Document Type" := ChangeRequest."Document Type";
//         //         recApprovalReqEntries."Document No." := ChangeRequest."Document No.";
//         //         recApprovalReqEntries."Request No." := ChangeRequest."Request No.";
//         //         recApprovalReqEntries."Requester Name" := UserId;
//         //         recApprovalReqEntries."Requester E-Mail" := ApprovalSetup."Requester E-Mail";
//         //         recApprovalReqEntries."Approver Name" := ApprovalSetup."Approver Name";
//         //         recApprovalReqEntries."Approver E-Mail" := ApprovalSetup."Approver E-Mail";
//         //         recApprovalReqEntries."Approval Submit DateTime" := CurrentDateTime;
//         //         recApprovalReqEntries."Approval Sequence" := ApprovalSetup."Approver Level";
//         //         recApprovalReqEntries."Approval Request Status" := recApprovalReqEntries."Approval Request Status"::Open;
//         //         recApprovalReqEntries.Insert(true);
//         //     until ApprovalSetup.Next() = 0;
//         // end;
//     end;

//     local procedure CheckOpenApprovalEntriesforApprover(var ChangeRequest: Record "Amendment Request")
//     var
//         recApprovalReqEntries: record "Amendment Approval Entries";
//         recAppreqEntries: Record "Amendment Approval Entries";
//     begin
//         recApprovalReqEntries.Reset();
//         recApprovalReqEntries.SetCurrentKey("Approval Sequence");
//         recApprovalReqEntries.SetRange("Document Type", ChangeRequest."Document Type");
//         recApprovalReqEntries.SetRange("Document No.", ChangeRequest."Document No.");
//         recApprovalReqEntries.SetRange("Approver Name", UserId);
//         recApprovalReqEntries.SetRange("Approval Request Status", recApprovalReqEntries."Approval Request Status"::Open);
//         if recApprovalReqEntries.FindFirst() then begin
//             recAppreqEntries.Reset();
//             recAppreqEntries.SetRange("Document No.", ChangeRequest."Document No.");
//             recAppreqEntries.SetRange("Document Type", ChangeRequest."Document Type");
//             recAppreqEntries.SetRange("Approval Request Status", recAppreqEntries."Approval Request Status"::Open);
//             recAppreqEntries.SetFilter("Approver Name", '<>%1', UserId);
//             recAppreqEntries.SetFilter("Approval Sequence", '<%1', recApprovalReqEntries."Approval Sequence");
//             if recAppreqEntries.FindFirst() then
//                 Error('You are not authorized to approve/reject this request.');
//         end else
//             Error('You are not authorized to approve/reject this request.');
//     end;

//     local procedure ApproveRequestEntries(ChangeRequest: Record "Amendment Request")
//     var
//         recApprovalReqEntries: record "Amendment Approval Entries";
//         recAppreqEntries: Record "Amendment Approval Entries";
//     begin
//         recApprovalReqEntries.Reset();
//         recApprovalReqEntries.SetCurrentKey("Approval Sequence");
//         recApprovalReqEntries.SetRange("Amendment No.", ChangeRequest."Amendment No.");
//         recApprovalReqEntries.SetRange("Document Type", ChangeRequest."Document Type");
//         recApprovalReqEntries.SetRange("Document No.", ChangeRequest."Document No.");
//         recApprovalReqEntries.SetRange("Approver Name", UserId);
//         recApprovalReqEntries.SetRange("Approval Request Status", recApprovalReqEntries."Approval Request Status"::Open);
//         if recApprovalReqEntries.FindFirst() then begin
//             recAppreqEntries.Reset();
//             recAppreqEntries.SetRange("Amendment No.", ChangeRequest."Amendment No.");
//             recAppreqEntries.SetRange("Document No.", ChangeRequest."Document No.");
//             recAppreqEntries.SetRange("Document Type", ChangeRequest."Document Type");
//             recAppreqEntries.SetRange("Approval Request Status", recAppreqEntries."Approval Request Status"::Open);
//             recAppreqEntries.SetFilter("Approver Name", '<>%1', UserId);
//             recAppreqEntries.SetRange("Approval Sequence", recApprovalReqEntries."Approval Sequence");
//             if recAppreqEntries.FindSet() then
//                 repeat
//                     recAppreqEntries."Approval Request Status" := recAppreqEntries."Approval Request Status"::"Approved";
//                     recAppreqEntries."Approved Date Time" := CurrentDateTime;
//                     recAppreqEntries.Modify(true);
//                 until recAppreqEntries.Next() = 0;

//             recApprovalReqEntries."Approval Request Status" := recApprovalReqEntries."Approval Request Status"::"Approved";
//             recApprovalReqEntries."Approved Date Time" := CurrentDateTime;
//             recApprovalReqEntries.Modify(true);
//         end else
//             Error('There are no approval entries available.');
//     end;

//     local procedure CancelequestEntries(ChangeRequest: Record "Amendment Request")
//     var
//         recApprovalReqEntries: record "Amendment Approval Entries";
//     begin
//         recApprovalReqEntries.Reset();
//         recApprovalReqEntries.SetCurrentKey("Approval Sequence");
//         recApprovalReqEntries.SetRange("Amendment No.", ChangeRequest."Amendment No.");
//         recApprovalReqEntries.SetRange("Document Type", ChangeRequest."Document Type");
//         recApprovalReqEntries.SetRange("Document No.", ChangeRequest."Document No.");
//         recApprovalReqEntries.SetRange("Requester Name", UserId);
//         if recApprovalReqEntries.FindSet() then begin
//             recApprovalReqEntries.ModifyAll("Approval Request Status", recApprovalReqEntries."Approval Request Status"::Cancelled);
//             //recApprovalReqEntries.DeleteAll();
//         end else
//             Error('There are no approval entries available.');
//     end;

//     local procedure SendForApprovalMail(ChangeRequest: Record "Amendment Request")
//     var
//         recApprovalEntries: Record "Amendment Approval Entries";
//         Receipents: List of [Text];
//         CCReceipents: Text;
//         Subject: Text;
//         Body: Text;
//         ApprovalMailTitle: Label 'Amendment request %1 for Posted Sales Invoice %2 is submitted.';
//         ApprovalMailMsg: Label 'Dear Approver,<br><br>The Amendment request <strong>%1</strong> for Posted Sales Invoice <strong>%2</strong> has been submitted for your approval.<br>';
//     begin
//         recApprovalEntries.Reset();
//         recApprovalEntries.SetCurrentKey("Amendment No.", "Approval Sequence");
//         recApprovalEntries.SetRange("Amendment No.", ChangeRequest."Amendment No.");
//         recApprovalEntries.SetRange("Document Type", ChangeRequest."Document Type");
//         recApprovalEntries.SetRange("Document No.", ChangeRequest."Document No.");
//         recApprovalEntries.SetRange("Approval Sequence", 1);
//         if recApprovalEntries.FindSet() then
//             repeat
//                 Receipents.Add(recApprovalEntries."Approver E-Mail");
//             until recApprovalEntries.Next() = 0;

//         CCReceipents := '';

//         Subject := StrSubstNo(ApprovalMailTitle, ChangeRequest."Amendment No.", ChangeRequest."Document No.");

//         Body := StrSubstNo(ApprovalMailMsg, ChangeRequest."Amendment No.", ChangeRequest."Document No.");

//         SendEMail(Receipents, CCReceipents, Subject, Body);
//     end;

//     procedure SendEMail(Receipents: List of [Text]; CCReceipents: Text; Subject: Text; Body: Text)
//     var
//         EmailMessage: Codeunit "Email Message";
//         Email: Codeunit Email;
//     begin
//         EmailMessage.Create(Receipents, Subject, Body, true);
//         if CCReceipents <> '' then
//             EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, CCReceipents);

//         Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
//     end;

//     local procedure RejectRequestEntries(var ChangeRequest: Record "Amendment Request")
//     var
//         recApprovalReqEntries: record "Amendment Approval Entries";
//     begin
//         recApprovalReqEntries.Reset();
//         recApprovalReqEntries.SetRange("Amendment No.", ChangeRequest."Amendment No.");
//         recApprovalReqEntries.SetRange("Approval Request Status", recApprovalReqEntries."Approval Request Status"::Open);
//         recApprovalReqEntries.SetRange("Approver Name", UserId);
//         if recApprovalReqEntries.FindSet() then begin
//             repeat
//                 recApprovalReqEntries."Approval Request Status" := recApprovalReqEntries."Approval Request Status"::"Rejected";
//                 recApprovalReqEntries."Rejected Date Time" := CurrentDateTime;
//                 recApprovalReqEntries.Modify();
//             until recApprovalReqEntries.Next() = 0;
//         end else
//             Error('There are no approval entries available.');
//     end;

//     //01-10-2022-start
//     procedure HasOpenApprovalEntries(ChangeRequest: Record "Amendment Request"): Boolean
//     var
//         recApprovalReqEntries: record "Amendment Approval Entries";
//         recAppreqEntries: Record "Amendment Approval Entries";
//     begin
//         recApprovalReqEntries.Reset();
//         recApprovalReqEntries.SetCurrentKey("Approval Sequence");
//         recApprovalReqEntries.SetRange("Document Type", ChangeRequest."Document Type");
//         recApprovalReqEntries.SetRange("Document No.", ChangeRequest."Document No.");
//         recApprovalReqEntries.SetRange("Approver Name", UserId);
//         recApprovalReqEntries.SetRange("Approval Request Status", recApprovalReqEntries."Approval Request Status"::Open);
//         if recApprovalReqEntries.FindFirst() then begin
//             exit(true);
//         end else
//             exit(false);
//     end;
//     //01-10-2022-end
// }