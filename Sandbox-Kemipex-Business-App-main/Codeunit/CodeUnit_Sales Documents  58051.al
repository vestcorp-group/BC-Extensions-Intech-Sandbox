// codeunit 58051 SalesDocuments//T12370-Full Comment
// {
//     EventSubscriberInstance = StaticAutomatic;
//     Permissions = tabledata "Item Ledger Entry" = rm,
//                   tabledata "Sales Invoice Line" = rm,
//                   tabledata "Sales Invoice Header" = rm;
//     trigger OnRun()
//     begin
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeRun', '', true, true)]
//     local procedure MakeOrderFromBlanketSO(var SalesHeader: Record "Sales Header")

//     begin
//         if SalesHeader."Status" <> SalesHeader.Status::Released then
//             Error('Blanket sales order status must be release!.');
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeManualReleaseSalesDoc', '', true, true)]
//     local procedure SOreleaseValid(var SalesHeader: Record "Sales Header")
//     var
//         Sales_line: Record "Sales Line";
//     begin
//         if SalesHeader."Sell-to IC Partner Code" = '' then
//             salesheader.TestField("Salesperson Code");

//         //if Sales_line.FindSet() then // hide by bayas
//         Sales_line.SetRange("Document No.", SalesHeader."No.");
//         Sales_line.SetRange("Document Type", SalesHeader."Document Type");
//         Sales_line.SetRange(Type, Sales_line.Type::Item);
//         if Sales_line.FindSet() then // added by bayas
//             repeat
//                 if Sales_line."Unit of Measure Code" = '' then Error('Unit of Measure Code Cannot be empty');
//             until Sales_line.Next() = 0;
//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Header", 'OnAfterValidateEvent', 'BillOfExit', false, false)]
//     local procedure UpdateBillofExit(var Rec: Record "Sales Invoice Header"; var xRec: Record "Sales Invoice Header")
//     var
//         Sales_invoice_line: Record "Sales Invoice Line";
//         valueent: Record "Value Entry";
//         ILE: Record "Item Ledger Entry";
//         CustomBOEFormatErr: Label 'Format of Declaration No. is xxx-xxxxxxxx-xx.\Max. allowed characters are 15 with "-" otherwise 13.';
//         YesUpdate: Boolean;
//     begin
//         //Format Control
//         Rec.TestField("Declaration Type");
//         if (Rec."Declaration Type" = Rec."Declaration Type"::LGP) or (Rec."Declaration Type" = Rec."Declaration Type"::ED) then begin
//             IF (COPYSTR(rec.BillOfExit, 4, 1) = '-') and (StrLen(rec.BillOfExit) <> 15) THEN
//                 Error(CustomBOEFormatErr);
//             if (COPYSTR(rec.BillOfExit, 4, 1) <> '-') and (StrLen(rec.BillOfExit) <> 13) THEN
//                 error(CustomBOEFormatErr);
//             rec.BillOfExit := FormatText(rec.BillOfExit);
//         end;


//         YesUpdate := Dialog.Confirm('Do you want to Update Customs Declaration No. %1?', true, Rec.BillOfExit);
//         if YesUpdate = false then begin
//             Rec.BillOfExit := xrec.BillOfExit;
//             Rec."Declaration Type" := xRec."Declaration Type"
//         end

//         else begin
//             if (Rec."Declaration Type" = Rec."Declaration Type"::Direct) then
//                 rec.BillOfExit := format(rec."Declaration Type");
//             //Copy Bill of Exit to Sales Line
//             Sales_invoice_line.SetRange("Document No.", Rec."No.");
//             Sales_invoice_line.SetRange(Type, Sales_invoice_line.Type::Item);
//             if Sales_invoice_line.FindSet() then
//                 repeat
//                     Sales_invoice_line.BillOfExit := Rec.BillOfExit;
//                     if Sales_invoice_line.Modify() then;
//                     begin
//                         valueent.SetRange("Document Type", valueent."Document Type"::"Sales Invoice");
//                         valueent.SetRange("Source Code", 'Sales');
//                         valueent.SetRange("Document No.", Sales_invoice_line."Document No.");
//                         valueent.SetRange("Document Line No.", Sales_invoice_line."Line No.");
//                         if valueent.FindSet() then begin
//                             repeat
//                                 ILE.SetRange("Document Type", ile."Document Type"::"Sales Shipment");
//                                 ILE.SetRange("Entry No.", valueent."Item Ledger Entry No.");
//                                 if ILE.FindFirst() then
//                                     ile.BillOfExit := Rec.BillOfExit;
//                                 if ILE.Modify() then;
//                             until valueent.Next() = 0;
//                         end;
//                     end;
//                 until Sales_invoice_line.Next() = 0;
//             Message('Declaration No. %1 Updated', Rec.BillOfExit);
//         end;
//     end;

