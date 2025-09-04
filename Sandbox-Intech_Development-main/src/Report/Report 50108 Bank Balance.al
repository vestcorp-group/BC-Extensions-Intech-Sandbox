report 50108 "Bank Balance"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    PreviewMode = PrintLayout;
    RDLCLayout = './Layouts/BankBalance.rdl';
    Description = 'T47761';

    dataset
    {
        dataitem(Company; Company)
        {
            dataitem("Bank Account"; "Bank Account")
            {
                column(Name; Name)
                {

                }
                column(No_; "No.")
                {

                }
                column(Bank_Account_No_; "Bank Account No.")
                {

                }
                column(Currency_Code; Curr_gCod) // "Currency Code")
                {

                }
                column(BalanceAccCurr_gDec; BalanceAccCurr_gDec)
                {

                }
                column(BalanceLCY_gDec; BalanceLCY_gDec)
                {

                }
                column(BalanceAED_gDec; BalanceAED_gDec)
                {

                }
                trigger OnAfterGetRecord()
                var
                    GLSetup_lRec: Record "General Ledger Setup";
                    CurrExchRate_lRec: Record "Currency Exchange Rate";
                    BankAccPostGrp_lRec: Record "Bank Account Posting Group";
                    BankAcc_lRec: Record "Bank Account";
                begin
                    Clear(GLSetup_lRec);
                    GLSetup_lRec.ChangeCompany(Company.Name);
                    GLSetup_lRec.Get();

                    Clear(BalanceAccCurr_gDec);
                    Clear(BankAcc_lRec);
                    BankAcc_lRec.ChangeCompany(Company.Name);
                    BankAcc_lRec.get("Bank Account"."No.");
                    BankAcc_lRec.SetRange("No.", "Bank Account"."No.");
                    BankAcc_lRec.SetFilter("Date Filter", '..%1', AsonDate_gDte);
                    if BankAcc_lRec.FindFirst() then begin
                        BankAcc_lRec.CalcFields("Balance at Date", "Balance (LCY)", "Balance at Date (LCY)");
                        BalanceAccCurr_gDec := BankAcc_lRec."Balance at Date";
                        BalanceLCY_gDec := BankAcc_lRec."Balance at Date (LCY)";
                    end;

                    "Bank Account".CalcFields("Balance at Date", "Balance (LCY)", "Balance at Date (LCY)");
                    // BalanceAccCurr_gDec := "Bank Account"."Balance at Date";

                    // Clear(CurrExchRate_lRec);
                    // Clear(BalanceLCY_gDec);
                    // CurrExchRate_lRec.ChangeCompany(Company.Name);
                    // CurrExchRate_lRec.SetRange("Currency Code", "Bank Account"."Currency Code");
                    // CurrExchRate_lRec.SetFilter("Starting Date", '..%1', AsonDate_gDte);
                    // //CurrExchRate_lRec.SetFilter("Exchange Rate Amount", '<>%1', 0);
                    // if CurrExchRate_lRec.FindLast() then begin
                    //     BalanceLCY_gDec := "Bank Account"."Balance at Date" * CurrExchRate_lRec."Relational Exch. Rate Amount";
                    // end;

                    // BalanceLCY_gDec := "Bank Account"."Balance at Date (LCY)";
                    if ("Bank Account"."Currency Code" = GLSetup_lRec."LCY Code") OR ("Bank Account"."Currency Code" = '') then begin
                        BalanceLCY_gDec := BalanceAccCurr_gDec;
                    end;

                    Clear(CurrExchRate_lRec);
                    Clear(BalanceAED_gDec);
                    CurrExchRate_lRec.ChangeCompany(Company.Name);
                    CurrExchRate_lRec.SetRange("Currency Code", 'AED');
                    CurrExchRate_lRec.SetFilter("Starting Date", '..%1', AsonDate_gDte);
                    //CurrExchRate_lRec.SetFilter("Exchange Rate Amount", '<>%1', 0);
                    if CurrExchRate_lRec.FindLast() then begin
                        BalanceAED_gDec := 1 / CurrExchRate_lRec."Relational Exch. Rate Amount" * BalanceLCY_gDec;
                    end;

                    Clear(Curr_gCod);
                    if "Bank Account"."Currency Code" = '' then
                        Curr_gCod := GLSetup_lRec."LCY Code"
                    else
                        Curr_gCod := "Bank Account"."Currency Code";

                    Clear(BankAccPostGrp_lRec);
                    BankAccPostGrp_lRec.ChangeCompany(Company.Name);
                    if BankAccPostGrp_lRec.get("Bank Account"."Bank Acc. Posting Group") then;
                    if BankAccPostGrp_lRec."G/L Account No." <> '110610' then
                        CurrReport.Skip();
                end;
            }
            column(Entity; "Display Name")
            {

            }
            column(DateFilter_gTxt; AsonDate_gDte)
            {

            }
            trigger OnAfterGetRecord()
            begin
                "Bank Account".ChangeCompany(Company.Name);
                //if EdDt_gDte <> 0D then
                "Bank Account".SetFilter("Date Filter", '..%1', AsonDate_gDte);
            end;

            trigger OnPreDataItem()
            begin
                Setfilter(Name, '<>%1&<>%2', 'Chemiprime Impex Pvt Ltd - do not use (only for system purpose)', 'Chemiprime Impex Pvt Ltd');
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
                group(Options)
                {
                    Caption = 'Options';
                    // field("Date Filter"; DateFilter_gTxt)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Date Filter';
                    //     trigger OnValidate()
                    //     var
                    //         FilterTokens: Codeunit "Filter Tokens";
                    //         Customer_gRec: Record 18;
                    //     begin
                    //         IF DateFilter_gTxt <> '' THEN BEGIN
                    //             FilterTokens.MakeDateFilter(DateFilter_gTxt);
                    //             Customer_gRec.SETFILTER("Date Filter", DateFilter_gTxt);
                    //             DateFilter_gTxt := Customer_gRec.GETFILTER("Date Filter");
                    //             StDt_gDte := Customer_gRec.GETRANGEMIN("Date Filter");
                    //             EdDt_gDte := Customer_gRec.GETRANGEMAX("Date Filter");
                    //         END ELSE BEGIN
                    //             StDt_gDte := 0D;
                    //             EdDt_gDte := 0D;
                    //         END;
                    //     end;
                    // }
                    field(AsonDate_gDte; AsonDate_gDte)
                    {
                        Caption = 'As on ';
                        ApplicationArea = all;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    var
        FilterTokens: Codeunit "Filter Tokens";
        Customer_gRec: Record 18;
    begin
        // IF DateFilter_gTxt <> '' THEN BEGIN
        //     FilterTokens.MakeDateFilter(DateFilter_gTxt);
        //     Customer_gRec.SETFILTER("Date Filter", DateFilter_gTxt);
        //     DateFilter_gTxt := Customer_gRec.GETFILTER("Date Filter");
        //     StDt_gDte := Customer_gRec.GETRANGEMIN("Date Filter");
        //     EdDt_gDte := Customer_gRec.GETRANGEMAX("Date Filter");
        // END ELSE BEGIN
        //     StDt_gDte := 0D;
        //     EdDt_gDte := 0D;
        // END;
    end;

    var
        BalanceAccCurr_gDec, BalanceLCY_gDec, BalanceAED_gDec : Decimal;
        DateFilter_gTxt: Text;
        StDt_gDte, EdDt_gDte : Date;
        AsonDate_gDte: Date;
        Curr_gCod: Code[20];
}