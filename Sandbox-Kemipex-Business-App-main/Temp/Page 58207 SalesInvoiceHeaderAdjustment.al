// page 58207 SalesInvoiceHeaderAdjustment//T12370-Full Comment
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Administration;
//     SourceTable = "Sales Invoice Header";
//     Permissions = tabledata 112 = rm;
//     Caption = 'Sales Invoice Header Adjustment';
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
// }