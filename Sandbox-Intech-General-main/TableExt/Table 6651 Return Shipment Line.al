TableExtension 75020 Return_Shipment_Line_75020 extends "Return Shipment Line"
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
        INT2GSTStatistics.GetStatisticsRetShptLineAmount(Rec, GstAmount_lDec);
        exit(GstAmount_lDec);
        //DG-NE
    end;

    procedure "GST Base Amount"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
    begin
        //Update Logic Here
        exit("Direct Unit Cost");
    end;

    procedure "Amount To Vendor"(): Decimal
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
        INT2GSTStatistics.GetStatisticsRetShptLinePercentage(Rec, GstPercentage_lDec);
        exit(GstPercentage_lDec);
        //DG-NE
    end;
}
