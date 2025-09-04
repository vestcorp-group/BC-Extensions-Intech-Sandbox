// page 58208 SalesShipmentHeaderAdjustment//T12370-Full Comment
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Administration;
//     SourceTable = "Sales Shipment Header";
//     Permissions = tabledata 110 = rm;
//     Caption = 'Sales Shipment Header Adjustment';
//     Editable = true;
//     DeleteAllowed = false;
//     InsertAllowed = false;

//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Sell-to Customer No."; rec."Sell-to Customer No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Sell-to Customer Name"; rec."Sell-to Customer Name")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Tax Type"; rec."Tax Type")
//                 {
//                     ApplicationArea = All;
//                     Editable = true;
//                 }
//                 field("VAT Registration No."; rec."VAT Registration No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = true;
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
//         GENLIne: Record 81;
// }