//     procedure FormatText(TextP: Text[20]): Text
//     var
//         NewTextL: Text[20];
//     begin
//         IF COPYSTR(TextP, 4, 1) <> '-' THEN BEGIN
//             NewTextL := COPYSTR(TextP, 1, 3);
//             NewTextL += '-';
//             NewTextL += COPYSTR(TextP, 4, 8);
//             NewTextL += '-';
//             NewTextL += COPYSTR(TextP, 12, MaxStrLen(TextP) - 13);
//         END
//         ELSE
//             NewTextL := TextP;
//         EXIT(NewTextL);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', true, true)]
//     local procedure UpdateRemarksOrderNo(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
//     var
//         SO_remarks: Record "Sales Order Remarks";
//         To_SO_remarks: Record "Sales Order Remarks";
//     begin

//         if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
//             SO_remarks.Reset();
//             SO_remarks.SetRange("Document No.", SalesHeader."No.");
//             SO_remarks.SetRange("Document Type", SO_remarks."Document Type"::Invoice);

//             if SO_remarks.FindSet() then
//                 repeat
//                     To_SO_remarks.Init();
//                     To_SO_remarks.TransferFields(SO_remarks);
//                     To_SO_remarks."Document No." := SalesInvHeader."No.";
//                     // To_SO_remarks."Document Type":= 
//                     if To_SO_remarks.Insert() then;
//                 until SO_remarks.Next() = 0;
//         end;
//         /*  if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
//               SalesInvHeader."Remarks Order No." := SalesHeader."No.";
//               if SalesInvHeader.Modify() then;
//     end;
//     */
//     end;


//     //Added by bayas 16-02-2023
//     [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', false, false)]
//     local procedure OnBeforeConfirmSalesPost(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer; var PostAndSend: Boolean)
//     var
//         SalesLine: Record "Sales Line";
//         ItemRec: Record Item;
//     begin
//         SalesLine.Reset();
//         SalesLine.SetFilter("Document Type", '%1', SalesHeader."Document Type");
//         SalesLine.SetFilter("Document No.", '%1', SalesHeader."No.");
//         SalesLine.SetFilter(Type, '%1', SalesLine.Type::Item);
//         if SalesLine.FindSet(true) then
//             repeat
//                 ItemRec.Get(SalesLine."No.");
//                 //Message('Before %1', SalesLine."Item Incentive Point (IIP)");
//                 SalesLine."Item Incentive Point (IIP)" := ItemRec."Item Incentive Ratio (IIR)";
//                 //Message('After %1', SalesLine."Item Incentive Point (IIP)");
//                 SalesLine.Modify();
//             until SalesLine.Next() = 0;
//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Quantity', true, true)]
//     local procedure SalesLine_OnBeforeQtyValidate(var Rec: Record "Sales Line"; CurrFieldNo: Integer)
//     var
//         ItemL: Record Item;
//         ItemUoML: Record "Item Unit of Measure";
//         UnitofMeasureL: Record "Unit of Measure";
//         ItemUOMVariant: Record "Item Unit of Measure";
//         BaseUOMQtyL: Decimal;

//     begin

