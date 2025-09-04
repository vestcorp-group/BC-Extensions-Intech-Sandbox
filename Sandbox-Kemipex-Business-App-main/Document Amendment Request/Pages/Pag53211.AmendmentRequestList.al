// page 53211 "Amendment Request List"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'Amendment Request List';
//     PageType = List;
//     SourceTable = "Amendment Request";
//     UsageCategory = Administration;
//     CardPageId = "Amendment Request";
//     Editable = false;

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
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
//                 field("Change Level"; Rec."Amendment Type")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Change Level field.';
//                 }
//                 field("Request Status"; Rec."Request Status")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Request Status field.';
//                 }
//                 field("Requested DateTime"; Rec."Requested DateTime")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Requested DateTime field.';
//                 }
//                 field(Requester; Rec.Requester)
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Requester field.';
//                 }
//             }
//         }
//     }

//     var
//         recGenLedSetup: Record "General Ledger Setup";

//     trigger OnOpenPage()
//     begin
//         recGenLedSetup.Get();
//         recGenLedSetup.TestField("Enable Amendment Request Mgmt");

//         if (Rec.Requester <> '') AND (Rec.Requester <> UserId) then
//             CurrPage.Editable := false
//         else
//             CurrPage.Editable := true;
//     end;
// }
