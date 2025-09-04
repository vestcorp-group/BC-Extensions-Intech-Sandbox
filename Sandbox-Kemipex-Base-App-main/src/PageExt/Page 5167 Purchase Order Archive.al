// pageextension 50257 KMP_PageExtPurchaseOrdArchive extends "Purchase Order Archive"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         modify("Document Date")
//         {
//             Caption = 'Supplier Invoice Date';
//         }

//         addafter(Status)
//         {
//             field(CustomBOENumber; rec.CustomBOENumber)
//             {
//                 ApplicationArea = All;
//                 Caption = 'Custom BOE No.';
//                 Editable = false;
//             }
//             // Start Issue - 59
//             field("Supplier Invoice Date"; rec."Supplier Invoice Date")
//             {
//                 ApplicationArea = all;
//             }
//             // Stop Issue - 59
//         }

//     }

// }