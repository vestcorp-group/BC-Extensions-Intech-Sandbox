// page 53215 "Amendment Approval Entries"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'Amendment Approval Entries';
//     PageType = List;
//     SourceTable = "Amendment Approval Entries";
//     UsageCategory = Administration;
//     Editable = false;

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Entry No."; Rec."Entry No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Entry No. field.';
//                     Visible = false;
//                 }
//                 field("Amendment No."; Rec."Amendment No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Request No. field.';
//                 }
//                 field("Document Type"; Rec."Document Type")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Document Type field.';
//                 }
//                 field("Amendment Type"; Rec."Amendment Type")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Document No."; Rec."Document No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Document No. field.';
//                 }
//                 field("Requester Name"; Rec."Requester Name")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Requester Name field.';
//                 }
//                 field("Approval Submit DateTime"; Rec."Approval Submit DateTime")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Approval Submit DateTime field.';
//                 }
//                 field("Approver Name"; Rec."Approver Name")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Approver Name field.';
//                 }
//                 field("Approval Request Status"; Rec."Approval Request Status")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Approval Request Status field.';
//                 }
//                 field("Approval Sequence"; Rec."Approval Sequence")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Approval Sequence field.';
//                 }
//                 field("Last Modify By"; Rec."Last Modify By")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Last Modify By field.';
//                 }
//                 field("Last Modify DateTime"; Rec."Last Modify DateTime")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Last Modify DateTime field.';
//                 }
//                 field("Approved Date Time"; Rec."Approved Date Time")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action("Open Record")
//             {
//                 ApplicationArea = All;
//                 Image = Card;
//                 Promoted = true;
//                 PromotedOnly = true;
//                 PromotedCategory = Process;
//                 trigger OnAction()
//                 var
//                     AmendmentReq: Record "Amendment Request";
//                 begin
//                     Clear(AmendmentReq);
//                     AmendmentReq.SetRange("Amendment No.", Rec."Amendment No.");
//                     if AmendmentReq.FindFirst() then;
//                     Page.Run(Page::"Amendment Request", AmendmentReq);
//                 end;
//             }
//         }
//     }
// }
