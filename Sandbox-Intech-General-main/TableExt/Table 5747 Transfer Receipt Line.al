TableExtension 75016 Transfer_Receipt_Line_75016 extends "Transfer Receipt Line"
{
    local procedure "====FieldFunc======"()
    begin
    end;

    procedure "Total GST Amount"(): Decimal
    var
        GstAmount_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetStatisticsTransferRcptLineAmount(Rec, GstAmount_lDec);
        exit(GstAmount_lDec);
        //DG-NE
    end;

    procedure "GST Base Amount"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
    begin
        //Update Logic Here
        exit(Amount);
    end;
}
