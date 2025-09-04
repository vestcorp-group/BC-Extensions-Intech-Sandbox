// pageextension 58103 BSO_archivee_page extends "Blanket Sales Order Archives"//T12370-Full Comment
// {
//     layout
//     {
//         addbefore("Version No.")
//         {

//             //30-04-2022- Commented below as No. field is already there in the base object. added caption
//             /* field("No."; rec."No.")
//              {
//                  ApplicationArea = all;
//                  Caption = 'Document No.';
//              }*/
//             field("Transaction Type"; rec."Transaction Type")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Order Type';
//             }
//         }
//         modify("No.")
//         {
//             Caption = 'Document No.';
//         }

//     }

//     actions
//     {
//         // Add changes to page actions here
//     }

//     var
//         myInt: Integer;
// }