// /// <summary>  //T12370-Full Comment
// /// Codeunit Process Staging Activitie (ID 60100).
// /// </summary>
// codeunit 54000 "Process Purch. Inv. Activities"
// {
//     TableNo = "Staging Purchase Invoice";
//     trigger OnRun()
//     begin
//         OnRunAfer(Rec);
//         if TempStagingPurchaseHeader_g.get(Rec."Vendor Refrence", Rec."Line No.") then;
//         ProcessStagingPurchInvoice();
//         OnRunBefor(Rec);
//     end;


//     /// <summary>
//     /// ImportStagingPurchaseInvoice.
//     /// </summary>
//     procedure ImportStagingPurchaseInvoice()
//     begin
//         OnExcelImportAfter();
//         Xmlport.Run(54000, false, true);
//     end;



//     local procedure ProcessStagingPurchInvoice();
//     var
//         StagingPurchaseHeader_l: Record "Staging Purchase Invoice";

//     begin
//         OnAfterInsertPurchInv(TempStagingPurchaseHeader_g);
//         InsertPurchaseInvoiceHeader();
//         if StagingPurchaseHeader_l.get(TempStagingPurchaseHeader_g."Vendor Refrence", TempStagingPurchaseHeader_g."Line No.") then begin
//             StagingPurchaseHeader_l."Purch. Inv. No." := PurchaseHeader."No.";
//             StagingPurchaseHeader_l."Error Remarks" := '';
//             StagingPurchaseHeader_l.Status := StagingPurchaseHeader_l.Status::Created;
//             OnBeforeChangeStagingPurchInv(StagingPurchaseHeader_l);
//             StagingPurchaseHeader_l.Modify(true);
//         end;
//         OnBeforeInsertPurchInv(TempStagingPurchaseHeader_g);
//         Commit();
//     end;

//     local procedure InsertPurchaseInvoiceHeader()
//     var
//         Currencies: Record Currency;
//     begin
//         PurchaseHeader.Reset();
//         PurchaseHeader.SetRange("Vendor Invoice No.", TempStagingPurchaseHeader_g."Vendor Refrence");
//         if not PurchaseHeader.FindFirst() then begin
//             Purchase_payableSetup.Get();
//             PurchaseHeader.LockTable();
//             PurchaseHeader.Init();
//             PurchaseHeader."No." := NoSeriesManagement.GetNextNo(Purchase_payableSetup."Invoice Nos.", Today, true);
//             PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice;
//             PurchaseHeader.Validate("Location Code", TempStagingPurchaseHeader_g."Location Code");
//             PurchaseHeader.Validate("Buy-from Vendor No.", TempStagingPurchaseHeader_g."Vendor No.");
//             PurchaseHeader."Vendor Invoice No." := TempStagingPurchaseHeader_g."Vendor Refrence";
//             PurchaseHeader."Posting Date" := TempStagingPurchaseHeader_g."Posting Date";
//             if TempStagingPurchaseHeader_g."Currency Code" <> '' then begin
//                 Currencies.Get(TempStagingPurchaseHeader_g."Currency Code");
//                 PurchaseHeader.validate("Currency Code", Currencies.Code);
//             end;
//             PurchaseHeader."Your Reference" := TempStagingPurchaseHeader_g."Your Reference/PO Refernce";
//             PurchaseHeader."Due Date" := Today;
//             PurchaseHeader.Insert(true);
//             PurchaseHeader."Posting Description" := TempStagingPurchaseHeader_g."Header Description";
//             PurchaseHeader."Document Date" := TempStagingPurchaseHeader_g."Document Date";
//             PurchaseHeader.Modify();
//             OnBeforeInsertPurchaseInvoice(TempStagingPurchaseHeader_g, PurchaseHeader);
//         end else begin
//             if PurchaseHeader."Currency Code" <> TempStagingPurchaseHeader_g."Currency Code" then
//                 Error('Vendor Invoice No. must have same Currency No. for this  Document No. %1 , Upload Batch No. %2 Line No. %3 ', PurchaseHeader."Currency Code", TempStagingPurchaseHeader_g."Upload Batch No.", TempStagingPurchaseHeader_g."Line No.");
//         end;
//         if (TempStagingPurchaseHeader_g.Type = TempStagingPurchaseHeader_g.Type::Item)
//         and
//         (TempStagingPurchaseHeader_g."Charge Item Types" = TempStagingPurchaseHeader_g."Charge Item Types"::" ")
//         and
//         (TempStagingPurchaseHeader_g."Receipt No." = '') then
//             InsertPurchaseInvoiceLine()
//         else
//             if (TempStagingPurchaseHeader_g.Type = TempStagingPurchaseHeader_g.Type::Item)
//             and
//             (TempStagingPurchaseHeader_g."Charge Item Types" = TempStagingPurchaseHeader_g."Charge Item Types"::" ")
//             and
//             (TempStagingPurchaseHeader_g."Receipt No." <> '') then
//                 GetPurchaseReceiptItemLine()
//             else
//                 if (TempStagingPurchaseHeader_g.Type = TempStagingPurchaseHeader_g.Type::"Charge (Item)")
//                  and
//                  //  (TempStagingPurchaseHeader_g."Charge Item Types" <> TempStagingPurchaseHeader_g."Charge Item Types"::" ")
//                  // and
//                  (TempStagingPurchaseHeader_g."Receipt No." = '') then begin
//                     TempStagingPurchaseHeader_g.TestField(TempStagingPurchaseHeader_g."Charge Item Types");
//                     TempStagingPurchaseHeader_g.TestField(TempStagingPurchaseHeader_g.Alloction);
//                     InsertPurchaseInvoiceChargItemLine()
//                 end

