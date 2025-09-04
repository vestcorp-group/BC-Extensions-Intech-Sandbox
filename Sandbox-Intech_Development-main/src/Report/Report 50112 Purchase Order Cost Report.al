report 50112 "Purchase Order Cost Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Purchase Order Cost Report ISPl';
    Description = '48125';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.", "Document Date";
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Purchase Header";
                DataItemTableView = where("Document Type" = const(Order));
                trigger OnAfterGetRecord()
                begin
                    Curr_gInt += 1;
                    Win_gDlg.Update(2, Curr_gInt);


                    MakeExcelDataBody_lFnc();
                end;

                trigger OnPostDataItem()
                begin
                    Win_gDlg.Close();
                end;

                trigger OnPreDataItem()
                begin

                    Win_gDlg.Open('Total #1#############\Current #2##############');
                    Win_gDlg.Update(1, Count);
                end;
            }
            trigger OnPreDataItem()
            begin
                SetRange("Order Date", StartDate_gDte, EndDate_gDte);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                Clear(Remarks_gtxt);
                PurchCommentLine_gRec.Reset();
                PurchCommentLine_gRec.SetRange("Document Type", PurchCommentLine_gRec."Document Type"::Order);
                PurchCommentLine_gRec.SetRange("No.", "Purchase Header"."No.");
                if PurchCommentLine_gRec.FindSet() then
                    repeat
                        Remarks_gtxt += PurchCommentLine_gRec.Comment + ',';
                    until PurchCommentLine_gRec.Next() = 0;
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
        CompanyDisplayName := COMPANYPROPERTY.DisplayName();

        ExcelBuffer_gRecTmp.Reset();
        ExcelBuffer_gRecTmp.DeleteAll();

        MakeExcelDataInfo_lFnc();
    end;

    local procedure CreateExcelBook_lFnc()
    begin
        ExcelBuffer_gRecTmp.CreateNewBook('Purchase Order Cost Report');
        ExcelBuffer_gRecTmp.WriteSheet('Purchase Order Cost', CompanyName, UserId);
        ExcelBuffer_gRecTmp.SetFriendlyFilename('Purchase Order Cost');
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
        ExcelBuffer_gRecTmp.AddInfoColumn(Report::"Purchase Order Cost Report", false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text005), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text006), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(Today, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn('Filter', false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(CopyStr("Purchase Header".GetFilters, 1, 250), false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.ClearNewRow();
        MakeExcelDataHeader_lFnc();
    end;

    local procedure MakeExcelDataHeader_lFnc()
    begin
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn('Company', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Order Date', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Document No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Vendor No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Vendor Name', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Status', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Item No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Vendor Item Name', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Warehouse', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Base UOM', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Base UOM Qty.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Currency', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Unit Price', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Amt. Exc. VAT ', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Payment Terms', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Est. Payment Date-1', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Est. Payment Date-2', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Est. Payment Date-3', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Remarks', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
    end;

    local procedure MakeExcelDataBody_lFnc()
    begin
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn(CompanyDisplayName, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Header"."Order Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Header"."No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Header"."Buy-from Vendor No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Header"."Buy-from Vendor Name", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Header".Status, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Line"."No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Line".Description, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Line"."Location Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Line"."Base UOM", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Line".Quantity, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Header"."Currency Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Line"."Unit Price Base UOM", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Line"."Amount", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Header"."Payment Terms Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Header"."Est Payment Date 1", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Header"."Est Payment Date 2", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.AddColumn("Purchase Header"."Est Payment Date 3", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.AddColumn(CopyStr(Remarks_gtxt, 1, 250), false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);

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
        CompanyDisplayName: Text;
        PurchCommentLine_gRec: Record "Purch. Comment Line";
        Remarks_gtxt: Text;

}