TableExtension 75017 Service_Invoice_Line_75017 extends "Service Invoice Line"
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
        INT2GSTStatistics.GetStatisticsSerInvLineAmount(Rec, GstAmount_lDec);
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
        CalTCSValue_lDec := "Line Amount" + "Total GST Amount"();
        exit(CalTCSValue_lDec);  //NG-UpdateFieldLogicHere
    end;
}
