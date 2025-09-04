// pageextension 80029 "Customer List_Ext" extends "Customer List"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         addafter(Name)
//         {
//             field(AltCustomerName; Rec.AltCustomerName)
//             {
//                 Caption = 'Customer Alternate Short Name';
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