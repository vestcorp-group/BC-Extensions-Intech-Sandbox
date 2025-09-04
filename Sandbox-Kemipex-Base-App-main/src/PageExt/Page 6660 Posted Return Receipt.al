// pageextension 50309 KMP_PagExtPostedReturnReceipt extends "Posted Return Receipt"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("No. Printed")
//         {
//             field(CustomBOENumber; rec.CustomBOENumber)
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//         }
//     }

//     actions
//     {
//         addafter("Co&mments")
//         {
//             action(Remarks)
//             {
//                 Image = Comment;
//                 Promoted = true;
//                 ApplicationArea = All;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                 trigger OnAction()
//                 var
//                     PurchaseRemarkL: Record "Purchase Remark Archieve";
//                 begin
//                     PurchaseRemarkL.ShowRemarks(PurchaseRemarkL."Document Type"::Receipt, rec."No.", 0);
//                 end;
//             }
//         }

//     }

//     var
//         myInt: Integer;
// }