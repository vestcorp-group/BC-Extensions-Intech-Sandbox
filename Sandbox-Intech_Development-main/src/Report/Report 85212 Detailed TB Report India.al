report 85212 "Detailed TB Report India"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Description = 'T50398';
    caption = 'Detailed TB Report India';

    dataset
    {
        // dataitem(Company; Company)
        // {
        dataitem("G/L Entry"; "G/L Entry")
        {
#pragma warning disable AL0254
            DataItemTableView = sorting("G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Posting Date", "VAT Reporting Date", "Source Currency Code");
#pragma warning restore AL0254
            trigger OnAfterGetRecord()
            begin
                Curr_gInt += 1;
                Win_gDlg.Update(2, Curr_gInt);

                Clear(GLSetup_gRec);
                // GLSetup_gRec.ChangeCompany(Company.Name);
                GLSetup_gRec.Get;

                "G/L Entry".CalcFields("G/L Account Name");
                Clear(LocationName_gTxt);
                Clear(CostCenterName_gTxt);
                Clear(MarketName_gTxt);
                Clear(OpeningBalance_gDec);
                Clear(DebitAmt_gDec);
                Clear(CreditAmt_gDec);
                Clear(ClosingBalance_gDec);
                CalcFields("Shortcut Dimension 3 Code");
                Clear(MonthNumber_gInt);
                Clear(Day_gInt);
                Clear(Year_gInt);
                Clear(NewJanDate_gInt);
                Clear(PrejanDate_gInt);
                Clear(RetainedEarningsGL_gDec);
                clear(SingleRetainingGLAcc_gDec);
                clear(fixedtotalIncomeGL_gDec);

                MonthNumber_gInt := DATE2DMY(StartDate_gDte, 2);
                Year_gInt := DATE2DMY(StartDate_gDte, 3);
                Day_gInt := DATE2DMY(StartDate_gDte, 1);
                NewJanDate_gInt := DMY2DATE(1, 1, Year_gInt);//from StartDate_gDte
                PrejanDate_gInt := DMY2DATE(1, 1, Year_gInt - 1);//from StartDate_gDte-1
                DimensionValue_gRec.Reset();
                // DimensionValue_gRec.ChangeCompany(Company.Name);
                DimensionValue_gRec.SetRange("Dimension Code", GLSetup_gRec."Global Dimension 1 Code");
                DimensionValue_gRec.SetRange(code, "G/L Entry"."Global Dimension 1 Code");
                if DimensionValue_gRec.FindFirst() then
                    LocationName_gTxt := DimensionValue_gRec.Name;

                DimensionValue_gRec.Reset();
                // DimensionValue_gRec.ChangeCompany(Company.Name);
                DimensionValue_gRec.SetRange("Dimension Code", GLSetup_gRec."Global Dimension 2 Code");
                DimensionValue_gRec.SetRange(code, "G/L Entry"."Global Dimension 2 Code");
                if DimensionValue_gRec.FindFirst() then
                    CostCenterName_gTxt := DimensionValue_gRec.Name;
                DimensionValue_gRec.Reset();
                // DimensionValue_gRec.ChangeCompany(Company.Name);
                DimensionValue_gRec.SetRange("Dimension Code", GLSetup_gRec."Shortcut Dimension 3 Code");
                DimensionValue_gRec.SetRange(code, "G/L Entry"."Shortcut Dimension 3 Code");
                if DimensionValue_gRec.FindFirst() then
                    MarketName_gTxt := DimensionValue_gRec.Name;


                if ConsText_gTxt <> "G/L Entry"."G/L Account No." + "G/L Entry"."Global Dimension 1 Code" + "G/L Entry"."Global Dimension 2 Code" + "G/L Entry"."Shortcut Dimension 3 Code" then begin
                    if (MonthNumber_gInt = 1) and (Day_gInt = 1) and ("G/L Entry"."G/L Account No." <> '330706') then begin //only for JAN
                        GLAccount_gRec.Get("G/L Entry"."G/L Account No.");
                        if (GLAccount_gRec."Income/Balance" = GLAccount_gRec."Income/Balance"::"Income Statement") then begin
                            OpeningBalance_gDec := 0
                        end else begin
                            GLEntry_gRec.Reset();
                            // GLEntry_gRec.ChangeCompany(Company.Name);
                            GLEntry_gRec.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                            // GLEntry_gRec.SetRange("Posting Date", 0D, ClosingDate(StartDate_gDte - 1));
                            GLEntry_gRec.SetRange("Posting Date", 0D, CalcDate('-1D', StartDate_gDte));
                            GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                            GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                            GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                            // GLEntry_gRec.CalcSums(Amount);
                            // OpeningBalance_gDec := Round(GLEntry_gRec.Amount, 0.01);
                            //15-05-2025-NS
                            if GLEntry_gRec.FindSet() then
                                repeat
                                    if CopyStr(Format(GLEntry_gRec."Posting Date"), 1, 1) <> 'C' then
                                        OpeningBalance_gDec += Round(GLEntry_gRec.Amount, 0.01);
                                until GLEntry_gRec.Next() = 0;
                            //15-05-2025-NE
                        end;
                    end else begin
                        GLAccount_gRec.Get("G/L Entry"."G/L Account No.");
                        if (GLAccount_gRec."Income/Balance" = GLAccount_gRec."Income/Balance"::"Income Statement") then begin
                            // GLEntry_gRec.Reset();
                            // GLEntry_gRec.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                            // GLEntry_gRec.SetRange("Posting Date", NewJanDate_gInt, CalcDate('-1D', StartDate_gDte));
                            // GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                            // GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                            // GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                            // GLEntry_gRec.CalcSums(Amount);
                            // OpeningBalance_gDec := Round(GLEntry_gRec.Amount, 0.01);
                            GLEntry_gRec.Reset();
                            GLEntry_gRec.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                            GLEntry_gRec.SetRange("Posting Date", NewJanDate_gInt, CalcDate('-1D', StartDate_gDte));
                            GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                            GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                            GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                            if GLEntry_gRec.FindSet() then
                                repeat
                                    if CopyStr(Format(GLEntry_gRec."Posting Date"), 1, 1) <> 'C' then
                                        OpeningBalance_gDec += Round(GLEntry_gRec.Amount, 0.01);
                                until GLEntry_gRec.Next() = 0;
                        end else begin
                            GLEntry_gRec.Reset();
                            GLEntry_gRec.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                            GLEntry_gRec.SetRange("Posting Date", 0D, CalcDate('-1D', StartDate_gDte));
                            GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                            GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                            GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                            // GLEntry_gRec.CalcSums(Amount);
                            // OpeningBalance_gDec := Round(GLEntry_gRec.Amount, 0.01);
                            //15-05-2025-NS
                            if GLEntry_gRec.FindSet() then
                                repeat
                                    if CopyStr(Format(GLEntry_gRec."Posting Date"), 1, 1) <> 'C' then
                                        OpeningBalance_gDec += Round(GLEntry_gRec.Amount, 0.01);
                                until GLEntry_gRec.Next() = 0;
                            //15-05-2025-NE
                        end;
                    end;

                    if ("G/L Entry"."G/L Account No." = '330706') then begin //Replace the vaule 330706 with the retained earnings account
                        //if ("G/L Entry"."G/L Account No." = '330706') and (MonthNumber_gInt = 1) and (Day_gInt = 1) then begin
                        Clear(GLAcc_Ltxt);
                        // GLAccount_gRec.Get(GLEntry_gRec."G/L Account No.");
                        GLAccount_gRec.Reset();
                        GLAccount_gRec.SetRange("Income/Balance", GLAccount_gRec."Income/Balance"::"Income Statement");
                        If GLAccount_gRec.FindSet() then
                            repeat
                                if GLAcc_Ltxt = '' then
                                    GLAcc_Ltxt := GLAccount_gRec."No."
                                else
                                    GLAcc_Ltxt += '|' + GLAccount_gRec."No.";

                            until GLAccount_gRec.Next() = 0;
                        if not RetainedEarRun_gBln then begin
                            GLEntry_gRec.Reset();
                            GLEntry_gRec.SetFilter("G/L Account No.", GLAcc_Ltxt);
                            GLEntry_gRec.SetRange("Posting Date", 0D, CalcDate('12M-1D', PrejanDate_gInt));// if user enter 01012025-->01012024-1D=31-12-2024  finalDate filter 01-01-2024..31-12-2024
                            if GLEntry_gRec.FindSet() then
                                repeat
                                    if CopyStr(Format(GLEntry_gRec."Posting Date"), 1, 1) <> 'C' then
                                        RetainedEarningsGL_gDec += Round(GLEntry_gRec.Amount, 0.01);
                                    RetainedEarRun_gBln := true;
                                until GLEntry_gRec.Next() = 0;
                        end;
                        //OpeningBalance_gDec := RetainedEarningsGL_gDec;
                        GLEntry_gRec.Reset();
                        GLEntry_gRec.SetFilter("G/L Account No.", '330706');
                        GLEntry_gRec.SetRange("Posting Date", 0D, CalcDate('12M-1D', PrejanDate_gInt));// if user enter 01012025-->01012024-1D=31-12-2024 finalDate filter 01-01-2024..31-12-2024
                        GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                        GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                        GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                        if GLEntry_gRec.FindSet() then
                            repeat
                                if CopyStr(Format(GLEntry_gRec."Posting Date"), 1, 1) <> 'C' then
                                    RetainedEarningsGL_gDec += Round(GLEntry_gRec.Amount, 0.01);
                            until GLEntry_gRec.Next() = 0;
                        OpeningBalance_gDec := RetainedEarningsGL_gDec;
                        // OpeningBalance_gDec := OpeningBalance_gDec + RetainedEarningsGL_gDec;//29-05-2025
                        //for 2024 Reatined earnings GL account
                        // if Year_gInt > 2025 then begin //Previous year to Previous year as per the user input-hassan                        
                        //     Fixed2024(Year_gInt);
                        //     OpeningBalance_gDec += SingleRetainingGLAcc_gDec + FixedTotalIncomeGL_gDec;
                        // end;


                    end;
                    GLEntry_gRec.Reset();
                    // GLEntry_gRec.ChangeCompany(Company.Name);
                    GLEntry_gRec.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                    GLEntry_gRec.SetRange("Posting Date", StartDate_gDte, EndDate_gDte);
                    GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                    GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                    GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                    // GLEntry_gRec.CalcSums("Debit Amount", "Credit Amount");
                    // DebitAmt_gDec := Round(GLEntry_gRec."Debit Amount", 0.01);
                    // CreditAmt_gDec := Round(GLEntry_gRec."Credit Amount", 0.01);
                    //14-05-2024-NS
                    if GLEntry_gRec.FindSet() then
                        repeat
                            if CopyStr(Format(GLEntry_gRec."Posting Date"), 1, 1) <> 'C' then begin
                                DebitAmt_gDec += Round(GLEntry_gRec."Debit Amount", 0.01);
                                CreditAmt_gDec += Round(GLEntry_gRec."Credit Amount", 0.01);
                            end;
                        until GLEntry_gRec.Next() = 0;
                    //14-05-2024-NE

                    ClosingBalance_gDec := OpeningBalance_gDec + DebitAmt_gDec - CreditAmt_gDec;
                    MakeExcelDataBody_lFnc();
                end;
                ConsText_gTxt := "G/L Entry"."G/L Account No." + "G/L Entry"."Global Dimension 1 Code" + "G/L Entry"."Global Dimension 2 Code" + "G/L Entry"."Shortcut Dimension 3 Code";
                //end;
            end;

            trigger OnPreDataItem()
            begin

                ConsText_gTxt := '';

                //SetRange("Posting Date", StartDate_gDte, EndDate_gDte);

                Win_gDlg.Open('Total #1#############\Current #2##############');
                Win_gDlg.Update(1, Count);
            end;

            trigger OnPostDataItem()
            begin
                Win_gDlg.Close();
            end;
        }
        // trigger OnPreDataItem()
        // begin
        //     if CompanyNameG <> '' then
        //         SetRange(Name, CompanyNameG)

        // end;

        // trigger OnAfterGetRecord()
        // begin
        //     GLEntry_gRec.ChangeCompany(Company.Name);
        //     DimensionValue_gRec.ChangeCompany(Company.Name);
        //     GLSetup_gRec.ChangeCompany(Company.Name);
        //     "G/L Entry".ChangeCompany(Company.Name);
        // end;
    }
    //}

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("Start Date"; StartDate_gDte)
                    {
                        ApplicationArea = All;

                    }
                    field("End Date"; EndDate_gDte)
                    {
                        ApplicationArea = All;

                    }
                    // field("Company Name"; CompanyNameG)
                    // {
                    //     ApplicationArea = all;
                    //     TableRelation = Company;
                    // }
                }
            }
        }

    }
    trigger OnPostReport()
    begin
        CreateExcelBook_lFnc();
    end;

    trigger OnPreReport()
    begin
        ExcelBuffer_gRecTmp.Reset();
        ExcelBuffer_gRecTmp.DeleteAll();
        // TempGLData_gRec.DeleteAll();


        MakeExcelDataInfo_lFnc();
    end;

    local procedure CreateExcelBook_lFnc()
    begin
        ExcelBuffer_gRecTmp.CreateNewBook('Detailed TB Report');
        ExcelBuffer_gRecTmp.WriteSheet('Detailed TB Report', CompanyName, UserId);
        ExcelBuffer_gRecTmp.SetFriendlyFilename('Detailed TB Report');
        ExcelBuffer_gRecTmp.CloseBook();
        ExcelBuffer_gRecTmp.OpenExcel();
        Error('');
    end;


    local procedure MakeExcelDataInfo_lFnc()
    begin
        ExcelBuffer_gRecTmp.SetUseInfoSheet();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text002), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(COMPANYNAME, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text003), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(Report::"Detailed TB Report", false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text005), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text006), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(Today, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn('Filter', false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(CopyStr("G/L Entry".GetFilters, 1, 250), false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.ClearNewRow();
        MakeExcelDataHeader_lFnc();
    end;

    local procedure MakeExcelDataHeader_lFnc()
    begin
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn('Detail Trail Balance', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn('Company Name :' + CompanyName, false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn('Period :' + Format(StartDate_gDte) + '..' + Format(EndDate_gDte), false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn('Entity', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('GL Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('GL Name', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Location Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Location Name', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('CC Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('CC Name', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Market Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Market Name', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Combination', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Opening Balance', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Debit', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Credit', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Net', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Closing Balance', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);

    end;

    local procedure MakeExcelDataBody_lFnc()
    begin
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn(CompanyName, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."G/L Account No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."G/L Account Name", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."Global Dimension 1 Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn(LocationName_gTxt, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."Global Dimension 2 Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn(CostCenterName_gTxt, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."Shortcut Dimension 3 Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn(MarketName_gTxt, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."G/L Account No." + '-' + "G/L Entry"."Global Dimension 1 Code" + '-' + "G/L Entry"."Global Dimension 2 Code" + '-' + "G/L Entry"."Shortcut Dimension 3 Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn(OpeningBalance_gDec, false, '', false, false, false, '#,##0.00', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(DebitAmt_gDec, false, '', false, false, false, '#,##0.00', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(CreditAmt_gDec, false, '', false, false, false, '#,##0.00', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(DebitAmt_gDec - CreditAmt_gDec, false, '', false, false, false, '#,##0.00', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(ClosingBalance_gDec, false, '', false, false, false, '#,##0.00', ExcelBuffer_gRecTmp."cell type"::Number);
    end;

    var
        ExcelBuffer_gRecTmp: Record "Excel Buffer";
        Win_gDlg: Dialog;
        Curr_gInt: Integer;
        Text002: label 'Company Name';
        Text003: label 'Report No.';
        Text005: label 'User ID';
        Text006: label 'Date';
        StartDate_gDte: Date;
        EndDate_gDte: Date;
        DimensionValue_gRec: Record "Dimension Value";
        GLSetup_gRec: Record "General Ledger Setup";
        LocationName_gTxt: Text;
        CostCenterName_gTxt: Text;
        MarketName_gTxt: Text;
        OpeningBalance_gDec: Decimal;
        ClosingBalance_gDec: Decimal;
        DebitAmt_gDec: Decimal;
        CreditAmt_gDec: Decimal;
        ConsText_gTxt: Text;
        GLEntry_gRec: Record "G/L Entry";
        CompanyNameG: Text;
        RetainedEarningsGL_gDec: Decimal;
        RetainedEarningsGLEntry_gRec: Record "G/L Entry";
        MonthNumber_gInt: Integer;
        Day_gInt: Integer;
        Year_gInt: Integer;
        NewJanDate_gInt: Date;
        PrejanDate_gInt: Date;
        GLAccount_gRec: Record "G/L Account";
        GLAcc_Ltxt: Text;
        FixedTotalIncomeGL_gDec: Decimal;
        SingleRetainingGLAcc_gDec: Decimal;
        RetainedEarRun_gBln: Boolean;
        ClosingTxt: Text;
    // TempGLData_gRec: Record TempGLData;

    /*  procedure BufferGLEntry_lFnc("GEntry": Record "G/L Entry")
     var
         GLAccount_lRec: Record "G/L Account";
     begin
         clear(TempGLData_gRec);
         TempGLData_gRec.Init();
         TempGLData_gRec."G/L Account No." := "GEntry"."G/L Account No.";
         TempGLData_gRec."G/L Account Name" := "GEntry"."G/L Account Name";
         TempGLData_gRec."Location Code" := "GEntry"."Global Dimension 1 Code";
         TempGLData_gRec."Cost Center Code" := "GEntry"."Global Dimension 2 Code";
         TempGLData_gRec."Market Code" := "GEntry"."Shortcut Dimension 3 Code";
         GLAccount_lRec.Get("GEntry"."G/L Account No.");
         TempGLData_gRec."Income/Balance" := GLAccount_lRec."Income/Balance";
         TempGLData_gRec.Amount := "GEntry".Amount;
         TempGLData_gRec.Insert(true);
         Commit();
     end; */

    local procedure Fixed2024(Year_iInt: Integer): Decimal
    var
        GLAccount: Record "G/L Account";
        GLE: Record "G/L Entry";
        fixedflag: Boolean;
    begin
        if Year_iInt = 2024 then
            exit;

        GLE.Reset();
        GLE.SetFilter("G/L Account No.", GLAcc_Ltxt);
        GLE.SetRange("Posting Date", 20240101D, CalcDate('-1D', PrejanDate_gInt));
        if GLE.FindSet() then
            repeat
                FixedTotalIncomeGL_gDec += Round(GLE.Amount, 0.01);
            until GLE.Next() = 0;






        GLE.Reset();
        GLE.Setrange("G/L Account No.", '330706');
        GLE.SetRange("Posting Date", 20240101D, CalcDate('-1D', PrejanDate_gInt));
        GLE.CalcSums(Amount);
        SingleRetainingGLAcc_gDec := Round(GLE.Amount, 0.01);
        // if (FixedTotalIncomeGL_gDec + SingleRetainingGLAcc_gDec) <> 0 then
        //     exit(FixedTotalIncomeGL_gDec + FixedTotalIncomeGL_gDec)
        // else
        //     exit(0);
        // Message('Retained Earnings GL Amount is not available for the year %1..%2........%3..%4', 20240101D, CalcDate('-1D', PrejanDate_gInt), FixedTotalIncomeGL_gDec, singleRetainingGLAcc_gDec);
    end;
}