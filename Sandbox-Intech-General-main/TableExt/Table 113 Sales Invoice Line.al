TableExtension 75009 Sales_Invoice_Line_75009 extends "Sales Invoice Line"
{
    local procedure "====FieldFunc======"()
    begin
    end;

    procedure "TDS/TCS Amount"(): Decimal
    var
        CalTDSValue_lDec: Decimal;
        INT2TDSStatistics: Codeunit "INT2 TCS Sales Management";
    begin
        //Update Logic Here
        //DG-NS
        INT2TDSStatistics.GetTCSSalesInvLineAmount(Rec, CalTDSValue_lDec);
        exit(CalTDSValue_lDec);
        //DG-NE
    end;

    procedure "Total GST Amount"(): Decimal
    var
        CalGSTValue_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetStatisticsSalesInvLineAmount(Rec, CalGSTValue_lDec);
        exit(CalGSTValue_lDec);
        //DG-NE
    end;

    procedure "Amount To Customer"(): Decimal
    var
        CalGSTValue_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        //DG-NS
        CalGSTValue_lDec := "Line Amount" + "Total GST Amount"();
        exit(CalGSTValue_lDec);
        //DG-NE
    end;

    procedure "GST Base Amount"(): Decimal
    var
        CalGSTValue_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        exit("Line Amount");         //DG-N
    end;

    procedure "GST %"(): Decimal
    var
        CalGSTPercent_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetStatisticsSalesInvLinePercentage(Rec, CalGSTPercent_lDec);
        exit(CalGSTPercent_lDec);
        //DG-NE
    end;

    procedure "TDS/TCS %"(): Decimal
    var
        CalTDSPercent_lDec: Decimal;
        INT2TDSStatistics: Codeunit "INT2 TCS Sales Management";
    begin
        //Update Logic Here
        //DG-NS
        INT2TDSStatistics.GetTCSSalesInvLinePercent(Rec, CalTDSPercent_lDec);
        exit(CalTDSPercent_lDec);
        //DG-NE
    end;
}