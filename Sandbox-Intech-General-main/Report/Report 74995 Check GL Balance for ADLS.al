Report 74995 "Check GL Balance for ADLS"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Check GL Entry.rdl';

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number);
            column(ReportForNavId_33027920; 33027920)
            {
            }
            column(Year; Integer.Number)
            {
            }
            column(TotalCreditBal_gDec; TotalCreditBal_gDec)
            {
            }
            column(TotalDebitBal_gDec; TotalDebitBal_gDec)
            {
            }

            trigger OnAfterGetRecord()
            var
                FromDate_lDate: Date;
                ToDate_lDte: Date;
                GLAccount_lRec: Record "G/L Account";
            begin
                TotalCreditBal_gDec := 0;
                TotalDebitBal_gDec := 0;

                FromDate_lDate := Dmy2date(1, 1, Integer.Number);
                ToDate_lDte := Dmy2date(31, 12, Integer.Number);

                GLAccount_lRec.Reset;
                GLAccount_lRec.SetRange("Account Type", GLAccount_lRec."account type"::Posting);
                GLAccount_lRec.SetRange("Date Filter", FromDate_lDate, ClosingDate(ToDate_lDte));
                if GLAccount_lRec.FindSet then begin
                    repeat
                        GLAccount_lRec.CalcFields("Credit Amount", "Debit Amount");
                        TotalCreditBal_gDec += GLAccount_lRec."Credit Amount";
                        TotalDebitBal_gDec += GLAccount_lRec."Debit Amount";
                    until GLAccount_lRec.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                Integer.SetRange(Number, FromYear_gInt, ToYear_gInt);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(FromYear_gInt; FromYear_gInt)
                {
                    ApplicationArea = Basic;
                    Caption = 'From Year';
                    MinValue = 2011;
                }
                field(ToYear_gInt; ToYear_gInt)
                {
                    ApplicationArea = Basic;
                    Caption = 'To Year';
                    MaxValue = 2050;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if FromYear_gInt = 0 then
            Error('Enter From Year');

        if ToYear_gInt = 0 then
            Error('Enter To Year');

        if ToYear_gInt < FromYear_gInt then
            Error('Enter Valid Data');
    end;

    var
        FromYear_gInt: Integer;
        ToYear_gInt: Integer;
        TotalCreditBal_gDec: Decimal;
        TotalDebitBal_gDec: Decimal;
}
