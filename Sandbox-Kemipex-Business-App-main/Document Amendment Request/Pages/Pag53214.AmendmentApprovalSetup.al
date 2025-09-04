// page 53214 "Amendment Approval Setup"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'Amendment Approval Setup';
//     PageType = List;
//     SourceTable = "Amendment Approval Setup";
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Document type"; Rec."Document type")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Document type field.';
//                 }
//                 field("Amendment Type"; Rec."Amendment Type")
//                 {
//                     ApplicationArea = All;
//                 }
//                 // field("User Name"; Rec."Requester Name")
//                 // {
//                 //     ApplicationArea = All;
//                 //     ToolTip = 'Specifies the value of the User Name field.';
//                 // }
//                 // field("User E-Mail"; Rec."Requester E-Mail")
//                 // {
//                 //     ApplicationArea = All;
//                 //     ToolTip = 'Specifies the value of the User E-Mail field.';
//                 // }
//                 field("Approver Type"; Rec."Approver Type")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Approver Name"; Rec."Approver Name")
//                 {
//                     ApplicationArea = All;
//                     Editable = Rec."Approver Type" = Rec."Approver Type"::User;
//                     ToolTip = 'Specifies the value of the Approver Name field.';
//                 }
//                 field("Approver E-Mail"; Rec."Approver E-Mail")
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                     ToolTip = 'Specifies the value of the Approver E-Mail field.';
//                 }
//                 field("Approver Level"; Rec."Approver Level")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Approver level field.';
//                 }
//             }
//         }
//     }
// }