//                 else
//                     if (TempStagingPurchaseHeader_g.Type = TempStagingPurchaseHeader_g.Type::"G/L Account")
//                     and (TempStagingPurchaseHeader_g."Charge Item Types" = TempStagingPurchaseHeader_g."Charge Item Types"::" ") and (TempStagingPurchaseHeader_g."Receipt No." = '') then
//                         InsertPurchaseInvoiceLine()
//                     else
//                         if (TempStagingPurchaseHeader_g.Type = TempStagingPurchaseHeader_g.Type::"Fixed Asset")
//                          and (TempStagingPurchaseHeader_g."Charge Item Types" = TempStagingPurchaseHeader_g."Charge Item Types"::" ") and (TempStagingPurchaseHeader_g."Receipt No." = '') then
//                             InsertPurchaseInvoiceLine()
//                         else
//                             if (TempStagingPurchaseHeader_g.Type = TempStagingPurchaseHeader_g.Type::Resource)
//                              and (TempStagingPurchaseHeader_g."Charge Item Types" = TempStagingPurchaseHeader_g."Charge Item Types"::" ") and (TempStagingPurchaseHeader_g."Receipt No." = '') then
//                                 InsertPurchaseInvoiceLine()
//                             else
//                                 if (TempStagingPurchaseHeader_g.Type = TempStagingPurchaseHeader_g.Type::Comment)
//                                  and (TempStagingPurchaseHeader_g."Charge Item Types" = TempStagingPurchaseHeader_g."Charge Item Types"::" ") and (TempStagingPurchaseHeader_g."Receipt No." = '') then
//                                     InsertPurchaseInvoiceLine();
//         OnAfterInsertPurchaseInvoice(TempStagingPurchaseHeader_g, PurchaseHeader, PurchaseLine);
//     end;

//     local procedure InsertPurchaseInvoiceLine()
//     begin
//         PurchaseLine.LockTable();
//         PurchaseLine.Init();
//         PurchaseLine."Document Type" := PurchaseHeader."Document Type"::Invoice;
//         PurchaseLine."Document No." := PurchaseHeader."No.";
//         PurchaseLine."Line No." := TempStagingPurchaseHeader_g."Line No.";
//         PurchaseLine.Validate("Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor No.");
//         PurchaseLine.Type := TempStagingPurchaseHeader_g.Type;
//         PurchaseLine.Validate("No.", TempStagingPurchaseHeader_g."Item No.");
//         PurchaseLine.Description := TempStagingPurchaseHeader_g.Description;
//         PurchaseLine.Validate("Location Code", TempStagingPurchaseHeader_g."Location Code");
//         PurchaseLine.Validate(Quantity, TempStagingPurchaseHeader_g.Quantity);
//         PurchaseLine.Validate("Direct Unit Cost", TempStagingPurchaseHeader_g."Direct Unit Cost");
//         PurchaseLine.Validate("Currency Code", PurchaseHeader."Currency Code");
//         OnBeforeInsertPurchaseInvoiceLine(TempStagingPurchaseHeader_g, PurchaseHeader, PurchaseLine);
//         PurchaseLine.Insert(true);
//     end;

//     local procedure GetPurchaseReceiptItemLine()
//         PurchaseLine_l: Record "Purchase Line";
//     begin
//         PurchRcptLine.SetCurrentKey("Pay-to Vendor No.");
//         PurchRcptLine.SetRange("Document No.", TempStagingPurchaseHeader_g."Receipt No.");
//         PurchRcptLine.SetRange("Pay-to Vendor No.", PurchaseHeader."Pay-to Vendor No.");
//         PurchRcptLine.SetRange("Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor No.");
//         PurchRcptLine.SetFilter("Qty. Rcd. Not Invoiced", '<>0');
//         PurchRcptLine.SetRange("Currency Code", PurchaseHeader."Currency Code");
//         PurchRcptLine.SetRange("No.", TempStagingPurchaseHeader_g."Item No.");
//         PurchRcptLine.FindFirst();
//         GetReceipts.SetPurchHeader(PurchaseHeader);
//         GetReceipts.CreateInvLines(PurchRcptLine);
//         OnBeforeGetPurchaseReceiptItemLine(TempStagingPurchaseHeader_g, PurchaseLine_l, PurchRcptLine);
//         PurchaseLine_l.Reset();
//         PurchaseLine_l.SetRange("Document No.", PurchaseHeader."No.");
//         PurchaseLine_l.SetRange("No.", TempStagingPurchaseHeader_g."Item No.");
//         if PurchaseLine_l.FindFirst() then begin
//             PurchaseLine_l.Description := TempStagingPurchaseHeader_g.Description;
//             PurchaseLine_l.Validate(Quantity, TempStagingPurchaseHeader_g.Quantity);
//             PurchaseLine_l.Validate("Direct Unit Cost", TempStagingPurchaseHeader_g."Direct Unit Cost");
//             PurchaseLine.Validate("Currency Code", PurchaseHeader."Currency Code");
//             OnAfterGetPurchaseReceiptItemLine(TempStagingPurchaseHeader_g, PurchaseLine_l, PurchRcptLine);
//             PurchaseLine_l.Modify(true);
//         end;

//     end;

//     local procedure InsertPurchaseInvoiceChargItemLine()
//     begin
//         PurchaseLine.LockTable();
//         PurchaseLine.Init();
//         PurchaseLine."Document Type" := PurchaseHeader."Document Type"::Invoice;
//         PurchaseLine."Document No." := PurchaseHeader."No.";
//         PurchaseLine."Line No." := TempStagingPurchaseHeader_g."Line No.";
//         PurchaseLine.Validate("Location Code", PurchaseHeader."Location Code");
//         PurchaseLine.Validate("Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor No.");
//         PurchaseLine.Type := PurchaseLine.Type::"Charge (Item)";
//         PurchaseLine.Validate("No.", TempStagingPurchaseHeader_g."Item No.");
//         PurchaseLine.Description := TempStagingPurchaseHeader_g.Description;
//         PurchaseLine.Validate(Quantity, TempStagingPurchaseHeader_g.Quantity);
//         PurchaseLine.Validate("Qty. to Invoice", TempStagingPurchaseHeader_g.Quantity);
//         PurchaseLine.Validate("Direct Unit Cost", TempStagingPurchaseHeader_g."Direct Unit Cost");
//         PurchaseLine.Validate("Currency Code", PurchaseHeader."Currency Code");
//         PurchaseLine.Insert(true);
//         GetItemChargeAssgnt();
//     end;

//     local procedure GetItemChargeAssgnt()
//     var
//         ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
//         AssignItemChargePurch: Codeunit "Item Charge Assgnt. (Purch.)";
//         ItemChargeAssgnts: Page "Item Charge Assignment (Purch)";
//         ItemChargeAssgntLineAmt: Decimal;
//         IsHandled: Boolean;
//     begin
//         PurchaseLine.TestField("No.");
//         PurchaseLine.TestField(Quantity);
//         if PurchaseHeader."Currency Code" = '' then
//             Currency.InitRoundingPrecision
//         else
//             Currency.Get(PurchaseHeader."Currency Code");
//         if (PurchaseLine."Inv. Discount Amount" = 0) and
//            (PurchaseLine."Line Discount Amount" = 0) and
//            (not PurchaseHeader."Prices Including VAT")
//         then
//             ItemChargeAssgntLineAmt := PurchaseLine."Line Amount"
//         else
//             if PurchaseHeader."Prices Including VAT" then
//                 ItemChargeAssgntLineAmt :=
//                   Round((PurchaseLine."Line Amount" - PurchaseLine."Inv. Discount Amount") / (1 + PurchaseLine."VAT %" / 100), Currency."Amount Rounding Precision")
//             else
//                 ItemChargeAssgntLineAmt := PurchaseLine."Line Amount" - PurchaseLine."Inv. Discount Amount";

//         ItemChargeAssgntPurch.Reset();
//         ItemChargeAssgntPurch.SetRange("Document Type", PurchaseLine."Document Type");
//         ItemChargeAssgntPurch.SetRange("Document No.", PurchaseLine."Document No.");
//         ItemChargeAssgntPurch.SetRange("Document Line No.", PurchaseLine."Line No.");
//         ItemChargeAssgntPurch.SetRange("Item Charge No.", PurchaseLine."No.");
//         if not ItemChargeAssgntPurch.FindLast then begin
//             ItemChargeAssgntPurch."Document Type" := PurchaseLine."Document Type";
//             ItemChargeAssgntPurch."Document No." := PurchaseLine."Document No.";
//             ItemChargeAssgntPurch."Document Line No." := PurchaseLine."Line No.";
//             ItemChargeAssgntPurch."Item Charge No." := PurchaseLine."No.";
//             ItemChargeAssgntPurch."Unit Cost" :=
//               Round(ItemChargeAssgntLineAmt / PurchaseLine.Quantity,
//                 Currency."Unit-Amount Rounding Precision");
//         end;

//         IsHandled := false;
//         if not IsHandled then
//             ItemChargeAssgntLineAmt :=
//                 Round(ItemChargeAssgntLineAmt * (PurchaseLine."Qty. to Invoice" / PurchaseLine.Quantity), Currency."Amount Rounding Precision");

//         AssignItemChargePurch.CreateDocChargeAssgnt(ItemChargeAssgntPurch, TempStagingPurchaseHeader_g."Charge Item Doc1");

//         Clear(AssignItemChargePurch);
//         case TempStagingPurchaseHeader_g."Charge Item Types" of
//             TempStagingPurchaseHeader_g."Charge Item Types"::PR:
//                 begin
//                     FromPurchRcptLine.Reset();
//                     FromPurchRcptLine.SetFilter("Document No.", '%1|%2', TempStagingPurchaseHeader_g."Charge Item Doc1", TempStagingPurchaseHeader_g."Charge Item Doc2");
//                     FromPurchRcptLine.SetRange(Type, FromPurchRcptLine.Type::Item);
//                     FromPurchRcptLine.SetFilter(Quantity, '>%1', 0);
//                     FromPurchRcptLine.SetRange(Correction, false);
//                     FromPurchRcptLine.FindFirst();
//                     AssignItemChargePurch.CreateRcptChargeAssgnt(FromPurchRcptLine, ItemChargeAssgntPurch);

//                 end;
//             TempStagingPurchaseHeader_g."Charge Item Types"::RR:
//                 begin
//                     ReturnRcptLines.Reset();
//                     ReturnRcptLines.SetFilter("Document No.", '%1|%2', TempStagingPurchaseHeader_g."Charge Item Doc1", TempStagingPurchaseHeader_g."Charge Item Doc2");
//                     ReturnRcptLines.SetRange(Type, ReturnRcptLines.Type::Item);
//                     ReturnRcptLines.SetFilter(Quantity, '>%1', 0);
//                     ReturnRcptLines.SetRange(Correction, false);
//                     ReturnRcptLines.FindFirst();
//                     AssignItemChargePurch.CreateReturnRcptChargeAssgnt(ReturnRcptLines, ItemChargeAssgntPurch);
//                 end;
//             TempStagingPurchaseHeader_g."Charge Item Types"::RS:
//                 begin
//                     ReturnShptLine.Reset();
//                     ReturnShptLine.SetFilter("Document No.", '%1|%2', TempStagingPurchaseHeader_g."Charge Item Doc1", TempStagingPurchaseHeader_g."Charge Item Doc2");
//                     ReturnShptLine.SetRange(Type, ReturnShptLine.Type::Item);
//                     ReturnShptLine.SetFilter(Quantity, '>%1', 0);
//                     ReturnShptLine.SetRange(Correction, false);
//                     ReturnShptLine.FindFirst();
//                     AssignItemChargePurch.CreateShptChargeAssgnt(ReturnShptLine, ItemChargeAssgntPurch);
//                 end;
//             TempStagingPurchaseHeader_g."Charge Item Types"::SS:
//                 begin
//                     SalesShipmentLines.Reset();
//                     SalesShipmentLines.SetFilter("Document No.", '%1|%2', TempStagingPurchaseHeader_g."Charge Item Doc1", TempStagingPurchaseHeader_g."Charge Item Doc2");
//                     SalesShipmentLines.SetRange(Type, SalesShipmentLines.Type::Item);
//                     SalesShipmentLines.SetFilter(Quantity, '>%1', 0);
//                     SalesShipmentLines.SetRange(Correction, false);
//                     SalesShipmentLines.FindFirst();
//                     AssignItemChargePurch.CreateSalesShptChargeAssgnt(SalesShipmentLines, ItemChargeAssgntPurch);
//                 end;
//             TempStagingPurchaseHeader_g."Charge Item Types"::TR:
//                 begin
//                     TransferRcptLine.Reset();
//                     TransferRcptLine.SetFilter("Document No.", '%1|%2', TempStagingPurchaseHeader_g."Charge Item Doc1", TempStagingPurchaseHeader_g."Charge Item Doc2");
//                     TransferRcptLine.SetFilter(Quantity, '>%1', 0);
//                     TransferRcptLine.FindFirst();
//                     AssignItemChargePurch.CreateTransferRcptChargeAssgnt(TransferRcptLine, ItemChargeAssgntPurch);
//                 end;
//         end;
//         AssignableQty := TempStagingPurchaseHeader_g.Quantity;
//         if TempStagingPurchaseHeader_g.Alloction = 'EQUALLY' then
//             AssignEqually(ItemChargeAssgntPurch, Currency, AssignableQty, ItemChargeAssgntLineAmt)
//         else
//             if TempStagingPurchaseHeader_g.Alloction = 'AMOUNT' then
//                 AssignByAmount(ItemChargeAssgntPurch, Currency, PurchaseHeader, AssignableQty, ItemChargeAssgntLineAmt)
//             else
//                 if TempStagingPurchaseHeader_g.Alloction = 'WEIGHT' then
//                     AssignByWeight(ItemChargeAssgntPurch, Currency, PurchaseHeader, AssignableQty);
//     end;

//     local procedure AssignEqually(var ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; Currency: Record Currency; TotalQtyToAssign: Decimal; TotalAmtToAssign: Decimal)
//     var
//         ItemChargeAssgntPurch1: Record "Item Charge Assignment (Purch)";
//         RemainingNumOfLines: Integer;
//     begin
//         ItemChargeAssgntPurch1.Reset();
//         ItemChargeAssgntPurch1.SetRange("Document Type", ItemChargeAssgntPurch."Document Type");
//         ItemChargeAssgntPurch1.SetRange("Document No.", ItemChargeAssgntPurch."Document No.");
//         ItemChargeAssgntPurch1.SetRange("Document Line No.", ItemChargeAssgntPurch."Document Line No.");
//         RemainingNumOfLines := ItemChargeAssgntPurch1.Count;
//         if ItemChargeAssgntPurch1.FindFirst() then begin
//             repeat
//                 ItemChargeAssgntPurch1."Qty. to Assign" := Round(TempStagingPurchaseHeader_g.Quantity / RemainingNumOfLines, UOMMgt.QtyRndPrecision);
//                 ItemChargeAssgntPurch1."Amount to Assign" :=
//                  Round(
//                    ItemChargeAssgntPurch1."Qty. to Assign" / TotalQtyToAssign * TotalAmtToAssign,
//                    Currency."Amount Rounding Precision");
//                 TotalQtyToAssign -= ItemChargeAssgntPurch1."Qty. to Assign";
//                 TotalAmtToAssign -= ItemChargeAssgntPurch1."Amount to Assign";
//                 ItemChargeAssgntPurch1.Modify();
//             until ItemChargeAssgntPurch1.Next() = 0;
//         end;
//         ItemChargeAssgntPurch1.Reset();
//         ItemChargeAssgntPurch1.SetRange("Document Type", ItemChargeAssgntPurch."Document Type");
//         ItemChargeAssgntPurch1.SetRange("Document No.", ItemChargeAssgntPurch."Document No.");
//         ItemChargeAssgntPurch1.SetRange("Document Line No.", ItemChargeAssgntPurch."Document Line No.");
//         if ItemChargeAssgntPurch1.FindLast() then begin
//             ItemChargeAssgntPurch1."Qty. to Assign" += TotalQtyToAssign;
//             ItemChargeAssgntPurch1."Amount to Assign" += TotalAmtToAssign;
//             ItemChargeAssgntPurch1.Modify();
//         End;
//     end;

