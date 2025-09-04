// codeunit 80001 "Post Transfer Comments"//T12370-Full Comment
// {
//     EventSubscriberInstance = StaticAutomatic;

//     [EventSubscriber(ObjectType::Codeunit, 5705, 'OnAfterTransferOrderPostReceipt', '', false, false)]
//     procedure TransferComments(VAR TransferHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; VAR TransferReceiptHeader: Record "Transfer Receipt Header")
//     var
//         TransferComments: Record "Transfer Transaction Comments";
//         PostedTransferComments: Record "Posted Transfer Txn. Comments";
//     begin
//         TransferComments.Reset();
//         TransferComments.SetRange("Document Type", TransferComments."Document Type"::"Transfer Order");
//         TransferComments.SetRange("Document No.", TransferHeader."No.");
//         if TransferComments.FindSet(false, false) then
//             repeat
//                 PostedTransferComments.Init();
//                 PostedTransferComments."Document Type" := PostedTransferComments."Document Type"::"Transfer Receipt";
//                 PostedTransferComments."Document No." := TransferReceiptHeader."No.";
//                 PostedTransferComments."Line No." := TransferComments."Line No.";
//                 PostedTransferComments.Comments := TransferComments.Comments;
//                 PostedTransferComments.Insert();
//             until TransferComments.Next() = 0;
//     end;
// }
