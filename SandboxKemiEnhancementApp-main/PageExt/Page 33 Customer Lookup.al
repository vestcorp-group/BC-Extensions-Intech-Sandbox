// pageextension 80030 "Customer Lookup_Ext" extends "Customer Lookup"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         addafter(Name)
//         {
//             field(AltCustomerName; Rec.AltCustomerName)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Customer Alternate short name';
//             }
//         }
//         modify("Search Name")
//         {
//             Caption = 'Customer Short Name';
//         }
//     }

//     actions
//     {
//         // Add changes to page actions here
//     }

//     var
//         myInt: Integer;
// }