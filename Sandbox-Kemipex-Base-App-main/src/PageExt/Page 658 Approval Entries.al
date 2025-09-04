// pageextension 50435 ApprovalEntry extends "Approval Entries"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         addafter(Details)
//         {
//             field("Short Name"; rec."Short Name")
//             {
//                 ApplicationArea = all;
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