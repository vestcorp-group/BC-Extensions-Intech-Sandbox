// pageextension 80004 PostedTransferReceiptPageExt extends "Posted Transfer Receipt"//T12370-Full Comment
// {
//     layout
//     {

//     }

//     actions
//     {
//         addlast(navigation)
//         {
//             action("Remarks")
//             {
//                 Image = ViewComments;
//                 ApplicationArea = All;
//                 trigger OnAction()
//                 var
//                     TransferComments: Record "Posted Transfer Txn. Comments";
//                 begin
//                     TransferComments.Reset();
//                     TransferComments.SetRange("Document Type", TransferComments."Document Type"::"Transfer Receipt");
//                     TransferComments.SetRange("Document No.", Rec."No.");
//                     if TransferComments.FindFirst() then;

//                     Page.RunModal(80002, TransferComments)
//                 end;
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }