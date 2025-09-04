// pageextension 58022 POList extends "Purchase Order List"//T12370-Full Comment
// {
//     layout
//     {
//         addbefore(Status)
//         {
//             field("Sell-to Customer No."; rec."Sell-to Customer No.")
//             {
//                 ApplicationArea = All;
//                 Visible = true;
//             }
//         }
//         addafter(Status)
//         {
//             field(approval; approval)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Pending Approval';
//             }
//             field("Transaction Type"; Rec."Transaction Type")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Order Type';
//             }
//         }
//         modify("Currency Code")
//         {
//             Visible = true;
//             ApplicationArea = all;
//         }
//         modify("Payment Terms Code")
//         {
//             Visible = true;
//             ApplicationArea = all;
//         }
//         modify("Location Code")
//         {
//             Visible = false;
//         }
//         modify("Vendor Authorization No.")
//         {
//             Visible = false;
//         }
//         modify("Assigned User ID")
//         {
//             Visible = false;
//         }
//         moveafter("Payment Terms Code"; "Currency Code")
//     }
//     trigger OnAfterGetRecord()
//     var
//         ApprovalEntries: Record "Approval Entry";
//     begin
//         Clear(approval);
//         ApprovalEntries.SetRange("Document No.", rec."No.");
//         ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Open);

//         if ApprovalEntries.FindSet() then
//             approval := ApprovalEntries."Approver ID";
//     end;

//     var
//         approval: Code[50];
// }