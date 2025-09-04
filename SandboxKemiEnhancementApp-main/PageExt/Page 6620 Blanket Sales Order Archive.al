// pageextension 70006 "Blanket Sales Order Arch. Ext" extends "Blanket Sales Order Archive"//T12370-Full Comment
// {

//     actions
//     {
//         // Add changes to page actions here
//         addlast(processing)
//         {
//             action(Remarks)
//             {
//                 Image = Comment;
//                 RunObject = page "Remarks Archive Part";
//                 Promoted = true;
//                 RunPageLink = "No." = field("No."), "Document Type" = filter("Blanket Order"), "Document Line No." = const(0), "Version No." = field("Version No.");
//                 ApplicationArea = All;
//             }

//         }
//     }

//     var
//         myInt: Integer;
// }