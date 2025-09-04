// codeunit 50457 "Item Record Codeunit"//T12370-Full Comment
// {
//     trigger OnRun()
//     begin

//     end;

//     var
//         myInt: Integer;

//     procedure CreateItemCompanyBlockBatch(ItemCode: Code[20])
//     var
//         ItemCompanyblockRec: Record "Item Company Block";
//         CompanyRec: Record Company;
//         ItemRec: Record Item;
//     begin
//         if CompanyRec.FindSet() then begin
//             repeat
//                 ItemRec.ChangeCompany(CompanyRec.Name);
//                 if ItemRec.Get(itemCode) then begin
//                     if not ItemCompanyblockRec.Get(ItemRec."No.", CompanyRec.Name) then begin
//                         ItemCompanyblockRec.Init();
//                         ItemCompanyblockRec."Item No." := ItemRec."No.";
//                         ItemCompanyblockRec.Company := CompanyRec.Name;
//                         if ItemCompanyblockRec.Insert then ItemCompanyblockRec.ValidateItemCompanyBlock(ItemRec."No.");
//                     end;
//                 end;
//             until CompanyRec.Next() = 0;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterInsertEvent', '', true, true)]
//     local procedure ValidateInsertItemCompanyBlock(var Rec: Record Item)
//     var
//         ItemCompanyBlock: Record "Item Company Block";
//     begin
//         CreateItemCompanyBlockBatch(rec."No.");
//     end;

//     [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterDeleteRelatedData', '', true, true)]
//     local procedure ValidateItemDeleteCompanyBlock(Item: Record Item)
//     var
//         ItemCompanyBlock: Record "Item Company Block";
//     begin
//         ItemCompanyBlock.SetRange("Item No.", Item."No.");
//         ItemCompanyBlock.SetRange(Company, Item.CurrentCompany);
//         if ItemCompanyBlock.FindFirst() then
//             ItemCompanyBlock.Delete();
//     end;

// }