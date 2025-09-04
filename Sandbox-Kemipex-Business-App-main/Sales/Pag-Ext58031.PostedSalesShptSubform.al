// pageextension 58031 "Posted Sales Shpt. Subform" extends "Posted Sales Shpt. Subform"//T12370-Full Comment
// {
//     layout
//     {
//         addlast(Control1)
//         {
//             field("Item Incentive Point (IIP)"; Rec."Item Incentive Point (IIP)")
//             {
//                 ApplicationArea = All;
//             }
//             field("Transaction Type"; rec."Transaction Type")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Order Type';
//             }
//             field("Container Size"; rec."Container Size")
//             {
//                 ApplicationArea = All;
//             }
//             field("Shipping Remarks"; rec."Shipping Remarks")
//             {
//                 ApplicationArea = All;
//             }
//             field("In-Out Instruction"; rec."In-Out Instruction")
//             {
//                 ApplicationArea = All;
//             }
//             field("Shipping Line"; rec."Shipping Line")
//             {
//                 ApplicationArea = All;
//             }
//             field("BL-AWB No."; rec."BL-AWB No.")
//             {
//                 ApplicationArea = All;
//             }
//             field("Vessel-Voyage No."; rec."Vessel-Voyage No.")
//             {
//                 ApplicationArea = all;
//             }
//             field("Freight Forwarder"; rec."Freight Forwarder")
//             {
//                 ApplicationArea = all;
//             }
//             field("Freight Charge"; rec."Freight Charge")
//             {
//                 ApplicationArea = all;
//             }
//         }
//         addafter("No.")
//         {
//             field("Variant Code1"; rec."Variant Code")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Variant Code';

//                 trigger OnLookup(var Text: Text): Boolean
//                 var
//                     ItemVariant: Record "Item Variant";
//                     ItemVariantPage: Page "Item Variants";
//                 begin
//                     ItemVariant.Reset();
//                     ItemVariant.FilterGroup(2);
//                     ItemVariant.SetRange("Item No.", Rec."No.");
//                     ItemVariant.SetRange(Blocked1, false);
//                     Clear(ItemVariantPage);
//                     ItemVariantPage.SetRecord(ItemVariant);
//                     ItemVariantPage.SetTableView(ItemVariant);
//                     ItemVariantPage.LookupMode(true);
//                     if ItemVariantPage.RunModal() = Action::LookupOK then begin
//                         ItemVariantPage.GetRecord(ItemVariant);
//                         Rec."Variant Code" := ItemVariant.Code;
//                         rec.Validate("Variant Code");
//                     end;
//                     ItemVariant.FilterGroup(0);
//                 end;
//             }
//         }
//         modify("Variant Code")
//         {
//             trigger OnLookup(var Text: Text): Boolean
//             var
//                 ItemVariant: Record "Item Variant";
//                 ItemVariantPage: Page "Item Variants";
//             begin
//                 ItemVariant.Reset();
//                 ItemVariant.FilterGroup(2);
//                 ItemVariant.SetRange("Item No.", Rec."No.");
//                 ItemVariant.SetRange(Blocked1, false);
//                 Clear(ItemVariantPage);
//                 ItemVariantPage.SetRecord(ItemVariant);
//                 ItemVariantPage.SetTableView(ItemVariant);
//                 ItemVariantPage.LookupMode(true);
//                 if ItemVariantPage.RunModal() = Action::LookupOK then begin
//                     ItemVariantPage.GetRecord(ItemVariant);
//                     Rec."Variant Code" := ItemVariant.Code;
//                     rec.Validate("Variant Code");
//                 end;
//                 ItemVariant.FilterGroup(0);
//             end;
//         }
//     }
//     actions
//     {
//         // Add changes to page actions here
//         //08-08-2022-start
//         addlast("&Line")
//         {
//             action("Update Line")
//             {
//                 ApplicationArea = All;
//                 Image = UpdateDescription;
//                 // Promoted = true;
//                 // PromotedOnly = true;
//                 trigger OnAction()
//                 var
//                     RecLine: Record "Sales Shipment Line";
//                     UpdateShptLine: Page "Update Sales Shipment Line";
//                     UserSetup: Record "User Setup";
//                 begin
//                     UserSetup.GET(UserId);
//                     if not UserSetup."Modify Posted Sales Shpt Line" then
//                         Error('You do not have permission to modify Posted Sales Shipment Line.');
//                     Clear(RecLine);
//                     RecLine.SetRange("Document No.", Rec."Document No.");
//                     RecLine.SetRange("Line No.", Rec."Line No.");
//                     RecLine.FindFirst();
//                     Clear(UpdateShptLine);
//                     UpdateShptLine.SetTableView(RecLine);
//                     UpdateShptLine.RunModal();
//                 end;
//             }
//         }
//         //08-08-2022-end
//     }
// }