//     local procedure AssignByAmount(var ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; Currency: Record Currency; PurchHeader: Record "Purchase Header"; TotalQtyToAssign: Decimal; TotalAmtToAssign: Decimal)
//     var
//         ItemChargeAssgntPurch1: Record "Item Charge Assignment (Purch)";
//         PurchLine: Record "Purchase Line";
//         PurchRcptLine: Record "Purch. Rcpt. Line";
//         CurrExchRate: Record "Currency Exchange Rate";
//         ReturnRcptLine: Record "Return Receipt Line";
//         ReturnShptLine: Record "Return Shipment Line";
//         SalesShptLine: Record "Sales Shipment Line";
//         CurrencyCode: Code[10];
//         TotalAppliesToDocLineAmount: Decimal;
//     begin
//         ItemChargeAssgntPurch1.Reset();
//         ItemChargeAssgntPurch1.SetRange("Document Type", ItemChargeAssgntPurch."Document Type");
//         ItemChargeAssgntPurch1.SetRange("Document No.", ItemChargeAssgntPurch."Document No.");
//         ItemChargeAssgntPurch1.SetRange("Document Line No.", ItemChargeAssgntPurch."Document Line No.");
//         if ItemChargeAssgntPurch1.FindFirst() then begin
//             repeat
//                 case ItemChargeAssgntPurch1."Applies-to Doc. Type" of
//                     ItemChargeAssgntPurch1."Applies-to Doc. Type"::Quote,
//                     ItemChargeAssgntPurch1."Applies-to Doc. Type"::Order,
//                     ItemChargeAssgntPurch1."Applies-to Doc. Type"::Invoice,
//                     ItemChargeAssgntPurch1."Applies-to Doc. Type"::"Return Order",
//                     ItemChargeAssgntPurch1."Applies-to Doc. Type"::"Credit Memo":
//                         begin
//                             ItemChargeAssgntPurch1."Applies-to Doc. Line Amount" :=
//                               Abs(PurchLine."Line Amount");
//                         end;
//                     ItemChargeAssgntPurch1."Applies-to Doc. Type"::Receipt:
//                         begin
//                             PurchRcptLine.Get(
//                               ItemChargeAssgntPurch1."Applies-to Doc. No.",
//                               ItemChargeAssgntPurch1."Applies-to Doc. Line No.");
//                             CurrencyCode := PurchRcptLine.GetCurrencyCodeFromHeader;
//                             if CurrencyCode = PurchHeader."Currency Code" then
//                                 ItemChargeAssgntPurch1."Applies-to Doc. Line Amount" :=
//                                   Abs(PurchRcptLine."Item Charge Base Amount")
//                             else
//                                 ItemChargeAssgntPurch1."Applies-to Doc. Line Amount" :=
//                                   CurrExchRate.ExchangeAmtFCYToFCY(
//                                     PurchHeader."Posting Date", CurrencyCode, PurchHeader."Currency Code",
//                                     Abs(PurchRcptLine."Item Charge Base Amount"));

//                         end;
//                     ItemChargeAssgntPurch1."Applies-to Doc. Type"::"Return Shipment":
//                         begin
//                             ReturnShptLine.Get(
//                               ItemChargeAssgntPurch1."Applies-to Doc. No.",
//                               ItemChargeAssgntPurch1."Applies-to Doc. Line No.");
//                             CurrencyCode := ReturnShptLine.GetCurrencyCode();
//                             if CurrencyCode = PurchHeader."Currency Code" then
//                                 ItemChargeAssgntPurch1."Applies-to Doc. Line Amount" :=
//                                   Abs(ReturnShptLine."Item Charge Base Amount")
//                             else
//                                 ItemChargeAssgntPurch1."Applies-to Doc. Line Amount" :=
//                                   CurrExchRate.ExchangeAmtFCYToFCY(
//                                     PurchHeader."Posting Date", CurrencyCode, PurchHeader."Currency Code",
//                                     Abs(ReturnShptLine."Item Charge Base Amount"));
//                         end;
//                     ItemChargeAssgntPurch1."Applies-to Doc. Type"::"Sales Shipment":
//                         begin
//                             SalesShptLine.Get(
//                               ItemChargeAssgntPurch1."Applies-to Doc. No.",
//                               ItemChargeAssgntPurch1."Applies-to Doc. Line No.");
//                             CurrencyCode := SalesShptLine.GetCurrencyCode();
//                             if CurrencyCode = PurchHeader."Currency Code" then
//                                 ItemChargeAssgntPurch1."Applies-to Doc. Line Amount" :=
//                                   Abs(SalesShptLine."Item Charge Base Amount")
//                             else
//                                 ItemChargeAssgntPurch1."Applies-to Doc. Line Amount" :=
//                                   CurrExchRate.ExchangeAmtFCYToFCY(
//                                     PurchHeader."Posting Date", CurrencyCode, PurchHeader."Currency Code",
//                                     Abs(SalesShptLine."Item Charge Base Amount"));
//                         end;
//                     ItemChargeAssgntPurch1."Applies-to Doc. Type"::"Return Receipt":
//                         begin
//                             ReturnRcptLine.Get(
//                               ItemChargeAssgntPurch1."Applies-to Doc. No.",
//                               ItemChargeAssgntPurch1."Applies-to Doc. Line No.");
//                             CurrencyCode := ReturnRcptLine.GetCurrencyCode();
//                             if CurrencyCode = PurchHeader."Currency Code" then
//                                 ItemChargeAssgntPurch1."Applies-to Doc. Line Amount" :=
//                                   Abs(ReturnRcptLine."Item Charge Base Amount")
//                             else
//                                 ItemChargeAssgntPurch1."Applies-to Doc. Line Amount" :=
//                                   CurrExchRate.ExchangeAmtFCYToFCY(
//                                     PurchHeader."Posting Date", CurrencyCode, PurchHeader."Currency Code",
//                                     Abs(ReturnRcptLine."Item Charge Base Amount"));
//                         end;
//                 end;
//                 ItemChargeAssgntPurch1."Amount to Assign" := 0;
//                 ItemChargeAssgntPurch1."Qty. to Assign" := 0;
//                 ItemChargeAssgntPurch1.Modify();
//                 TotalAppliesToDocLineAmount += ItemChargeAssgntPurch1."Applies-to Doc. Line Amount";
//             until ItemChargeAssgntPurch1.Next() = 0;
//         end;
//         ItemChargeAssgntPurch1.Reset();
//         ItemChargeAssgntPurch1.SetRange("Document Type", ItemChargeAssgntPurch."Document Type");
//         ItemChargeAssgntPurch1.SetRange("Document No.", ItemChargeAssgntPurch."Document No.");
//         ItemChargeAssgntPurch1.SetRange("Document Line No.", ItemChargeAssgntPurch."Document Line No.");
//         ItemChargeAssgntPurch1.SetFILTER("Applies-to Doc. Line Amount", '<>%1', 0);
//         if ItemChargeAssgntPurch1.FindSet() then begin
//             repeat
//                 if TotalQtyToAssign <> 0 then begin
//                     ItemChargeAssgntPurch1."Qty. to Assign" :=
//                       Round(
//                         ItemChargeAssgntPurch1."Applies-to Doc. Line Amount" / TotalAppliesToDocLineAmount * TotalQtyToAssign,
//                         UOMMgt.QtyRndPrecision);
//                     ItemChargeAssgntPurch1."Amount to Assign" :=
//                       Round(
//                         ItemChargeAssgntPurch1."Qty. to Assign" / TotalQtyToAssign * TotalAmtToAssign,
//                         Currency."Amount Rounding Precision");

//                     TotalQtyToAssign -= ItemChargeAssgntPurch1."Qty. to Assign";
//                     TotalAmtToAssign -= ItemChargeAssgntPurch1."Amount to Assign";
//                     TotalAppliesToDocLineAmount -= ItemChargeAssgntPurch1."Applies-to Doc. Line Amount";
//                     ItemChargeAssgntPurch1.Modify();
//                 end;
//             until ItemChargeAssgntPurch1.next = 0;
//         end;
//         ItemChargeAssgntPurch1.Reset();
//         ItemChargeAssgntPurch1.SetRange("Document Type", ItemChargeAssgntPurch."Document Type");
//         ItemChargeAssgntPurch1.SetRange("Document No.", ItemChargeAssgntPurch."Document No.");
//         ItemChargeAssgntPurch1.SetRange("Document Line No.", ItemChargeAssgntPurch."Document Line No.");
//         ItemChargeAssgntPurch1.SetFILTER("Applies-to Doc. Line Amount", '<>%1', 0);
//         if ItemChargeAssgntPurch1.FindLast() then begin
//             ItemChargeAssgntPurch1."Qty. to Assign" += TotalQtyToAssign;
//             ItemChargeAssgntPurch1."Amount to Assign" += TotalAmtToAssign;
//             ItemChargeAssgntPurch1.Modify();
//         End;
//     end;

//     local procedure AssignByWeight(var ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; Currency: Record Currency; PurchHeader: Record "Purchase Header"; TotalQtyToAssign: Decimal)
//     var
//         TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary;
//         LineAray: array[3] of Decimal;
//         TotalGrossWeight: Decimal;
//         QtyRemainder: Decimal;
//         AmountRemainder: Decimal;
//     begin
//         repeat
//             if not ItemChargeAssgntPurch.PurchLineInvoiced then begin
//                 TempItemChargeAssgntPurch.Init();
//                 TempItemChargeAssgntPurch := ItemChargeAssgntPurch;
//                 TempItemChargeAssgntPurch.Insert();
//                 GetItemValues(TempItemChargeAssgntPurch, LineAray);
//                 // TotalGrossWeight := TotalGrossWeight + (LineAray[2] * LineAray[1]);
//                 TotalGrossWeight := TotalGrossWeight + LineAray[2];
//             end;
//         until ItemChargeAssgntPurch.Next() = 0;
//         OnAssignByWeightOnAfterCalcTotalGrossWeight(ItemChargeAssgntPurch, TotalGrossWeight);

//         if TempItemChargeAssgntPurch.FindSet(true) then
//             repeat
//                 GetItemValues(TempItemChargeAssgntPurch, LineAray);
//                 if TotalGrossWeight <> 0 then
//                     // TempItemChargeAssgntPurch."Qty. to Assign" := (TotalQtyToAssign * LineAray[2] * LineAray[1]) / TotalGrossWeight + QtyRemainder
//                       TempItemChargeAssgntPurch."Qty. to Assign" := (TotalQtyToAssign * LineAray[2]) / TotalGrossWeight + QtyRemainder
//                 else
//                     TempItemChargeAssgntPurch."Qty. to Assign" := 0;
//                 AssignPurchItemCharge(ItemChargeAssgntPurch, TempItemChargeAssgntPurch, Currency, QtyRemainder, AmountRemainder);
//             until TempItemChargeAssgntPurch.Next() = 0;
//         OnAssignByWeightOnBeforeTempItemChargeAssgntPurchDelete(ItemChargeAssgntPurch, QtyRemainder, TotalQtyToAssign);
//         TempItemChargeAssgntPurch.DeleteAll();
//     end;

