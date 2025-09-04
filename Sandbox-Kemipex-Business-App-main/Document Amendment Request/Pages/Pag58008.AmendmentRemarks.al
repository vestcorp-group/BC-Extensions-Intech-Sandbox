// page 58008 "Amendment Remarks"//T12370-Full Comment
// {
//     Caption = 'Amendment Remarks';
//     PageType = ListPart;
//     SourceTable = "Amendment Remarks";
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = true;
//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Document Type"; Rec."Document Type")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     ToolTip = 'Specifies the value of the Document Type field.';
//                 }
//                 field("Document No."; Rec."Document No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     ToolTip = 'Specifies the value of the Document No. field.';
//                 }
//                 field(Comments; Rec.Comments)
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Comments field.';
//                     Editable = false;
//                 }
//                 field("New Remarks"; Rec."New Remarks")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }
// }
