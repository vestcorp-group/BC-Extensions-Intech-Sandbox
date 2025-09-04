// pageextension 50301 KMP_PagExtPurchaseReturnOrder extends "Purchase Return Order"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         addafter(Status)
//         {
//             field(CustomBOENumber; rec.CustomBOENumber)
//             {
//                 Caption = 'Custom BOE No.';
//                 ApplicationArea = All;
//             }
//         }
//     }
// }