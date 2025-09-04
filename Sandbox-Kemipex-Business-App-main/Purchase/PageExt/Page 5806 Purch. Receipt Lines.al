// pageextension 58068 Purchase_receipt_Line_page extends "Purch. Receipt Lines"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("Document No.")
//         {
//             field("Order No. "; rec."Order No.")
//             {
//                 ApplicationArea = all;
//             }
//         }
//         addafter("Location Code")
//         {
//             field(BUOM; BUOM)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Base UOM';
//             }
//             field("Quantity (Base)"; rec."Quantity (Base)")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 Caption = 'Base UOM Qty.';
//             }
//             field("Posting Date"; rec."Posting Date")
//             {
//                 ApplicationArea = all;
//                 Visible = false;
//             }
//             field("Blanket Order No."; rec."Blanket Order No.")
//             {
//                 ApplicationArea = all;
//                 Visible = false;
//             }
//             field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
//             {
//                 ApplicationArea = all;
//                 Visible = false;
//             }
//             field("Currency Code"; rec."Currency Code")
//             {
//                 ApplicationArea = all;
//                 Visible = false;
//             }
//             field("Transaction Specification"; rec."Transaction Specification")
//             {
//                 ApplicationArea = all;
//                 Visible = false;
//             }
//             field("Area"; rec."Area")
//             {
//                 ApplicationArea = all;
//                 Visible = false;
//             }
//             field("Entry Point"; rec."Entry Point")
//             {
//                 ApplicationArea = all;
//                 Visible = false;
//             }
//             field("Transaction Type"; rec."Transaction Type")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Order Type';
//             }
//         }
//         moveafter("Unit of Measure"; Quantity)
//     }
//     var
//         BUOM: Code[10];

//     trigger OnAfterGetRecord()
//     var
//         item: Record Item;
//     begin
//         Clear(BUOM);
//         item.SetRange("No.", rec."No.");
//         if item.FindSet() then
//             BUOM := item."Base Unit of Measure";
//     end;
// }