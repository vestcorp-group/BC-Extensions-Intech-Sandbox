// codeunit 50484 "Skip IC PO Create Restriction" //T12370-Full Comment
// {
//     local procedure CheckValidationsBeforeCreatingICPurchOrder(SalesHeader: Record "Sales Header"; IsHandled: Boolean)
//     var
//         Text001: Label 'Purchase Order %1 already exists in %2.';
//         Text002: Label 'Qty shipped must not be blank in Line No. %1';
//         SalesOrder: Page "Sales Order";
//         Salesline: Record "Sales Line";
//         Purchheader: Record "Purchase Header";
//         BlanketSalesOrder: Page "Blanket Sales Order";
//         ICpartner: Record "IC Partner";
//         UserSetup: Record "User Setup";
//     begin
//         if UserSetup.Get(UserId) then
//             if UserSetup."Skip IC PO Restriction" then
//                 exit;

//         if SalesHeader."Sell-to IC Partner Code" = '' then
//             exit;

//         /* Salesline.reset;
//         Salesline.SetRange("Document No.", SalesHeader."No.");
//         Salesline.SetRange("Document Type", SalesHeader."Document Type");
//         Salesline.SetRange("Drop Shipment", true);
//         if not Salesline.FindFirst() then
//             exit; */

//         ICpartner.Get(SalesHeader."Sell-to IC Partner Code");
//         //
//         Salesline.reset;
//         Salesline.SetRange("Document No.", SalesHeader."No.");
//         Salesline.SetRange("Document Type", SalesHeader."Document Type");
//         Salesline.SetRange(Type, Salesline.Type::Item);
//         Salesline.SetRange("Quantity Shipped", 0);
//         if Salesline.FindFirst then
//             Error(Text002, Salesline."Line No.");

//         Purchheader.Reset();
//         Purchheader.ChangeCompany(ICpartner.Name);
//         Purchheader.SetRange("Vendor Order No.", SalesHeader."No.");
//         //Purchheader.SetRange("Buy-from Vendor No.", ICpartner."Vendor No.");
//         if Purchheader.FindFirst() then
//             Error(Text001, Purchheader."No.", ICpartner.Name);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"ICInboxOutboxMgt", 'OnBeforeSendSalesDoc', '', true, true)]
//     local procedure CheckICResctrictionsOnBeforeSendSalesDoc(var SalesHeader: Record "Sales Header"; var Post: Boolean; var IsHandled: Boolean)
//     var
//         Text001: Label 'Purchase Order %1 already exists in %2.';
//         Text002: Label 'Qty shipped must not be blank in Line No. %1';
//         SalesOrder: Page "Sales Order";
//         Salesline: Record "Sales Line";
//         Purchheader: Record "Purchase Header";
//         BlanketSalesOrder: Page "Blanket Sales Order";
//         ICpartner: Record "IC Partner";
//         UserSetup: Record "User Setup";
//     begin

//         if Post then exit;

//         if UserSetup.Get(UserId) then
//             if UserSetup."Skip IC PO Restriction" then
//                 exit;

//         if SalesHeader."Bill-to IC Partner Code" = '' then
//             exit;

//         /* Salesline.reset;
//         Salesline.SetRange("Document No.", SalesHeader."No.");
//         Salesline.SetRange("Document Type", SalesHeader."Document Type");
//         Salesline.SetRange("Drop Shipment", true);
//         if not Salesline.FindFirst() then
//             exit; */

//         ICpartner.Get(SalesHeader."Bill-to IC Partner Code");
//         //
//         Salesline.reset;
//         Salesline.SetRange("Document No.", SalesHeader."No.");
//         Salesline.SetRange("Document Type", SalesHeader."Document Type");
//         Salesline.SetRange(Type, Salesline.Type::Item);
//         Salesline.SetRange("Quantity Shipped", 0);
//         if Salesline.FindFirst then
//             Error(Text002, Salesline."Line No.");

//         Purchheader.Reset();
//         Purchheader.ChangeCompany(ICpartner.Name);
//         Purchheader.SetRange("Vendor Order No.", SalesHeader."No.");
//         //Purchheader.SetRange("Buy-from Vendor No.", ICpartner."Vendor No.");
//         if Purchheader.FindFirst() then
//             Error(Text001, Purchheader."No.", ICpartner.Name);
//     end;

// }