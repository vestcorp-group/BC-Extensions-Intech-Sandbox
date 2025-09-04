report 50463 "Statement of Accounts"//T12370-N
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/StatementofAccounts 50463.rdl';
    AdditionalSearchTerms = 'payment due,order status';
    ApplicationArea = Basic, Suite;
    Caption = 'Statement of Accounts';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = WHERE("Account Type" = CONST(Posting));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";

            column(OpeningCLE1; OpeningCLE) { }
            column(AccountFilter1; AccountFilter) { }
            column(No_; "No.") { }
            column(GLName; Name) { }
            column(CompanyInfo; CompanyInfo.Picture) { }
            column(CompanyAddr1; CompanyAddr[1]) { }
            column(CompanyAddr2; CompanyAddr[2]) { }
            column(CompanyAddr3; CompanyAddr[3]) { }
            column(CompanyAddr4; CompanyAddr[4]) { }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyInfoHomePage; CompanyInfo."Home Page") { }
            column(CompanyInfoEmail; CompanyInfo."E-Mail") { }
            column(CompanyAddr5; CompanyAddr[5]) { }
            column(CompanyAddr6; CompanyAddr[6]) { }
            column(CompanyInfoFaxNo; CompanyInfo."Fax No.") { }
            column(CompanyInfoVATRegtnNo; CompanyInfo."VAT Registration No.") { }
            column(CompanyInfoGiroNo; CompanyInfo."Giro No.") { }
            column(CompanyInfoBankName; CompanyInfo."Bank Name") { }
            column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.") { }
            column(PeriodFilter; StrSubstNo(Text003, PeriodStartDate, PeriodEndDate)) { }
            column(CompanyName; COMPANYPROPERTY.DisplayName) { }
            column(PeriodStartDate; Format(PeriodStartDate)) { }
            column(PeriodEndDate; Format(PeriodEndDate)) { }

            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter");
                column(Debit_Amount; "Debit Amount") { }
                column(Credit_Amount; "Credit Amount") { }
                column(Posting_Date1; "Posting Date") { }
                column(Description1; Description) { }
                column(Document_Date; "Document Date") { }
                column(Document_No_1; "Document No.") { }
                column(BalanceCLE1; BalanceCLE) { }

                trigger OnPreDataItem()
                begin

                    "G/L Entry".SetRange("Posting Date", PeriodStartDate, PeriodEndDate);
                end;

                trigger OnAfterGetRecord()
                begin
                    BalanceCLE := BalanceCLE + "Debit Amount" - ABS("Credit Amount");

                    if DimensionFilter <> '' then begin
                        DimensionSetentry.SetRange("Dimension Set ID", "G/L Entry"."Dimension Set ID");
                        DimensionSetentry.SetRange("Dimension Code", DimensionFilter);
                        if not DimensionSetentry.FindFirst() then
                            CurrReport.Skip();
                    end;

                end;
            }
            trigger OnPreDataItem()
            begin
                VerifyDates();
                "G/L Account".SetRange("Date Filter", PeriodStartDate, PeriodEndDate);
            end;


            trigger OnAfterGetRecord()
            var
                GLaccount: Record "G/L Account";
            begin
                if AccountFilter <> AccountFilter::"G/L" then
                    CurrReport.Break();


                AccountFilter := 3;
                GLaccount := "G/L Account";

                GLaccount.SETRANGE("Date Filter", 0D, PeriodStartDate - 1);
                GLaccount.CALCFIELDS("Net Change");

                OpeningCLE := GLaccount."Net Change";
                BalanceCLE := GLaccount."Net Change";
            end;
        }

        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            PrintOnlyIfDetail = true;
            column(AccountFilter; Format(AccountFilter)) { }
            column(Customer_No_; "No.") { }
            column(Customer_Name; "Name") { }
            column(CustPeriodFilter; StrSubstNo(Text003, PeriodStartDate, PeriodEndDate)) { }
            column(CustCompanyInfo; CompanyInfo.Picture) { }
            column(CustCompanyAddr1; CompanyAddr[1]) { }
            column(CustCompanyAddr2; CompanyAddr[2]) { }
            column(CustCompanyAddr3; CompanyAddr[3]) { }
            column(CustCompanyAddr4; CompanyAddr[4]) { }
            column(CustCompanyInfoPhoneNo; CompanyInfo."Phone No.") { }
            column(CustCompanyInfoHomePage; CompanyInfo."Home Page") { }
            column(CustCompanyInfoEmail; CompanyInfo."E-Mail") { }
            column(CustCompanyAddr5; CompanyAddr[5]) { }
            column(CustCompanyAddr6; CompanyAddr[6]) { }
            column(CustCompanyInfoFaxNo; CompanyInfo."Fax No.") { }
            column(CustCompanyInfoVATRegtnNo; CompanyInfo."VAT Registration No.") { }
            column(CustCompanyInfoGiroNo; CompanyInfo."Giro No.") { }
            column(CustCompanyInfoBankName; CompanyInfo."Bank Name") { }
            column(CustCompanyInfoBankAccountNo; CompanyInfo."Bank Account No.") { }
            column(OpeningCLE; OpeningCLE) { }
            column(PageNoCaption; PageNoCaptionLbl) { }
            column(AmountInwords; AmountInwords) { }

            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."), "Posting Date" = FIELD("Date Filter");
                column(Posting_Date; "Posting Date") { }
                column(Document_No_; "Document No.") { }
                column(Credit_Amount__LCY_; "Credit Amount (LCY)") { }
                column(Debit_Amount__LCY_; "Debit Amount (LCY)") { }
                column(BalanceCLE; BalanceCLE) { }
                column(Description; Description) { }

                trigger OnPreDataItem()
                begin
                    "Cust. Ledger Entry".SetRange("Posting Date", PeriodStartDate, PeriodEndDate);
                end;

                trigger OnAfterGetRecord()
                begin

                    AccountFilter := AccountFilter::Customer;
                    BalanceCLE := BalanceCLE + "Debit Amount (LCY)" - ABS("Credit Amount (LCY)");

                    if DimensionFilter <> '' then begin
                        DimensionSetentry.SetRange("Dimension Set ID", "Cust. Ledger Entry"."Dimension Set ID");
                        DimensionSetentry.SetRange("Dimension Code", DimensionFilter);
                        if not DimensionSetentry.FindFirst() then
                            CurrReport.Skip();
                    end;
                end;
            }
            trigger OnPreDataItem()
            begin
                if AccountFilter <> AccountFilter::Customer then
                    CurrReport.Break()
                else begin
                    VerifyDates();
                    Customer.SetRange("Date Filter", PeriodStartDate, PeriodEndDate);
                end;
            end;

            trigger OnAfterGetRecord()
            begin

                AccountFilter := AccountFilter::Customer;
                Cust2 := Customer;
                Cust2.SETRANGE("Date Filter", 0D, PeriodStartDate - 1);
                Cust2.SETRANGE("Currency Filter", Cust2."Currency Code");
                Cust2.CALCFIELDS("Net Change (LCY)");
                OpeningCLE := Cust2."Net Change (LCY)";
                BalanceCLE := Cust2."Net Change (LCY)";
            end;

            trigger OnPostDataItem()
            begin
                Repcheck.InitTextVariable();
                Repcheck.FormatNoText(Notext, ABS(BalanceCLE), "Currency Code");
                AmountInwords := Notext[1];

            end;
        }


        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(OpeningCLE2; OpeningCLE) { }
            column(AccountFilter2; AccountFilter) { }
            column(VendorNo_; "No.") { }
            column(Name; Name) { }
            column(VendPeriodFilter; StrSubstNo(Text003, PeriodStartDate, PeriodEndDate)) { }
            column(VendCompanyInfo; CompanyInfo.Picture) { }
            column(VendCompanyAddr1; CompanyAddr[1]) { }
            column(VendCompanyAddr2; CompanyAddr[2]) { }
            column(VendCompanyAddr3; CompanyAddr[3]) { }
            column(VendCompanyAddr4; CompanyAddr[4]) { }
            column(VendCompanyInfoPhoneNo; CompanyInfo."Phone No.") { }
            column(VendCompanyInfoHomePage; CompanyInfo."Home Page") { }
            column(VendCompanyInfoEmail; CompanyInfo."E-Mail") { }
            column(VendCompanyAddr5; CompanyAddr[5]) { }
            column(VendCompanyAddr6; CompanyAddr[6]) { }
            column(VendCompanyInfoFaxNo; CompanyInfo."Fax No.") { }
            column(VendCompanyInfoVATRegtnNo; CompanyInfo."VAT Registration No.") { }
            column(VendCompanyInfoGiroNo; CompanyInfo."Giro No.") { }
            column(VendCompanyInfoBankName; CompanyInfo."Bank Name") { }
            column(VendCompanyInfoBankAccountNo; CompanyInfo."Bank Account No.") { }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = field("No."), "Posting Date" = FIELD("Date Filter");
                column(Document_No_2; "Document No.") { }
                column(Posting_Date2; "Posting Date") { }
                column(Debit_Amount__LCY_2; "Debit Amount (LCY)") { }
                column(Credit_Amount__LCY_2; "Credit Amount (LCY)") { }
                column(BalanceCLE2; BalanceCLE) { }
                column(Description2; Description) { }

                trigger OnPreDataItem()
                begin

                    "Vendor Ledger Entry".SetRange("Posting Date", PeriodStartDate, PeriodEndDate);
                end;

                trigger OnAfterGetRecord()
                begin

                    BalanceCLE := BalanceCLE + "Debit Amount (LCY)" - ABS("Credit Amount (LCY)");

                    if DimensionFilter <> '' then begin
                        DimensionSetentry.SetRange("Dimension Set ID", "Vendor Ledger Entry"."Dimension Set ID");
                        DimensionSetentry.SetRange("Dimension Code", DimensionFilter);
                        if not DimensionSetentry.FindFirst() then
                            CurrReport.Skip();
                    end;

                end;
            }
            trigger OnPreDataItem()
            begin
                if AccountFilter <> AccountFilter::Vendor then
                    CurrReport.Break()
                else begin

                    VerifyDates();
                    Vendor.SetRange("Date Filter", PeriodStartDate, PeriodEndDate);
                end;
            end;

            trigger OnAfterGetRecord()
            var
                Vendor2: Record Vendor;
            begin

                Vendor2 := Vendor;

                Vendor2.SETRANGE("Date Filter", 0D, PeriodStartDate - 1);
                Vendor2.CALCFIELDS("Net Change (LCY)");

                OpeningCLE := Vendor2."Net Change (LCY)";
                BalanceCLE := Vendor2."Net Change (LCY)";

            end;
        }
        dataitem(Employee; Employee)
        {

            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(OpeningCLE3; OpeningCLE) { }
            column(AccountFilter3; AccountFilter) { }
            column(EmployeeNo_; "No.") { }
            column(FullName; FullName) { }

            dataitem("Employee Ledger Entry"; "Employee Ledger Entry")
            {
                DataItemLink = "Employee No." = field("No."), "posting date" = field("Date filter");
                column(Debit_Amount__LCY_3; "Debit Amount") { }
                column(Credit_Amount__LCY_3; "Credit Amount") { }
                column(Document_No_3; "Document No.") { }
                column(Posting_Date3; "Posting Date") { }
                column(BalanceCLE3; BalanceCLE) { }
                column(Description3; Description) { }
                column(EmpPeriodFilter; StrSubstNo(Text003, PeriodStartDate, PeriodEndDate)) { }
                column(EmpCompanyInfo; CompanyInfo.Picture) { }
                column(EmpCompanyAddr1; CompanyAddr[1]) { }
                column(EmpCompanyAddr2; CompanyAddr[2]) { }
                column(EmpCompanyAddr3; CompanyAddr[3]) { }
                column(EmpCompanyAddr4; CompanyAddr[4]) { }
                column(EmpCompanyInfoPhoneNo; CompanyInfo."Phone No.") { }
                column(EmpCompanyInfoHomePage; CompanyInfo."Home Page") { }
                column(EmpCompanyInfoEmail; CompanyInfo."E-Mail") { }
                column(EmpCompanyAddr5; CompanyAddr[5]) { }
                column(EmpCompanyAddr6; CompanyAddr[6]) { }
                column(EmpCompanyInfoFaxNo; CompanyInfo."Fax No.") { }
                column(EmpCompanyInfoVATRegtnNo; CompanyInfo."VAT Registration No.") { }
                column(EmpCompanyInfoGiroNo; CompanyInfo."Giro No.") { }
                column(EmpCompanyInfoBankName; CompanyInfo."Bank Name") { }
                column(EmpCompanyInfoBankAccountNo; CompanyInfo."Bank Account No.") { }

                trigger OnPreDataItem()
                begin
                    "Employee Ledger Entry".SetRange("Posting Date", PeriodStartDate, PeriodEndDate);
                end;

                trigger OnAfterGetRecord()
                begin
                    BalanceCLE := BalanceCLE + "Debit Amount" - ABS("Credit Amount");

                    if DimensionFilter <> '' then begin
                        DimensionSetentry.SetRange("Dimension Set ID", "Employee Ledger Entry"."Dimension Set ID");
                        DimensionSetentry.SetRange("Dimension Code", DimensionFilter);
                        if not DimensionSetentry.FindFirst() then
                            CurrReport.Skip();
                    end;

                end;

            }
            trigger OnPreDataItem()
            begin
                if AccountFilter <> AccountFilter::Employee then
                    CurrReport.Break()
                else begin
                    VerifyDates();
                    Employee.SetRange("Date Filter", PeriodStartDate, PeriodEndDate);
                end;
            end;

            trigger OnAfterGetRecord()
            var
                Emp2: Record Employee;
            begin

                Emp2 := Employee;

                Emp2.SETRANGE("Date Filter", 0D, PeriodStartDate - 1);
                Emp2.CalcFields(Emp2.Balance);

                OpeningCLE := Emp2.Balance;
                BalanceCLE := Emp2.Balance;

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
                    Caption = 'Filters';
                    field(PeriodStartDate; PeriodStartDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'From Date';
                        ToolTip = 'Specifies the from Date';
                    }
                    field(PeriodEndDate; PeriodEndDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'To Date';
                        ToolTip = 'Specifies the To Date.';
                    }
                    field(DimensionFilter; DimensionFilter)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Dimension Filter';
                        ToolTip = 'Specifies the Dimension Filter';
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Dimension: Record Dimension;
                        begin
                            if Page.RunModal(0, Dimension) = Action::LookupOK then
                                DimensionFilter := Dimension.code;
                        end;
                    }
                    field(AccountFilter; AccountFilter)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Account Filter';
                        MultiLine = true;
                        ToolTip = 'Select the Account';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        PeriodBeginBalanceCaption = 'Beginning Balance';
        PeriodDebitAmtCaption = 'Debit';
        PeriodCreditAmtCaption = 'Credit';
    }

    trigger OnPreReport()
    begin

    end;

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        FormatAddr.Company(CompanyAddr, CompanyInfo);
    end;

    var
        Text000: Label 'It was not possible to find a %1 in %2.';
        AccountingPeriod: Record "Accounting Period";
        DimensionSetentry: Record "Dimension Set Entry";
        Cust2: Record Customer;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        CompanyInfo: Record "Company Information";
        AmountInwords: Text;
        Notext: array[2] of Text;
        Repcheck: Report Check;
        FormatAddr: Codeunit "Format Address";
        DimensionManagement: Codeunit DimensionManagement;
        Selectionfiltermgmnt: Codeunit SelectionFilterManagement;
        PageNoCaptionLbl: Label 'Page';
        CompanyAddr: array[8] of Text[100];
        PeriodBeginBalance: Decimal;
        AccountFilter: Option Customer,Vendor,Employee,"G/L";
        DimensionFilter: Code[20];
        BalanceCLE: Decimal;
        OpeningCLE: Decimal;
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        PostingDate: date;
        DocNo: Code[100];
        PeriodDebitAmt: Decimal;
        PeriodCreditAmt: Decimal;
        YTDBeginBalance: Decimal;
        YTDDebitAmt: Decimal;
        YTDCreditAmt: Decimal;
        YTDTotal: Decimal;
        PeriodFilter: Text;
        FiscalYearFilter: Text;
        CustFilter: Text;
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        FiscalYearStartDate: Date;
        Text003: Label 'Period From: %1 to %2';
        BlankStartDateErr: Label 'Start Date must have a value';
        BlankEndDateErr: Label 'End Date must have a value';
        StartDateLaterTheEndDateErr: Label 'Start Date must be earlier than End date';
        Text004: Label 'Total for';
        Text005: Label 'Group Totals: %1';
        CustTrialBalanceCaptionLbl: Label 'Customer - Trial Balance';
        CurrReportPageNoCaptionLbl: Label 'Page';
        AmtsinLCYCaptionLbl: Label 'Amounts in LCY';
        inclcustentriesinperiodCaptionLbl: Label 'Only includes customers with entries in the period';
        YTDTotalCaptionLbl: Label 'Ending Balance';
        PeriodCaptionLbl: Label 'Period';
        NetChangeCaptionLbl: Label 'Net Change';
        TotalinLCYCaptionLbl: Label 'Total in LCY';
        reprtbb: Report Statement;

    local procedure VerifyDates()
    begin
        if PeriodStartDate = 0D then
            Error(BlankStartDateErr);
        if PeriodEndDate = 0D then
            Error(BlankEndDateErr);
        if PeriodStartDate > PeriodEndDate then
            Error(StartDateLaterTheEndDateErr);
    end;
}



