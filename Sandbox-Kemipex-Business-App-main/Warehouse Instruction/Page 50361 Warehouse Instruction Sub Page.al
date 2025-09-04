// pageextension 58243 WarehouseDISubform extends "Warehouse Instruction Sub Page"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("No.")
//         {
//             field("Variant Code"; rec."Variant Code")
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
//     }

// }