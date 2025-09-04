// pageextension 58248 Vendorlistpageext extends "Vendor List"//T12370-Full Comment
// {
//     layout
//     {
//         addafter(Blocked)
//         {
//             field("Blocked Reason"; rec."Blocked Reason")
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