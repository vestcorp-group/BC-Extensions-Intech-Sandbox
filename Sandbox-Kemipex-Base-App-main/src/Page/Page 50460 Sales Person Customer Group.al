// page 50460 "Sales Person Customer Group"//T12370-Full Comment
// {
//     Caption = 'Salesperson Customer Group List';
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Administration;
//     SourceTable = "Salesperson Customer Group";

//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {
//                 field("Customer Group Code"; rec."Customer Group Code")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Region Description"; rec."Region Description")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Salesperson code"; rec."Salesperson code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Salesperson Name"; rec."Salesperson Name")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action(ActionName)
//             {
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 begin

//                 end;
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }