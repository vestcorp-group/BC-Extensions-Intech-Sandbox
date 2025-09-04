Report 50133 "Item Ledger Export to Excel"
{

    //DefaultLayout = RDLC;
    ProcessingOnly = true;
    // RDLCLayout = './Layouts/Item Ledger Export to Excel.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Description = 'T50324';

    dataset
    {
        dataitem(Company; Company)
        {
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemTableView = sorting("Item No.");
                RequestFilterFields = "Item No.", "Posting Date", "Date Filter";

                trigger OnAfterGetRecord()
                var
                    DimensionSetEntry_lRec: Record "Dimension Set Entry";
                    ValueEntry_lRec: Record "value Entry";
                    CostAmt_gDec: Decimal;
                    ILE_lRec: record "Item Ledger Entry";
                    ToDt_lDte: Date;
                    Item: Record Item;
                begin
                    Curr_gIn += 1;
                    Window_gDlg.Update(2, Curr_gIn);

                    Clear(Item);
                    Item.ChangeCompany(Company.Name);
                    Item.Get("Item Ledger Entry"."Item No.");
                    Clear(InvPostingGrp_gCod);
                    InvPostingGrp_gCod := Item."Inventory Posting Group";
                    // "Item Ledger Entry".CalcFields("Item Description 1", "Item Description 2");
                    if FilterInvPostGrp_gTxt <> '' then begin
                        if not (InvPostingGrp_gCod in [FilterInvPostGrp_gTxt]) then
                            CurrReport.Skip();
                    end;

                    "Item Ledger Entry".CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)", "Sales Amount (Actual)");

                    GlobalDimension3Code := '';
                    GlobalDimension4Code := '';
                    GlobalDimension5Code := '';
                    GlobalDimension6Code := '';
                    GlobalDimension7Code := '';
                    GlobalDimension8Code := '';

                    Clear(DimensionSetEntry_lRec);
                    DimensionSetEntry_lRec.ChangeCompany(Company.Name);
                    if DimensionSetEntry_lRec.Get("Item Ledger Entry"."Dimension Set ID", GLSetup_gRec."Shortcut Dimension 3 Code") then
                        GlobalDimension3Code := DimensionSetEntry_lRec."Dimension Value Code";

                    Clear(DimensionSetEntry_lRec);
                    DimensionSetEntry_lRec.ChangeCompany(Company.Name);
                    if DimensionSetEntry_lRec.Get("Item Ledger Entry"."Dimension Set ID", GLSetup_gRec."Shortcut Dimension 4 Code") then
                        GlobalDimension4Code := DimensionSetEntry_lRec."Dimension Value Code";

                    Clear(DimensionSetEntry_lRec);
                    DimensionSetEntry_lRec.ChangeCompany(Company.Name);
                    if DimensionSetEntry_lRec.Get("Item Ledger Entry"."Dimension Set ID", GLSetup_gRec."Shortcut Dimension 5 Code") then
                        GlobalDimension5Code := DimensionSetEntry_lRec."Dimension Value Code";

                    Clear(DimensionSetEntry_lRec);
                    DimensionSetEntry_lRec.ChangeCompany(Company.Name);
                    if DimensionSetEntry_lRec.Get("Item Ledger Entry"."Dimension Set ID", GLSetup_gRec."Shortcut Dimension 6 Code") then
                        GlobalDimension6Code := DimensionSetEntry_lRec."Dimension Value Code";

                    Clear(DimensionSetEntry_lRec);
                    DimensionSetEntry_lRec.ChangeCompany(Company.Name);
                    if DimensionSetEntry_lRec.Get("Item Ledger Entry"."Dimension Set ID", GLSetup_gRec."Shortcut Dimension 7 Code") then
                        GlobalDimension7Code := DimensionSetEntry_lRec."Dimension Value Code";

                    Clear(DimensionSetEntry_lRec);
                    DimensionSetEntry_lRec.ChangeCompany(Company.Name);
                    if DimensionSetEntry_lRec.Get("Item Ledger Entry"."Dimension Set ID", GLSetup_gRec."Shortcut Dimension 8 Code") then
                        GlobalDimension8Code := DimensionSetEntry_lRec."Dimension Value Code";

                    RemainingCost_gDec := 0;
                    InboundQty_gDec := 0;
                    CostAmt_gDec := 0;
                    Clear(ILE_lRec);
                    ILE_lRec.ChangeCompany(Company.Name);
                    ILE_lRec.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                    ILE_lRec.SetFilter("Date Filter", '..%1', "Item Ledger Entry".GetRangeMax("Date Filter"));
                    //ILE_lRec.SetFilter("Inbound Quantity", '>%1', 0);
                    ILE_lRec.SetRange("Entry No.", "Item Ledger Entry"."Entry No.");
                    if ILE_lRec.FindSet() then begin
                        repeat
                            ILE_lRec.CalcFields("Inbound Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
                            //  CostAmt_gDec += ILE_lRec."Cost Amount (Actual)" + ILE_lRec."Cost Amount (Expected)";
                            InboundQty_gDec += ILE_lRec."Inbound Quantity";
                        until ILE_lRec.Next = 0;
                    end;

                    ValueEntry_lRec.Reset;
                    Clear(ValueEntry_lRec);
                    ValueEntry_lRec.ChangeCompany(Company.Name);
                    ValueEntry_lRec.SetCurrentkey("Item Ledger Entry No.", "Document No.", "Document Line No.");
                    ValueEntry_lRec.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                    ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    ValueEntry_lRec.SetFilter("Posting Date", '..%1', "Item Ledger Entry".GetRangeMax("Date Filter"));
                    ValueEntry_lRec.SetLoadFields("Cost Amount (Actual)", "Cost Amount (Expected)", "Item Ledger Entry Quantity");
                    if ValueEntry_lRec.FindSet then begin
                        ValueEntry_lRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
                        CostAmt_gDec := ValueEntry_lRec."Cost Amount (Actual)" + ValueEntry_lRec."Cost Amount (Expected)";
                    end;

                    if "Item Ledger Entry".Quantity <> 0 then
                        RemainingCost_gDec := (CostAmt_gDec / "Item Ledger Entry".Quantity) * InboundQty_gDec;

                    MakeExcelDataBody;
                end;

                trigger OnPreDataItem()
                begin
                    if "Item Ledger Entry".GetFilter("Date Filter") = '' then
                        Error('Please select the date filter');

                    //"Item Ledger Entry".SetRange("posting Date", FromDt_gDte, ToDate_gDte);
                    // "Item Ledger Entry".SetFilter("Remaining Quantity", '>%1', 0);
                    //"Item Ledger Entry".SetFilter("Inbound Quantity", '>%1', 0);
                    Window_gDlg.Update(1, "Item Ledger Entry".Count);
                end;
            }
            trigger OnPreDataItem()
            begin
                if CompanyNameG <> '' then
                    SetRange(Name, CompanyNameG)
                else
                    Setfilter(Name, '<>%1&<>%2&<>%3', 'Chemified FZ LLC', 'Chemiprime Impex Pvt Ltd - do not use (only for system purpose)', 'Chemiprime Impex Pvt Ltd');
            end;

            trigger OnAfterGetRecord()
            begin
                "Item Ledger Entry".ChangeCompany(Company.Name);
                Clear(GLSetup_gRec);
                GLSetup_gRec.ChangeCompany(Company.Name);
                GLSetup_gRec.Get();
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
                group(Option)
                {
                    Caption = 'Option';
                    field("Company Name"; CompanyNameG)
                    {
                        ApplicationArea = all;
                        TableRelation = Company;
                    }
                    field("Inventory Posting Grp Filter"; FilterInvPostGrp_gTxt)
                    {
                        ApplicationArea = All;
                        trigger OnLookup(var Text: text): Boolean
                        var
                            Inv_lRec: Record "Inventory Posting Group";
                            Inv: Page "Inventory Posting Groups";
                        begin
                            Clear(Inv);
                            Clear(Inv_lRec);
                            Inv.LookupMode(true);
                            Inv.Editable(false);
                            Inv.SetTableView(Inv_lRec);
                            if Inv.RunModal() = Action::LookupOK then begin
                                FilterInvPostGrp_gTxt := Inv.GetSelectionFilter();
                            end;
                        end;
                    }
                }
            }
        }
    }

    trigger OnPostReport()
    begin
        Window_gDlg.Close();
        CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        ItemFilter := "Item Ledger Entry".GetFilters;
        MakeExcelInfo;
        Window_gDlg.Open('Total Lines #1###########\Current Line #2##########');
    end;

    var
        PrintToExcel: Boolean;
        ExcelBuf: Record "Excel Buffer" temporary;
        Text011_gCtx: label 'Report No.';
        Text012_gCtx: label 'Report Name';
        Text013_gCtx: label 'User ID';
        Text014_gCtx: label 'Date';
        Text015_gCtx: label 'Item Ledger Entry Filter';
        Text016_gCtx: label 'Start Date';
        Text017_gCtx: label 'Item Ledger Export to Excel';
        Text018_gCtx: label 'End Date';
        Text019_gCtx: label 'Data';
        Text020_gCtx: label 'Include Expected Cost';
        Text010_gCtx: label 'Company Name';
        ItemFilter: Text[250];
        Item_Ledger_EntryCaptionLbl: label 'Item Ledger Entry';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        GLSetup_gRec: Record "General Ledger Setup";
        InboundQty_gDec, RemainingCost_gDec : Decimal;
        InvPostingGrp_gCod, GlobalDimension3Code, GlobalDimension4Code, GlobalDimension5Code, GlobalDimension6Code, GlobalDimension7Code, GlobalDimension8Code : code[20];
        FilterInvPostGrp_gTxt, CompanyNameG : Text;
        Window_gDlg: Dialog;
        Curr_gIn: Integer;
        GroupGRNDate_gDte: date;

    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(Format(Text010_gCtx), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text012_gCtx), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Format(Text017_gCtx), false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text011_gCtx), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Report::"Item Ledger Export to Excel", false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text013_gCtx), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text014_gCtx), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Today, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text015_gCtx), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(ItemFilter, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.AddColumn('Company', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Entry Type', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Document Type', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Document No.', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Item No.', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Filter', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Variant Code', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Item Description', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry".FieldCaption("Global Dimension 1 Code"), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry".FieldCaption("Global Dimension 2 Code"), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Analysis Date', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Location Code', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Unit of Measure Code', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Custom Lot No.', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Custom BOE No.', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Bill of Exit', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Supplier Batch No.', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Expiry Period', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Net Weight', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Gross Weight', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Invoiced Quantity', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Remaining Quantity', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Sales Amount (Actual)', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Cost Amount (Actual)', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Cost Amount (Expected)', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Cost Amount (Non-Invtbl.)', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Open', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Order Type', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('QC No.', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Posted QC No.', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('QC Relation Entry No."', false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Entry No.', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Group GRN Date', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Group GRN Date Custom', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Manufacturing Date', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Inbound Qty', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Remaining Cost', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(GLSetup_gRec."Shortcut Dimension 3 Code", false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(GLSetup_gRec."Shortcut Dimension 4 Code", false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(GLSetup_gRec."Shortcut Dimension 5 Code", false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(GLSetup_gRec."Shortcut Dimension 6 Code", false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(GLSetup_gRec."Shortcut Dimension 7 Code", false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(GLSetup_gRec."Shortcut Dimension 8 Code", false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        //ExcelBuf.NewRow;
    end;

    procedure MakeExcelDataBody()
    var
        ILE_lRec: Record "Item Ledger Entry";
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Company.Name, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Posting Date", false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        ExcelBuf.AddColumn(Format("Item Ledger Entry"."Entry Type"), false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Format("Item Ledger Entry"."Document Type"), false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Document No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Item No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(InvPostingGrp_gCod, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Variant Code", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry".Description, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Global Dimension 1 Code", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Global Dimension 2 Code", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Analysis Date", false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        ExcelBuf.AddColumn("Item Ledger Entry"."Location Code", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Unit of Measure Code", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry".Quantity, false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry".CustomLotNumber, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry".CustomBOENumber, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry".BillOfExit, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Supplier Batch No. 2", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(FORMAT("Item Ledger Entry"."Expiry Period 2"), false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Net Weight 2", false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Gross Weight 2", false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Invoiced Quantity", false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Remaining Quantity", false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Sales Amount (Actual)", false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Cost Amount (Actual)", false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Cost Amount (Expected)", false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn("Item Ledger Entry"."Cost Amount (Non-Invtbl.)", false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        if "Item Ledger Entry".Open then
            ExcelBuf.AddColumn('Yes', false, '', false, false, false, '', ExcelBuf."cell type"::Text)
        else
            ExcelBuf.AddColumn('No', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(FORMAT("Item Ledger Entry"."Order Type"), false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."QC No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Posted QC No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."QC Relation Entry No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Entry No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Item Ledger Entry"."Group GRN Date", false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        Clear(GroupGRNDate_gDte);
        Clear(ILE_lRec);
        ILE_lRec.ChangeCompany(Company.Name);
        ILE_lRec.SetCurrentKey("Item No.", "Group GRN Date");
        ILE_lRec.SetRange("Item No.", "Item Ledger Entry"."Item No.");
        ILE_lRec.SetRange(CustomLotNumber, "Item Ledger Entry".CustomLotNumber);
        ILE_lRec.SetFilter("Group GRN Date", '<>%1', 0D);
        if ILE_lRec.FindFirst() then
            GroupGRNDate_gDte := ILE_lRec."Group GRN Date";
        ExcelBuf.AddColumn(GroupGRNDate_gDte, false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        ExcelBuf.AddColumn("Item Ledger Entry"."Manufacturing Date 2", false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        ExcelBuf.AddColumn(InboundQty_gDec, false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn(RemainingCost_gDec, false, '', false, false, false, '#,##0.00', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn(GlobalDimension3Code, false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        ExcelBuf.AddColumn(GlobalDimension4Code, false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        ExcelBuf.AddColumn(GlobalDimension5Code, false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        ExcelBuf.AddColumn(GlobalDimension6Code, false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        ExcelBuf.AddColumn(GlobalDimension7Code, false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        ExcelBuf.AddColumn(GlobalDimension8Code, false, '', false, false, false, '', ExcelBuf."cell type"::Date);
    end;


    procedure CreateExcelbook()
    begin
        //I-A010_A-63000010-01-OS
        //I-A012_A-1000259-01 NS
        //ExcelBuf.CreateBook;
        //ExcelBuf.CreateSheet(Text019_gCtx,Text017_gCtx,COMPANYNAME,USERID);
        //ExcelBuf.GiveUserControl;
        //I-A012_A-1000259-01 NE
        //I-A010_A-63000010-01-OE
        //I-A010_A-63000010-01-NS
        ExcelBuf.CreateBookAndOpenExcel_gFnc('', Text019_gCtx, Text017_gCtx, COMPANYNAME, UserId);
        Error('');
        //I-A010_A-63000010-01-NE
    end;
}

