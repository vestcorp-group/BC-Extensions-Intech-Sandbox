// page 50438 "Salesperson Customer Groups"//T12370-Full Comment
// {

//     Caption = 'Customer Groups';
//     PageType = ListPart;
//     SourceTable = "Salesperson Customer Group";
//     // UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Salesperson code"; Rec."Salesperson code")
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Salesperson Name"; Rec."Salesperson Name")
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Region Code"; Rec."Customer Group Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Region Description"; Rec."Region Description")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }
//     var
//         Item: Record Item;
// }

