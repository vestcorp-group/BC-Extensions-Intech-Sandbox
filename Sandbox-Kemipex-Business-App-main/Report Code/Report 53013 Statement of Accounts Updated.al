report 53013 "Statement of Accounts Updated"//T12370-Full Comment
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Statement of Accounts 53013.rdl';
    Caption = 'Statement of Accounts Updated';
    UsageCategory = Administration;
    ApplicationArea = all;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Address_CompanyInformation; CompInfo.Address)
            {
            }
            column(Address2_CompanyInformation; CompInfo."Address 2")
            {
            }
            column(City_CompanyInformation; CompInfo.City)
            {
            }
            column(Picture_CompanyInformation; CompInfo.Picture)
            {
            }
            column(Name_CompanyInformation; CompInfo.Name)
            {
            }
            column(PostCode_CompanyInformation; CompInfo."Post Code")
            {
            }
            column(County_CompanyInformation; CompInfo.County)
            {
            }
            column(EMail_CompanyInformation; CompInfo."E-Mail")
            {
            }
            column(IBAN_CompanyInformation; CompInfo."VAT Registration No.")
            {
            }
            column(PhoneNo_CompanyInformation; CompInfo."Phone No.")
            {
            }
            column(StDt; StDt)
            {
            }
            column(EndDt; EndDt)
            {
            }
            column(DimCode; DimCode)
            {
            }
            column(DimValue; DimValue)
            {
            }
            column(DimCode2; DimCode2)
            {
            }
            column(DimValue2; DimValue2)
            {
            }
        }
        /* dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.", "Global Dimension 1 Filter", "Global Dimension 2 Filter", "Date Filter";
            //ReqFilterHeading = 'G/L Account';
            column(Name_GLAccount; "G/L Account".Name)
            {
            }
            column(blnGlEntry; blnGlEntry)
            {
            }
            column(No_GLAccount; "G/L Account"."No.")
            {
            }
            column(StartBalance; StartBalance)
            {
            }
            column(GLDateFilter; GLDateFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("G/L Account No.", "Posting Date") ORDER(Ascending);
                column(WhiteRow; WhiteRow)
                {
                }
                column(IntRow; IntRow)
                {
                }
                column(AmtInWords; AmtInWords)
                {
                }
                column(GLBalance; GLBalance)
                {
                }
                column(GLAccountNo_GLEntry; "G/L Entry"."G/L Account No.")
                {
                }
                column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
                {
                }
                column(DocumentType_GLEntry; "G/L Entry"."Document Type")
                {
                }
                column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
                {
                }
                column(Description_GLEntry; "G/L Entry".Description)
                {
                }
                column(Amount_GLEntry; "G/L Entry".Amount)
                {
                }
                column(GlobalDimension1Code_GLEntry; "G/L Entry"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_GLEntry; "G/L Entry"."Global Dimension 2 Code")
                {
                }
                column(DebitAmount_GLEntry; "G/L Entry"."Debit Amount")
                {
                }
                column(CreditAmount_GLEntry; "G/L Entry"."Credit Amount")
                {
                }
                column(DocumentDate_GLEntry; "G/L Entry"."Document Date")
                {
                }
                column(ExternalDocumentNo_GLEntry; "G/L Entry"."External Document No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    GLBalance := GLBalance + Amount;
                    CLEAR(RepCheck);
                    RepCheck.InitTextVariable;
                    RepCheck.FormatNoText(NoText, ROUND(GLBalance, 0.01), GLsetup."LCY Code");
                    AmtInWords := NoText[1];

                    ChangeRowsColor;
                end;

                trigger OnPreDataItem();
                begin
                    if not blnGlEntry then
                        CurrReport.BREAK;
                    GLBalance := StartBalance;
                end;
            }

            trigger OnAfterGetRecord();
            var
                Date: Record Date;
            begin
                StartBalance := 0;
                if GLDateFilter <> '' then begin
                    Date.SETRANGE("Period Type", Date."Period Type"::Date);
                    Date.SETFILTER("Period Start", GLDateFilter);
                    if Date.FINDFIRST then begin
                        SETRANGE("Date Filter", 0D, CLOSINGDATE(Date."Period Start" - 1));
                        CALCFIELDS("Net Change");
                        StartBalance := "Net Change";
                        SETFILTER("Date Filter", GLDateFilter);
                    end;
                end;
                CLEAR(AmtInWords);
            end;

            trigger OnPreDataItem();
            begin
                if not blnGlEntry then
                    CurrReport.BREAK;
                CLEAR(GLDateFilter);
                CLEAR(GLDateFilter);
                if ((StDt <> 0D) and (EndDt <> 0D)) then
                    "G/L Account".SETFILTER("Date Filter", '%1..%2', StDt, EndDt);
                GLFilter := "G/L Account".GETFILTERS;
                GLDateFilter := "G/L Account".GETFILTER("Date Filter");
            end;
        } */
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.", "Global Dimension 1 Filter", "Global Dimension 2 Filter", "Date Filter";
            //ReqFilterHeading = 'Employee';
            column(blnELE; blnELE)
            {
            }
            column(No_Employee; Employee."No.")
            {
            }
            column(FirstName_Employee; Employee."First Name")
            {
            }
            column(StartBalanceEmp; StartBalance)
            {
            }
            column(GLDateFilterEmp; GLDateFilter)
            {
            }
            column(GLFilterEmp; GLFilter)
            {
            }
            dataitem("Employee Ledger Entry"; "Employee Ledger Entry")
            {
                CalcFields = "Remaining Amt. (LCY)", "Remaining Amount", "Debit Amount (LCY)", "Credit Amount (LCY)", "Amount (LCY)";
                DataItemLink = "Employee No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Entry No.") ORDER(Ascending);
                column(WhiteRowEmp; WhiteRow)
                {
                }
                column(IntRowEmp; IntRow)
                {
                }
                column(AmtInWordsEmp; AmtInWords)
                {
                }
                column(GLBalanceEmp; GLBalance)
                {
                }
                column(EmployeeNo_EmployeeLedgerEntry; "Employee Ledger Entry"."Employee No.")
                {
                }
                column(PostingDate_EmployeeLedgerEntry; "Employee Ledger Entry"."Posting Date")
                {
                }
                column(DocumentType_EmployeeLedgerEntry; "Employee Ledger Entry"."Document Type")
                {
                }
                column(DocumentNo_EmployeeLedgerEntry; "Employee Ledger Entry"."Document No.")
                {
                }
                column(Description_EmployeeLedgerEntry; "Employee Ledger Entry".Description)
                {
                }
                column(Amount_EmployeeLedgerEntry; "Employee Ledger Entry".Amount)
                {
                }
                column(RemainingAmount_EmployeeLedgerEntry; "Employee Ledger Entry"."Remaining Amount")
                {
                }
                column(RemainingAmtLCY_EmployeeLedgerEntry; "Employee Ledger Entry"."Remaining Amt. (LCY)")
                {
                }
                column(AmountLCY_EmployeeLedgerEntry; "Employee Ledger Entry"."Amount (LCY)")
                {
                }
                column(GlobalDimension1Code_EmployeeLedgerEntry; "Employee Ledger Entry"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_EmployeeLedgerEntry; "Employee Ledger Entry"."Global Dimension 2 Code")
                {
                }
                column(DebitAmountLCY_EmployeeLedgerEntry; "Employee Ledger Entry"."Debit Amount (LCY)")
                {
                }
                column(CreditAmountLCY_EmployeeLedgerEntry; "Employee Ledger Entry"."Credit Amount (LCY)")
                {
                }
                column(DateFilter_EmployeeLedgerEntry; "Employee Ledger Entry"."Date Filter")
                {
                }
                column(DimensionSetID_EmployeeLedgerEntry; "Employee Ledger Entry"."Dimension Set ID")
                {
                }

                trigger OnAfterGetRecord();
                begin

                    ClearValues();
                    if DimCode = '' then begin
                        if DimCode2 = '' then
                            Dim1Exists := true
                        else
                            Dim1Exists := false;
                    end
                    else
                        Dim1Exists := CheckDim1Exists("Dimension Set ID");

                    if DimCode2 = '' then begin
                        if DimCode = '' then
                            Dim2Exists := true
                        else
                            Dim2Exists := false;
                    end
                    else
                        Dim2Exists := CheckDim2Exists("Dimension Set ID");

                    if ((not Dim1Exists) and (not Dim2Exists)) then
                        CurrReport.Skip();

                    CLEAR(RepCheck);
                    GLBalance := GLBalance + "Amount (LCY)";
                    RepCheck.InitTextVariable;
                    RepCheck.FormatNoText(NoText, ROUND(ABS(GLBalance), 0.01), GLsetup."LCY Code");
                    AmtInWords := NoText[1];
                    ChangeRowsColor;
                end;

                trigger OnPreDataItem();
                begin
                    if not blnELE then
                        CurrReport.BREAK;
                    GLBalance := StartBalance;
                end;
            }

            trigger OnAfterGetRecord();
            var
                Date: Record Date;
            begin

                StartBalance := 0;
                if GLDateFilter <> '' then begin
                    Date.SETRANGE("Period Type", Date."Period Type"::Date);
                    Date.SETFILTER("Period Start", GLDateFilter);
                    if Date.FINDFIRST then begin
                        SETRANGE("Date Filter", 0D, CLOSINGDATE(Date."Period Start" - 1));
                        CALCFIELDS(Balance);
                        StartBalance := ABS(Balance);
                        SETFILTER("Date Filter", GLDateFilter);
                    end;
                end;
                CLEAR(AmtInWords);
            end;

            trigger OnPreDataItem();
            begin
                if not blnELE then
                    CurrReport.BREAK;
                CLEAR(GLDateFilter);
                CLEAR(GLDateFilter);
                if ((StDt <> 0D) and (EndDt <> 0D)) then
                    Employee.SETRANGE("Date Filter", StDt, EndDt);
                GLFilter := Employee.GETFILTERS;
                GLDateFilter := Employee.GETFILTER("Date Filter");
            end;
        }
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Global Dimension 1 Filter", "Global Dimension 2 Filter", "Date Filter";
            //ReqFilterHeading = 'Customer';
            column(blnCLE; blnCLE)
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(StartBalanceCust; StartBalance)
            {
            }
            column(GLDateFilterCust; GLDateFilter)
            {
            }
            column(GLFilterCust; GLFilter)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = "Remaining Amt. (LCY)", "Remaining Amount", "Debit Amount (LCY)", "Credit Amount (LCY)", "Amount (LCY)";
                DataItemLink = "Customer No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Entry No.") ORDER(Ascending);
                column(WhiteRowCust; WhiteRow)
                {
                }
                column(IntRowCust; IntRow)
                {
                }
                column(AmtInWordsCust; AmtInWords)
                {
                }
                column(GLBalanceCust; GLBalance)
                {
                }
                column(CustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Customer No.")
                {
                }
                column(PostingDate_CustLedgerEntry; "Cust. Ledger Entry"."Posting Date")
                {
                }
                column(DocumentType_CustLedgerEntry; "Cust. Ledger Entry"."Document Type")
                {
                }
                column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(Description_CustLedgerEntry; "Cust. Ledger Entry".Description)
                {
                }
                column(Amount_CustLedgerEntry; "Cust. Ledger Entry".Amount)
                {
                }
                column(RemainingAmtLCY_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amt. (LCY)")
                {
                }
                column(AmountLCY_CustLedgerEntry; "Cust. Ledger Entry"."Amount (LCY)")
                {
                }
                column(GlobalDimension1Code_CustLedgerEntry; "Cust. Ledger Entry"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_CustLedgerEntry; "Cust. Ledger Entry"."Global Dimension 2 Code")
                {
                }
                column(DebitAmountLCY_CustLedgerEntry; "Cust. Ledger Entry"."Debit Amount (LCY)")
                {
                }
                column(CreditAmountLCY_CustLedgerEntry; "Cust. Ledger Entry"."Credit Amount (LCY)")
                {
                }
                column(ExternalDocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."External Document No.")
                {
                }
                column(DateFilter_CustLedgerEntry; "Cust. Ledger Entry"."Date Filter")
                {
                }
                column(DimensionSetID_CustLedgerEntry; "Cust. Ledger Entry"."Dimension Set ID")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    ClearValues();

                    if DimCode = '' then begin
                        if DimCode2 = '' then
                            Dim1Exists := true
                        else
                            Dim1Exists := false;
                    end
                    else
                        Dim1Exists := CheckDim1Exists("Cust. Ledger Entry"."Dimension Set ID");

                    if DimCode2 = '' then begin
                        if DimCode = '' then
                            Dim2Exists := true
                        else
                            Dim2Exists := false;
                    end
                    else
                        Dim2Exists := CheckDim2Exists("Cust. Ledger Entry"."Dimension Set ID");


                    if ((not Dim1Exists) and (not Dim2Exists)) then
                        CurrReport.Skip();

                    CLEAR(RepCheck);
                    GLBalance := GLBalance + "Amount (LCY)";
                    RepCheck.InitTextVariable;
                    RepCheck.FormatNoText(NoText, ROUND(ABS(GLBalance), 0.01), GLsetup."LCY Code");
                    AmtInWords := NoText[1];
                    ChangeRowsColor;
                end;

                trigger OnPreDataItem();
                begin
                    if not blnCLE then
                        CurrReport.BREAK;
                    GLBalance := StartBalance;
                end;
            }

            trigger OnAfterGetRecord();
            var
                Date: Record Date;
            begin
                StartBalance := 0;
                if GLDateFilter <> '' then begin
                    Date.SETRANGE("Period Type", Date."Period Type"::Date);
                    Date.SETFILTER("Period Start", GLDateFilter);
                    if Date.FINDFIRST then begin
                        SETRANGE("Date Filter", 0D, CLOSINGDATE(Date."Period Start" - 1));
                        CALCFIELDS("Net Change (LCY)");
                        StartBalance := "Net Change (LCY)";
                        SETFILTER("Date Filter", GLDateFilter);
                    end;
                end;
                CLEAR(AmtInWords);
            end;

            trigger OnPreDataItem();
            begin
                if not blnCLE then
                    CurrReport.BREAK;
                CLEAR(GLDateFilter);
                CLEAR(GLDateFilter);
                if ((StDt <> 0D) and (EndDt <> 0D)) then
                    Customer.SETRANGE("Date Filter", StDt, EndDt);
                GLFilter := Customer.GETFILTERS;
                GLDateFilter := Customer.GETFILTER("Date Filter");
            end;
        }
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.", "Global Dimension 1 Filter", "Global Dimension 2 Filter", "Date Filter";
            //ReqFilterHeading = 'Vendor';
            column(blnVLE; blnVLE)
            {
            }
            column(No_Vendor; Vendor."No.")
            {
            }
            column(Name_Vendor; Vendor.Name)
            {
            }
            column(StartBalanceVend; StartBalance)
            {
            }
            column(GLDateFilterVend; GLDateFilter)
            {
            }
            column(GLFilterVend; GLFilter)
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                CalcFields = "Remaining Amt. (LCY)", "Remaining Amount", "Debit Amount (LCY)", "Credit Amount (LCY)", "Amount (LCY)";
                DataItemLink = "Vendor No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Entry No.") ORDER(Ascending);
                column(WhiteRowVend; WhiteRow)
                {
                }
                column(IntRowVend; IntRow)
                {
                }
                column(AmtInWordsVend; AmtInWords)
                {
                }
                column(GLBalanceVend; GLBalance)
                {
                }
                column(VendorNo_VendorLedgerEntry; "Vendor Ledger Entry"."Vendor No.")
                {
                }
                column(PostingDate_VendorLedgerEntry; "Vendor Ledger Entry"."Posting Date")
                {
                }
                column(DocumentType_VendorLedgerEntry; "Vendor Ledger Entry"."Document Type")
                {
                }
                column(DocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(Description_VendorLedgerEntry; "Vendor Ledger Entry".Description)
                {
                }
                column(Amount_VendorLedgerEntry; "Vendor Ledger Entry".Amount)
                {
                }
                column(RemainingAmtLCY_VendorLedgerEntry; "Vendor Ledger Entry"."Remaining Amt. (LCY)")
                {
                }
                column(AmountLCY_VendorLedgerEntry; "Vendor Ledger Entry"."Amount (LCY)")
                {
                }
                column(GlobalDimension1Code_VendorLedgerEntry; "Vendor Ledger Entry"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_VendorLedgerEntry; "Vendor Ledger Entry"."Global Dimension 2 Code")
                {
                }
                column(DebitAmountLCY_VendorLedgerEntry; "Vendor Ledger Entry"."Debit Amount (LCY)")
                {
                }
                column(CreditAmountLCY_VendorLedgerEntry; "Vendor Ledger Entry"."Credit Amount (LCY)")
                {
                }
                column(DocumentDate_VendorLedgerEntry; "Vendor Ledger Entry"."Document Date")
                {
                }
                column(ExternalDocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."External Document No.")
                {
                }
                column(DateFilter_VendorLedgerEntry; "Vendor Ledger Entry"."Date Filter")
                {
                }
                column(DimensionSetID_VendorLedgerEntry; "Vendor Ledger Entry"."Dimension Set ID")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    ClearValues();
                    if DimCode = '' then begin
                        if DimCode2 = '' then
                            Dim1Exists := true
                        else
                            Dim1Exists := false;
                    end
                    else
                        Dim1Exists := CheckDim1Exists("Dimension Set ID");

                    if DimCode2 = '' then begin
                        if DimCode = '' then
                            Dim2Exists := true
                        else
                            Dim2Exists := false;
                    end
                    else
                        Dim2Exists := CheckDim2Exists("Dimension Set ID");

                    if ((not Dim1Exists) and (not Dim2Exists)) then
                        CurrReport.Skip();

                    CLEAR(RepCheck);
                    GLBalance := GLBalance + "Amount (LCY)";
                    RepCheck.InitTextVariable;
                    RepCheck.FormatNoText(NoText, ROUND(ABS(GLBalance), 0.01), GLsetup."LCY Code");
                    AmtInWords := NoText[1];
                    ChangeRowsColor;
                end;

                trigger OnPreDataItem();
                begin
                    if not blnVLE then
                        CurrReport.BREAK;
                    GLBalance := StartBalance;
                end;
            }

            trigger OnAfterGetRecord();
            var
                Date: Record Date;
            begin
                StartBalance := 0;
                if GLDateFilter <> '' then begin
                    Date.SETRANGE("Period Type", Date."Period Type"::Date);
                    Date.SETFILTER("Period Start", GLDateFilter);
                    if Date.FINDFIRST then begin
                        SETRANGE("Date Filter", 0D, CLOSINGDATE(Date."Period Start" - 1));
                        CALCFIELDS("Net Change (LCY)");
                        StartBalance := abs("Net Change (LCY)");
                        SETFILTER("Date Filter", GLDateFilter);
                    end;
                end;
                CLEAR(AmtInWords);
            end;

            trigger OnPreDataItem();
            begin
                if not blnVLE then
                    CurrReport.BREAK;
                CLEAR(GLDateFilter);
                CLEAR(GLDateFilter);
                if ((StDt <> 0D) and (EndDt <> 0D)) then
                    Vendor.SETRANGE("Date Filter", StDt, EndDt);
                GLFilter := Vendor.GETFILTERS;
                GLDateFilter := Vendor.GETFILTER("Date Filter");
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

                    field("Start Date"; StDt)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("End Date"; EndDt)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    /* field("Show G/L Entries"; blnGlEntry)
                    {
                        ApplicationArea = Basic, Suite;
                    } */
                    field("Show Customer Ledger"; blnCLE)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Show Vendor Ledger"; blnVLE)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Show Employee Ledger"; blnELE)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    group(Dim1Filter)
                    {
                        Caption = 'Dimension 1 Filter';
                        field("Dimension Code 1"; DimCode)
                        {
                            ApplicationArea = Basic, Suite;
                            TableRelation = Dimension.Code;
                            trigger OnValidate()
                            begin
                                IF DimValue <> '' THEN
                                    ERROR('Dimension Value must be blank');
                            end;
                        }
                        field("Dimension Code 1 Value"; DimValue)
                        {
                            ApplicationArea = Basic, Suite;
                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                IF DimCode <> '' THEN BEGIN
                                    DimValRec.RESET;
                                    DimValRec.FILTERGROUP(2);
                                    DimValRec.SETRANGE("Dimension Code", DimCode);
                                    DimValRec.FILTERGROUP(0);
                                    IF PAGE.RUNMODAL(0, DimValRec) = ACTION::LookupOK THEN
                                        DimValue := DimValRec.Code;
                                END;
                            end;

                        }
                    }
                    group(Dim2Filter)
                    {
                        Caption = 'Dimension 2 Filter';
                        field("Dimension Code 2"; DimCode2)
                        {
                            ApplicationArea = Basic, Suite;
                            TableRelation = Dimension.Code;
                            trigger OnValidate()
                            begin
                                IF DimValue2 <> '' THEN
                                    ERROR('Dimension Value must be blank');
                            end;
                        }
                        field("Dimension Code 2 Value"; DimValue2)
                        {
                            ApplicationArea = Basic, Suite;
                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                IF DimCode2 <> '' THEN BEGIN
                                    DimValRec.RESET;
                                    DimValRec.FILTERGROUP(2);
                                    DimValRec.SETRANGE("Dimension Code", DimCode2);
                                    DimValRec.FILTERGROUP(0);
                                    IF PAGE.RUNMODAL(0, DimValRec) = ACTION::LookupOK THEN
                                        DimValue2 := DimValRec.Code;
                                END;
                            end;

                        }
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            /* Clear(DimCode);
            Clear(DimValue);
            Clear(DimCode2);
            Clear(DimValue2); */

        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
        GLsetup.GET;
        IntRow := 1;
    end;

    var
        CompInfo: Record "Company Information";
        blnGlEntry: Boolean;
        blnCLE: Boolean;
        blnVLE: Boolean;
        blnELE: Boolean;
        StDt: Date;
        EndDt: Date;
        StartBalance: Decimal;
        GLDateFilter: Text;
        GLFilter: Text;
        GLBalance: Decimal;
        AmtInWords: Text;
        RepCheck: Report Check;
        NoText: array[2] of Text;
        GLsetup: Record "General Ledger Setup";
        IntRow: Integer;
        WhiteRow: Boolean;
        DimCode: Code[20];
        DimValue: Code[20];
        DimValRec: Record "Dimension Value";
        DimCode2: Code[20];
        DimValue2: Code[20];

        Dim1Exists: Boolean;
        Dim2Exists: Boolean;

    local procedure ChangeRowsColor();
    begin
        IntRow += 1;
        if (IntRow mod 2) = 0 then
            WhiteRow := true
        else
            WhiteRow := false;
    end;

    local procedure ClearValues()
    begin

        Clear(Dim1Exists);
        Clear(Dim2Exists);
    end;

    local procedure CheckDim1Exists(DimSetID: Integer): Boolean
    var
        DimSetEntry: Record "Dimension Set Entry";
    begin
        DimSetEntry.Reset();
        DimSetEntry.SetRange("Dimension Set ID", DimSetID);
        DimSetEntry.SetRange("Dimension Code", DimCode);
        DimSetEntry.SetRange("Dimension Value Code", DimValue);
        if DimSetEntry.FindSet() then begin
            //Message('Hi.....%1', DimSetEntry);
            exit(true);
        end;

        exit(false);
    end;

    local procedure CheckDim2Exists(DimSetID: Integer): Boolean
    var
        DimSetEntry: Record "Dimension Set Entry";
    begin
        DimSetEntry.Reset();
        DimSetEntry.SetRange("Dimension Set ID", DimSetID);
        DimSetEntry.SetRange("Dimension Code", DimCode2);
        DimSetEntry.SetRange("Dimension Value Code", DimValue2);
        if DimSetEntry.FindSet() then begin
            //Message('bye.....%1', DimSetEntry);
            exit(true);
        end;

        exit(false);
    end;
}

