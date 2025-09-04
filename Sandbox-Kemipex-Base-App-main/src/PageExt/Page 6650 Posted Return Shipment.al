// pageextension 50303 KMP_PagExtPostedReturnShipment extends "Posted Return Shipment"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("No. Printed")
//         {
//             field(CustomBOENumber; rec.CustomBOENumber)
//             {
//                 Caption = 'Custom BOE No.';
//                 ApplicationArea = All;
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
//                     PurchaseRemarkL.ShowRemarks(PurchaseRemarkL."Document Type"::"Posted Return Shipment", rec."No.", 0);
//                 end;
//             }
//         }
//     }
// }