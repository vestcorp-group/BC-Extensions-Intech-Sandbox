// pageextension 58129 SO_list_page extends "Sales Order List"//T12370-Full Comment
// {
//     layout
//     {
//         modify("Assigned User ID")
//         {
//             Visible = false;
//         }
//         modify("Payment Discount %")
//         {
//             ApplicationArea = all;
//             Visible = false;
//         }
//         modify("Due Date")
//         {
//             Visible = false;
//             ApplicationArea = all;
//         }
//         modify("Location Code")
//         {
//             Visible = false;
//             ApplicationArea = all;
//         }
//         addafter(Status)
//         {
//             field(approval; approval)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Pending Approval';
//             }
//         }
//         modify("Salesperson Code")
//         {
//             Visible = true;
//             ApplicationArea = all;
//         }
//         addafter("Salesperson Code")
//         {
//             field(SalespersonName; SalespersonName)
//             {
//                 Caption = 'Salesperson Name';
//                 ApplicationArea = all;
//                 Visible = true;
//             }
//         }
//         modify(VatAmountG)
//         {
//             CaptionClass = 'GSTORVAT,VAT Amount';
//         }

//         addbefore(Status)
//         {
//             field("Sub Status"; Rec."Sub Status")
//             {
//                 ApplicationArea = All;
//                 Editable = false;
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
//     }

//     actions
//     {
//         // Add changes to page actions here
//     }

//     trigger OnAfterGetRecord()
//     var
//         ApprovalEntries: Record "Approval Entry";
//         currencyrec: Record Currency;
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