// page 50466 "Kemipex Approval Entry"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'Kemipex Approval Entry';
//     PageType = List;
//     SourceTable = "Kemipex Approval Entry";
//     UsageCategory = Lists;
//     ModifyAllowed = false;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     Editable = false;

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {

//                 field("Entry No."; Rec."Entry No.")
//                 {
//                     ToolTip = 'Specifies the value of the Entry No. field';
//                     ApplicationArea = All;
//                 }
//                 field("Document Type"; Rec."Document Type")
//                 {
//                     ToolTip = 'Specifies the value of the Document Type field';
//                     ApplicationArea = All;
//                 }
//                 field("Document No."; Rec."Document No.")
//                 {
//                     ToolTip = 'Specifies the value of the Document No. field';
//                     ApplicationArea = All;
//                 }

//                 field("Currency Code"; Rec."Currency Code")
//                 {
//                     ToolTip = 'Specifies the value of the Currency Code field';
//                     ApplicationArea = All;
//                 }
//                 field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
//                 {
//                     ToolTip = 'Specifies the value of the Date-Time Sent for Approval field';
//                     ApplicationArea = All;
//                 }
//                 // field("Due Date"; Rec."Due Date")
//                 // {
//                 //     ToolTip = 'Specifies the value of the Due Date field';
//                 //     ApplicationArea = All;
//                 // }

//                 field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
//                 {
//                     ToolTip = 'Specifies the value of the Last Date-Time Modified field';
//                     ApplicationArea = All;
//                 }
//                 field("Last Modified By User ID"; Rec."Last Modified By User ID")
//                 {
//                     ToolTip = 'Specifies the value of the Last Modified By User ID field';
//                     ApplicationArea = All;
//                 }
//                 field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
//                 {
//                     ToolTip = 'Specifies the value of the Salespers./Purch. Code field';
//                     ApplicationArea = All;
//                 }
//                 field("Sender ID"; Rec."Sender ID")
//                 {
//                     ToolTip = 'Specifies the value of the Sender ID field';
//                     ApplicationArea = All;
//                 }
//                 field("Approver Type"; rec."Approver Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Approver ID"; Rec."Approver ID")
//                 {
//                     ToolTip = 'Specifies the value of the Approver ID field';
//                     ApplicationArea = All;
//                 }
//                 field("Approval Type"; rec."Approval Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Sequence No."; Rec."Sequence No.")
//                 {
//                     ToolTip = 'Specifies the value of the Sequence No. field';
//                     ApplicationArea = All;
//                 }
//                 field(Status; Rec.Status)
//                 {
//                     ToolTip = 'Specifies the value of the Status field';
//                     ApplicationArea = All;
//                 }
//                 // field(SystemCreatedAt; Rec.SystemCreatedAt)
//                 // {
//                 //     ToolTip = 'Specifies the value of the SystemCreatedAt field';
//                 //     ApplicationArea = All;
//                 // }
//                 // field(SystemCreatedBy; Rec.SystemCreatedBy)
//                 // {
//                 //     ToolTip = 'Specifies the value of the SystemCreatedBy field';
//                 //     ApplicationArea = All;
//                 // }
//                 // field(SystemId; Rec.SystemId)
//                 // {
//                 //     ToolTip = 'Specifies the value of the SystemId field';
//                 //     ApplicationArea = All;
//                 // // }
//                 // field(SystemModifiedAt; Rec.SystemModifiedAt)
//                 // {
//                 //     ToolTip = 'Specifies the value of the SystemModifiedAt field';
//                 //     ApplicationArea = All;
//                 // }
//                 // field(SystemModifiedBy; Rec.SystemModifiedBy)
//                 // {
//                 //     ToolTip = 'Specifies the value of the SystemModifiedBy field';
//                 //     ApplicationArea = All;
//                 // }
//                 field("Table ID"; Rec."Table ID")
//                 {
//                     ToolTip = 'Specifies the value of the Table ID field';
//                     ApplicationArea = All;
//                 }
//                 field(NoteText; NoteText)
//                 {
//                     Caption = 'Approval Note';
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             // action("Approve")
//             // {
//             //     ApplicationArea = all;
//             //     Promoted = true;
//             //     PromotedCategory = Process;
//             //     PromotedIsBig = true;
//             //     // Enabled = (rec."Approver ID" = Currentuser);
//             //     // and (Rec.Status = Rec.Status::Open)
//             //     trigger OnAction()
//             //     var
//             //         KemipexApprovalcodeunit: Codeunit "Kemipex Approval Codeunit";
//             //     begin
//             //         if Rec.Status = Rec.Status::Open then
//             //             KemipexApprovalcodeunit.ApproveSalesDocumentReopen(Rec);
//             //     end;
//             // }
//         }
//     }
//     trigger OnAfterGetRecord()
//     var
//         myInt: Integer;
//         Ins: InStream;
//     begin
//         Clear(NoteText);
//         rec.CalcFields("Approval Note");
//         rec."Approval Note".CreateinStream(Ins, TextEncoding::UTF8);
//         Ins.ReadText(NoteText);
//     end;

//     trigger OnOpenPage()
//     var
//         WorkflowUsergroupMember: Record "Workflow User Group Member";
//         FilterString: Text;
//         KMapprovalEntry: Record "Kemipex Approval Entry";
//     begin
//         // WorkflowUsergroupMember.SetRange("User Name", UserId);
//         // if WorkflowUsergroupMember.FindSet() then begin
//         //     repeat
//         //         FilterString += WorkflowUsergroupMember."Workflow User Group Code";
//         //         FilterString += '|';
//         //     until WorkflowUsergroupMember.Next() = 0;
//         // end;
//         // FilterString += UserId;

//         // KMapprovalEntry.SetRange("Approver ID", rec."User ID Filter");
//         // // KMapprovalEntry.SetRange(Status, KMapprovalEntry.Status::Open);
//         // if KMapprovalEntry.FindSet() then begin
//         //     KMApprovals := 9;
//         //     Message('%1', KMApprovals);
//         // end
//     end;


//     procedure Setfilter(RecID: RecordId)

//     begin
//         rec.FilterGroup(2);
//         rec.SetRange("Record ID to Approve", RecID);
//         rec.FilterGroup(0);
//     end;

//     var
//         ApproveEnable: Boolean;
//         Currentuser: Code[30];
//         ApprovalEntry: Page "Approval Entries";
//         NoteText: Text;
// }
