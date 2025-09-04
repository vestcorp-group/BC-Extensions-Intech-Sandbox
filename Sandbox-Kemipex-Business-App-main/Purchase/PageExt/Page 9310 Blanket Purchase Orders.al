// pageextension 58128 BPO_Listpage extends "Blanket Purchase Orders"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("Buy-from Vendor Name")
//         {
//             //  field(Status; rec.Status)
//             // {
//             //      ApplicationArea = all;
//             // } // hide by B for MS update
//             field(approval; approval)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Pending Approval';
//             }
//             field("Payment Terms Code"; rec."Payment Terms Code")
//             {
//                 ApplicationArea = all;
//             }
//             field(Amount; rec.Amount)
//             {
//                 ApplicationArea = all;
//             }
//             field("Amount Including VAT"; rec."Amount Including VAT")
//             {
//                 ApplicationArea = all;
//             }
//             field("Transaction Type"; rec."Transaction Type")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Order Type';
//             }
//         }

//         modify("Currency Code")
//         {
//             ApplicationArea = all;
//             Visible = true;
//         }
//         modify("Location Code")
//         {
//             Visible = false;
//         }
//         modify("Assigned User ID")
//         {
//             Visible = false;
//         }
//         modify("Vendor Authorization No.")
//         {
//             Visible = false;
//         }
//         moveafter("Payment Terms Code"; "Currency Code")
//     }
//     actions
//     {
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