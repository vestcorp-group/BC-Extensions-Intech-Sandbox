// codeunit 53002 "Clearance ShipTo"//T12370-Full Comment
// {


//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeSalesOrderHeaderModify', '', true, true)]
//     local procedure fnOnBeforeSalesOrderHeaderModify(var SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesHeader: Record "Sales Header")
//     begin
//         if BlanketOrderSalesHeader."Clearance Ship-to Code" <> '' then
//             SalesOrderHeader.Validate("Clearance Ship-to Code", BlanketOrderSalesHeader."Clearance Ship-to Code");
//     end;

//     [EventSubscriber(ObjectType::Table, 36, 'OnAfterCheckSellToCust', '', true, true)]
//     local procedure fnOnAfterCheckSellToCust(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; Customer: Record Customer; CurrentFieldNo: Integer)
//     begin
//         //SalesHeader."Clearance Ship-to Code" := Customer."Clearance Ship-To Address";
//         //SalesHeader.Validate("Clearance Ship-to Code");
//     end;

//     //17-07-2022-start
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", 'OnAfterInsertLine', '', false, false)]
//     local procedure OnAfterInsertLine(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line"; SalesShptLine2: Record "Sales Shipment Line"; TransferLine: Boolean; var SalesHeader: Record "Sales Header");
//     var
//         RecSalesShipment: Record "Sales Shipment Header";
//         SalesHeaderL: Record "Sales Header";
//     begin
//         Clear(SalesHeaderL);
//         SalesHeaderL.SetRange("Document Type", SalesLine."Document Type");
//         SalesHeaderL.SetRange("No.", SalesLine."Document No.");
//         if SalesHeaderL.FindFirst() then begin
//             Clear(RecSalesShipment);
//             RecSalesShipment.SetRange("No.", SalesShptLine."Document No.");
//             if RecSalesShipment.FindFirst() then begin
//                 if (SalesHeaderL."Release Of Shipping Document" = SalesHeaderL."Release Of Shipping Document"::" ") OR (RecSalesShipment."Release Of Shipping Document" <> RecSalesShipment."Release Of Shipping Document"::" ") then
//                     SalesHeaderL."Release Of Shipping Document" := RecSalesShipment."Release Of Shipping Document";
//                 if RecSalesShipment."Courier Details" <> '' then
//                     SalesHeaderL."Courier Details" := RecSalesShipment."Courier Details";
//                 if RecSalesShipment."Free Time Requested" <> '' then
//                     SalesHeaderL."Free Time Requested" := RecSalesShipment."Free Time Requested";
//                 SalesHeaderL.Modify(false);
//             end;
//         end;
//     end;

//     // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", 'OnAfterInsertLines', '', false, false)]
//     // local procedure OnAfterInsertLines(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line");
//     // var
//     //     RecSalesShipment: Record "Sales Shipment Header";
//     //     SalesHeaderL: Record "Sales Header";
//     // begin
//     //     Clear(SalesHeaderL);
//     //     SalesHeaderL.SetRange("Document Type", SalesLine."Document Type");
//     //     SalesHeaderL.SetRange("No.", SalesLine."Document No.");
//     //     if SalesHeaderL.FindFirst() then begin
//     //         Clear(RecSalesShipment);
//     //         RecSalesShipment.SetRange("No.", SalesLine."Shipment No.");
//     //         if RecSalesShipment.FindFirst() then begin
//     //             SalesHeaderL."Release Of Shipping Document" := RecSalesShipment."Release Of Shipping Document";
//     //             SalesHeaderL."Courier Details" := RecSalesShipment."Courier Details";
//     //             SalesHeaderL."Free Time Requested" := RecSalesShipment."Free Time Requested";
//     //             SalesHeaderL.Modify(false);
//     //         end;
//     //     end;
//     // end;

//     //17-07-2022-end

// }