// pageextension 53050 transferordersubform extends "Transfer Order Subform"//T12370-Full Comment
// {
//     layout
//     {
//         modify("Variant Code")
//         {
//             Visible = true;
//             Editable = true;

//             /* trigger OnLookup(var Text: Text): Boolean
//             var
//                 ItemVariant: Record "Item Variant";
//                 ItemVariantPage: Page "Item Variants";
//             begin
//                 ItemVariant.Reset();
//                 ItemVariant.FilterGroup(2);
//                 ItemVariant.SetRange("Item No.", Rec."Item No.");
//                 ItemVariant.SetRange(Blocked, false);
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
//             end; */
//         }
//     }
// }
