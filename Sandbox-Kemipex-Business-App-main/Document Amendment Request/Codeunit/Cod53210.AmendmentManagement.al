// codeunit 53210 "Amendment Management"//T12370-Full Comment
// {
//     Permissions = tabledata "Sales Invoice Header" = rim, tabledata "Sales Invoice Line" = rim, tabledata "Sales Shipment Header" = rim, tabledata "Sales Shipment Line" = rim;

//     procedure ApplyChangeRequest(var ChangeReq: Record "Amendment Request")
//     var
//         recChangeLine: Record "Amendment Request Line";
//         recSalInvHead: Record "Sales Invoice Header";
//         recSalInvLine: Record "Sales Invoice Line";
//         HeadRecordRef: RecordRef;
//         LineRecordRef: RecordRef;
//         intLineNo: Integer;
//         checkList: List of [Text];
//         TempSalesShptLine: Record "Sales Shipment Line" temporary;
//         ShipmentHdr: Record "Sales Shipment Header";
//         RecInvLines: Record "Sales Invoice Line";
//         ShipmentLines: Record "Sales Shipment Line";
//         SalesOrderRemarks: Record "Sales Order Remarks";
//         AmendmentRemarks: Record "Amendment Remarks";
//     begin

//         case ChangeReq."Amendment Type" of
//             ChangeReq."Amendment Type"::"Invoice Modification":
//                 begin
//                     //Apply Header Changes
//                     HeadRecordRef.Open(112);
//                     recSalInvHead.Get(ChangeReq."Document No.");
//                     HeadRecordRef.GetTable(recSalInvHead);

//                     recChangeLine.Reset();
//                     recChangeLine.SetRange("Amendment No.", ChangeReq."Amendment No.");
//                     recChangeLine.SetRange("Document No.", ChangeReq."Document No.");
//                     recChangeLine.SetRange("Document Type", ChangeReq."Document Type");
//                     recChangeLine.SetRange("Table No.", HeadRecordRef.Number);
//                     recChangeLine.SetRange("Amendment Type", recChangeLine."Amendment Type"::"Invoice Modification");
//                     if recChangeLine.FindSet() then
//                         repeat
//                             ApplySalInvoiceChanges(recChangeLine, HeadRecordRef);

//                             //updating lines for selected fields that are available in lines
//                             if recChangeLine."Field No." = recSalInvHead.FieldNo("Transaction Specification") then begin
//                                 Clear(RecInvLines);
//                                 RecInvLines.SetRange("Document No.", recSalInvHead."No.");
//                                 RecInvLines.SetFilter(Type, '<>%1', RecInvLines.Type::" ");
//                                 if RecInvLines.FindSet() then
//                                     RecInvLines.ModifyAll("Transaction Specification", recChangeLine."New Value", true);
//                             end else
//                                 if recChangeLine."Field No." = recSalInvHead.FieldNo("Transport Method") then begin
//                                     Clear(RecInvLines);
//                                     RecInvLines.SetRange("Document No.", recSalInvHead."No.");
//                                     RecInvLines.SetFilter(Type, '<>%1', RecInvLines.Type::" ");
//                                     if RecInvLines.FindSet() then
//                                         RecInvLines.ModifyAll("Transport Method", recChangeLine."New Value", true);
//                                 end else
//                                     if recChangeLine."Field No." = recSalInvHead.FieldNo("Area") then begin
//                                         Clear(RecInvLines);
//                                         RecInvLines.SetRange("Document No.", recSalInvHead."No.");
//                                         RecInvLines.SetFilter(Type, '<>%1', RecInvLines.Type::" ");
//                                         if RecInvLines.FindSet() then
//                                             RecInvLines.ModifyAll(Area, recChangeLine."New Value", true);
//                                     end else
//                                         if recChangeLine."Field No." = recSalInvHead.FieldNo("Exit Point") then begin
//                                             Clear(RecInvLines);
//                                             RecInvLines.SetRange("Document No.", recSalInvHead."No.");
//                                             RecInvLines.SetFilter(Type, '<>%1', RecInvLines.Type::" ");
//                                             if RecInvLines.FindSet() then
//                                                 RecInvLines.ModifyAll("Exit Point", recChangeLine."New Value", true);
//                                         end;
//                         until recChangeLine.Next() = 0;

//                     HeadRecordRef.Modify(true);
//                     Clear(HeadRecordRef);

