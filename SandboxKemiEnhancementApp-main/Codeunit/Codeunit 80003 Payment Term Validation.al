codeunit 80003 "Payment Term Validation"
{
    // EventSubscriberInstance = StaticAutomatic;

    // [EventSubscriber(ObjectType::table, 36, 'onAfterValidateEvent', 'Sell-to Customer No.', true, true)]
    // local procedure PaymentTermsValidation(var Rec: Record "Sales Header")
    // begin
    //     if Rec."Document Type" = Rec."Document Type"::"Blanket Order" then
    //         if Customer_Rec.get(Rec."Sell-to Customer No.") then
    //             if Customer_Rec."IC Partner Code" = '' then
    //                 if Customer_Rec."Payment Terms Code" = '' then
    //                     Error('Update payment terms in customer master.');
    // end;

    // [EventSubscriber(ObjectType::Table, 36, 'onAfterValidateEvent', 'Payment Terms Code', true, true)]
    // local procedure canModifyPaymentTerms(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    // begin
    //     if Rec."Document Type" = Rec."Document Type"::"Blanket Order" then
    //         if Customer_Rec.GET(Rec."Sell-to Customer No.") THEN
    //             IF Customer_Rec."IC Partner Code" = '' THEN
    //                 if xRec."Payment Terms Code" <> '' then begin
    //                     PaymentTermforSalesHeader_Rec.Get(Rec."Payment Terms Code");
    //                     PaymentTermforCustomer_Rec.Get(Customer_Rec."Payment Terms Code");
    //                     DocumentDateCalculation := CalcDate(PaymentTermforSalesHeader_Rec."Due Date Calculation", Rec."Document Date");
    //                     CustomerDateCalculation := CalcDate(PaymentTermforCustomer_Rec."Due Date Calculation", Rec."Document Date");
    //                     if DocumentDateCalculation > CustomerDateCalculation then begin
    //                         UserSetup_Rec.SetRange("User ID", UserId);
    //                         if UserSetup_Rec.FindFirst() then
    //                             if not UserSetup_Rec."Allow Payment Terms on Sales1" then
    //                                 Error('Select Payment Terms less than or equal to %1. Please contact to administrator.', PaymentTermforCustomer_Rec."Due Date Calculation");
    //                     end;
    //                 end;
    // end;

    // var
    //     UserSetup_Rec: Record "User Setup";
    //     Customer_Rec: Record Customer;
    //     PaymentTermforSalesHeader_Rec: Record "Payment Terms";
    //     PaymentTermforCustomer_Rec: Record "Payment Terms";
    //     DocumentDateCalculation: Date;
    //     CustomerDateCalculation: Date;

}