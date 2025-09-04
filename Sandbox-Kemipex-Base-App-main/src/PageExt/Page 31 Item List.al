// pageextension 50457 ItemListext extends "Item List"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         addfirst(factboxes)
//         {
//             part(Picture; "Item Picture")
//             {
//                 SubPageLink = "No." = field("No.");
//                 ApplicationArea = all;
//                 Caption = 'Item Picture';
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