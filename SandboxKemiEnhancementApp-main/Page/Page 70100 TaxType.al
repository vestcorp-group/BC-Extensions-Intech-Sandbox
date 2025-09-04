// page 70100 TaxType//T12370-Full Comment
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Administration;
//     SourceTable = TaxType;
//     Caption = 'Tax Type';

//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {
//                 field("Tax Type Code"; rec."Tax Type Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Tax Type Description"; rec."Tax Type Description")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }