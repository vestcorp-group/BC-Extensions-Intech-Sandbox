TableExtension 75005 Sales_Line_75005 extends "Sales Line"
{
    local procedure "====FieldFunc======"()
    begin
    end;

    procedure "TDS/TCS %"(): Decimal
    var
        CalTCSPerc_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 TCS Sales Management";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetSalesLineTCSPerc(Rec, CalTCSPerc_lDec);
        exit(CalTCSPerc_lDec);
        //DG-NE
    end;

    procedure "TDS/TCS Amount"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 TCS Sales Management";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetSalesLineTCSAmount(Rec, CalTCSValue_lDec);
        exit(CalTCSValue_lDec);
        //DG-NE
    end;

    procedure "GST Base Amount"(): Decimal
    var
        CalGSTValue_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        exit("Line Amount");  //DG-N
    end;

    procedure "Amount To Customer"(): Decimal
    var
        CalGSTValue_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        CalGSTValue_lDec := "Line Amount" + "Total GST Amount";
        exit(CalGSTValue_lDec);  //DG-N
    end;

    procedure "Total GST Amount"(): Decimal
    var
        CalGSTValue_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetSalesLineStatisticsAmount(Rec, CalGSTValue_lDec);
        exit(CalGSTValue_lDec);
        //DG-NE
    end;

    procedure "Total TDS/TCS Incl. SHE CESS"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 TCS Sales Management";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetSalesLineTCSAmount(Rec, CalTCSValue_lDec);
        exit(CalTCSValue_lDec);
        //DG-NE
    end;

}