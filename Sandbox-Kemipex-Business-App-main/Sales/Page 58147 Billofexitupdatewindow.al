// page 58147 Billofexitupdatewindow//T12370-Full Comment
// {
//     PageType = Card;
//     Caption = 'Update Declaration & Shipment Date';
//     ApplicationArea = All;
//     UsageCategory = Documents;
//     SourceTable = "Sales Invoice Header";
//     Permissions = tabledata 112 = rm;
//     Editable = true;
//     DeleteAllowed = false;

//     layout
//     {
//         area(Content)
//         {
//             group("Customs Declaration")
//             {
//                 field("No."; rec."No.")
//                 {
//                     Caption = 'Sales Invoice No.';
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Declaration Type"; rec."Declaration Type")
//                 {
//                     ApplicationArea = all;
//                     Enabled = BOE_boolean;
//                     trigger OnValidate()
//                     var
//                         YesUpdate: Boolean;
//                     begin
//                         if (rec."Declaration Type" = rec."Declaration Type"::Direct) then
//                             rec.Validate(BillOfExit, Format(rec."Declaration Type"));
//                         if rec.BillOfExit = 'Direct' then BOE_boolean := false;
//                     end;
//                 }
//                 field(BillOfExit; rec.BillOfExit)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Declaration No.';
//                     Editable = true;
//                     Enabled = BOE_boolean;
//                     trigger OnValidate()
//                     var
//                     begin
//                         if rec.BillOfExit <> '' then BOE_boolean := false;
//                     end;
//                 }
//                 field("Actual Shipment Date"; rec."Actual Shipment Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                     Enabled = ShipmentDate_boolean;

//                     trigger OnValidate()
//                     var
//                         ConfirmUpdate: Boolean;
//                     begin

//                         ConfirmUpdate := Dialog.Confirm('Do you want to Update Shipment date %1?', true, Rec."Actual Shipment Date");
//                         if ConfirmUpdate = false then
//                             Rec."Actual Shipment Date" := xRec."Actual Shipment Date";

//                         if rec."Actual Shipment Date" <> 0D then ShipmentDate_boolean := false;
//                     end;
//                 }
//             }
//         }
//     }
//     trigger OnAfterGetCurrRecord()
//     var
//         myInt: Integer;
//     begin
//         if rec.BillOfExit = '' then
//             BOE_boolean := true
//         else
//             BOE_boolean := false;


//         if rec."Actual Shipment Date" = 0D then
//             ShipmentDate_boolean := true
//         else
//             ShipmentDate_boolean := false;


//     end;

//     var
//         BOE_boolean: Boolean;
//         ShipmentDate_boolean: Boolean;
// }