//                     //Apply Line Changes
//                     LineRecordRef.Open(113);
//                     recSalInvLine.Reset();
//                     recSalInvLine.SetRange("Document No.", ChangeReq."Document No.");
//                     if recSalInvLine.FindSet() then
//                         repeat
//                             LineRecordRef.GetTable(recSalInvLine);
//                             recChangeLine.Reset();
//                             recChangeLine.SetRange("Amendment No.", ChangeReq."Amendment No.");
//                             recChangeLine.SetRange("Document No.", ChangeReq."Document No.");
//                             recChangeLine.SetRange("Document Type", ChangeReq."Document Type");
//                             recChangeLine.SetRange("Document Line No.", recSalInvLine."Line No.");
//                             recChangeLine.SetRange("Table No.", LineRecordRef.Number);
//                             recChangeLine.SetRange("Amendment Type", recChangeLine."Amendment Type"::"Invoice Modification");
//                             if recChangeLine.FindSet() then
//                                 repeat
//                                     ApplySalInvoiceChanges(recChangeLine, LineRecordRef);
//                                 until recChangeLine.Next() = 0;
//                             LineRecordRef.Modify(true);
//                             Clear(LineRecordRef);
//                         until recSalInvLine.Next() = 0;


//                     //------------shipment Modification-start

//                     //shipment header
//                     Clear(checkList);
//                     Clear(RecInvLines);
//                     RecInvLines.SetRange("Document No.", ChangeReq."Document No.");
//                     if RecInvLines.FindSet() then begin

//                         repeat
//                             RecInvLines.GetSalesShptLines(TempSalesShptLine);
//                             if TempSalesShptLine.FindSet() then begin
//                                 repeat
//                                     if not checkList.Contains(TempSalesShptLine."Document No.") then begin
//                                         checkList.Add(TempSalesShptLine."Document No.");
//                                         HeadRecordRef.Open(110);
//                                         if ShipmentHdr.GET(TempSalesShptLine."Document No.") then begin
//                                             HeadRecordRef.GetTable(ShipmentHdr);//shipment Header in Recordref

//                                             recChangeLine.Reset();
//                                             recChangeLine.SetRange("Amendment No.", ChangeReq."Amendment No.");
//                                             recChangeLine.SetRange("Document No.", ChangeReq."Document No.");
//                                             recChangeLine.SetRange("Document Type", ChangeReq."Document Type");
//                                             recChangeLine.SetRange("Table No.", 112);
//                                             recChangeLine.SetRange("Amendment Type", recChangeLine."Amendment Type"::"Invoice Modification");
//                                             if recChangeLine.FindSet() then
//                                                 repeat
//                                                     ApplySalInvoiceChanges(recChangeLine, HeadRecordRef);

//                                                     //updating lines for selected fields that are available in lines
//                                                     if recChangeLine."Field No." = ShipmentHdr.FieldNo("Transaction Specification") then begin
//                                                         Clear(ShipmentLines);
//                                                         ShipmentLines.SetRange("Document No.", ShipmentHdr."No.");
//                                                         ShipmentLines.SetFilter(Type, '<>%1', ShipmentLines.Type::" ");
//                                                         if ShipmentLines.FindSet() then
//                                                             ShipmentLines.ModifyAll("Transaction Specification", recChangeLine."New Value", true);
//                                                     end else
//                                                         if recChangeLine."Field No." = ShipmentHdr.FieldNo("Transport Method") then begin
//                                                             Clear(ShipmentLines);
//                                                             ShipmentLines.SetRange("Document No.", ShipmentHdr."No.");
//                                                             ShipmentLines.SetFilter(Type, '<>%1', ShipmentLines.Type::" ");
//                                                             if ShipmentLines.FindSet() then
//                                                                 ShipmentLines.ModifyAll("Transport Method", recChangeLine."New Value", true);
//                                                         end else
//                                                             if recChangeLine."Field No." = ShipmentHdr.FieldNo("Area") then begin
//                                                                 Clear(ShipmentLines);
//                                                                 ShipmentLines.SetRange("Document No.", ShipmentHdr."No.");
//                                                                 ShipmentLines.SetFilter(Type, '<>%1', ShipmentLines.Type::" ");
//                                                                 if ShipmentLines.FindSet() then
//                                                                     ShipmentLines.ModifyAll(Area, recChangeLine."New Value", true);
//                                                             end else
//                                                                 if recChangeLine."Field No." = ShipmentHdr.FieldNo("Exit Point") then begin
//                                                                     Clear(ShipmentLines);
//                                                                     ShipmentLines.SetRange("Document No.", ShipmentHdr."No.");
//                                                                     ShipmentLines.SetFilter(Type, '<>%1', ShipmentLines.Type::" ");
//                                                                     if ShipmentLines.FindSet() then
//                                                                         ShipmentLines.ModifyAll("Exit Point", recChangeLine."New Value", true);
//                                                                 end;
//                                                 until recChangeLine.Next() = 0;

//                                             HeadRecordRef.Modify(true);
//                                             Clear(HeadRecordRef);
//                                         end;
//                                     end;
//                                 until TempSalesShptLine.Next() = 0;
//                             end;
//                         until RecInvLines.Next() = 0;
//                     end;


//                     //------------Apply shipment Line Changes
//                     Clear(checkList);
//                     Clear(RecInvLines);
//                     RecInvLines.SetRange("Document No.", ChangeReq."Document No.");
//                     if RecInvLines.FindSet() then begin
//                         repeat
//                             RecInvLines.GetSalesShptLines(TempSalesShptLine);
//                             if TempSalesShptLine.FindSet() then begin
//                                 repeat
//                                     if not checkList.Contains(TempSalesShptLine."Document No." + FORMAT(TempSalesShptLine."Line No.")) then begin
//                                         checkList.Add(TempSalesShptLine."Document No." + FORMAT(TempSalesShptLine."Line No."));

