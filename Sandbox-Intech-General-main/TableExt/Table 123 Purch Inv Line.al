TableExtension 75012 Purch_Inv_Line_75012 extends "Purch. Inv. Line"
{
    local procedure "====FieldFunc======"()
    begin
    end;

    procedure "Amount To Vendor"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
        GSTAmt_lDec: Decimal;
        PIH_lRec: Record "Purch. Inv. Header";
    begin
        //Update Logic Here
        GSTAmt_lDec := "Total GST Amount";
        IF PIH_lRec.GET("Document No.") Then begin
            IF PIH_lRec."GST Vendor Type" = PIH_lRec."GST Vendor Type"::Unregistered then
                GSTAmt_lDec := 0;

            IF (PIH_lRec."Vendor GST Reg. No." = '') AND (PIH_lRec."Order Address GST Reg. No." = '') then
                GSTAmt_lDec := 0;
        end;

        CalTCSValue_lDec := "Line Amount" + GSTAmt_lDec - "Total TDS Including SHE CESS";
        exit(CalTCSValue_lDec);
    end;

    procedure "Total TDS Including SHE CESS"(): Decimal
    var
        CalTDSValue_lDec: Decimal;
        INT2TDSStatistics: Codeunit "INT2 TDS Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2TDSStatistics.GetPurchInvLineTDSAmount(Rec, CalTDSValue_lDec);
        exit(CalTDSValue_lDec);
        //DG-NE
    end;

    procedure "GST Base Amount"(): Decimal
    begin
        //Update Logic Here
        exit("Line Amount");  //DG-N
    end;

    procedure "GST %"(): Decimal
    var
        GstPercentage_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetStatisticsPurchInvLinePercentage(Rec, GstPercentage_lDec);
        exit(GstPercentage_lDec);
        //DG-NE
    end;

    procedure "Total GST Amount"(): Decimal
    var
        GstAmount_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetStatisticsPurchInvLineAmount(Rec, GstAmount_lDec);
        exit(GstAmount_lDec);
        //DG-NE
    end;

    procedure "TDS %"(): Decimal
    var
        TDSAmount_lDec: Decimal;
        INT2TDSStatistics: Codeunit "INT2 TDS Statistics";
    begin
        //DG-NS
        INT2TDSStatistics.GetPurchInvLineTDSPercentage(Rec, TDSAmount_lDec);
        exit(TDSAmount_lDec);
        //DG-NE
    end;
}