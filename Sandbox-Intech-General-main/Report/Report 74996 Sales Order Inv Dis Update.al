Report 74996 "Sales Order Inv Dis Update"
{
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CalFinalAmt_gDec := 0;
    end;

    trigger OnPostReport()
    begin
        TotalSalesLine[1]."Inv. Discount Amount" := AppliedInvDisAmt_gDec;
        AllowInvDisc := true;
        UpdateInvDiscAmount(1);
    end;

    trigger OnPreReport()
    begin
        AllowInvDisc := true;
        AllowVATDifference := false;
        VATLinesFormIsEditable := false;
        RefreshOnAfterGetRecord;
    end;

    var
        TotalSalesLine: array[3] of Record "Sales Line";
        TotalSalesLineLCY: array[3] of Record "Sales Line";
        Cust: Record Customer;
        TempVATAmountLine1: Record "VAT Amount Line" temporary;
        TempVATAmountLine2: Record "VAT Amount Line" temporary;
        TempVATAmountLine3: Record "VAT Amount Line" temporary;
        TempVATAmountLine4: Record "VAT Amount Line" temporary;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPost: Codeunit "Sales-Post";
        TotalAmount1: array[3] of Decimal;
        TotalAmount2: array[3] of Decimal;
        VATAmount: array[3] of Decimal;
        PrepmtTotalAmount: Decimal;
        PrepmtVATAmount: Decimal;
        PrepmtTotalAmount2: Decimal;
        VATAmountText: array[3] of Text[30];
        PrepmtVATAmountText: Text[30];
        ProfitLCY: array[3] of Decimal;
        ProfitPct: array[3] of Decimal;
        AdjProfitLCY: array[3] of Decimal;
        AdjProfitPct: array[3] of Decimal;
        TotalAdjCostLCY: array[3] of Decimal;
        CreditLimitLCYExpendedPct: Decimal;
        PrepmtInvPct: Decimal;
        PrepmtDeductedPct: Decimal;
        i: Integer;
        PrevNo: Code[20];
        ActiveTab: Option General,Invoicing,Shipping,Prepayment;
        PrevTab: Option General,Invoicing,Shipping,Prepayment;
        VATLinesFormIsEditable: Boolean;
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
        VATLinesForm: Page "VAT Amount Lines";
        DynamicEditable: Boolean;
        TotalGSTInvoiced: Decimal;
        TotalGSTShipped: Decimal;
        TotalAdvGSTInvoiced: Decimal;
        TotalAdvGSTShipped: Decimal;
        TotalGSTAmt: Decimal;
        TotalGST: Decimal;
        TotalAdvAmount: Decimal;
        TotalAmountApplied: Decimal;
        SalesHeader_gRec: Record "Sales Header";
        AppliedInvDisAmt_gDec: Decimal;
        Text000: label 'Sales %1 Statistics';
        Text001: label 'Total';
        Text002: label 'Amount';
        Text003: label '%1 must not be 0.';
        Text004: label '%1 must not be greater than %2.';
        Text005: label 'You cannot change the invoice discount because a customer invoice discount with the code %1 exists.';
        Text006: label 'Prepmt. Amount';
        Text007: label 'Prepmt. Amt. Invoiced';
        Text008: label 'Prepmt. Amt. Deducted';
        Text009: label 'Prepmt. Amt. to Deduct';
        UpdateInvDiscountQst: label 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?';
        CalFinalAmt_gDec: Decimal;

    local procedure RefreshOnAfterGetRecord()
    var
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
        SalesPostPrepayments: Codeunit "Sales-Post Prepayments";
    begin
        begin
            if PrevNo = SalesHeader_gRec."No." then
                exit;
            PrevNo := SalesHeader_gRec."No.";
            SalesHeader_gRec.FilterGroup(2);
            SalesHeader_gRec.SetRange(SalesHeader_gRec."No.", PrevNo);
            SalesHeader_gRec.FilterGroup(0);

            Clear(SalesLine);
            Clear(TotalSalesLine);
            Clear(TotalSalesLineLCY);

            for i := 1 to 3 do begin
                TempSalesLine.DeleteAll;
                Clear(TempSalesLine);
                Clear(SalesPost);
                SalesPost.GetSalesLines(SalesHeader_gRec, TempSalesLine, i - 1);
                Clear(SalesPost);
                case i of
                    1:
                        SalesLine.CalcVATAmountLines(0, SalesHeader_gRec, TempSalesLine, TempVATAmountLine1);
                    2:
                        SalesLine.CalcVATAmountLines(0, SalesHeader_gRec, TempSalesLine, TempVATAmountLine2);
                    3:
                        SalesLine.CalcVATAmountLines(0, SalesHeader_gRec, TempSalesLine, TempVATAmountLine3);
                end;

                SalesPost.SumSalesLinesTemp(
                  SalesHeader_gRec, TempSalesLine, i - 1, TotalSalesLine[i], TotalSalesLineLCY[i],
                  VATAmount[i], VATAmountText[i], ProfitLCY[i], ProfitPct[i], TotalAdjCostLCY[i]);

                if i = 3 then
                    TotalAdjCostLCY[i] := TotalSalesLineLCY[i]."Unit Cost (LCY)";

                AdjProfitLCY[i] := TotalSalesLineLCY[i].Amount - TotalAdjCostLCY[i];
                if TotalSalesLineLCY[i].Amount <> 0 then
                    AdjProfitPct[i] := ROUND(AdjProfitLCY[i] / TotalSalesLineLCY[i].Amount * 100, 0.1);

                if SalesHeader_gRec."Prices Including VAT" then begin
                    TotalAmount2[i] := TotalSalesLine[i].Amount;
                    TotalAmount1[i] := TotalAmount2[i] + VATAmount[i];
                    TotalSalesLine[i]."Line Amount" := TotalAmount1[i] + TotalSalesLine[i]."Inv. Discount Amount";
                end else begin
                    TotalAmount1[i] := TotalSalesLine[i].Amount;
                    TotalAmount2[i] := TotalSalesLine[i]."Amount Including VAT";
                end;
                //SalesHeader_gRec.CalcFields("Price Inclusive of Taxes");
                //if "Price Inclusive of Taxes" then
                //    TotalAmount1[i] := TotalSalesLine[i].Amount - TotalGSTAmt;
            end;
            TempSalesLine.DeleteAll;
            Clear(TempSalesLine);
            SalesPostPrepayments.GetSalesLines(SalesHeader_gRec, 0, TempSalesLine);
            SalesPostPrepayments.SumPrepmt(
              SalesHeader_gRec, TempSalesLine, TempVATAmountLine4, PrepmtTotalAmount, PrepmtVATAmount, PrepmtVATAmountText);
            PrepmtInvPct :=
              Pct(TotalSalesLine[1]."Prepmt. Amt. Inv.", PrepmtTotalAmount);
            PrepmtDeductedPct :=
              Pct(TotalSalesLine[1]."Prepmt Amt Deducted", TotalSalesLine[1]."Prepmt. Amt. Inv.");
            if SalesHeader_gRec."Prices Including VAT" then begin
                PrepmtTotalAmount2 := PrepmtTotalAmount;
                PrepmtTotalAmount := PrepmtTotalAmount + PrepmtVATAmount;
            end else
                PrepmtTotalAmount2 := PrepmtTotalAmount + PrepmtVATAmount;

            if Cust.Get(SalesHeader_gRec."Bill-to Customer No.") then
                Cust.CalcFields("Balance (LCY)")
            else
                Clear(Cust);

            case true of
                Cust."Credit Limit (LCY)" = 0:
                    CreditLimitLCYExpendedPct := 0;
                Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" < 0:
                    CreditLimitLCYExpendedPct := 0;
                Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" > 1:
                    CreditLimitLCYExpendedPct := 10000;
                else
                    CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000, 1);
            end;

            TempVATAmountLine1.ModifyAll(Modified, false);
            TempVATAmountLine2.ModifyAll(Modified, false);
            TempVATAmountLine3.ModifyAll(Modified, false);
            TempVATAmountLine4.ModifyAll(Modified, false);

