// pageextension 50102 KMP_PageExtPostedPurchaseInv extends "Posted Purchase Invoice"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         modify("Document Date")
//         {
//             Caption = 'Supplier Invoice Date';
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
//                 PromotedCategory = Category5;
//                 PromotedIsBig = true;
//                 trigger OnAction()
//                 var
//                     PurchaseRemarkL: Record "Purchase Remark Archieve";
//                 begin
//                     PurchaseRemarkL.ShowRemarks(PurchaseRemarkL."Document Type"::"Posted Invoice", Rec."No.", 0);
//                 end;
//             }
//         }
//     }



// }