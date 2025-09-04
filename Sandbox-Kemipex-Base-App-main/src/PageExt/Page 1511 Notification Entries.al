// pageextension 50465 NotificationEntryPgExt extends "Notification Entries"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//     }
//     actions
//     {
//         // Add changes to page actions here
//         addfirst(Creation)
//         {
//             action("Delete Record")
//             {
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedCategory = New;
//                 PromotedIsBig = true;
//                 trigger OnAction()
//                 var

//                 begin
//                     Rec.Delete();
//                 end;
//             }
//             action("Delete All Record")
//             {
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedCategory = New;
//                 PromotedIsBig = true;
//                 trigger OnAction()
//                 var

//                 begin
//                     Rec.DeleteAll();
//                 end;
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }