// pageextension 58035 Customer extends "Customer Lookup"//T12370-Full Comment
// {

//     layout
//     {
//         modify("Post Code")
//         {
//             Visible = false;
//         }
//         modify("Phone No.")
//         {
//             Visible = false;
//         }
//         modify(Contact)
//         {
//             Visible = false;
//         }
//         addafter(Name)
//         {
//             field("Short Name"; rec."Search Name")
//             {
//                 Caption = 'Customer Short Name';
//                 ApplicationArea = all;
//             }
//         }
//     }
//     var
// }