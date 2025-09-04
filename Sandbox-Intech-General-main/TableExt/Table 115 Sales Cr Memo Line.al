TableExtension 75010 Sales_Cr_Memo_Line_75010 extends "Sales Cr.Memo Line"
{
    fields
    {
        field(74981; "Skip Check Invoice Ref"; Boolean)
        {
            Caption = 'Skip Check Invoice Reference for Old Invoice Credit Memo';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
    }

    local procedure "====FieldFunc======"()
    begin
    end;

    procedure "TDS/TCS Amount"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
        INT2TCSStatistics: Codeunit "INT2 TCS Sales Management";
    begin
        //Update Logic Here
        //DG-NS
        INT2TCSStatistics.GetTCSSalesCrMemoLineAmount(Rec, CalTCSValue_lDec);
        exit(CalTCSValue_lDec);
        //DG-NE
    end;

    procedure "Amount To Customer"(): Decimal
    var
        CalAmount_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        //DG-NS
        CalAmount_lDec := "Line Amount" + "Total GST Amount"();
        exit(CalAmount_lDec);
        //DG-NE
    end;

    procedure "Total GST Amount"(): Decimal
    var
        CalAmount_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetStatisticsSalesCrMemoLineAmount(Rec, CalAmount_lDec);
        exit(CalAmount_lDec);
        //DG-NE
    end;

    procedure "Total TDS/TCS Incl. SHE CESS"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
        INT2TCSStatistics: Codeunit "INT2 TCS Sales Management";
    begin
        //Update Logic Here
        //DG-NS
        INT2TCSStatistics.GetTCSSalesCrMemoLineAmount(Rec, CalTCSValue_lDec);
        exit(CalTCSValue_lDec);
        //DG-NE
    end;

    procedure "GST Base Amount"(): Decimal
    var
        CalAmount_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        exit("Line Amount");//DG-N
    end;

    procedure "GST %"(): Decimal
    var
        CalPercentage_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        CalPercentage_lDec := INT2GSTStatistics.GetGSTPercentage(Rec.RecordId);//DG-N
    end;

    procedure "TDS/TCS %"(): Decimal
    var
        CalTCSPercent_lDec: Decimal;
        INT2TCSStatistics: Codeunit "INT2 TCS Sales Management";
    begin
        //Update Logic Here
        //DG-NS
        INT2TCSStatistics.GetTCSSalesCrMemoLinePercentage(Rec, CalTCSPercent_lDec);
        exit(CalTCSPercent_lDec);
        //DG-NE
    end;

    procedure "Total TDS/TCS Incl SHE CESS"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
    begin
        //Update Logic Here
        exit("Amount Including VAT");
    end;
}