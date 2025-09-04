tableextension 74996 Sales_Cr_Memo_Header_74996 extends "Sales Cr.Memo Header"
{
    fields
    {
        //SkipRefNoChk-NS
        field(74981; "Skip Check Invoice Ref"; Boolean)
        {
            Caption = 'Skip Check Invoice Reference for Old Invoice Credit Memo';
            DataClassification = ToBeClassified;
        }
        //SkipRefNoChk-NE
    }

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
        CalcStatistics.GetPostedSalesCrMemoStatisticsAmount(Rec, CalGSTValue_lDec);
        exit(CalGSTValue_lDec);
        //DG-NE
    end;
}