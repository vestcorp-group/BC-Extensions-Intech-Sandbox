// codeunit 80002 ValidateCustomer//T12370-Full Comment
// {
//     EventSubscriberInstance = StaticAutomatic;

//     [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
//     procedure ValidateCustomerNo(var Rec: Record "Sales Header")
//     var
//         Customer_Rec: Record Customer;
//     begin
//         if Rec."Document Type" = Rec."Document Type"::Order then
//             if Customer_Rec.Get(Rec."Sell-to Customer No.") then
//                 if Customer_Rec."IC Partner Code" = '' then
//                     Error(ErrorLabel);
//     end;

//     [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Sell-to Customer Name', false, false)]
//     procedure ValidateCustomerName(var Rec: Record "Sales Header")
//     var
//         Customer_Rec: Record Customer;
//     begin
//         if Rec."Document Type" = Rec."Document Type"::Order then
//             if Customer_Rec.Get(Rec."Sell-to Customer No.") then
//                 if Customer_Rec."IC Partner Code" = '' then
//                     Error(ErrorLabel);
//     end;

//     var
//         ErrorLabel: Label 'Only Inter company Sales order is allowed. please contact your administration.';
// }