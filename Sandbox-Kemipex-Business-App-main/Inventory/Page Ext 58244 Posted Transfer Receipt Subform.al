// pageextension 58244 postedtransferreceiptsubform extends "Posted Transfer Rcpt. Subform"//T12370-Full Comment
// {
//     layout
//     {
//         modify("Variant Code")
//         {
//             Visible = true;
//             Editable = false;

//             trigger OnLookup(var Text: Text): Boolean
//             var
//                 ItemVariant: Record "Item Variant";
//                 ItemVariantPage: Page "Item Variants";
//             begin
//                 ItemVariant.Reset();
//                 ItemVariant.FilterGroup(2);
//                 ItemVariant.SetRange("Item No.", Rec."Item No.");
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
// }
