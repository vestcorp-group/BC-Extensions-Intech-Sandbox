// pageextension 50109 KMP_PageExtWarehouseReceiptLn extends "Whse. Receipt Subform"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         addafter(Quantity)
//         {
//             field(CustomBOENumber; rec.CustomBOENumber)
//             {
//                 ApplicationArea = All;
//                 Caption = 'Custom BOE No.';
//                 Editable = false;
//             }
//         }
//     }

// }