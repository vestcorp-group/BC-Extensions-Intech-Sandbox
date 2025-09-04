// pageextension 50103 KMP_PageExtPurchaseInvoice extends "Purchase Invoice"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         modify("Document Date")
//         {
//             Caption = 'Supplier Invoice Date';
//         }

//         modify("Posting Date")
//         {
//             trigger OnAfterValidate()
//             var
//                 myInt: Integer;
//             begin
//                 rec."Document Date" := xRec."Document Date";
//             end;
//         }
//         addafter("Posting Description")
//         {
//             field("Your Reference"; rec."Your Reference")
//             {
//                 Caption = 'Your Reference';
//                 ApplicationArea = all;

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
//                 PromotedCategory = Category5;
//                 PromotedIsBig = true;
//                 trigger OnAction()
//                 var
//                     PurchaseRemarkL: Record "Purchase Remarks";
//                 begin
//                     PurchaseRemarkL.ShowRemarks(PurchaseRemarkL."Document Type"::Invoice, rec."No.", 0);
//                 end;
//             }
//         }
//     }

//     var
//         myInt: Integer;

//     // trigger OnDeleteRecord(): Boolean
//     // begin
//     //     StagingPurchInv.Reset();
//     //     StagingPurchInv.SetRange("Purch. Inv. No.", Rec."No.");
//     //     StagingPurchInv.SetRange(Status, StagingPurchInv.Status::Created);
//     //     StagingPurchInv.ModifyAll(Status, StagingPurchInv.Status::Deleted);
//     // end;

//     /* *Hide by B* trigger OnModifyRecord(): Boolean
//      var
//          myInt: Integer;
//      begin
//          rec."Document Date" := xRec."Document Date";
//      end; *Hide by B* */

//     var
//     // StagingPurchInv: Record "Staging Purchase Invoice";
// }