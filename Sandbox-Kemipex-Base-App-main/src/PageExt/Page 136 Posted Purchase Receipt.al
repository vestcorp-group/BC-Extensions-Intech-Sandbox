// pageextension 50110 KMP_PageExtPostedPurRecHdr extends "Posted Purchase Receipt"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         addafter("Responsibility Center")
//         {
//             field(CustomBOENumber; rec.CustomBOENumber)
//             {
//                 ApplicationArea = All;
//                 Caption = 'Custom BOE No.';
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

// }