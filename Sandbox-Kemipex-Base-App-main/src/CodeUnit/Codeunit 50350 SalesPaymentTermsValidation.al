// codeunit 50350 "SalesPaymentTermsValidation" //T12370-Full Comment
// {
//     EventSubscriberInstance = StaticAutomatic;
//     trigger OnRun()
//     var
//         myInt: Integer;
//     begin

//     end;

//     [EventSubscriber(ObjectType::table, 36, 'onAfterValidateEvent', 'Sell-to Customer No.', true, true)]
//     local procedure PaymentTermsValidation(var Rec: Record "Sales Header")
//     begin
//         if Rec."Document Type" = Rec."Document Type"::"Blanket Order" then
//             if Customer_Rec.get(Rec."Sell-to Customer No.") then
//                 if Customer_Rec."IC Partner Code" = '' then
//                     if Customer_Rec."Payment Terms Code" = '' then
//                         Error('Update payment terms in customer master.');
//     end;

//     [EventSubscriber(ObjectType::Table, 36, 'onAfterValidateEvent', 'Payment Terms Code', true, true)]
//     local procedure BSOPaymentValidation(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
//     var
//         ApprovedpaymentTerm: Boolean;
//     begin
//         if Rec."Document Type" = Rec."Document Type"::"Blanket Order" then
//             if Customer_Rec.GET(Rec."Sell-to Customer No.") THEN
//                 IF Customer_Rec."IC Partner Code" = '' THEN begin
//                     PaymentTermforSalesHeader_Rec.Get(Rec."Payment Terms Code");
//                     PaymentTermforCustomer_Rec.get(Customer_Rec."Payment Terms Code");
//                     ApprovedpaymentTerm := ValidatePaymenttermDuedays(Customer_Rec."Payment Terms Code", rec."Payment Terms Code", rec."Document Date");
//                     UserSetup_Rec.Get(UserId);
//                     if UserSetup_Rec."Allow Payment Terms on Sales" then begin
//                         if ApprovedpaymentTerm then
//                             Rec."Maximum Allowed Due days" := PaymentTermforCustomer_Rec."Due Date Calculation"
//                         else
//                             Rec."Maximum Allowed Due days" := PaymentTermforSalesHeader_Rec."Due Date Calculation";
//                     end
//                     else
//                         if Format(Rec."Maximum Allowed Due days") <> '' then begin
//                             if CalcDate(PaymentTermforSalesHeader_Rec."Due Date Calculation", Rec."Document Date") > CalcDate(rec."Maximum Allowed Due days", Rec."Document Date") then
//                                 Error('Select Payment Terms less than or equal to %1. Please contact to administrator.', rec."Maximum Allowed Due days")
//                         end
//                         else
//                             if Format(Rec."Maximum Allowed Due days") = '' then begin
//                                 rec."Maximum Allowed Due days" := PaymentTermforCustomer_Rec."Due Date Calculation";
//                                 if rec.Modify() then;
//                             end;
//                 end;
//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Payment Terms Code', true, true)]
//     local procedure SalesOrderPaymentTermValidation(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
//     var
//         cust_master: Record Customer;
//         paymentterms: Record "Payment Terms";
//         usersetup: Record "User Setup";
//         CustomerPaymentterm: Record "Payment Terms";
//         SaleheaderPaymentTerm: Record "Payment Terms";
//         Cust_mast_duedate: Date;
//         SOduedate: Date;
//         BSOHeader: Record "Sales Header";
//         ApprovedpaymentTerm: Boolean;
//     begin
//         if (Rec."Document Type" = rec."Document Type"::Order) or (Rec."Document Type" = rec."Document Type"::Invoice) then
//             if cust_master.GET(Rec."Sell-to Customer No.") THEN
//                 IF cust_master."IC Partner Code" = '' THEN begin
//                     CustomerPaymentterm.get(cust_master."Payment Terms Code");
//                     SaleheaderPaymentTerm.get(Rec."Payment Terms Code");
//                     ApprovedpaymentTerm := ValidatePaymenttermDuedays(cust_master."Payment Terms Code", rec."Payment Terms Code", rec."Document Date");
//                     usersetup.Get(UserId);
//                     if usersetup."Allow Payment Terms on Sales" then begin
//                         if ApprovedpaymentTerm then
//                             Rec."Maximum Allowed Due days" := CustomerPaymentterm."Due Date Calculation"
//                         else
//                             Rec."Maximum Allowed Due days" := SaleheaderPaymentTerm."Due Date Calculation";
//                     end
//                     else
//                         if Format(Rec."Maximum Allowed Due days") <> '' then begin
//                             if CalcDate(SaleheaderPaymentTerm."Due Date Calculation", Rec."Document Date") > CalcDate(Rec."Maximum Allowed Due days", Rec."Document Date") then
//                                 Error('Select Payment Terms less than or equal to %1. Please contact to administrator.', rec."Maximum Allowed Due days")
//                         end
//                         else
//                             if Format(Rec."Maximum Allowed Due days") = '' then begin
//                                 rec."Maximum Allowed Due days" := SaleheaderPaymentTerm."Due Date Calculation";
//                                 if rec.Modify() then;
//                             end;
//                 end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeInsertSalesOrderHeader', '', true, true)]
//     local procedure BSOtoSO_Makeorder(BlanketOrderSalesHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header")
//     var
//     begin
//         // SalesOrderHeader."Skip payment term validation" := true;
//         // if SalesOrderHeader.Modify() then;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeSalesOrderHeaderModify', '', true, true)]
//     local procedure BSOtoSO_Makeorder2(BlanketOrderSalesHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header")
//     var
//     begin
//         // SalesOrderHeader."Skip payment term validation" := false;
//         // if SalesOrderHeader.Modify() then;
//     end;