//         if not UnitofMeasureL.Get(Rec."Unit of Measure Code") then
//             exit;
//         if UnitofMeasureL."Decimal Allowed" then
//             exit;
//         ItemUoML.Get(Rec."No.", Rec."Unit of Measure Code");
//         Rec."Net Weight" := Rec.Quantity * ItemUoML."Net Weight";
//         Rec."Gross Weight" := Rec."Net Weight";
//         BaseUOMQtyL := Rec.Quantity * ItemUoML."Qty. per Unit of Measure";
//         ItemUoML.Reset();
//         ItemUoML.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
//         ItemUoML.Ascending(true);
//         ItemUoML.SetRange("Item No.", Rec."No.");
//         if Rec."Variant Code" <> '' then begin
//             If ItemUoML."Variant Code" = Rec."Variant Code" then begin
//                 ItemUoML.SetRange("Variant Code", Rec."Variant Code");
//             end else begin
//                 ItemUoML.SetRange("Variant Code", '');
//             end;
//         end else begin
//             ItemUOMVariant.Get(Rec."No.", Rec."Unit of Measure Code");
//             if ItemUOMVariant."Variant Code" <> '' then begin
//                 ItemUoML.SetRange("Variant Code", ItemUOMVariant."Variant Code");
//             end else begin
//                 ItemUoML.SetRange("Variant Code", '');
//             end;
//         end;

//         if Rec."Allow Loose Qty." then begin
//             if ItemUoML.FindFirst() then
//                 Rec."Gross Weight" += Round(BaseUOMQtyL / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";
//         end else begin
//             if ItemUoML.FindSet() then
//                 repeat
//                     UnitofMeasureL.Get(ItemUoML.Code);
//                     if not UnitofMeasureL."Decimal Allowed" then
//                         Rec."Gross Weight" += Round(BaseUOMQtyL / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";
//                 until ItemUoML.Next() = 0;
//         end;
//         Rec."Gross Weight" := Round(Rec."Gross Weight", 1, '=');
//         Rec."Net Weight" := Round(Rec."Net Weight", 1, '=');
//     end;

//     //Payment terms Control
//     // [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Payment Terms Code', true, true)]
//     // local procedure SalesHeaderPaymentTermValidation(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
//     // var
//     //     cust_master: Record Customer;
//     //     paymentterms: Record "Payment Terms";
//     //     usersetup: Record "User Setup";
//     //     CustomerPaymentterm: Record "Payment Terms";
//     //     SaleheaderPaymentTerm: Record "Payment Terms";
//     //     Cust_mast_duedate: Date;
//     //     SOduedate: Date;
//     // begin
//     //     if (Rec."Document Type" = rec."Document Type"::Order) or (Rec."Document Type" = rec."Document Type"::Invoice) then
//     //         if cust_master.GET(Rec."Sell-to Customer No.") THEN
//     //             IF cust_master."IC Partner Code" = '' THEN
//     //                 if xRec."Payment Terms Code" <> '' then begin
//     //                     SaleheaderPaymentTerm.Get(rec."Payment Terms Code");
//     //                     CustomerPaymentterm.Get(cust_master."Payment Terms Code");
//     //                     SOduedate := CalcDate(SaleheaderPaymentTerm."Due Date Calculation", rec."Document Date");
//     //                     Cust_mast_duedate := CalcDate(CustomerPaymentterm."Due Date Calculation", Rec."Document Date");
//     //                     if SOduedate > Cust_mast_duedate then begin
//     //                         usersetup.SetRange("User ID", UserId);
//     //                         if usersetup.FindSet() then
//     //                             if not usersetup."Allow Payment Terms on Sales1" then
//     //                                 Error('Select Payment Terms less than or equal to %1. Please contact to administrator.', CustomerPaymentterm."Due Date Calculation");
//     //                     end;
//     //                 end;
//     // end;

//     /*
//        [EventSubscriber(ObjectType::Table, Database::"Sales Line", after, '', true, true)]
//        local procedure MyProcedure(SalesLine: Record "Sales Line"; SalesShipmentLine: Record "Sales Shipment Line")
//        begin
//            if SalesLine.FindSet() then begin
//                SalesShipmentLine."Customer Requested Unit Price" := SalesLine."Customer Requested Unit Price";
//                if SalesLine.Modify() then;
//            end;
//        end;
//         [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", 'OnAfterInsertLine', '', true, true)]
//          local procedure Cust_request_priceCopy(var SalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
//          begin
//              if SalesLine.FindSet() then begin
//                  SalesShptLine."Customer Requested Unit Price" := SalesLine."Customer Requested Unit Price";
//                  if SalesLine.Modify() then;
//              end;
//          end;
//      */
// }
