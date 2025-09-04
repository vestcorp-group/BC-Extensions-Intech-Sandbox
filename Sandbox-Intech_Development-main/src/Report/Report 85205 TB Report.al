report 85205 "TB Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = '2024 TB Report';
    Description = 'T52067';

    dataset
    {
        dataitem(Company; Company)
        {
            dataitem("G/L Account"; "G/L Account")
            {
                DataItemTableView = sorting("No.");
                trigger OnAfterGetRecord()
                begin
                    Curr_gInt += 1;
                    Win_gDlg.Update(2, Curr_gInt);


                    GLEntry_gRec.Reset();
                    GLEntry_gRec.ChangeCompany(Company.Name);
                    GLEntry_gRec.SetRange("G/L Account No.", "G/L Account"."No.");
                    GLEntry_gRec.SetRange("Posting Date", 0D, ClosingDate(StartDate_gDte - 1));
                    GLEntry_gRec.CalcSums(Amount);
                    OpeningBalance_gDec := Round(GLEntry_gRec.Amount, 0.01);

                    GLEntry_gRec.Reset();
                    GLEntry_gRec.ChangeCompany(Company.Name);
                    GLEntry_gRec.SetRange("G/L Account No.", "G/L Account"."No.");
                    GLEntry_gRec.SetRange("Posting Date", StartDate_gDte, ClosingDate(EndDate_gDte));
                    GLEntry_gRec.CalcSums("Debit Amount", "Credit Amount");
                    DebitAmt_gDec := Round(GLEntry_gRec."Debit Amount", 0.01);
                    CreditAmt_gDec := Round(GLEntry_gRec."Credit Amount", 0.01);

                    ClosingBalance_gDec := OpeningBalance_gDec + DebitAmt_gDec - CreditAmt_gDec;
                    MakeExcelDataBody_lFnc();




                end;

                trigger OnPreDataItem()
                begin

                    //SetRange("Posting Date", StartDate_gDte, EndDate_gDte);

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
                "G/L Account".ChangeCompany(Company.Name);
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
        ExcelBuffer_gRecTmp.CreateNewBook('2024 TB Format');
        ExcelBuffer_gRecTmp.WriteSheet('2024 TB Format', CompanyName, UserId);
        ExcelBuffer_gRecTmp.SetFriendlyFilename('2024 TB Format');
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
        ExcelBuffer_gRecTmp.AddInfoColumn(Report::"TB Report", false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text005), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text006), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(Today, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn('Filter', false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(CopyStr("G/L Account".GetFilters, 1, 250), false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.ClearNewRow();
        MakeExcelDataHeader_lFnc();
    end;

    local procedure MakeExcelDataHeader_lFnc()
    begin
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn('Trail Balance', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn('Period :' + Format(StartDate_gDte) + '..' + Format(EndDate_gDte), false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn('Entity', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('GL No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('GL Name', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Opening Balance', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Debit', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Credit', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Net', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Closing Balance', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);

    end;

    local procedure MakeExcelDataBody_lFnc()
    begin
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn(Company.Name, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("G/L Account"."No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("G/L Account"."Name", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
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


}