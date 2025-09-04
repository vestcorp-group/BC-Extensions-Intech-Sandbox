TableExtension 75008 Sales_Invoice_Header_75008 extends "Sales Invoice Header"
{
    local procedure "====FieldFunc======"()
    begin
    end;

    procedure "Amount To Customer"(): Decimal
    var
        CalGSTValue_lDec: Decimal;
        CalcStatistics: Codeunit "Calculate Statistics";
    begin
        //Update Logic Here
        //DG-NS
        CalcStatistics.GetPostedSalesInvStatisticsAmount(Rec, CalGSTValue_lDec);
        exit(CalGSTValue_lDec);
        //DG-NE
    end;
}