// pageextension 58252 PostedsalesCrememos extends "Posted Sales Credit Memos"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("No. Printed")
//         {
//             field("User ID"; rec."User ID")
//             {
//                 ApplicationArea = all;
//             }
//         }
//     }
//     trigger OnDeleteRecord(): Boolean
//     begin
//         Error('Not allowed to delete the record!');
//     end;
// }
