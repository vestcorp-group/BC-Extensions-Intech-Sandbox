// pageextension 58102 BPO_Archive_page extends "Blanket Purch. Order Archives"//T12370-Full Comment
// {
//     layout
//     {
//         addbefore("Version No.")
//         {
//             field("No."; rec."No.")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Document No.';
//             }
//             field("Transaction Type"; rec."Transaction Type")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Order Type';
//             }
//         }
//     }
//     actions
//     {
//     }
//     var
//         myInt: Integer;
// }