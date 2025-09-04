// pageextension 58255 PostedAssemblyOrders extends "Posted Assembly Orders"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("Unit Cost")
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
