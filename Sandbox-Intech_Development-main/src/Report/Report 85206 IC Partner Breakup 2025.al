report 85206 "2025 IC Partner Breakup"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = '2025 IC Partner Breakup';
    Description = 'T52067';

    dataset
    {
        dataitem(Company; Company)
        {
            dataitem("G/L Entry"; "G/L Entry")
            {
#pragma warning disable AL0254
                DataItemTableView = sorting("G/L Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Source No.", "Posting Date", "VAT Reporting Date", "Source Currency Code");
                RequestFilterFields = "G/L Account No.";
#pragma warning restore AL0254
                trigger OnAfterGetRecord()
                begin
                    Curr_gInt += 1;
                    Win_gDlg.Update(2, Curr_gInt);

                    Clear(GLSetup_gRec);
                    GLSetup_gRec.ChangeCompany(Company.Name);
                    GLSetup_gRec.Get;

                    CustVenName_gTxt := '';
                    if "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Customer then begin
                        Customer_gRec.ChangeCompany(Company.Name);
                        //11-04-2025 Changes for IC Partner Breakup
                        Customer_gRec.Reset();
                        Customer_gRec.SetRange("IC Partner Code", "G/L Entry"."IC Partner Code");
                        if Customer_gRec.FindFirst() then
                            // if Customer_gRec.Get("G/L Entry"."Source No.") then //11-04-2025
                            CustVenName_gTxt := Customer_gRec.Name;
                    end else if "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Vendor then begin
                        Vendor_gRec.ChangeCompany(Company.Name);
                        if Vendor_gRec.Get("G/L Entry"."Source No.") then
                            CustVenName_gTxt := Vendor_gRec.Name;
                    End;

                    "G/L Entry".CalcFields("G/L Account Name");
                    Clear(LocationName_gTxt);
                    Clear(CostCenterName_gTxt);
                    Clear(MarketName_gTxt);
                    Clear(OpeningBalance_gDec);
                    Clear(DebitAmt_gDec);
                    Clear(CreditAmt_gDec);
                    Clear(ClosingBalance_gDec);
                    CalcFields("Shortcut Dimension 3 Code");
                    DimensionValue_gRec.Reset();
                    DimensionValue_gRec.ChangeCompany(Company.Name);
                    DimensionValue_gRec.SetRange("Dimension Code", GLSetup_gRec."Global Dimension 1 Code");
                    DimensionValue_gRec.SetRange(code, "G/L Entry"."Global Dimension 1 Code");
                    if DimensionValue_gRec.FindFirst() then
                        LocationName_gTxt := DimensionValue_gRec.Name;

                    DimensionValue_gRec.Reset();
                    DimensionValue_gRec.ChangeCompany(Company.Name);
                    DimensionValue_gRec.SetRange("Dimension Code", GLSetup_gRec."Global Dimension 2 Code");
                    DimensionValue_gRec.SetRange(code, "G/L Entry"."Global Dimension 2 Code");
                    if DimensionValue_gRec.FindFirst() then
                        CostCenterName_gTxt := DimensionValue_gRec.Name;
                    DimensionValue_gRec.Reset();
                    DimensionValue_gRec.ChangeCompany(Company.Name);
                    DimensionValue_gRec.SetRange("Dimension Code", GLSetup_gRec."Shortcut Dimension 3 Code");
                    DimensionValue_gRec.SetRange(code, "G/L Entry"."Shortcut Dimension 3 Code");
                    if DimensionValue_gRec.FindFirst() then
                        MarketName_gTxt := DimensionValue_gRec.Name;


                    if ConsText_gTxt <> "G/L Entry"."G/L Account No." + "G/L Entry"."Global Dimension 1 Code" + "G/L Entry"."Global Dimension 2 Code" + "G/L Entry"."Shortcut Dimension 3 Code" + "G/L Entry"."Source No." then begin
                        GLEntry_gRec.Reset();
                        GLEntry_gRec.ChangeCompany(Company.Name);
                        GLEntry_gRec.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                        GLEntry_gRec.SetRange("Posting Date", 0D, ClosingDate(StartDate_gDte - 1));
                        GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                        GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                        GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                        GLEntry_gRec.SetRange("Source No.", "G/L Entry"."Source No.");
                        GLEntry_gRec.CalcSums(Amount);
                        OpeningBalance_gDec := Round(GLEntry_gRec.Amount, 0.01);

                        GLEntry_gRec.Reset();
                        GLEntry_gRec.ChangeCompany(Company.Name);
                        GLEntry_gRec.SetRange("G/L Account No.", "G/L Entry"."G/L Account No.");
                        GLEntry_gRec.SetRange("Posting Date", StartDate_gDte, ClosingDate(EndDate_gDte));
                        GLEntry_gRec.SetRange("Global Dimension 1 Code", "G/L Entry"."Global Dimension 1 Code");
                        GLEntry_gRec.SetRange("Global Dimension 2 Code", "G/L Entry"."Global Dimension 2 Code");
                        GLEntry_gRec.SetRange("Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code");
                        GLEntry_gRec.SetRange("Source No.", "G/L Entry"."Source No.");
                        GLEntry_gRec.CalcSums("Debit Amount", "Credit Amount");
                        DebitAmt_gDec := Round(GLEntry_gRec."Debit Amount", 0.01);
                        CreditAmt_gDec := Round(GLEntry_gRec."Credit Amount", 0.01);

                        ClosingBalance_gDec := OpeningBalance_gDec + DebitAmt_gDec - CreditAmt_gDec;
                        MakeExcelDataBody_lFnc();
                    end;
                    ConsText_gTxt := "G/L Entry"."G/L Account No." + "G/L Entry"."Global Dimension 1 Code" + "G/L Entry"."Global Dimension 2 Code" + "G/L Entry"."Shortcut Dimension 3 Code" + "G/L Entry"."Source No.";



                end;

                trigger OnPreDataItem()
                var
                    GlAct_lRec: Record "G/L Account";
                    GlActPipe_lTxt: Text;
                begin

                    ConsText_gTxt := '';

                    //SetRange("Posting Date", StartDate_gDte, EndDate_gDte);
                    //NS 21042024 Nilesh Sir shared Code
                    GlActPipe_lTxt := '';
                    GlAct_lRec.RESET;
                    GlAct_lRec.SetRange("IC Partner Report Bre Act", TRUE);
                    IF GlAct_lRec.FindSet() Then begin
                        repeat
                            IF GlActPipe_lTxt = '' then
                                GlActPipe_lTxt := GlAct_lRec."No."
                            Else
                                GlActPipe_lTxt += '|' + GlAct_lRec."No.";

                        until GlAct_lRec.Next() = 0;
                    end;

                    IF GlActPipe_lTxt <> '' Then
                        SetFilter("G/L Account No.", GlActPipe_lTxt);
                    //NE 21042024 Nilesh Sir shared Code

                    Win_gDlg.Open('Total #1#############\Current #2##############');
                    Win_gDlg.Update(1, Count);
                end;

                trigger OnPostDataItem()
                begin
                    Win_gDlg.Close();
                end;
            }
            trigger OnPreDataItem()
            begin
                if CompanyNameG <> '' then
                    SetRange(Name, CompanyNameG)

            end;

            trigger OnAfterGetRecord()
            begin
                GLEntry_gRec.ChangeCompany(Company.Name);
                DimensionValue_gRec.ChangeCompany(Company.Name);
                GLSetup_gRec.ChangeCompany(Company.Name);
                "G/L Entry".ChangeCompany(Company.Name);
            end;
        }
    }

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
                    field("Company Name"; CompanyNameG)
                    {
                        ApplicationArea = all;
                        TableRelation = Company;
                    }
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

        MakeExcelDataInfo_lFnc();
    end;

    local procedure CreateExcelBook_lFnc()
    begin
        ExcelBuffer_gRecTmp.CreateNewBook('2025 IC Partner Breakup');
        ExcelBuffer_gRecTmp.WriteSheet('2025 IC Partner Breakup', CompanyName, UserId);
        ExcelBuffer_gRecTmp.SetFriendlyFilename('2025 IC Partner Breakup');
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
        ExcelBuffer_gRecTmp.AddInfoColumn(Report::"2025 IC Partner Breakup", false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
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
        ExcelBuffer_gRecTmp.AddColumn('IC Customer/Vendor Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('IC Customer/Vendor Name', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);

    end;

    local procedure MakeExcelDataBody_lFnc()
    begin
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn(Company.Name, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."G/L Account No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."G/L Account Name", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."Global Dimension 1 Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn(LocationName_gTxt, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."Global Dimension 2 Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn(CostCenterName_gTxt, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."Shortcut Dimension 3 Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn(MarketName_gTxt, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."G/L Account No." + '-' + "G/L Entry"."Global Dimension 1 Code" + '-' + "G/L Entry"."Global Dimension 2 Code" + '-' + "G/L Entry"."Shortcut Dimension 3 Code" + '-' + "G/L Entry"."Source No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn(OpeningBalance_gDec, false, '', false, false, false, '#,##0.00', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(DebitAmt_gDec, false, '', false, false, false, '#,##0.00', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(CreditAmt_gDec, false, '', false, false, false, '#,##0.00', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(DebitAmt_gDec - CreditAmt_gDec, false, '', false, false, false, '#,##0.00', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(ClosingBalance_gDec, false, '', false, false, false, '#,##0.00', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn("G/L Entry"."Source No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn(CustVenName_gTxt, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
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
        CustVenName_gTxt: Text;
        Customer_gRec: Record Customer;
        Vendor_gRec: Record Vendor;


}