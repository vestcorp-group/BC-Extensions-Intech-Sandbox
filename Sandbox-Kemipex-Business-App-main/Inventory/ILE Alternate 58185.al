// page 58185 ILE2//T12370-Full Comment
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Lists;
//     SourceTable = "Item Ledger Entry";
//     Permissions = tabledata "Item Ledger Entry" = rm;
//     SourceTableView = where("Document Type" = filter("Purchase Receipt"), "Invoiced Quantity" = filter(> 0), "Cost Amount (Actual)" = filter(= 0));

//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {
//                 field("Entry No."; rec."Entry No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Document No."; rec."Document No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Entry Type"; rec."Entry Type")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Document Type"; rec."Document Type")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Item No."; rec."Item No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Location Code"; rec."Location Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(Quantity; rec.Quantity)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Remaining Quantity"; rec."Remaining Quantity")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }

//                 field("Lot No."; rec."Lot No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(CustomBOENumber; rec.CustomBOENumber)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(CustomBOENumber2; rec.CustomBOENumber2)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(CustomLotNumber; rec.CustomLotNumber)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Completely Invoiced"; rec."Completely Invoiced")
//                 {
//                     ApplicationArea = All;
//                     Editable = true;

//                     trigger OnValidate()
//                     var
//                         myInt: Integer;
//                     begin
//                         if rec."Entry Type" <> rec."Entry Type"::Purchase then Error('Entry Type is not Purchase');
//                         if rec."Cost Amount (Actual)" = 0 then begin
//                             if Rec.Modify() then;
//                         end
//                         else
//                             Error('Invoice is already Posted ');
//                     end;
//                 }
//                 field("Invoiced Quantity"; rec."Invoiced Quantity")
//                 {
//                     ApplicationArea = All;
//                     Editable = true;
//                     trigger OnValidate()
//                     var
//                         myInt: Integer;
//                     begin
//                         if rec."Entry Type" <> rec."Entry Type"::Purchase then Error('Entry Type is not Purchase');
//                         if rec."Invoiced Quantity" <= rec.Quantity then begin
//                             if rec."Cost Amount (Actual)" = 0 then begin
//                                 if Rec.Modify() then;
//                             end
//                             else
//                                 Error('Invoice is already Posted ');
//                         end
//                         else
//                             Error('Invoiced Qty cannot be more than Quantity');
//                     end;
//                 }
//                 field("Cost Amount (Expected)"; rec."Cost Amount (Expected)")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Cost Amount (Actual)"; rec."Cost Amount (Actual)")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//             }
//         }
//         area(Factboxes)
//         {

//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action(ActionName)
//             {
//                 ApplicationArea = All;

//                 trigger OnAction();
//                 begin

//                 end;
//             }
//         }
//     }
// }