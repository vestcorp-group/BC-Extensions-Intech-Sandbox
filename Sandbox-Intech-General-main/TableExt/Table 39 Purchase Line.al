tableextension 74982 Purchase_Line_74982 extends "Purchase Line"
{
    fields
    {
        // Add changes to table fields here
        field(50130; "GST Import Duty Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'GSTImport';
            TableRelation = "GST Import Duty Setup".Code;
        }
        field(50131; "Landing Cost Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'GSTImport';
            Editable = false;
        }
    }

    var
        myInt: Integer;

    local procedure "====FieldFunc======"()
    begin
    end;

    procedure "TDS %"(): Decimal
    var
        CalTDSPercent_lDec: Decimal;
        INT2TDSStatistics: Codeunit "INT2 TDS Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2TDSStatistics.GetPurchLineTDSPercentage(Rec, CalTDSPercent_lDec);
        exit(CalTDSPercent_lDec);
        //DG-NE
    end;

    procedure "Total TDS Including SHE CESS"(): Decimal
    var
        CalTDSAmount_lDec: Decimal;
        INT2TDSStatistics: Codeunit "INT2 TDS Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2TDSStatistics.GetPurchLineTDSAmount(Rec, CalTDSAmount_lDec);
        exit(CalTDSAmount_lDec);
        //DG-NE
    end;

    procedure "Amount To Vendor"(): Decimal
    var
        CalAmount_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        CalAmount_lDec := "Line Amount" + "Total GST Amount"();
        exit(CalAmount_lDec);  //DG-N
    end;

    procedure "GST Base Amount"(): Decimal
    var
        CalGSTAmount_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        exit("Line Amount");  //DG-N
    end;

    procedure "TDS Amount"(): Decimal
    var
        CalTDSAmount_lDec: Decimal;
        INT2TDSStatistics: Codeunit "INT2 TDS Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2TDSStatistics.GetPurchLineTDSAmount(Rec, CalTDSAmount_lDec);
        exit(CalTDSAmount_lDec);
        //DG-NE
    end;

    procedure "Total GST Amount"(): Decimal
    var
        CalGSTAmount_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetPurchaseLineStatisticsAmount(Rec, CalGSTAmount_lDec);
        exit(CalGSTAmount_lDec);
        //DG-NE
    end;

    procedure "GST %"(): Decimal
    var
        CalGSTPercent_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetGSTPercentage(Rec.RecordId);
        exit(CalGSTPercent_lDec);
        //DG-NE
    end;
}