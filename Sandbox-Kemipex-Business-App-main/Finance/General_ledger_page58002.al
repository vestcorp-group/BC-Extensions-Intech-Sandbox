// pageextension 58002 PageExtension50100 extends "General Ledger Entries"//T12370-Full Comment
// {

//     layout
//     {
//         addafter("Credit Amount")
//         {
//             field("Source No.1"; rec."Source No.")
//             {
//                 Caption = 'Source No.';
//                 ApplicationArea = All;
//             }
//         }
//         addafter("Document No.")
//         {
//             field("Business Unit Code1"; rec."Business Unit Code")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Business Unit Code';
//             }
//         }
//         modify("Entry No.")
//         {
//             Visible = false;
//         }
//         modify("G/L Account Name")
//         {
//             Visible = true;
//         }
//         modify("VAT Amount")
//         {
//             Visible = true;
//         }
//         modify("Debit Amount")
//         {
//             Visible = true;
//         }
//         modify("Credit Amount")
//         {
//             Visible = true;
//         }


//         moveafter("G/L Account Name"; "Debit Amount")
//         moveafter("Debit Amount"; "Credit Amount")
//     }
//     actions
//     {
//     }

//     trigger OnOpenPage()
//     var
//         myInt: Integer;
//         GL: Page "General Ledger Entries";
//         GLR: Record "G/L Entry";

//     begin



//     end;
// }
