TableExtension 75018 Service_Cr_Memo_Line_75018 extends "Service Cr.Memo Line"
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
        INT2GSTStatistics.GetStatisticsSerCrMemoLineAmount(Rec, GstAmount_lDec);
        exit(GstAmount_lDec);
        //DG-NE
    end;

    procedure "GST Base Amount"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
    begin
        //Update Logic Here
        exit("Line Amount");
    end;

    procedure "Amount To Customer"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
    begin
        //Update Logic Here
        exit(CalTCSValue_lDec);  //NG-UpdateFieldLogicHere
    end;
}
