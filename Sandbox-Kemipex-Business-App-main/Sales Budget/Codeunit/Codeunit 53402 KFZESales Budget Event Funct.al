// codeunit 53402 "KFZESales Budget Event Funct."//T12370-Full Comment
// {
//     internal procedure OnAfterInsertEvent_ItemBudgetEntry(var ItemBudgetEntry: Record "Item Budget Entry"; RunTrigger: Boolean)
//     var
//         ItemBudgetName: Record "Item Budget Name";
//         Item: Record Item;
//         UserSetup: Record "User Setup";
//         TeamSalesperson: Record "Team Salesperson";
//     begin
//         if ItemBudgetEntry."Analysis Area" <> ItemBudgetEntry."Analysis Area"::Sales then
//             exit;
//         ItemBudgetName.Get(ItemBudgetEntry."Analysis Area", ItemBudgetEntry."Budget Name");
//         ItemBudgetName.TestField(Blocked, false);
//         UserSetup.Get(UserId);

//         if UpperCase(ItemBudgetName."KFZEShow as Lines") = UpperCase(Item.TableCaption()) then
//             if ItemBudgetName."KFZEShow Value as" = ItemBudgetName."KFZEShow Value as"::Quantity then
//                 PickPrice(ItemBudgetEntry);

//         ItemBudgetEntry."KFZESalesperson Code" := UserSetup."Salespers./Purch. Code";
//         if UserSetup."Salespers./Purch. Code" > '' then begin
//             TeamSalesperson.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
//             if TeamSalesperson.FindFirst() then
//                 ItemBudgetEntry."KFZESales Team" := TeamSalesperson."Team Code";
//         end;
//         ItemBudgetEntry.Modify();

//     end;

//     internal procedure OnAfterValidateEvent_Quantity_ItemBudgetEntry(var ItemBudgetEntry: Record "Item Budget Entry")
//     var
//         ItemBudgetName: Record "Item Budget Name";
//         Item: Record Item;
//         UserSetup: Record "User Setup";
//         TeamSalesperson: Record "Team Salesperson";
//     begin
//         if ItemBudgetEntry."Analysis Area" <> ItemBudgetEntry."Analysis Area"::Sales then
//             exit;
//         ItemBudgetName.Get(ItemBudgetEntry."Analysis Area", ItemBudgetEntry."Budget Name");
//         ItemBudgetName.TestField(Blocked, false);

//         if UpperCase(ItemBudgetName."KFZEShow as Lines") = UpperCase(Item.TableCaption()) then
//             if ItemBudgetName."KFZEShow Value as" = ItemBudgetName."KFZEShow Value as"::Quantity then
//                 PickPrice(ItemBudgetEntry);
//     end;

//     local procedure GetPriceCalculationHandler(ItemNo: Code[20]; Qty: Decimal; var PriceCalculation: Interface "Price Calculation")
//     var
//         SalesLine: Record "Sales Line";
//         PriceCalculationMgt: codeunit "Price Calculation Mgt.";
//         LineWithPrice: Interface "Line With Price";
//     begin
//         SalesLine.init();
//         SalesLine.Type := SalesLine.Type::Item;
//         SalesLine."No." := ItemNo;
//         SalesLine.Quantity := 1;
//         GetLineWithPrice(LineWithPrice);
//         LineWithPrice.SetLine(Enum::"Price Type"::Sale, SalesLine);
//         PriceCalculationMgt.GetHandler(LineWithPrice, PriceCalculation);

//     end;

//     local procedure GetLineWithPrice(var LineWithPrice: Interface "Line With Price")
//     var
//         SalesLinePrice: Codeunit "Sales Line - Price";
//     begin
//         LineWithPrice := SalesLinePrice;
//     end;

//     local procedure PickPrice(var ItemBudgetEntry: Record "Item Budget Entry")
//     var
//         PriceCalculation: Interface "Price Calculation";
//         TempPriceListLine: Record "Price List Line" temporary;
//         ShowAll: Boolean;
//     begin
//         GetPriceCalculationHandler(ItemBudgetEntry."Item No.", ItemBudgetEntry.Quantity, PriceCalculation);
//         PriceCalculation.FindPrice(TempPriceListLine, false);
//         if TempPriceListLine.FindFirst() then
//             ItemBudgetEntry."Sales Amount" := TempPriceListLine."Unit Price" * ItemBudgetEntry.Quantity;
//     end;
// }