// pageextension 70009 "Sales Order Archive Ext" extends "Sales Order Archive"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//     }

//     actions
//     {
//         addlast(processing)
//         {
//             action(Remarks)
//             {
//                 Image = Comment;
//                 RunObject = page "Remarks Archive Part";
//                 Promoted = true;
//                 RunPageLink = "No." = field("No."), "Document Type" = filter(Order), "Document Line No." = const(0), "Version No." = field("Version No.");
//                 ApplicationArea = All;
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }