pageextension 85209 RequestToapproveExt extends "Requests to Approve"
{
    Description = 'T47288';
    layout
    {
        addafter("Amount (LCY)")
        {
            field(AmountFCY_gDec; AmountFCY_gDec)
            {
                Caption = 'Amount (USD)';
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        SalesHdr_lRec: Record "Sales Header";
        PurchaseHdr_lRec: Record "Purchase Header";
        Currency_lRec: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        ExchangeRateAmt: Decimal;
        DDate_lDte: Date;
    begin
        Clear(AmountFCY_gDec);
        DDate_lDte := Today;
        // if Rec."Table ID" = 36 then begin
        //     SalesHdr_lRec.Reset();
        //     SalesHdr_lRec.SetRange("No.", Rec."Document No.");
        //     SalesHdr_lRec.SetRange("Document Type", Rec."Document Type");
        //     if SalesHdr_lRec.Findfirst() then begin
        CurrencyExchangeRate.GetLastestExchangeRate('USD', DDate_lDte, ExchangeRateAmt);
        // SalesHdr_lRec.CalcFields("Amount Including VAT");
        AmountFCY_gDec := Rec."Amount (LCY)" / ExchangeRateAmt;
        //end;
        //end;

        // if Rec."Table ID" = 38 then begin
        //     PurchaseHdr_lRec.Reset();
        //     PurchaseHdr_lRec.SetRange("No.", Rec."Document No.");
        //     PurchaseHdr_lRec.SetRange("Document Type", Rec."Document Type");
        //     if PurchaseHdr_lRec.Findfirst() then
        //         PurchaseHdr_lRec.CalcFields("Amount Including VAT");
        //     AmountFCY_gDec := PurchaseHdr_lRec."Amount Including VAT";
        // end;
    end;

    var
        AmountFCY_gDec: Decimal;
}