// codeunit 70100 "Get Posting Time"//T12370-Full Comment
// {
//     Permissions = tabledata "Sales Shipment Header" = rm;
//     trigger OnRun()
//     begin

//     end;

//     // [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
//     // procedure GetPostingTime(var SalesHeader: Record "Sales Header"; SalesShptHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
//     // var
//     //     Invoicedqty: Decimal;
//     // begin
//     //     SalesLine.Reset();
//     //     SalesLine.SetRange("Document No.", SalesHeader."No.");
//     //     if SalesLine.FindSet() then
//     //         repeat
//     //             if SalesLine."Quantity Invoiced" = SalesLine.Quantity then
//     //                 Invoicedqty := SalesLine.Quantity;
//     //         until SalesLine.Next = 0;
//     //     if Invoicedqty <> 0 then begin
//     //         if (SalesHeader."Sell-to Customer No." <> '') and (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then begin
//     //             SalesHeader."Posting Date Time" := DT2Time(CurrentDateTime);
//     //             SalesHeader.Modify();
//     //         end;

//     //     end;

//     //     SalesShipmentHeader.reset;
//     //     SalesShipmentHeader.SetRange("Order No.", SalesHeader."No.");
//     //     if SalesShipmentHeader.FindFirst() then begin
//     //         SalesShipmentHeader."Posting Date Time" := SalesHeader."Posting Date Time";
//     //         SalesShipmentHeader.Modify();
//     //         SalesInvoiceline.SetRange("Shipment No.", SalesShipmentHeader."No.");
//     //         if SalesInvoiceline.FindFirst() then begin
//     //             SalesInvoiceHeader.SetRange("No.", SalesInvoiceline."Document No.");
//     //             if SalesInvoiceHeader.FindFirst() then begin
//     //                 SalesInvoiceHeader."Posting Date Time" := SalesShipmentHeader."Posting Date Time";
//     //                 SalesInvoiceHeader.Modify();
//     //             end;
//     //         end;
//     //     end;

//     // end;

//     // [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', true, true)]
//     // local procedure GetPostingTime(VAR SalesHeader: Record "Sales Header"; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean)
//     // var
//     //     SalesLineRec: Record "Sales Line";
//     // begin
//     //     SalesLineRec.Reset();
//     //     SalesLineRec.SetRange("Document No.", SalesHeader."No.");
//     //     if SalesLineRec.FindSet() then
//     //         repeat
//     //             if SalesLineRec."Quantity Shipped" <> SalesLineRec.Quantity then begin

//     //             end;

//     //         until SalesLineRec.Next() = 0;
//     // end;

//     [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', true, true)]
//     local procedure GetPostingTime(VAR SalesHeader: Record "Sales Header"; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean)
//     var
//         SalesShipmentHeader: Record "Sales Shipment Header";
//         SalesHeaderRec: Record "Sales Header";
//         SalesShipmentLine: Record "Sales Shipment Line";
//     begin
//         SalesShipmentHeader.Reset();
//         SalesShipmentHeader.SetRange("No.", SalesShptHdrNo);
//         if SalesShipmentHeader.FindFirst() then begin
//             if SalesShipmentHeader."Order No." <> '' then begin
//                 SalesHeader.Reset();
//                 SalesHeader.SetRange("No.", SalesShipmentHeader."Order No.");
//                 if SalesHeader.FindFirst() then begin
//                     SalesHeader."Posting Date Time" := DT2Time(CurrentDateTime);
//                     SalesHeader.Modify();
//                 end;
//             end else begin
//                 SalesShipmentLine.Reset();
//                 SalesShipmentLine.SetRange("Document No.", SalesShipmentHeader."No.");
//                 SalesShipmentLine.SetFilter("No.", '<>%1', '');
//                 if SalesShipmentLine.FindFirst() then begin
//                     SalesHeader.Reset();
//                     SalesHeader.SetRange("No.", SalesShipmentLine."Document No.");
//                     if SalesHeader.FindFirst() then begin
//                         SalesHeader."Posting Date Time" := DT2Time(CurrentDateTime);
//                         SalesHeader.Modify();
//                     end;
//                 end;
//             end;
//             SalesShipmentHeader."Posting Date Time" := DT2Time(CurrentDateTime);
//             SalesShipmentHeader.Modify();
//         end;
//     end;

//     [EventSubscriber(ObjectType::Table, 37, 'OnAfterInsertEvent', '', false, false)]

//     local procedure SalesOrderToSalesInvoice(var Rec: Record "Sales Line"; RunTrigger: Boolean)
//     var
//         SalesShipmentLine1: Record "Sales Shipment Line";
//         SalesShipmentHeader1: Record "Sales Shipment Header";
//         SalesHeader1: Record "Sales Header";
//         SalesHeader2: Record "Sales Header";
//         SalesLineRec: Record "Sales Line";
//         OrderNo: Code[20];
//     begin
//         if Rec."Document Type" = Rec."Document Type"::Invoice then begin
//             SalesShipmentLine1.Reset();
//             SalesShipmentLine1.SetRange("Document No.", Rec."Shipment No.");
//             SalesShipmentLine1.SetRange(Type, SalesShipmentLine1.Type::Item);
//             SalesShipmentLine1.SetRange("No.", Rec."No.");
//             if SalesShipmentLine1.FindFirst() then begin
//                 OrderNo := SalesShipmentLine1."Order No.";
//                 SalesHeader1.Reset();
//                 SalesHeader1.SetRange("No.", OrderNo);
//                 if SalesHeader1.FindFirst() then begin
//                     SalesHeader2.Reset();
//                     if SalesHeader2.Get(SalesHeader2."Document Type"::Invoice, Rec."Document No.") then begin
//                         SalesHeader2."Customer Port of Discharge" := SalesHeader1."Customer Port of Discharge";
//                         SalesHeader2.Modify();
//                     end;
//                 end;
//             end;
//         end;
//     end;

//     local procedure MyProcedure()
//     begin

//     end;

//     //end;
//     // if SalesCrMemoHeader.Get(SalesHeader."Sell-to Customer No.") then begin
//     //     SalesCrMemoHeader."Posting Date Time" := DT2Time(CurrentDateTime);
//     //     SalesCrMemoHeader.Modify();
//     // end;
//     // if ReturnReceiptHeader.Get(SalesHeader."Sell-to Customer No.") then begin
//     //     ReturnReceiptHeader."Posting Date Time" := DT2Time(CurrentDateTime);
//     //     ReturnReceiptHeader.Modify();
//     // end;




//     var
//         SalesInvoiceHeader: Record "Sales Invoice Header";
//         ReturnReceiptHeader: Record "Return Receipt Header";
//         SalesCrMemoHeader: Record "Sales Cr.Memo Header";
//         SalesShipmentHeader: Record "Sales Shipment Header";
//         SalesLine: Record "Sales Line";
//         SalesInvoiceline: Record "Sales Invoice Line";
// }