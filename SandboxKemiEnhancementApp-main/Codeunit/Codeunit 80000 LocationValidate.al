// codeunit 80000 LocationValidate//T12370-Full Comment
// {
//     EventSubscriberInstance = StaticAutomatic;

//     [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Location Code', false, false)]
//     procedure LocationCodeValidation(var Rec: Record "Sales Header")
//     var
//         Location: Record Location;
//         LocationError: Label 'You cannot select restricted location.';
//     begin
//         if Location.Get(Rec."Location Code") then begin
//             if Location."Production Warehouse" = true then
//                 Error(LocationError);
//         end;
//     end;

//     [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'Location Code', false, false)]
//     procedure LocationValidateSalesLine(var Rec: Record "Sales Line")
//     var
//         Location: Record Location;
//         LocationError: Label 'You cannot select restricted location.';
//     begin
//         if Location.Get(Rec."Location Code") then begin
//             if Location."Production Warehouse" = true then
//                 Error(LocationError);
//         end;
//     end;

//     [EventSubscriber(ObjectType::table, 36, 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
//     procedure getBankAcc(var Rec: Record "Sales Header")
//     var
//         cust: Record Customer;
//     begin
//         if cust.get(Rec."Sell-to Customer No.") then
//             Rec."Bank on Invoice 2" := cust."Default Bank Account"; //PackingListExtChange
//     end;

//     [EventSubscriber(ObjectType::table, 36, 'OnAfterValidateEvent', 'Bank on Invoice 2', false, false)] //PackingListExtChange
//     procedure RestrictBankAcc(var Rec: Record "Sales Header")
//     var
//         BankAcc: Record "Bank Account";
//     begin
//         if BankAcc.get(Rec."Bank on Invoice 2") then
//             if BankAcc.Restricted then
//                 Error('You cannot select restricted Bank.');
//     end;
// }
