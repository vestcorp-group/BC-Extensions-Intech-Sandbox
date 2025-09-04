TableExtension 75019 Return_Receipt_Line_75019 extends "Return Receipt Line"
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
        INT2GSTStatistics.GetStatisticsRetRcptLineAmount(Rec, GstAmount_lDec);
        exit(GstAmount_lDec);
        //DG-NE
    end;

    procedure "GST Base Amount"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
    begin
        //Update Logic Here
        exit("Unit Cost");
    end;

    procedure "Amount To Customer"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
    begin
        //Update Logic Here
        exit(CalTCSValue_lDec);  //NG-UpdateFieldLogicHere
    end;

    procedure "GST %"(): Decimal
    var
        GstPercentage_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetStatisticsRetRcptLinePercentage(Rec, GstPercentage_lDec);
        exit(GstPercentage_lDec);
        //DG-NE
    end;
}