//     local procedure AssignPurchItemCharge(var ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; ItemChargeAssgntPurch2: Record "Item Charge Assignment (Purch)"; Currency: Record Currency; var QtyRemainder: Decimal; var AmountRemainder: Decimal)
//     begin
//         ItemChargeAssgntPurch.Reset();
//         ItemChargeAssgntPurch.SetRange("Document Type", ItemChargeAssgntPurch2."Document Type");
//         ItemChargeAssgntPurch.SetRange("Document No.", ItemChargeAssgntPurch2."Document No.");
//         ItemChargeAssgntPurch.SetRange("Document Line No.", ItemChargeAssgntPurch2."Document Line No.");
//         ItemChargeAssgntPurch.SetRange("Line No.", ItemChargeAssgntPurch2."Line No.");
//         if ItemChargeAssgntPurch.FindFirst() then begin
//             ItemChargeAssgntPurch."Qty. to Assign" := Round(ItemChargeAssgntPurch2."Qty. to Assign", UOMMgt.QtyRndPrecision);
//             ItemChargeAssgntPurch."Amount to Assign" :=
//               ItemChargeAssgntPurch."Qty. to Assign" * ItemChargeAssgntPurch."Unit Cost" + AmountRemainder;
//             AmountRemainder := ItemChargeAssgntPurch."Amount to Assign" -
//               Round(ItemChargeAssgntPurch."Amount to Assign", Currency."Amount Rounding Precision");
//             QtyRemainder := ItemChargeAssgntPurch2."Qty. to Assign" - ItemChargeAssgntPurch."Qty. to Assign";
//             ItemChargeAssgntPurch."Amount to Assign" :=
//               Round(ItemChargeAssgntPurch."Amount to Assign", Currency."Amount Rounding Precision");
//             ItemChargeAssgntPurch.Modify();
//         end;
//     end;

//     procedure GetItemValues(TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary; var DecimalArray: array[3] of Decimal)
//     var
//         PurchLine: Record "Purchase Line";
//         PurchRcptLine: Record "Purch. Rcpt. Line";
//         ReturnShptLine: Record "Return Shipment Line";
//         TransferRcptLine: Record "Transfer Receipt Line";
//         SalesShptLine: Record "Sales Shipment Line";
//         ReturnRcptLine: Record "Return Receipt Line";
//     begin
//         Clear(DecimalArray);
//         case TempItemChargeAssgntPurch."Applies-to Doc. Type" of
//             TempItemChargeAssgntPurch."Applies-to Doc. Type"::Order,
//             TempItemChargeAssgntPurch."Applies-to Doc. Type"::Invoice,
//             TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Order",
//             TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Credit Memo":
//                 begin
//                     PurchLine.Get(TempItemChargeAssgntPurch."Applies-to Doc. Type", TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
//                     DecimalArray[1] := PurchLine.Quantity;
//                     DecimalArray[2] := PurchLine."Gross Weight";
//                     DecimalArray[3] := PurchLine."Unit Volume";
//                 end;
//             TempItemChargeAssgntPurch."Applies-to Doc. Type"::Receipt:
//                 begin
//                     PurchRcptLine.Get(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
//                     DecimalArray[1] := PurchRcptLine.Quantity;
//                     DecimalArray[2] := PurchRcptLine."Gross Weight";
//                     DecimalArray[3] := PurchRcptLine."Unit Volume";
//                 end;
//             TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Receipt":
//                 begin
//                     ReturnRcptLine.Get(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
//                     DecimalArray[1] := ReturnRcptLine.Quantity;
//                     DecimalArray[2] := ReturnRcptLine."Gross Weight";
//                     DecimalArray[3] := ReturnRcptLine."Unit Volume";
//                 end;
//             TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Shipment":
//                 begin
//                     ReturnShptLine.Get(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
//                     DecimalArray[1] := ReturnShptLine.Quantity;
//                     DecimalArray[2] := ReturnShptLine."Gross Weight";
//                     DecimalArray[3] := ReturnShptLine."Unit Volume";
//                 end;
//             TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Transfer Receipt":
//                 begin
//                     TransferRcptLine.Get(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
//                     DecimalArray[1] := TransferRcptLine.Quantity;
//                     DecimalArray[2] := TransferRcptLine."Gross Weight";
//                     DecimalArray[3] := TransferRcptLine."Unit Volume";
//                 end;
//             TempItemChargeAssgntPurch."Applies-to Doc. Type"::"Sales Shipment":
//                 begin
//                     SalesShptLine.Get(TempItemChargeAssgntPurch."Applies-to Doc. No.", TempItemChargeAssgntPurch."Applies-to Doc. Line No.");
//                     DecimalArray[1] := SalesShptLine.Quantity;
//                     DecimalArray[2] := SalesShptLine."Gross Weight";
//                     DecimalArray[3] := SalesShptLine."Unit Volume";
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', true, true)]
//     local procedure "Purch.-Post_OnBeforePostPurchaseDoc"
//     (
//         var PurchaseHeader: Record "Purchase Header";
//         PreviewMode: Boolean;
//         CommitIsSupressed: Boolean;
//         var HideProgressWindow: Boolean
//     )
//     begin
//         if (not PreviewMode) And (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) then begin
//             ExitsStagingPurchaseInvoice.Reset();
//             ExitsStagingPurchaseInvoice.SetRange("Purch. Inv. No.", PurchaseHeader."No.");
//             if ExitsStagingPurchaseInvoice.FindSet() then begin
//                 UpdateBefore_Purch_Post(PurchaseHeader);
//             end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', true, true)]
//     local procedure "Purch.-Post_OnAfterPostPurchaseDoc"
//     (
//         var PurchaseHeader: Record "Purchase Header";
//         var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
//         PurchRcpHdrNo: Code[20];
//         RetShptHdrNo: Code[20];
//         PurchInvHdrNo: Code[20];
//         PurchCrMemoHdrNo: Code[20];
//         CommitIsSupressed: Boolean
//     )
//     begin
//         StagingPurchaseInvoice.Reset();
//         StagingPurchaseInvoice.SetRange("Vendor Refrence", PurchaseHeader."Vendor Invoice No.");
//         StagingPurchaseInvoice.SetRange("Purch. Inv. No.", PurchaseHeader."No.");
//         if StagingPurchaseInvoice.FindSet() then
//             repeat
//                 StagingPurchaseInvoice."Posted Purch. Inv. No." := PurchInvHdrNo;
//                 StagingPurchaseInvoice.Modify(true);
//             until StagingPurchaseInvoice.next = 0;

