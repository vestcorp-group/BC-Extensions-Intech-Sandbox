// codeunit 53004 "Drop Shipment Validation"//T12370-Full Comment
// {
//    Permissions = tabledata "Sales Shipment Header" = RIMD;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeReleaseSalesDocument', '', false, false)]
//     local procedure OnBeforeReleaseSalesDocument(SalesHeader: Record "Sales Header"; PreviewMode: Boolean);
//     var
//         RecLines: Record "Sales Line";
//         SalesSetup: Record "Sales & Receivables Setup";
//     begin
//         SalesSetup.GET;
//         If not SalesSetup."Validate Shipped Qty. DropShip" then exit;
//         if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
//             if SalesHeader.Invoice then begin
//                 Clear(RecLines);
//                 RecLines.SetRange("Document Type", SalesHeader."Document Type");
//                 RecLines.SetRange("Document No.", SalesHeader."No.");
//                 RecLines.SetRange("Drop Shipment", true);
//                 RecLines.SetFilter(Type, '<>%1', RecLines.Type::" ");
//                 if RecLines.FindFirst() then begin
//                     Clear(RecLines);
//                     RecLines.SetRange("Document Type", SalesHeader."Document Type");
//                     RecLines.SetRange("Document No.", SalesHeader."No.");
//                     RecLines.SetFilter(Type, '<>%1', RecLines.Type::" ");
//                     if RecLines.FindFirst() then begin
//                         repeat
//                             if RecLines.Type <> RecLines.Type::Item then begin
//                                 RecLines.TestField("Quantity Shipped", RecLines.Quantity);
//                             end;
//                         until RecLines.Next() = 0;
//                     end;
//                 end;
//             end;
//         end;
//     end;

//     //28-07-2022
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterSalesShptHeaderInsert', '', false, false)]
//     local procedure OnAfterSalesShptHeaderInsert(var SalesShipmentHeader: Record "Sales Shipment Header"; SalesOrderHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PurchHeader: Record "Purchase Header");
//     var
//         SoRemarks: Record "Sales Order Remarks";
//         SoRemarks2: Record "Sales Order Remarks";
//     begin
//         Clear(SoRemarks);
//         SoRemarks.SetRange("Document Type", SoRemarks."Document Type"::Shipment);
//         SoRemarks.SetRange("Document No.", SalesOrderHeader."No.");
//         if SoRemarks.FindSet() then begin
//             repeat
//                 SoRemarks2.Init();
//                 SoRemarks2.TransferFields(SoRemarks);
//                 SoRemarks2."Document No." := SalesShipmentHeader."No.";
//                 SoRemarks2.Insert();
//             //SoRemarks.Delete();
//             until SoRemarks.Next() = 0;
//         end;
//         SalesShipmentHeader."Remarks Order No." := SalesShipmentHeader."No.";
//         SalesShipmentHeader.Modify();
//     end;
// }