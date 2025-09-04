report 50121 "Inventory Opening Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Description = 'T49173';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = where("Remaining Quantity" = filter(> 0), Open = filter(true));
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                Curr_gInt += 1;
                Win_gDlg.Update(2, Curr_gInt);

                CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                MakeExcelDataBody_lFnc();
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                Win_gDlg.Close();
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                Win_gDlg.Open('Total #1#############\Current #2##############');
                Win_gDlg.Update(1, Count);
            end;


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
        ExcelBuffer_gRecTmp.CreateNewBook('Inventory Opening Detail');
        ExcelBuffer_gRecTmp.WriteSheet('Inventory Opening Detail', CompanyName, UserId);
        ExcelBuffer_gRecTmp.SetFriendlyFilename('Inventory Opening Detail');
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
        ExcelBuffer_gRecTmp.AddInfoColumn(Report::"Inventory Opening Report", false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text005), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text006), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(Today, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.ClearNewRow();
        MakeExcelDataHeader_lFnc();
    end;

    local procedure MakeExcelDataHeader_lFnc()
    begin
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn('Company :' + CompanyName, false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn('Item No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Variant Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Entry Type', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Document No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Location Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('UOM', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Unit Cost', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //   ExcelBuffer_gRecTmp.AddColumn('Cost Expected', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Total Amount', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Shortcut Dimension 1 Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Shortcut Dimension 2 Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Shortcut Dimension 3 Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Shortcut Dimension 4 Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Shortcut Dimension 5 Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Shortcut Dimension 6 Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Shortcut Dimension 7 Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Shortcut Dimension 8 Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Bin Code', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Serial No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Lot No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Manufacturing Date', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Document Date', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Gen. Bus. Posting Group', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Expiration Date', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Expiry Period', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Custom Lot No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Custom BOE No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Bill Of Exit', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Supplier Batch No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //  ExcelBuffer_gRecTmp.AddColumn('Open', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Group GRN Date', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
    end;

    local procedure MakeExcelDataBody_lFnc()
    begin
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Item No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Variant Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Posting Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Entry Type", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry".Description, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Location Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry".Quantity, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Remaining Quantity", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);//T49173
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Unit of Measure Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //T49173-NS-NB
        //  ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Cost Amount (Actual)", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        if ("Item Ledger Entry"."Cost Amount (Actual)" <> 0) AND ("Item Ledger Entry"."Cost Amount (Expected)" = 0) then
            ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Cost Amount (Actual)" / "Item Ledger Entry".Quantity, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number)
        else if ("Item Ledger Entry"."Cost Amount (Actual)" = 0) AND ("Item Ledger Entry"."Cost Amount (Expected)" <> 0) then
            ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Cost Amount (Expected)" / "Item Ledger Entry".Quantity, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number)
        else if ("Item Ledger Entry"."Cost Amount (Actual)" <> 0) AND ("Item Ledger Entry"."Cost Amount (Expected)" <> 0) then
            ExcelBuffer_gRecTmp.AddColumn(("Item Ledger Entry"."Cost Amount (Actual)" + "Item Ledger Entry"."Cost Amount (Expected)") / "Item Ledger Entry".Quantity, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number)
        else if ("Item Ledger Entry"."Cost Amount (Actual)" = 0) AND ("Item Ledger Entry"."Cost Amount (Expected)" = 0) then
            ExcelBuffer_gRecTmp.AddColumn(0, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);

        //T49173-NE-NB
        //  ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Cost Amount (Expected)", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        // ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry".Quantity * "Item Ledger Entry"."Cost Amount (Actual)", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        //T49173-NS-NB
        // if "Item Ledger Entry"."Cost Amount (Actual)" <> 0 then
        //     ExcelBuffer_gRecTmp.AddColumn(("Item Ledger Entry"."Cost Amount (Actual)" / "Item Ledger Entry".Quantity) * "Item Ledger Entry"."Remaining Quantity", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number)
        // else
        //     ExcelBuffer_gRecTmp.AddColumn(("Item Ledger Entry"."Cost Amount (Expected)" / "Item Ledger Entry".Quantity) * "Item Ledger Entry"."Remaining Quantity", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        if ("Item Ledger Entry"."Cost Amount (Actual)" <> 0) AND ("Item Ledger Entry"."Cost Amount (Expected)" = 0) then
            ExcelBuffer_gRecTmp.AddColumn(("Item Ledger Entry"."Cost Amount (Actual)" / "Item Ledger Entry".Quantity) * "Item Ledger Entry"."Remaining Quantity", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number)
        else if ("Item Ledger Entry"."Cost Amount (Actual)" = 0) AND ("Item Ledger Entry"."Cost Amount (Expected)" <> 0) then
            ExcelBuffer_gRecTmp.AddColumn(("Item Ledger Entry"."Cost Amount (Expected)" / "Item Ledger Entry".Quantity) * "Item Ledger Entry"."Remaining Quantity", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number)
        else if ("Item Ledger Entry"."Cost Amount (Actual)" <> 0) AND ("Item Ledger Entry"."Cost Amount (Expected)" <> 0) then
            ExcelBuffer_gRecTmp.AddColumn((("Item Ledger Entry"."Cost Amount (Actual)" + "Item Ledger Entry"."Cost Amount (Expected)") / "Item Ledger Entry".Quantity) * "Item Ledger Entry"."Remaining Quantity", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number)
        else if ("Item Ledger Entry"."Cost Amount (Actual)" = 0) AND ("Item Ledger Entry"."Cost Amount (Expected)" = 0) then
            ExcelBuffer_gRecTmp.AddColumn(0, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        //T49173-NE-NB
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        if "Item Ledger Entry"."Serial No." <> '' then
            ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Serial No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text)//T49173-Changed to Text-NB
        else
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);//T49173-Changed to Text-NB

        if "Item Ledger Entry"."Lot No." <> '' then
            ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Lot No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text)//T49173-Changed to Text - NB
        else
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);//T49173-Changed to Text-NB

        if "Item Ledger Entry"."Manufacturing Date 2" <> 0D then
            ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Manufacturing Date 2", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date)
        else
            ExcelBuffer_gRecTmp.AddColumn(0D, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Document Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Expiration Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Expiry Period 2", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry".CustomLotNumber, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);//T49173-Changed to Text-NB
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry".CustomBOENumber, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);//T49173-Changed to Text-NB
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry".BillOfExit, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Supplier Batch No. 2", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //  ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry".open, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Item Ledger Entry"."Group GRN Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);

    end;

    var
        ExcelBuffer_gRecTmp: Record "Excel Buffer";
        Win_gDlg: Dialog;
        Curr_gInt: Integer;
        Text002: label 'Company Name';
        Text003: label 'Report No.';
        Text005: label 'User ID';
        Text006: label 'Date';
}