// pageextension 50299 KMP_BlanketAssOrderExt extends "Blanket Assembly Order"//T12370-Full Comment
// {
//     layout
//     {
//         addafter(Quantity)
//         {
//             field(Vessel; rec.Vessel)
//             {
//                 ApplicationArea = ALL;
//             }
//         }
//     }

//     actions
//     {
//         // Add changes to page actions here
//     }

//     var
//         myInt: Integer;
// }