#pragma warning disable
            PrevTab := -1;
#pragma warning disable

            UpdateHeaderInfo(2, TempVATAmountLine2);
        end;
    end;

    local procedure Pct(Numerator: Decimal; Denominator: Decimal): Decimal
    begin
        if Denominator = 0 then
            exit(0);
        exit(ROUND(Numerator / Denominator * 10000, 1));
    end;

    local procedure UpdateHeaderInfo(IndexNo: Integer; var VATAmountLine: Record "VAT Amount Line")
    var
        CurrExchRate: Record "Currency Exchange Rate";
        UseDate: Date;
    begin
        begin
            TotalSalesLine[IndexNo]."Inv. Discount Amount" := VATAmountLine.GetTotalInvDiscAmount;
            TotalAmount1[IndexNo] :=
              TotalSalesLine[IndexNo]."Line Amount" - TotalSalesLine[IndexNo]."Inv. Discount Amount";
            VATAmount[IndexNo] := VATAmountLine.GetTotalVATAmount;
            if SalesHeader_gRec."Prices Including VAT" then begin
                TotalAmount1[IndexNo] := VATAmountLine.GetTotalAmountInclVAT;
                TotalAmount2[IndexNo] := TotalAmount1[IndexNo] - VATAmount[IndexNo];
                TotalSalesLine[IndexNo]."Line Amount" :=
                  TotalAmount1[IndexNo] + TotalSalesLine[IndexNo]."Inv. Discount Amount";
            end else
                TotalAmount2[IndexNo] := TotalAmount1[IndexNo] + VATAmount[IndexNo];

            if SalesHeader_gRec."Prices Including VAT" then
                TotalSalesLineLCY[IndexNo].Amount := TotalAmount2[IndexNo]
            else
                TotalSalesLineLCY[IndexNo].Amount := TotalAmount1[IndexNo];
            if SalesHeader_gRec."Currency Code" <> '' then
                if SalesHeader_gRec."Posting Date" = 0D then
                    UseDate := WorkDate
                else
                    UseDate := SalesHeader_gRec."Posting Date";

            TotalSalesLineLCY[IndexNo].Amount :=
              CurrExchRate.ExchangeAmtFCYToLCY(
                UseDate, SalesHeader_gRec."Currency Code", TotalSalesLineLCY[IndexNo].Amount, SalesHeader_gRec."Currency Factor");

            ProfitLCY[IndexNo] := TotalSalesLineLCY[IndexNo].Amount - TotalSalesLineLCY[IndexNo]."Unit Cost (LCY)";
            if TotalSalesLineLCY[IndexNo].Amount = 0 then
                ProfitPct[IndexNo] := 0
            else
                ProfitPct[IndexNo] := ROUND(100 * ProfitLCY[IndexNo] / TotalSalesLineLCY[IndexNo].Amount, 0.01);

            AdjProfitLCY[IndexNo] := TotalSalesLineLCY[IndexNo].Amount - TotalAdjCostLCY[IndexNo];
            if TotalSalesLineLCY[IndexNo].Amount = 0 then
                AdjProfitPct[IndexNo] := 0
            else
                AdjProfitPct[IndexNo] := ROUND(100 * AdjProfitLCY[IndexNo] / TotalSalesLineLCY[IndexNo].Amount, 0.01);
        end;
    end;

    local procedure UpdateInvDiscAmount(ModifiedIndexNo: Integer)
    var
        PartialInvoicing: Boolean;
        MaxIndexNo: Integer;
        IndexNo: array[2] of Integer;
        i: Integer;
        InvDiscBaseAmount: Decimal;
    begin

        CheckAllowInvDisc;
        if not (ModifiedIndexNo in [1, 2]) then
            exit;

        if SalesHeader_gRec.InvoicedLineExists then
            if not Confirm(UpdateInvDiscountQst, false) then
                Error('');

        if ModifiedIndexNo = 1 then
            InvDiscBaseAmount := TempVATAmountLine1.GetTotalInvDiscBaseAmount(false, SalesHeader_gRec."Currency Code")
        else
            InvDiscBaseAmount := TempVATAmountLine2.GetTotalInvDiscBaseAmount(false, SalesHeader_gRec."Currency Code");

        if InvDiscBaseAmount = 0 then
            //ERROR(Text003,TempVATAmountLine2.FIELDCAPTION("Inv. Disc. Base Amount"));
            exit;

        if TotalSalesLine[ModifiedIndexNo]."Inv. Discount Amount" / InvDiscBaseAmount > 1 then
            Error(
              Text004,
              TotalSalesLine[ModifiedIndexNo].FieldCaption("Inv. Discount Amount"),
              TempVATAmountLine2.FieldCaption("Inv. Disc. Base Amount"));

        PartialInvoicing := (TotalSalesLine[1]."Line Amount" <> TotalSalesLine[2]."Line Amount");

        IndexNo[1] := ModifiedIndexNo;
        IndexNo[2] := 3 - ModifiedIndexNo;
        if (ModifiedIndexNo = 2) and PartialInvoicing then
            MaxIndexNo := 1
        else
            MaxIndexNo := 2;

        if not PartialInvoicing then
            if ModifiedIndexNo = 1 then
                TotalSalesLine[2]."Inv. Discount Amount" := TotalSalesLine[1]."Inv. Discount Amount"
            else
                TotalSalesLine[1]."Inv. Discount Amount" := TotalSalesLine[2]."Inv. Discount Amount";

        for i := 1 to MaxIndexNo do begin
            if (i = 1) or not PartialInvoicing then
                if IndexNo[i] = 1 then begin
                    TempVATAmountLine1.SetInvoiceDiscountAmount(
                      TotalSalesLine[IndexNo[i]]."Inv. Discount Amount", TotalSalesLine[IndexNo[i]]."Currency Code", SalesHeader_gRec."Prices Including VAT", SalesHeader_gRec."VAT Base Discount %");
                end else
                    TempVATAmountLine2.SetInvoiceDiscountAmount(
                      TotalSalesLine[IndexNo[i]]."Inv. Discount Amount", TotalSalesLine[IndexNo[i]]."Currency Code", SalesHeader_gRec."Prices Including VAT", SalesHeader_gRec."VAT Base Discount %");

            if (i = 2) and PartialInvoicing then
                if IndexNo[i] = 1 then begin
                    InvDiscBaseAmount := TempVATAmountLine2.GetTotalInvDiscBaseAmount(false, TotalSalesLine[IndexNo[i]]."Currency Code");
                    if InvDiscBaseAmount = 0 then
                        TempVATAmountLine1.SetInvoiceDiscountPercent(
                          0, TotalSalesLine[IndexNo[i]]."Currency Code", SalesHeader_gRec."Prices Including VAT", false, SalesHeader_gRec."VAT Base Discount %")
                    else
                        TempVATAmountLine1.SetInvoiceDiscountPercent(
                          100 * TempVATAmountLine2.GetTotalInvDiscAmount / InvDiscBaseAmount,
                          TotalSalesLine[IndexNo[i]]."Currency Code", SalesHeader_gRec."Prices Including VAT", false, SalesHeader_gRec."VAT Base Discount %");
                end else begin
                    InvDiscBaseAmount := TempVATAmountLine1.GetTotalInvDiscBaseAmount(false, TotalSalesLine[IndexNo[i]]."Currency Code");
                    if InvDiscBaseAmount = 0 then
                        TempVATAmountLine2.SetInvoiceDiscountPercent(
                          0, TotalSalesLine[IndexNo[i]]."Currency Code", SalesHeader_gRec."Prices Including VAT", false, SalesHeader_gRec."VAT Base Discount %")
                    else
                        TempVATAmountLine2.SetInvoiceDiscountPercent(
                          100 * TempVATAmountLine1.GetTotalInvDiscAmount / InvDiscBaseAmount,
                          TotalSalesLine[IndexNo[i]]."Currency Code", SalesHeader_gRec."Prices Including VAT", false, SalesHeader_gRec."VAT Base Discount %");
                end;
        end;

        UpdateHeaderInfo(1, TempVATAmountLine1);
        UpdateHeaderInfo(2, TempVATAmountLine2);

        if ModifiedIndexNo = 1 then
            VATLinesForm.SetTempVATAmountLine(TempVATAmountLine1)
        else
            VATLinesForm.SetTempVATAmountLine(TempVATAmountLine2);

        SalesHeader_gRec."Invoice Discount Calculation" := SalesHeader_gRec."invoice discount calculation"::Amount;
        SalesHeader_gRec."Invoice Discount Value" := TotalSalesLine[1]."Inv. Discount Amount";
        //MODIFY;
        CalFinalAmt_gDec := SalesHeader_gRec."Invoice Discount Value";

        UpdateVATOnSalesLines;

    end;

    local procedure CheckAllowInvDisc()
    begin
        if not AllowInvDisc then
            Error(Text005, SalesHeader_gRec."Invoice Disc. Code");
    end;

    local procedure UpdateVATOnSalesLines()
    var
        SalesLine: Record "Sales Line";
    begin
        GetVATSpecification(ActiveTab);
        if TempVATAmountLine1.GetAnyLineModified then
            SalesLine.UpdateVATOnLines(0, SalesHeader_gRec, SalesLine, TempVATAmountLine1);
        if TempVATAmountLine2.GetAnyLineModified then
            SalesLine.UpdateVATOnLines(1, SalesHeader_gRec, SalesLine, TempVATAmountLine2);
        PrevNo := '';
    end;

    local procedure GetVATSpecification(QtyType: Option General,Invoicing,Shipping)
    begin
        case QtyType of
            Qtytype::General:
                begin
                    VATLinesForm.GetTempVATAmountLine(TempVATAmountLine1);
                    UpdateHeaderInfo(1, TempVATAmountLine1);
                end;
            Qtytype::Invoicing:
                begin
                    VATLinesForm.GetTempVATAmountLine(TempVATAmountLine2);
                    UpdateHeaderInfo(2, TempVATAmountLine2);
                end;
            Qtytype::Shipping:
                VATLinesForm.GetTempVATAmountLine(TempVATAmountLine3);
        end;
    end;

    local procedure "---------- Other --------"()
    begin
    end;


    procedure SetSalesHeader_gFnc(SalesHeader_iRec: Record "Sales Header"; AppliedInvDisAmt_iDec: Decimal)
    begin
        SalesHeader_gRec := SalesHeader_iRec;
        AppliedInvDisAmt_gDec := AppliedInvDisAmt_iDec;
    end;


    procedure GetCalAmt_gFnc(): Decimal
    begin
        exit(CalFinalAmt_gDec);
    end;
}
