// codeunit 53400 "KFZESales Budget Events"//T12370-Full Comment
// {
//     var
//         SalesBugetEventFunct: Codeunit "KFZESales Budget Event Funct.";

//     [EventSubscriber(ObjectType::Table, Database::"Item Budget Entry", 'OnAfterInsertEvent', '', true, true)]
//     local procedure OnAfterInsertEvent_ItemBudgetEntry(var Rec: Record "Item Budget Entry"; RunTrigger: Boolean)
//     begin
//         SalesBugetEventFunct.OnAfterInsertEvent_ItemBudgetEntry(Rec, RunTrigger);
//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Item Budget Entry", 'OnAfterValidateEvent', 'Quantity', true, true)]
//     local procedure OnAfterValidateEvent_Quantity_ItemBudgetEntry(var Rec: Record "Item Budget Entry")
//     begin
//         SalesBugetEventFunct.OnAfterValidateEvent_Quantity_ItemBudgetEntry(Rec);
//     end;
// }