//     end;
//     /// <summary>
//     /// UpdateBefore__Purch_Post.
//     /// </summary>
//     /// <param name="PurchaseHeader1">VAR Record "Purchase Header".</param>
//     procedure UpdateBefore_Purch_Post(var PurchaseHeader1: Record "Purchase Header")
//     PurchInvHeader: Record "Purch. Inv. Header";
//     begin
//         StagingPurchaseInvoice.Reset();
//         StagingPurchaseInvoice.SetRange("Purch. Inv. No.", PurchaseHeader1."No.");
//         //StagingPurchaseInvoice.SetRange(Status, StagingPurchaseInvoice.Status::Created);
//         StagingPurchaseInvoice.FindSet();
//         repeat
//             PurchaseLine.Reset();
//             PurchaseLine.SetRange("Document No.", PurchaseHeader1."No.");
//             PurchaseLine.SetRange("No.", StagingPurchaseInvoice."Item No.");
//             if PurchaseLine.FindFirst() then begin
//                 clear(PurchInvHeader);
//                 PurchInvHeader.SetRange(PurchInvHeader."Pre-Assigned No.", PurchaseHeader1."No.");
//                 if PurchInvHeader.FindFirst() then
//                     StagingPurchaseInvoice."Posted Purch. Inv. No." := PurchInvHeader."No.";
//                 StagingPurchaseInvoice.Status := StagingPurchaseInvoice.Status::Closed;
//                 StagingPurchaseInvoice.Modify(true);
//             end else
//                 Error('Staging Purch. Inv. Line status are in Open\Error, Please Check before posting');
//         until StagingPurchaseInvoice.next = 0;
//     end;


//     [IntegrationEvent(false, false)]
//     local procedure OnAssignByWeightOnBeforeTempItemChargeAssgntPurchDelete(var ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; QtyRemainder: Decimal; QtyToAssign: Decimal)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAssignByWeightOnAfterCalcTotalGrossWeight(var ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; TotalGrossWeight: Decimal)
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnExcelImportAfter()
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnRunAfer(var StagingPurchInv: Record "Staging Purchase Invoice")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnRunBefor(var StagingPurchInv: Record "Staging Purchase Invoice")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterInsertPurchInv(var StagingPurchInv: Record "Staging Purchase Invoice")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeInsertPurchInv(var StagingPurchInv: Record "Staging Purchase Invoice")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeChangeStagingPurchInv(var StagingPurchInv: Record "Staging Purchase Invoice")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeInsertPurchaseInvoice(var StagingPurchInv: Record "Staging Purchase Invoice"; Var PurchHeader: Record "Purchase Header")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterInsertPurchaseInvoice(var StagingPurchInv: Record "Staging Purchase Invoice"; Var PurchHeader: Record "Purchase Header"; Var PurchLine: Record "Purchase Line")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeInsertPurchaseInvoiceLine(var StagingPurchInv: Record "Staging Purchase Invoice"; Var PurchHeader: Record "Purchase Header"; Var PurchLine: Record "Purchase Line")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeGetPurchaseReceiptItemLine(var StagingPurchInv: Record "Staging Purchase Invoice"; Var PurchLine: Record "Purchase Line"; var PurchReceiptLine: Record "Purch. Rcpt. Line")
//     begin
//     end;

//     [IntegrationEvent(false, false)]
//     local procedure OnAfterGetPurchaseReceiptItemLine(var StagingPurchInv: Record "Staging Purchase Invoice"; Var PurchLine: Record "Purchase Line"; var PurchReceiptLine: Record "Purch. Rcpt. Line")
//     begin
//     end;


//     var
//         StagingPurchaseInvoice: Record "Staging Purchase Invoice";
//         ExitsStagingPurchaseInvoice: Record "Staging Purchase Invoice";
//         AssignableQty: Decimal;
//         SalesShipmentLines: Record "Sales Shipment Line";
//         TransferRcptLine: Record "Transfer Receipt Line";
//         ReturnShptLine: Record "Return Shipment Line";
//         ReturnRcptLines: Record "Return Receipt Line";
//         PurchaseHeader: Record "Purchase Header";
//         PurchaseLine: Record "Purchase Line";
//         PurchaseLine2: Record "Purchase Line";
//         GenJournalLine: Record "Gen. Journal Line";
//         Purchase_payableSetup: Record "Purchases & Payables Setup";
//         NoSeriesManagement: Codeunit NoSeriesManagement;
//         GetReceipts: Codeunit "Purch.-Get Receipt";
//         PurchRcptLine: Record "Purch. Rcpt. Line";
//         Currency: Record Currency;
//         FromPurchRcptLine: Record "Purch. Rcpt. Line";
//         TempStagingPurchaseHeader_g: Record "Staging Purchase Invoice";
//         UOMMgt: Codeunit "Unit of Measure Management";
//         PurchInvHeader1: Record "Purch. Inv. Header";
// }