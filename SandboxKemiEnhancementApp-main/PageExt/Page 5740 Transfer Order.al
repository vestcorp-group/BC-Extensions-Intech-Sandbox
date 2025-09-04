// pageextension 80003 TransferOrderPageExt extends "Transfer Order"//T12370-Full Comment
// {
//     layout
//     {

//     }

//     actions
//     {
//         addlast(navigation)
//         {
//             action("R&emarks")
//             {
//                 Image = ViewComments;
//                 ApplicationArea = All;
//                 trigger OnAction()
//                 var
//                     TransferComments: Record "Transfer Transaction Comments";
//                 begin
//                     TransferComments.Reset();
//                     TransferComments.SetRange("Document Type", TransferComments."Document Type"::"Transfer Order");
//                     TransferComments.SetRange("Document No.", Rec."No.");
//                     if TransferComments.FindFirst() then;

//                     Page.RunModal(80001, TransferComments)
//                 end;
//             }

//         }
//     }

//     var
//         myInt: Integer;
// }