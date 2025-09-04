// pageextension 58180 SP_list extends "Salespersons/Purchasers"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("Short Name")
//         {
//             field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 Visible = false;
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