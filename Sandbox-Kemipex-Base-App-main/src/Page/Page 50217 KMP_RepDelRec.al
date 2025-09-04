// page 50217 KMP_RepDelRec//T12370-Full Comment
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Administration;
//     SourceTable = 337;
//     Caption = 'Remove Record From Res. Entry';
//     layout
//     {
//         area(Content)
//         {
//             repeater(Group)
//             {
//                 field("Entry No."; rec."Entry No.")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Item No."; rec."Item No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Quantity (Base)"; rec."Quantity (Base)")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Reservation Status"; rec."Reservation Status")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Creation Date"; rec."Creation Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Source ID"; rec."Source ID")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Source Ref. No."; rec."Source Ref. No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Item Ledger Entry No."; rec."Item Ledger Entry No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Lot No."; rec."Lot No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Supplier Batch No."; rec."Supplier Batch No. 2")
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