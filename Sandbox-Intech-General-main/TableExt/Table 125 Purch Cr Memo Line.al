TableExtension 75013 Purch_Cr_Memo_Line_75013 extends "Purch. Cr. Memo Line"
{
    local procedure "====FieldFunc======"()
    begin
    end;

    procedure "Amount To Vendor"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
    begin
        //Update Logic Here
        CalTCSValue_lDec := "Line Amount" + "Total GST Amount"();
        exit(CalTCSValue_lDec);  //NG-UpdateFieldLogicHere
    end;


    procedure "Total TDS Including SHE CESS"(): Decimal
    var
        CalTDSValue_lDec: Decimal;
        INT2TDSStatistics: Codeunit "INT2 TDS Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2TDSStatistics.GetPurchCrMemoLineTDSAmount(Rec, CalTDSValue_lDec);
        exit(CalTDSValue_lDec);
        //DG-NE
    end;


    procedure "TDS Amount"(): Decimal
    var
        TDSAmount_lDec: Decimal;
        INT2TDSStatistics: Codeunit "INT2 TDS Statistics";
    begin
        //DG-NS
        INT2TDSStatistics.GetPurchCrMemoLineTDSAmount(Rec, TDSAmount_lDec);
        exit(TDSAmount_lDec);
        //DG-NE
    end;

    procedure "GST Base Amount"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
    begin
        //Update Logic Here
        exit("Line Amount");
    end;

    procedure "GST %"(): Decimal
    var
        GstPercentage_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetStatisticsPurchCrMemoLinePercentage(Rec, GstPercentage_lDec);
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
        INT2GSTStatistics.GetStatisticsPurchCrMemoAmount(Rec, GstAmount_lDec);
        exit(GstAmount_lDec);
        //DG-NE
    end;
}