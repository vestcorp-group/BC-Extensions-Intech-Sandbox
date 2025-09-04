// pageextension 58036 "Inventory Setup" extends "Inventory Setup"//T12370-Full Comment
// {
//     layout
//     {
//         addlast(General)
//         {
//             field("Allow to edit Item UOM"; Rec."Allow to edit Item UOM")
//             {
//                 ApplicationArea = All;
//             }
//             field("Transfer Gen. Prod. Group"; rec."Transfer Gen. Prod. Group")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Transfer Gen. Prod. Posting Group';
//                 ToolTip = 'While posting Transfer Order, system will change Gen. Prod. Posting Group as this, based on selection Inventory adjustment account added to Gen. Posting Setup. If Blank, system will consider item master default Gen. Prod. Posting Group';
//             }
//             field("Assembly Gen. Prod. Group"; rec."Assembly Gen. Prod. Group")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Assembly Gen. Prod. Posting Group';
//                 ToolTip = 'While posting Assembly Order, system will change assembly header and line Gen. Prod. Posting Group as this, based on selection Inventory adjustment account added to Gen. Posting Setup. If Blank, system will consider item master default Gen. Prod. Posting Group';
//             }
//         }
//     }
// }
