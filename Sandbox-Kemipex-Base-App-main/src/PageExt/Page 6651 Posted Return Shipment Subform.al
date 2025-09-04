// pageextension 50304 KMP_PagExtPostedRetShipSubform extends "Posted Return Shipment Subform"//T12370-Full Comment
// {
//     layout
//     {
//         addafter(Quantity)
//         {
//             field(CustomBOENumber; rec.CustomBOENumber)
//             {
//                 Caption = 'Custom BOE No.';
//                 ApplicationArea = All;
//                 Editable = false;
//             }
//         }
//         addafter("Quantity Invoiced")
//         {
//             field("Container No. 2"; rec."Container No. 2")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Container No.';
//             }
//         }
//     }
// }