//                                         LineRecordRef.Open(111);
//                                         Clear(ShipmentLines);
//                                         ShipmentLines.SetRange("Document No.", TempSalesShptLine."Document No.");
//                                         ShipmentLines.SetRange("Line No.", TempSalesShptLine."Line No.");
//                                         if ShipmentLines.FindFirst() then;
//                                         LineRecordRef.GetTable(ShipmentLines);

//                                         recChangeLine.Reset();
//                                         recChangeLine.SetRange("Amendment No.", ChangeReq."Amendment No.");
//                                         recChangeLine.SetRange("Document No.", ChangeReq."Document No.");
//                                         recChangeLine.SetRange("Document Type", ChangeReq."Document Type");
//                                         recChangeLine.SetRange("Document Line No.", RecInvLines."Line No.");
//                                         recChangeLine.SetRange("Table No.", 113);
//                                         recChangeLine.SetRange("Amendment Type", recChangeLine."Amendment Type"::"Invoice Modification");
//                                         if recChangeLine.FindSet() then
//                                             repeat
//                                                 ApplySalInvoiceChanges(recChangeLine, LineRecordRef);
//                                             until recChangeLine.Next() = 0;
//                                         LineRecordRef.Modify(true);
//                                         Clear(LineRecordRef);
//                                     end;
//                                 until TempSalesShptLine.Next() = 0;
//                             end;
//                         until RecInvLines.Next() = 0;
//                     end;
//                     //----------end

//                     //remarks

//                     Clear(AmendmentRemarks);
//                     AmendmentRemarks.SetRange("Amendment No.", ChangeReq."Amendment No.");
//                     if AmendmentRemarks.FindSet() then begin
//                         repeat
//                             if AmendmentRemarks.Comments <> AmendmentRemarks."New Remarks" then begin
//                                 Clear(SalesOrderRemarks);
//                                 SalesOrderRemarks.SetRange("Document Type", AmendmentRemarks."Document Type");
//                                 SalesOrderRemarks.SetRange("Document No.", AmendmentRemarks."Document No.");
//                                 SalesOrderRemarks.SetRange("Document Line No.", AmendmentRemarks."Document Line No.");
//                                 SalesOrderRemarks.SetRange("Line No.", AmendmentRemarks."Line No.");
//                                 if SalesOrderRemarks.FindFirst() then begin
//                                     SalesOrderRemarks.Comments := AmendmentRemarks."New Remarks";
//                                     SalesOrderRemarks.Modify();
//                                 end;
//                             end;
//                         until AmendmentRemarks.Next() = 0;
//                     end;
//                 end;
//         end;
//         ChangeReq."Request Status" := ChangeReq."Request Status"::Closed;
//         ChangeReq.Modify(true);

//     end;

//     local procedure ApplySalInvoiceChanges(var ChangeLine: Record "Amendment Request Line"; var RecRef: RecordRef)
//     var
//         xFieldRef: FieldRef;
//         xField: Record Field;
//     begin
//         Clear(xFieldRef);
//         xField.Reset();
//         xField.SetRange(TableNo, RecRef.Number);
//         xField.SetRange("No.", ChangeLine."Field No.");
//         if xField.FindFirst() then begin
//             xFieldRef := RecRef.Field(xField."No.");
//             case xField.Type of
//                 xField.Type::Boolean:
//                     begin
//                         xFieldRef.Value := ChangeLine."New Value";
//                         xFieldRef.Validate();
//                     end;
//                 xField.Type::Date:
//                     begin
//                         xFieldRef.Value := ConverDate(ChangeLine."New Value");
//                         xFieldRef.Validate();
//                     end;
//                 else begin
//                     xFieldRef.Value := ChangeLine."New Value";
//                     xFieldRef.Validate();
//                 end;
//             end;
//         end;
//     end;

//     procedure GetFieldCurrentValue(var xRecRef: RecordRef; FieldNumber: Integer): Text
//     var
//         xField: Record Field;
//     begin
//         xField.Reset();
//         xField.SetRange(TableNo, xRecRef.Number);
//         xField.SetRange("No.", FieldNumber);
//         if xField.FindFirst() then begin
//             Exit(format(xRecRef.Field(xField."No.")));
//         end;
//     end;


//     local procedure ConverDateTime(txtDateTime: Text): Date
//     var
//         Dt: DateTime;
//     begin
//         EVALUATE(dt, txtDateTime, 9);
//         exit(DT2Date(dt));
//     end;

//     local procedure ConverDate(txtDate: Text): Date
//     var
//         Dt: Date;
//     begin
//         EVALUATE(dt, txtDate);

//         exit(Dt);
//     end;
// }
