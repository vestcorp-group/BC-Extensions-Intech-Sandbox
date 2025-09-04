report 50210 "Bank Reconciliation"//T12370-N
{
    Caption = 'Bank Reconciliation';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/KMP_BankReconciliation.rdl';

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            column(No_; "No.") { }
            column(Name; Name) { }
            column(RemainingAmount; RemainingAmount) { }
            column(CompanyName; CompanyName) { }
            column(IBAN; IBAN) { }
            column(Balance; RemainingAmountG) { }
            column(Balance__LCY_; RemainingAmountLCYG) { }
            column(Currency_Code; "Currency Code") { }
            column(Remaining_Amount; BankBalanceG) { }
            column(Remaining_Amount_LCY; BankBalanceLCYG) { }
            column(Amount; Amount)
            { }
            column(Bank_Account_No_; "Bank Account No.") { }
            column(BalanceLCYRec; BalanceLCYRec)
            {

            }
            column(BalanceRec; BalanceRec)
            {

            }
            column(FromDate; Format(FromDateG, 0, '<Day, 2>-<Month Text>-<year4>')) { }
            column(ToDate; Format(ToDateG, 0, '<Day, 2>-<Month Text>-<year4>')) { }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter");
                DataItemTableView = sorting("Bank Account No.", "Posting Date") where(Open = const(true), "Statement Status" = filter(Open | "Bank Acc. Entry Applied" | "Check Entry Applied"), Reversed = const(false));
                column(Posting_Date; "Posting Date") { }
                column(Document_No_; "Document No.") { }
                column(Check_No_; CheckNoG) { }
                column(AccountName; Description) { }
                column(TransactionAmount; Amount) { }
                column(TransactionAmount_LCY; "Amount (LCY)") { }

                column(CompanyBook_Balance; RemainingAmountG) { }
                column(CompanyBook_Balance_LCY; RemainingAmountLCYG) { }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SETCURRENTKEY("Bank Account No.", "Posting Date");
                    // SETRANGE("Bank Account No.", "Bank Account"."No.");
                    SETRANGE("Posting Date", FromDateG, ToDateG);
                    // SETRANGE(Open, TRUE);
                    // SETRANGE("Statement Status", "Bank Account Ledger Entry"."Statement Status"::Open);
                end;

                trigger OnAfterGetRecord()
                var
                    ChkLedgEntryL: Record "Check Ledger Entry";
                begin
                    CheckNoG := '';
                    AccNameG := GetAccountName("Bal. Account Type".AsInteger(), "Bal. Account No.");//30-04-2022-added asintegr with enum
                    // BankBalanceG += "Remaining Amount";
                    // if GLSetupG."LCY Code" <> "Currency Code" then
                    //     BankBalanceLCYG += CurrExchRateG.ExchangeAmtFCYToLCY(WorkDate(), "Currency Code", "Remaining Amount", CurrExchRateG.ExchangeRate(WorkDate(), "Currency Code"))
                    // else
                    //     BankBalanceLCYG += BankBalanceG;
                    BankBalanceG -= Amount;
                    BankBalanceLCYG -= "Amount (LCY)";
                    RemainingAmountG -= Amount;
                    RemainingAmountLCYG -= "Amount (LCY)";

                    ChkLedgEntryL.SetRange("Bank Account No.", "Bank Account No.");
                    ChkLedgEntryL.SetRange("Bank Account Ledger Entry No.", "Entry No.");
                    if ChkLedgEntryL.FindFirst() then
                        CheckNoG := ChkLedgEntryL."Check No.";
                    //PDC Mig issue-NS
                    // tblPDCToDeposit.SetRange("Journal Batch Name", "Journal Batch Name");
                    // tblPDCToDeposit.SetRange("Document Type", "Document Type");
                    //tblPDCToDeposit.SetRange("Document No_", "Document No.");//PDC Mig issue-N
                    // if tblPDCToDeposit.FindFirst() then
                    //     CheckNoG := tblPDCToDeposit.CheckNumber;

                    // tblPDCPayment.SetRange("Journal Batch Name", "Journal Batch Name");
                    // tblPDCPayment.SetRange("Document Type", "Document Type");
                    //tblPDCPayment.SetRange("Document No_", "Document No.");//PDC Mig issue-N
                    // if tblPDCPayment.FindFirst() then
                    //     CheckNoG := tblPDCPayment.CheckNumber;
                    //PDC Mig issue-NE
                end;
            }

            trigger OnAfterGetRecord()
            var
                BankLedEntry: Record "Bank Account Ledger Entry";

            begin
                GLSetupG.Get();
                RemainingAmountG := 0;
                RemainingAmountLCYG := 0;
                BankLedEntry.Reset();
                BankLedEntry.SETCURRENTKEY("Bank Account No.", "Posting Date");
                BankLedEntry.SETRANGE("Bank Account No.", "No.");
                //BankLedEntry.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Filter");
                //BankLedEntry.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Filter");
                BankLedEntry.setfilter("Posting Date", '..%1', ToDateG);
                // BankLedEntry.SETRANGE(Open, TRUE);
                // BankLedEntry.SetRange(Reversed, false);
                if BankLedEntry.findset() then
                    BankLedEntry.CalcSums("Amount (LCY)", Amount);
                BalanceRec := BankLedEntry.Amount;
                BalanceLCYRec := BankLedEntry."Amount (LCY)";
                RemainingAmount := BankLedEntry.Amount;
                RemainingAmountLCYG := BankLedEntry."Amount (LCY)";
                // if GLSetupG."LCY Code" <> "Currency Code" then
                //     RemainingAmountLCYG := CurrExchRateG.ExchangeAmtFCYToLCY(WorkDate(), "Currency Code", RemainingAmountG, CurrExchRateG.ExchangeRate(WorkDate(), "Currency Code"));
                BankBalanceG := RemainingAmount;
                BankBalanceLCYG := RemainingAmountLCYG;
                // BankBalanceG := Balance;
                // BankBalanceLCYG := "Balance (LCY)";
                if "Currency Code" = '' then
                    "Currency Code" := GLSetupG."LCY Code";
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field("From Date"; FromDateG)
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field("Period up to"; ToDateG)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

    }

    local procedure GetAccountName(BalAccountTypeP: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset",,Employee; BalAccountNoP: code[20]): Text[100];
    var
        AccNameL: Text[100];
        VendL: Record "Vendor";
        CustL: Record "Customer";
        BankL: Record "Bank Account";
        GLAccountL: Record "G/L Account";
        EmployeeL: Record Employee;
    begin
        if BalAccountNoP = '' then
            exit('');
        case BalAccountTypeP of
            BalAccountTypeP::"Bank Account":
                begin
                    BankL.Get(BalAccountNoP);
                    AccNameL := BankL.Name;
                end;
            BalAccountTypeP::Customer:
                begin
                    CustL.Get(BalAccountNoP);
                    AccNameL := CustL.Name;
                end;
            BalAccountTypeP::Employee:
                begin
                    EmployeeL.Get(BalAccountNoP);
                    AccNameL := EmployeeL.FullName();
                end;
            BalAccountTypeP::Vendor:
                begin
                    VendL.Get(BalAccountNoP);
                    AccNameL := VendL.Name;
                end;
            BalAccountTypeP::"G/L Account":
                begin
                    GLAccountL.Get(BalAccountNoP);
                    AccNameL := GLAccountL.Name;
                end;
        end;
        exit(AccNameL);
    end;

    var
        GLSetupG: Record "General Ledger Setup";
        CurrExchRateG: Record "Currency Exchange Rate";
        //tblPDCToDeposit: Record tblPDCToDeposit;//Intech PDC Mig issue-N
        //tblPDCPayment: Record tblPDCPayment;//Intech PDC Mig issue-N
        CheckNoG: Code[20];
        AccNameG: Text[100];
        FromDateG: Date;
        ToDateG: Date;
        RemainingAmountG: Decimal;
        RemainingAmountLCYG: Decimal;
        BankBalanceG: Decimal;
        BankBalanceLCYG: Decimal;
        RemainingAmount: Decimal;
        BalanceRec: Decimal;
        BalanceLCYRec: Decimal;
}