//     procedure ValidatePaymenttermDuedays(var CustMasterPaymentterm: Code[10]; OrderPaymentTerms: Code[10]; DocumentDate: Date) approvedpaymentterm: Boolean;
//     var
//         PaymentTerms1: Record "Payment Terms";
//         PaymentTerms2: Record "Payment Terms";
//         SalesDocDuedate: Date;
//         CustomerMasterDuedate: Date;
//     begin
//         PaymentTerms1.Get(OrderPaymentTerms);
//         SalesDocDuedate := CalcDate(PaymentTerms1."Due Date Calculation", DocumentDate);
//         PaymentTerms2.Get(CustMasterPaymentterm);
//         CustomerMasterDuedate := CalcDate(PaymentTerms2."Due Date Calculation", DocumentDate);
//         if SalesDocDuedate <= CustomerMasterDuedate then begin
//             approvedpaymentterm := true;
//             exit(approvedpaymentterm);
//         end;
//     end;

//     var
//         Customer_Rec: Record Customer;
//         PaymentTermforCustomer_Rec: Record "Payment Terms";
//         PaymentTermforSalesHeader_Rec: Record "Payment Terms";
//         UserSetup_Rec: Record "User Setup";
//         CustomerDateCalculation: Date;
//         DocumentDateCalculation: Date;
// }

// // BSO 
// // PaymentTermforSalesHeader_Rec.Get(Rec."Payment Terms Code");
// // PaymentTermforCustomer_Rec.Get(Customer_Rec."Payment Terms Code");
// // DocumentDateCalculation := CalcDate(PaymentTermforSalesHeader_Rec."Due Date Calculation", Rec."Document Date");
// // CustomerDateCalculation := CalcDate(PaymentTermforCustomer_Rec."Due Date Calculation", Rec."Document Date");
// // if DocumentDateCalculation > CustomerDateCalculation then begin

// // SO
// // SaleheaderPaymentTerm.Get(rec."Payment Terms Code");
// // CustomerPaymentterm.Get(cust_master."Payment Terms Code");
// // SOduedate := CalcDate(SaleheaderPaymentTerm."Due Date Calculation", rec."Document Date");
// // Cust_mast_duedate := CalcDate(CustomerPaymentterm."Due Date Calculation", Rec."Document Date");
// // if SOduedate > Cust_mast_duedate then begin

// // begin
// //     if Rec."Document Type" = Rec."Document Type"::"Blanket Order" then
// //         if Customer_Rec.GET(Rec."Sell-to Customer No.") THEN
// //             IF Customer_Rec."IC Partner Code" = '' THEN
// //                 if xRec."Payment Terms Code" <> '' then begin

// //                     PaymentTermforSalesHeader_Rec.Get(Rec."Payment Terms Code");
// //                     PaymentTermforCustomer_Rec.get(Customer_Rec."Payment Terms Code");

// //                     ApprovedpaymentTerm := ValidatePaymenttermDuedays(Customer_Rec."Payment Terms Code", rec."Payment Terms Code", rec."Document Date");

// //                     if not ApprovedpaymentTerm then begin
// //                         UserSetup_Rec.Get(UserId);
// //                         if not UserSetup_Rec."Allow Payment Terms on Sales" then
// //                             Error('Select Payment Terms less than or equal to %1. Please contact to administrator.', PaymentTermforCustomer_Rec."Due Date Calculation")
// //                         else
// //                             Rec."Maximum Allowed Due days" := PaymentTermforSalesHeader_Rec."Due Date Calculation";
// //                     end
// //                     else
// //                         Rec."Maximum Allowed Due days" := PaymentTermforCustomer_Rec."Due Date Calculation";
// //                 end;
// // end;

