// pageextension 58120 BSO_list_page extends "Blanket Sales Orders"//T12370-Full Comment
// {
//     layout
//     {

//         modify("Assigned User ID")
//         {
//             Visible = false;
//         }
//         modify("Location Code")
//         {
//             Visible = false;
//         }
//         modify("Salesperson Code")
//         {
//             Visible = true;
//             ApplicationArea = all;
//         }

//         addafter("Bill-to Name")
//         {
//             field(SalespersonName; SalespersonName)
//             {
//                 ApplicationArea = all;
//                 Visible = true;
//                 Caption = 'Salesperson Name';
//             }
//             // field(Status; rec.Status)
//             // {
//             //     ApplicationArea = all;
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
//             field(SystemCreatedBy; Rec.SystemCreatedBy)
//             {
//                 ApplicationArea = all;
//             }
//             field("Transaction Type"; Rec."Transaction Type")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Order Type';
//             }
//         }

//         moveafter("Bill-to Name"; "Salesperson Code")
//         // Add changes to page layout here
//     }
//     actions
//     {
//         // Add changes to page actions here
//         modify(Print)
//         {
//             trigger OnBeforeAction()
//             var
//                 myInt: Integer;
//             begin
//                 if Rec.Status <> Rec.Status::Released then Error('Blanket Sales Order must approved and released');
//             end;
//         }
//         modify(AttachAsPDF)
//         {
//             trigger OnBeforeAction()
//             var
//                 myInt: Integer;
//             begin
//                 if Rec.Status <> Rec.Status::Released then Error('Blanket Sales Order must approved and released');
//             end;
//         }
//     }

//     trigger OnAfterGetRecord()
//     var
//         ApprovalEntries: Record "Approval Entry";
//         SP: Record "Salesperson/Purchaser";
//     begin
//         Clear(approval);
//         ApprovalEntries.SetRange("Document No.", rec."No.");
//         ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Open);

//         if ApprovalEntries.FindSet() then
//             approval := ApprovalEntries."Approver ID";

//         Clear(SalespersonName);
//         if rec."Salesperson Code" <> '' then begin
//             sp.get(rec."Salesperson Code");
//             SalespersonName := sp.Name;
//         end;
//     end;

//     var
//         approval: Code[50];
//         SalespersonName: Text[100];
// }