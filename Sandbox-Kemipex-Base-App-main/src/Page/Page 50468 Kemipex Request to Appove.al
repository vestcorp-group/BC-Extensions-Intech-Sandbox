// page 50468 "Kemipex Request to Appove"//T12370-Full Comment
// {

//     ApplicationArea = All;
//     Caption = 'Kemipex Request to Appove';
//     PageType = List;
//     SourceTable = "Kemipex Approval Entry";
//     RefreshOnActivate = true;
//     Editable = false;
//     InsertAllowed = false;
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     SourceTableView = SORTING("Approver ID", Status)
//                       ORDER(Ascending);
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Document Type"; Rec."Document Type")
//                 {
//                     ApplicationArea = All;
//                     Width = 1;
//                 }
//                 field("Document No."; Rec."Document No.")
//                 {
//                     ApplicationArea = All;
//                     Width = 4;
//                 }
//                 field("Approval Type"; rec."Approval Type")
//                 {
//                     ApplicationArea = all;
//                     Width = 3;
//                 }
//                 field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
//                 {
//                     ApplicationArea = All;
//                     Width = 3;
//                 }
//                 field("Sender ID"; Rec."Sender ID")
//                 {
//                     ApplicationArea = All;
//                     Width = 3;
//                 }
//                 field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
//                 {
//                     ApplicationArea = All;
//                     Width = 2;
//                 }
//                 field("Approver ID"; Rec."Approver ID")
//                 {
//                     ToolTip = 'Specifies the value of the Approver ID field';
//                     ApplicationArea = All;
//                     Width = 5;
//                 }
//                 // field(Note; Note)
//                 // {
//                 //     ApplicationArea = all;
//                 //     Width = 15;
//                 // }
//                 field("Sequence No."; Rec."Sequence No.")
//                 {
//                     ApplicationArea = All;
//                     Width = 1;
//                 }
//                 field("Last Modified By User ID"; rec."Last Modified By User ID")
//                 {
//                     ApplicationArea = all;
//                     Width = 3;
//                 }
//                 field("Last Date-Time Modified"; rec."Last Date-Time Modified")
//                 {
//                     ApplicationArea = all;
//                     Width = 5;
//                 }
//             }
//         }
//         area(FactBoxes)
//         {
//             part(Note2; "Approval Note")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "Entry No." = field("Entry No.");
//             }
//         }
//     }
//     actions
//     {
//         area(Processing)
//         {
//             action("Approve")
//             {
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Image = Approve;
//                 // Enabled = (rec."Approver ID" = Currentuser);
//                 // and (Rec.Status = Rec.Status::Open)
//                 trigger OnAction()
//                 var
//                     KemipexApprovalcodeunit: Codeunit "Kemipex Approval Codeunit";
//                 begin
//                     if Rec.Status = Rec.Status::Open then
//                         KemipexApprovalcodeunit.ApproveSalesDocumentReopen(Rec);
//                 end;
//             }
//             action(Reject)
//             {
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Image = Reject;
//                 trigger OnAction()
//                 var
//                     KemipexApprovalcodeunit: Codeunit "Kemipex Approval Codeunit";
//                 begin
//                     if Rec.Status = Rec.Status::Open then
//                         KemipexApprovalcodeunit.RejectSalesDocumentReopen(Rec);
//                 end;
//             }
//             action("Open Record")
//             {
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Image = Document;
//                 trigger OnAction()
//                 var
//                     KemipexApprovalcodeunit: Codeunit "Kemipex Approval Codeunit";
//                     RecRef: RecordRef;
//                     PageManagement: Codeunit "Page Management";
//                 begin
//                     if not RecRef.Get(rec."Record ID to Approve") then
//                         exit;
//                     RecRef.SetRecFilter;
//                     PageManagement.PageRun(RecRef);
//                 end;
//             }
//         }

//     }

//     trigger OnAfterGetRecord()
//     var
//         RecordLink: Record "Record Link";
//         RecordLinkmangement: Codeunit "Record Link Management";
//     begin
//         // RecordLink.Get(rec."Related Note");
//         // RecordLink.CalcFields(Note);
//         // Note := RecordLinkmangement.ReadNote(RecordLink);
//     end;

//     trigger OnOpenPage()
//     var
//         WorkflowUsergroupMember: Record "Workflow User Group Member";
//         FilterString: Text;
//         UserSetupRec: Record "User Setup";
//         KmApprovalCodeunit: Codeunit "Kemipex Approval Codeunit";
//         KMapprovalEntry: Record "Kemipex Approval Entry";
//     begin

//         FilterString += UserId;
//         rec.FilterGroup(2);
//         Rec.SetFilter("Approver ID", KmApprovalCodeunit.GetuserGroupFilter());
//         rec.FilterGroup(0);
//         Rec.SetRange(Status, rec.Status::Open);
//     end;

//     var
//         ApproveEnable: Boolean;
//         Currentuser: Code[30];
//         ApprovalEntry: Page "Approval Entries";
//         Note: Text;
// }


// // WorkflowUsergroupMember.SetRange("User Name", UserId);
// // if WorkflowUsergroupMember.FindSet() then begin
// //     repeat
// //         FilterString += WorkflowUsergroupMember."Workflow User Group Code";
// //         FilterString += '|';
// //     until WorkflowUsergroupMember.Next() = 0;
// // end;