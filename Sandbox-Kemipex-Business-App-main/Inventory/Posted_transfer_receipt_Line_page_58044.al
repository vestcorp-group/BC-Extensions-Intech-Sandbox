// pageextension 58044 TransferReceiptLine extends "Posted Transfer Receipt Lines"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("Document No.")
//         {
//             field("Transfer Order No."; rec."Transfer Order No.")
//             {
//                 ApplicationArea = all;
//             }
//         }
//         // Add changes to page layout here
//     }

//     actions
//     {
//         // Add changes to page actions here
//     }

//     var
//         myInt: Integer;
// }