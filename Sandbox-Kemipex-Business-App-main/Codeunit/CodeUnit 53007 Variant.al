// codeunit 53007 VariantEvents//T12370-Full Comment
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnCreatePurchLinesOnAfterModify', '', true, true)]
//     local procedure OnCreatePurchLinesOnAfterModify(var PurchaseLine: Record "Purchase Line"; ICInboxPurchLine: Record "IC Inbox Purchase Line")
//     begin
//         ItemVariant.SetRange(Code, ICInboxPurchLine."Variant Code");
//         ItemVariant.SetRange("Item No.", PurchaseLine."No.");
//         if ItemVariant.FindFirst() then begin
//             PurchaseLine."Item HS Code" := ItemVariant.HSNCode;
//             PurchaseLine.Item_COO := ItemVariant.CountryOfOrigin;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnCreatePurchLinesOnAfterTransferFields', '', true, true)]
//     local procedure OnCreatePurchLinesOnAfterTransferFields(var PurchaseLine: Record "Purchase Line"; ICInboxPurchLine: Record "IC Inbox Purchase Line")
//     begin
//         ItemVariant.SetRange(Code, ICInboxPurchLine."Variant Code");
//         ItemVariant.SetRange("Item No.", PurchaseLine."No.");
//         if ItemVariant.FindFirst() then begin
//             PurchaseLine."Item HS Code" := ItemVariant.HSNCode;
//             PurchaseLine.Item_COO := ItemVariant.CountryOfOrigin;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnAfterCreatePurchLines', '', true, true)]
//     local procedure OnAfterCreatePurchLines(ICInboxPurchLine: Record "IC Inbox Purchase Line"; var PurchLine: Record "Purchase Line")
//     begin
//         ItemVariant.SetRange(Code, ICInboxPurchLine."Variant Code");
//         ItemVariant.SetRange("Item No.", PurchLine."No.");
//         if ItemVariant.FindFirst() then begin
//             PurchLine."Item HS Code" := ItemVariant.HSNCode;
//             PurchLine.Item_COO := ItemVariant.CountryOfOrigin;
//         end;
//     end;


//     var
//         ItemVariant: Record "Item Variant";
// }