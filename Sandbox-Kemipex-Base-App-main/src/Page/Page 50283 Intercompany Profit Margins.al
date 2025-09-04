// page 50283 "Intercompany Profit Margins"//T12370-Full Comment
// {
//     PageType = List;
//     SourceTable = "Intercompany Profit Margin";

//     layout
//     {
//         area(Content)
//         {
//             repeater(General)
//             {
//                 field("From Company"; rec."From Company")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("To Company"; rec."To Company")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Profit Margin %"; rec."Profit Margin %")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }