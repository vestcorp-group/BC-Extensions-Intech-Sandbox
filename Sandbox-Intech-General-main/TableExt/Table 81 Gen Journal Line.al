TableExtension 75007 Gen_Journal_Line_75007 extends "Gen. Journal Line"
{
    fields
    {

        field(74981; "Error Log"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'T10078';
            Editable = false;
        }

        //I-C0059-1001707-01-NS
        field(74982; "TDS Receivable Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Description = 'C0059-1001707-01';

            trigger OnValidate()
            var
                Text33029769_gCtx: label 'TDS Receivable Amount must be Positive.';
                Text33029770_gCtx: label '"Account Type" OR "Bal. Account Type" must be Customer for TDS Receivable Amount.';
            begin

                if ("Account Type" = "account type"::Customer) or ("Bal. Account Type" = "bal. account type"::Customer) then begin
                    if "TDS Receivable Amount" < 0 then
                        Error(Text33029769_gCtx);
                end else
                    Error(Text33029770_gCtx);
                GetCurrency;
                if "Currency Code" = '' then
                    "TDS Receivable Amount (LCY)" := "TDS Receivable Amount"
                else
                    "TDS Receivable Amount (LCY)" := ROUND(
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        "Posting Date", "Currency Code",
                        "TDS Receivable Amount", "Currency Factor"));

                "TDS Receivable Amount" := ROUND("TDS Receivable Amount", Currency."Amount Rounding Precision");
            end;
        }

        field(74983; "TDS Receivable Amount (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            Description = 'C0059-1001707-01';
        }
        //I-C0059-1001707-01-NE
    }
    keys
    {

    }

    local procedure "====FieldFunc======"()
    begin
    end;

    procedure "Total TDS/TCS Incl. SHE CESS"(): Decimal
    var
        CalTCSValue_lDec: Decimal;
        INTTDSCal_lCdu: Codeunit "INT2 TDS Statistics";
    begin
        //Update Logic Here
        CalTCSValue_lDec := INTTDSCal_lCdu.GetTDSAmount(Rec.RecordId);
        exit(CalTCSValue_lDec);  //NG-UpdateFieldLogicHere
    end;

}