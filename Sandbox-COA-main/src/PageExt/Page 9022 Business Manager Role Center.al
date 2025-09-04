// pageextension 50502 "Business Manager RC Ext" extends "Business Manager Role Center"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//     }

//     actions
//     {
//         addafter(Items)
//         {
//             action("Testing Parameters")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Testing Parameters';
//                 ToolTip = 'View or edit the testing parameters';
//                 RunObject = page "Testing Parameters";
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }