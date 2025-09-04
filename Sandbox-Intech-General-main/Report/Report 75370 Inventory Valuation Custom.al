report 75370 "Inventory Valuation Custom"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/InventoryValuation.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Inventory Valuation-';
    EnableHyperlinks = true;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("Inventory Posting Group") WHERE(Type = CONST(Inventory));
            RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group";
            column(BoM_Text; BoM_TextLbl)
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(STRSUBSTNO___1___2__Item_TABLECAPTION_ItemFilter_; StrSubstNo('%1: %2', TableCaption(), ItemFilter))
            {
            }
            column(STRSUBSTNO_Text005_StartDateText_; StrSubstNo(Text005, StartDateText))
            {
            }
            column(STRSUBSTNO_Text005_FORMAT_EndDate__; StrSubstNo(Text005, Format(EndDate)))
            {
            }
            column(ShowExpected; ShowExpected)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(Inventory_ValuationCaption; Inventory_ValuationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(This_report_includes_entries_that_have_been_posted_with_expected_costs_Caption; This_report_includes_entries_that_have_been_posted_with_expected_costs_CaptionLbl)
            {
            }
            column(ItemNoCaption; ValueEntry.FieldCaption("Item No."))
            {
            }
            column(ItemDescriptionCaption; FieldCaption(Description))
            {
            }
            column(IncreaseInvoicedQtyCaption; IncreaseInvoicedQtyCaptionLbl)
            {
            }
            column(DecreaseInvoicedQtyCaption; DecreaseInvoicedQtyCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(ValueCaption; ValueCaptionLbl)
            {
            }
            column(QuantityCaption_Control31; QuantityCaption_Control31Lbl)
            {
            }
            column(QuantityCaption_Control40; QuantityCaption_Control40Lbl)
            {
            }
            column(InvCostPostedToGL_Control53Caption; InvCostPostedToGL_Control53CaptionLbl)
            {
            }
            column(QuantityCaption_Control58; QuantityCaption_Control58Lbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Expected_Cost_IncludedCaption; Expected_Cost_IncludedCaptionLbl)
            {
            }
            column(Expected_Cost_Included_TotalCaption; Expected_Cost_Included_TotalCaptionLbl)
            {
            }
            column(Expected_Cost_TotalCaption; Expected_Cost_TotalCaptionLbl)
            {
            }
            column(GetUrlForReportDrilldown; GetUrlForReportDrilldown("No."))
            {
            }
            column(ItemNo; "No.")
            {
            }
            column(ItemDescription; Description)
            {
            }
            column(ItemBaseUnitofMeasure; "Base Unit of Measure")
            {
            }
            column(Item_Inventory_Posting_Group; "Inventory Posting Group")
            {
            }
            column(StartingInvoicedValue; StartingInvoicedValue)
            {
                AutoFormatType = 1;
            }
            column(StartingInvoicedQty; StartingInvoicedQty)
            {
                DecimalPlaces = 0 : 5;
            }
            column(StartingExpectedValue; StartingExpectedValue)
            {
                AutoFormatType = 1;
            }
            column(StartingExpectedQty; StartingExpectedQty)
            {
                DecimalPlaces = 0 : 5;
            }
            column(IncreaseInvoicedValue; IncreaseInvoicedValue)
            {
                AutoFormatType = 1;
            }
            column(IncreaseInvoicedQty; IncreaseInvoicedQty)
            {
                DecimalPlaces = 0 : 5;
            }
            column(IncreaseExpectedValue; IncreaseExpectedValue)
            {
                AutoFormatType = 1;
            }
            column(IncreaseExpectedQty; IncreaseExpectedQty)
            {
                DecimalPlaces = 0 : 5;
            }
            column(DecreaseInvoicedValue; DecreaseInvoicedValue)
            {
                AutoFormatType = 1;
            }
            column(DecreaseInvoicedQty; DecreaseInvoicedQty)
            {
                DecimalPlaces = 0 : 5;
            }
            column(DecreaseExpectedValue; DecreaseExpectedValue)
            {
                AutoFormatType = 1;
            }
            column(DecreaseExpectedQty; DecreaseExpectedQty)
            {
                DecimalPlaces = 0 : 5;
            }
            column(EndingInvoicedValue; StartingInvoicedValue + IncreaseInvoicedValue - DecreaseInvoicedValue)
            {
            }
            column(EndingInvoicedQty; StartingInvoicedQty + IncreaseInvoicedQty - DecreaseInvoicedQty)
            {
            }
            column(EndingExpectedValue; StartingExpectedValue + IncreaseExpectedValue - DecreaseExpectedValue)
            {
                AutoFormatType = 1;
            }
            column(EndingExpectedQty; StartingExpectedQty + IncreaseExpectedQty - DecreaseExpectedQty)
            {
            }
            column(CostPostedToGL; CostPostedToGL)
            {
                AutoFormatType = 1;
            }
            column(InvCostPostedToGL; InvCostPostedToGL)
            {
                AutoFormatType = 1;
            }
            column(ExpCostPostedToGL; ExpCostPostedToGL)
            {
                AutoFormatType = 1;
            }

            dataitem("Value Entry"; "Value Entry")
            {
                DataItemTableView = SORTING("Item No.", "Posting Date", "Item Ledger Entry Type");
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SETRANGE("Item No.", Item."No.");
                    SETFILTER("Variant Code", Item.GETFILTER("Variant Filter"));
                    SETFILTER("Location Code", Item.GETFILTER("Location Filter"));
                    SETFILTER("Global Dimension 1 Code", Item.GETFILTER("Global Dimension 1 Filter"));
                    SETFILTER("Global Dimension 2 Code", Item.GETFILTER("Global Dimension 2 Filter"));
                    IF EndDate <> 0D THEN
                        SETRANGE("Posting Date", 0D, EndDate);

                end;

                trigger OnPostDataItem()
                var
                    myInt: Integer;
                begin
                    //I-C0007-1301232-01-NS
                    IF PrinttoExcel_gBln THEN BEGIN
                        MakeExcelDataBody_gFnc;
                        //    SumInvPostingGroup_gFnc;
                    END;
                    //I-C0007-1301232-01-NE
                end;

            }



            trigger OnAfterGetRecord()
            var
                SkipItem: Boolean;
            begin
                SkipItem := false;
                OnBeforeOnAfterItemGetRecord(Item, SkipItem);
                if SkipItem then
                    CurrReport.Skip();

                CalculateItem(Item);
                //I-C0007-1301232-01-NS
                IF PrinttoExcel_gBln THEN BEGIN
                    // IF PreInvPostGroup_gCod <> '' THEN
                    //     IF PreInvPostGroup_gCod <> "Inventory Posting Group" THEN BEGIN
                    //         MakeExcelGroupFooter_gFnc;
                    //         ClearSubTotalField_gFnc;
                    //     END;
                    // PreInvPostGroup_gCod := "Inventory Posting Group";
                END;
                //I-C0007-1301232-01-NE
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                //I-C0007-1301232-01-NS
                IF PrinttoExcel_gBln THEN BEGIN
                    // MakeExcelGroupFooter_gFnc;
                    // MakeExcelTotalFooter_gFnc;
                END;
                //I-C0007-1301232-01-NE

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
                    field(StartingDate; StartDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the date from which the report or batch job processes information.';
                    }
                    field(EndingDate; EndDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Ending Date';
                        ToolTip = 'Specifies the date to which the report or batch job processes information.';
                    }
                    field(IncludeExpectedCost; ShowExpected)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Expected Cost';
                        ToolTip = 'Specifies if you want the report to also show entries that only have expected costs.';
                    }

                    field(PrinttoExcel_gBln; PrinttoExcel_gBln)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Export to Excel';
                        ToolTip = 'Specifies if you want the report to also show entries that only have expected costs.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if (StartDate = 0D) and (EndDate = 0D) then
                EndDate := WorkDate();
        end;
    }

    labels
    {
        Inventory_Posting_Group_NameCaption = 'Inventory Posting Group Name';
        Expected_CostCaption = 'Expected Cost';
    }

    trigger OnPreReport()
    begin
        if (StartDate = 0D) and (EndDate = 0D) then
            EndDate := WorkDate();

        if StartDate in [0D, 00000101D] then
            StartDateText := ''
        else
            StartDateText := Format(StartDate - 1);

        ItemFilter := Item.GetFilters();
        //I-C0007-1301232-01-NS
        IF PrinttoExcel_gBln THEN BEGIN
            MakeExcelInfo_gFnc;
            //  PreInvPostGroup_gCod := '';
        END;
        //I-C0007-1301232-01-NE
    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        //I-C0007-1301232-01-NS
        IF PrinttoExcel_gBln THEN;
        //   CreateExcelbook_gFnc;
        //I-C0007-1301232-01-NE
    end;

    var
        ValueEntry: Record "Value Entry";
        StartDate: Date;
        EndDate: Date;
        ShowExpected: Boolean;
        ItemFilter: Text;
        StartDateText: Text[10];
        StartingInvoicedValue: Decimal;
        StartingExpectedValue: Decimal;
        StartingInvoicedQty: Decimal;
        StartingExpectedQty: Decimal;
        IncreaseInvoicedValue: Decimal;
        IncreaseExpectedValue: Decimal;
        IncreaseInvoicedQty: Decimal;
        IncreaseExpectedQty: Decimal;
        DecreaseInvoicedValue: Decimal;
        DecreaseExpectedValue: Decimal;
        DecreaseInvoicedQty: Decimal;
        DecreaseExpectedQty: Decimal;

        Text005: Label 'As of %1';
        BoM_TextLbl: Label 'Base UoM';
        Inventory_ValuationCaptionLbl: Label 'Inventory Valuation';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        This_report_includes_entries_that_have_been_posted_with_expected_costs_CaptionLbl: Label 'This report includes entries that have been posted with expected costs.';
        IncreaseInvoicedQtyCaptionLbl: Label 'Increases (LCY)';
        DecreaseInvoicedQtyCaptionLbl: Label 'Decreases (LCY)';
        QuantityCaptionLbl: Label 'Quantity';
        ValueCaptionLbl: Label 'Value';
        QuantityCaption_Control31Lbl: Label 'Quantity';
        QuantityCaption_Control40Lbl: Label 'Quantity';
        InvCostPostedToGL_Control53CaptionLbl: Label 'Cost Posted to G/L';
        QuantityCaption_Control58Lbl: Label 'Quantity';
        TotalCaptionLbl: Label 'Total';
        Expected_Cost_Included_TotalCaptionLbl: Label 'Expected Cost Included Total';
        Expected_Cost_TotalCaptionLbl: Label 'Expected Cost Total';
        Expected_Cost_IncludedCaptionLbl: Label 'Expected Cost Included';
        InvCostPostedToGL: Decimal;
        CostPostedToGL: Decimal;
        ExpCostPostedToGL: Decimal;
        IsEmptyLine: Boolean;
        PrinttoExcel_gBln: Boolean;


        ExcelBuf_gRec: Record "Excel Buffer";
        Text000_gCtx: Label 'Data';
        Text001_gCtx: Label 'Company Name';

        Text002_gCtx: Label 'Report No.';
        Text003_gCtx: Label 'Report Name';
        Text004_gCtx: Label 'Inventory Valuation';
        Text005_gCtx: Label 'User ID';
        Text006_gCtx: Label 'Date';
        Text007_gCtx: Label 'Item Filter';
        Text008_gCtx: Label 'Increases (LCY)';
        Text009_gCtx: Label 'Decreases (LCY)';
        Text010_gCtx: Label 'Quantity';
        Text016_gCtx: Label 'Start Date';
        Text017_gCtx: Label 'End Date';
        Text015_gCtx: Label 'Actual';

        Text014_gCtx: Label 'Expected Cost Total';

        Text011_gCtx: Label 'Value';


        Text012_gCtx: Label 'Cost Posted to G/L';









    local procedure AssignAmounts(ValueEntry: Record "Value Entry"; var InvoicedValue: Decimal; var InvoicedQty: Decimal; var ExpectedValue: Decimal; var ExpectedQty: Decimal; Sign: Decimal)
    begin
        InvoicedValue += ValueEntry."Cost Amount (Actual)" * Sign;
        InvoicedQty += ValueEntry."Invoiced Quantity" * Sign;
        ExpectedValue += ValueEntry."Cost Amount (Expected)" * Sign;
        ExpectedQty += ValueEntry."Item Ledger Entry Quantity" * Sign;
    end;

    procedure CalculateItem(var Item: Record Item)
    var
        IsHandled: Boolean;
    begin
        Item.CalcFields("Assembly BOM");

        if EndDate = 0D then
            EndDate := DMY2Date(31, 12, 9999);

        StartingInvoicedValue := 0;
        StartingExpectedValue := 0;
        StartingInvoicedQty := 0;
        StartingExpectedQty := 0;
        IncreaseInvoicedValue := 0;
        IncreaseExpectedValue := 0;
        IncreaseInvoicedQty := 0;
        IncreaseExpectedQty := 0;
        DecreaseInvoicedValue := 0;
        DecreaseExpectedValue := 0;
        DecreaseInvoicedQty := 0;
        DecreaseExpectedQty := 0;
        InvCostPostedToGL := 0;
        CostPostedToGL := 0;
        ExpCostPostedToGL := 0;

        IsEmptyLine := true;
        ValueEntry.Reset();
        ValueEntry.SetRange("Item No.", Item."No.");
        ValueEntry.SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
        ValueEntry.SetFilter("Location Code", Item.GetFilter("Location Filter"));
        ValueEntry.SetFilter("Global Dimension 1 Code", Item.GetFilter("Global Dimension 1 Filter"));
        ValueEntry.SetFilter("Global Dimension 2 Code", Item.GetFilter("Global Dimension 2 Filter"));
        OnItemOnAfterGetRecordOnAfterValueEntrySetInitialFilters(ValueEntry, Item);

        if StartDate > 0D then begin
            ValueEntry.SetRange("Posting Date", 0D, CalcDate('<-1D>', StartDate));
            ValueEntry.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)", "Invoiced Quantity");
            AssignAmounts(ValueEntry, StartingInvoicedValue, StartingInvoicedQty, StartingExpectedValue, StartingExpectedQty, 1);
            IsEmptyLine := IsEmptyLine and ((StartingInvoicedValue = 0) and (StartingInvoicedQty = 0));
            if ShowExpected then
                IsEmptyLine := IsEmptyLine and ((StartingExpectedValue = 0) and (StartingExpectedQty = 0));
        end;

        ValueEntry.SetRange("Posting Date", StartDate, EndDate);
        ValueEntry.SetFilter(
            "Item Ledger Entry Type", '%1|%2|%3|%4',
            ValueEntry."Item Ledger Entry Type"::Purchase,
            ValueEntry."Item Ledger Entry Type"::"Positive Adjmt.",
            ValueEntry."Item Ledger Entry Type"::Output,
            ValueEntry."Item Ledger Entry Type"::"Assembly Output");
        ValueEntry.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)", "Invoiced Quantity");
        AssignAmounts(ValueEntry, IncreaseInvoicedValue, IncreaseInvoicedQty, IncreaseExpectedValue, IncreaseExpectedQty, 1);

        ValueEntry.SetRange("Posting Date", StartDate, EndDate);
        ValueEntry.SetFilter(
            "Item Ledger Entry Type", '%1|%2|%3|%4',
            ValueEntry."Item Ledger Entry Type"::Sale,
            ValueEntry."Item Ledger Entry Type"::"Negative Adjmt.",
            ValueEntry."Item Ledger Entry Type"::Consumption,
            ValueEntry."Item Ledger Entry Type"::"Assembly Consumption");
        ValueEntry.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)", "Invoiced Quantity");
        AssignAmounts(ValueEntry, DecreaseInvoicedValue, DecreaseInvoicedQty, DecreaseExpectedValue, DecreaseExpectedQty, -1);

        ValueEntry.SetRange("Posting Date", StartDate, EndDate);
        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Transfer);
        if ValueEntry.FindSet() then
            repeat
                if true in [ValueEntry."Valued Quantity" < 0, not GetOutboundItemEntry(ValueEntry."Item Ledger Entry No.")] then
                    AssignAmounts(ValueEntry, DecreaseInvoicedValue, DecreaseInvoicedQty, DecreaseExpectedValue, DecreaseExpectedQty, -1)
                else
                    AssignAmounts(ValueEntry, IncreaseInvoicedValue, IncreaseInvoicedQty, IncreaseExpectedValue, IncreaseExpectedQty, 1);
            until ValueEntry.Next() = 0;

        IsEmptyLine := IsEmptyLine and ((IncreaseInvoicedValue = 0) and (IncreaseInvoicedQty = 0));
        IsEmptyLine := IsEmptyLine and ((DecreaseInvoicedValue = 0) and (DecreaseInvoicedQty = 0));
        if ShowExpected then begin
            IsEmptyLine := IsEmptyLine and ((IncreaseExpectedValue = 0) and (IncreaseExpectedQty = 0));
            IsEmptyLine := IsEmptyLine and ((DecreaseExpectedValue = 0) and (DecreaseExpectedQty = 0));
        end;

        ValueEntry.SetRange("Posting Date", 0D, EndDate);
        ValueEntry.SetRange("Item Ledger Entry Type");
        ValueEntry.CalcSums("Cost Posted to G/L", "Expected Cost Posted to G/L");
        ExpCostPostedToGL += ValueEntry."Expected Cost Posted to G/L";
        InvCostPostedToGL += ValueEntry."Cost Posted to G/L";

        StartingExpectedValue += StartingInvoicedValue;
        IncreaseExpectedValue += IncreaseInvoicedValue;
        DecreaseExpectedValue += DecreaseInvoicedValue;
        CostPostedToGL := ExpCostPostedToGL + InvCostPostedToGL;

        IsHandled := false;
        OnAfterGetRecordItemOnBeforeSkipEmptyLine(Item, StartingInvoicedQty, IncreaseInvoicedQty, DecreaseInvoicedQty, IsHandled, IsEmptyLine);
        if not IsHandled then
            if IsEmptyLine then
                CurrReport.Skip();
    end;

    local procedure GetOutboundItemEntry(ItemLedgerEntryNo: Integer): Boolean
    var
        ItemApplnEntry: Record "Item Application Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemApplnEntry.SetCurrentKey("Item Ledger Entry No.");
        ItemApplnEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntryNo);
        if not ItemApplnEntry.FindFirst() then
            exit(true);

        ItemLedgEntry.SetRange("Item No.", Item."No.");
        ItemLedgEntry.SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
        ItemLedgEntry.SetFilter("Location Code", Item.GetFilter("Location Filter"));
        ItemLedgEntry.SetFilter("Global Dimension 1 Code", Item.GetFilter("Global Dimension 1 Filter"));
        ItemLedgEntry.SetFilter("Global Dimension 2 Code", Item.GetFilter("Global Dimension 2 Filter"));
        ItemLedgEntry."Entry No." := ItemApplnEntry."Outbound Item Entry No.";
        exit(ItemLedgEntry.IsEmpty());
    end;

    procedure SetStartDate(DateValue: Date)
    begin
        StartDate := DateValue;
    end;

    procedure SetEndDate(DateValue: Date)
    begin
        EndDate := DateValue;
    end;

    procedure InitializeRequest(NewStartDate: Date; NewEndDate: Date; NewShowExpected: Boolean)
    begin
        StartDate := NewStartDate;
        EndDate := NewEndDate;
        ShowExpected := NewShowExpected;
    end;

    local procedure GetUrlForReportDrilldown(ItemNumber: Code[20]): Text
    var
        ClientTypeManagement: Codeunit "Client Type Management";
    begin
        // Generates a URL to the report which sets tab "Item" and field "Field1" on the request page, such as
        // dynamicsnav://hostname:port/instance/company/runreport?report=5801<&Tenant=tenantId>&filter=Item.Field1:1100.
        // TODO
        // Eventually leverage parameters 5 and 6 of GETURL by adding ",Item,TRUE)" and
        // use filter Item.SETFILTER("No.",'=%1',ItemNumber);.
        exit(GetUrl(ClientTypeManagement.GetCurrentClientType(), CompanyName, OBJECTTYPE::Report, REPORT::"Invt. Valuation - Cost Spec.") +
          StrSubstNo('&filter=Item.Field1:%1', ItemNumber));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnAfterItemGetRecord(var Item: Record Item; var SkipItem: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetRecordItemOnBeforeSkipEmptyLine(var Item: Record Item; StartingInvoicedQty: Decimal; IncreaseInvoicedQty: Decimal; DecreaseInvoicedQty: Decimal; var IsHandled: Boolean; var IsEmptyLine: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnItemOnAfterGetRecordOnAfterValueEntrySetInitialFilters(var ValueEntry: Record "Value Entry"; Item: Record Item)
    begin
    end;


    procedure MakeExcelInfo_gFnc()
    var
        myInt: Integer;
    begin
        //I-C0007-1301232-01-NS
        ExcelBuf_gRec.SetUseInfoSheet;
        ExcelBuf_gRec.AddInfoColumn(FORMAT(Text001_gCtx), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.NewRow;
        ExcelBuf_gRec.AddInfoColumn(FORMAT(Text003_gCtx), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddInfoColumn(FORMAT(Text004_gCtx), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.NewRow;
        ExcelBuf_gRec.AddInfoColumn(FORMAT(Text002_gCtx), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddInfoColumn(REPORT::"Inventory Valuation", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.NewRow;
        ExcelBuf_gRec.AddInfoColumn(FORMAT(Text005_gCtx), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.NewRow;
        ExcelBuf_gRec.AddInfoColumn(FORMAT(Text006_gCtx), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.NewRow;
        ExcelBuf_gRec.AddInfoColumn(FORMAT(Text007_gCtx), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddInfoColumn(ItemFilter, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.NewRow;
        ExcelBuf_gRec.AddInfoColumn(FORMAT(Text016_gCtx), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddInfoColumn(FORMAT(StartDate), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.NewRow;
        ExcelBuf_gRec.AddInfoColumn(FORMAT(Text017_gCtx), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddInfoColumn(FORMAT(EndDate), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.NewRow;
        ExcelBuf_gRec.ClearNewRow;
        MakeExcelDataHeader_gFnc;
        //I-C0007-1301232-01-NE
    end;

    local procedure MakeExcelDataHeader_gFnc()
    begin
        //I-C0007-1301232-01-NS
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Text015_gCtx), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        IF ShowExpected THEN
            ExcelBuf_gRec.AddColumn(FORMAT(Text014_gCtx), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);


        ExcelBuf_gRec.NewRow;
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(STRSUBSTNO(Text005, StartDateText), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Text008_gCtx), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Text009_gCtx), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(STRSUBSTNO(Text005, FORMAT(EndDate)), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        IF ShowExpected THEN BEGIN
            ExcelBuf_gRec.AddColumn(STRSUBSTNO(Text005, StartDateText), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn(FORMAT(Text008_gCtx), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn(FORMAT(Text009_gCtx), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn(STRSUBSTNO(Text005, FORMAT(EndDate)), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        END;

        ExcelBuf_gRec.NewRow;
        ExcelBuf_gRec.AddColumn(FORMAT(Item.FIELDCAPTION("Inventory Posting Group")), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Item.FIELDCAPTION("No.")), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Item.FIELDCAPTION(Description)), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Item.FIELDCAPTION("Base Unit of Measure")), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Text010_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Text011_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Text010_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Text011_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Text010_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Text011_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Text010_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Text011_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(FORMAT(Text012_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
        IF ShowExpected THEN BEGIN
            ExcelBuf_gRec.AddColumn(FORMAT(Text010_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn(FORMAT(Text011_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn(FORMAT(Text010_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn(FORMAT(Text011_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn(FORMAT(Text010_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn(FORMAT(Text011_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn(FORMAT(Text010_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn(FORMAT(Text011_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
            ExcelBuf_gRec.AddColumn(FORMAT(Text012_gCtx), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf_gRec."Cell Type"::Text);
        END;
        //I-C0007-1301232-01-NE
    end;


    procedure MakeExcelDataBody_gFnc()
    begin
        //   StartingInvoicedQty, IncreaseInvoicedQty, DecreaseInvoicedQty
        // I-C0007-1301232-01-NS
        ExcelBuf_gRec.NewRow;
        ExcelBuf_gRec.AddColumn(Item."Inventory Posting Group", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(Item."No.", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(Item.Description + ' ' + Item."Description 2", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(Item."Base Unit of Measure", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf_gRec."Cell Type"::Text);
        ExcelBuf_gRec.AddColumn(StartingInvoicedQty, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        ExcelBuf_gRec.AddColumn(StartingInvoicedValue, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        ExcelBuf_gRec.AddColumn(IncreaseInvoicedQty, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        ExcelBuf_gRec.AddColumn(IncreaseInvoicedValue, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        ExcelBuf_gRec.AddColumn(DecreaseInvoicedQty, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        ExcelBuf_gRec.AddColumn(DecreaseInvoicedValue, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        ExcelBuf_gRec.AddColumn(StartingInvoicedQty + StartingInvoicedValue - IncreaseInvoicedQty, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        ExcelBuf_gRec.AddColumn(IncreaseInvoicedValue + DecreaseInvoicedQty - DecreaseInvoicedValue, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        ExcelBuf_gRec.AddColumn(InvCostPostedToGL, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        ///   IF ShowExpected THEN BEGIN
        // ExcelBuf_gRec.AddColumn(QtyOnHand, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        // ExcelBuf_gRec.AddColumn(ValueOfQtyOnHand, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        // ExcelBuf_gRec.AddColumn(RcdIncreases, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        // ExcelBuf_gRec.AddColumn(ValueOfRcdIncreases, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        // ExcelBuf_gRec.AddColumn(ShipDecreases, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        // ExcelBuf_gRec.AddColumn(CostOfShipDecreases, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        // ExcelBuf_gRec.AddColumn(QtyOnHand + RcdIncreases - ShipDecreases, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        // ExcelBuf_gRec.AddColumn(ValueOfQtyOnHand + ValueOfRcdIncreases - CostOfShipDecreases, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);
        // ExcelBuf_gRec.AddColumn(CostPostedToGL, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf_gRec."Cell Type"::Number);


    END;

    // MakeExcelGroupFooter_gFnc()
    // //I-C0007-1301232-01-NS
    // ExcelBuf_gRec.NewRow;
    // ExcelBuf_gRec.NewRow;
    // ExcelBuf_gRec.AddColumn(STRSUBSTNO(Text018_gCtx,PreInvPostGroup_gCod),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);

    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(SubValueOfInvoicedQty_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(SubValueOfInvIncreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(SubCostOfInvDecreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(SubValueEntryCostAmtAct_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn(SubInvCostPostedToGL_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // IF ShowExpected THEN BEGIN
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(SubValueOfQtyOnHand_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(SubValueOfRcdIncreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(SubCostOfShipDecreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(SubValueEntryCostAmtEx_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn(SubCostPostedToGL_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // END;
    // ExcelBuf_gRec.NewRow;
    // //I-C0007-1301232-01-NE

    // MakeExcelTotalFooter_gFnc()
    // //I-C0007-1301232-01-NS
    // ExcelBuf_gRec.NewRow;
    // ExcelBuf_gRec.NewRow;
    // ExcelBuf_gRec.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(FORMAT(Text013_gCtx),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);

    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(TotalValueOfInvoicedQty_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(TotalValueOfInvIncreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(TotalCostOfInvDecreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(TotalValueEntryCostAmtAct_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn(TotalInvCostPostedToGL_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // IF ShowExpected THEN BEGIN
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(TotalValueOfQtyOnHand_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(TotalValueOfRcdIncreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(TotalCostOfShipDecreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(TotalValueEntryCostAmtEx_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn(TotalCostPostedToGL_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // END;
    // //I-C0007-1301232-01-NE

    // CreateExcelbook_gFnc()
    // //I-C0007-1301232-01-NS
    // ExcelBuf_gRec.CreateBookAndOpenExcel('',Text000_gCtx,Text004_gCtx,COMPANYNAME,USERID);
    // ERROR('');
    // //I-C0007-1301232-01-NE

    // SumInvPostingGroup_gFnc()
    // //I-C0007-1301232-01-NS
    // SubValueOfInvoicedQty_gDec += ValueOfInvoicedQty;
    // SubValueOfInvIncreases_gDec += ValueOfInvIncreases;
    // SubCostOfInvDecreases_gDec += CostOfInvDecreases;
    // SubValueEntryCostAmtAct_gDec += (ValueOfInvoicedQty + ValueOfInvIncreases - CostOfInvDecreases);
    // SubInvCostPostedToGL_gDec += InvCostPostedToGL;
    // SubValueOfQtyOnHand_gDec += ValueOfQtyOnHand;
    // SubValueOfRcdIncreases_gDec += ValueOfRcdIncreases;
    // SubCostOfShipDecreases_gDec += CostOfShipDecreases;
    // SubValueEntryCostAmtEx_gDec += (ValueOfQtyOnHand + ValueOfRcdIncreases - CostOfShipDecreases);
    // SubCostPostedToGL_gDec += CostPostedToGL;

    // TotalValueOfInvoicedQty_gDec += ValueOfInvoicedQty;
    // TotalValueOfInvIncreases_gDec += ValueOfInvIncreases;
    // TotalCostOfInvDecreases_gDec += CostOfInvDecreases;
    // TotalValueEntryCostAmtAct_gDec += (ValueOfInvoicedQty + ValueOfInvIncreases - CostOfInvDecreases);
    // TotalInvCostPostedToGL_gDec += InvCostPostedToGL;
    // TotalValueOfQtyOnHand_gDec += ValueOfQtyOnHand;
    // TotalValueOfRcdIncreases_gDec += ValueOfRcdIncreases;
    // TotalCostOfShipDecreases_gDec += CostOfShipDecreases;
    // TotalValueEntryCostAmtEx_gDec += (ValueOfQtyOnHand + ValueOfRcdIncreases - CostOfShipDecreases);
    // TotalCostPostedToGL_gDec += CostPostedToGL;
    // //I-C0007-1301232-01-NE

    // ClearSubTotalField_gFnc()
    // //I-C0007-1301232-01-NS
    // SubValueOfInvoicedQty_gDec := 0;
    // SubValueOfInvIncreases_gDec := 0;
    // SubCostOfInvDecreases_gDec := 0;
    // SubValueEntryCostAmtAct_gDec := 0;
    // SubInvCostPostedToGL_gDec := 0;
    // SubValueOfQtyOnHand_gDec := 0;
    // SubValueOfRcdIncreases_gDec := 0;
    // SubCostOfShipDecreases_gDec := 0;
    // SubValueEntryCostAmtEx_gDec := 0;
    // SubCostPostedToGL_gDec := 0;
    // //I-C0007-1301232-01-NE

    // end;



    // MakeExcelDataBody_gFnc()
    // //I-C0007-1301232-01-NS
    // ExcelBuf_gRec.NewRow;
    // ExcelBuf_gRec.AddColumn(Item."Inventory Posting Group",FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(Item."No.",FALSE,'',FALSE,FALSE,FALSE,'@',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(Item.Description + ' ' + Item."Description 2" ,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(Item."Base Unit of Measure",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(InvoicedQty,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn(ValueOfInvoicedQty,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn(InvIncreases,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn(ValueOfInvIncreases,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn(InvDecreases,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn(CostOfInvDecreases,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn(InvoicedQty + InvIncreases - InvDecreases,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn(ValueOfInvoicedQty + ValueOfInvIncreases - CostOfInvDecreases,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn(InvCostPostedToGL,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // IF ShowExpected THEN BEGIN
    //   ExcelBuf_gRec.AddColumn(QtyOnHand,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn(ValueOfQtyOnHand,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn(RcdIncreases,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn(ValueOfRcdIncreases,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn(ShipDecreases,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn(CostOfShipDecreases,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn(QtyOnHand + RcdIncreases - ShipDecreases,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn(ValueOfQtyOnHand + ValueOfRcdIncreases - CostOfShipDecreases,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn(CostPostedToGL,FALSE,'',FALSE,FALSE,FALSE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // END;
    // //I-C0007-1301232-01-NE

    // MakeExcelGroupFooter_gFnc()
    // //I-C0007-1301232-01-NS
    // ExcelBuf_gRec.NewRow;
    // ExcelBuf_gRec.NewRow;
    // ExcelBuf_gRec.AddColumn(STRSUBSTNO(Text018_gCtx,PreInvPostGroup_gCod),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);

    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(SubValueOfInvoicedQty_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(SubValueOfInvIncreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(SubCostOfInvDecreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(SubValueEntryCostAmtAct_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn(SubInvCostPostedToGL_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // IF ShowExpected THEN BEGIN
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(SubValueOfQtyOnHand_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(SubValueOfRcdIncreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(SubCostOfShipDecreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(SubValueEntryCostAmtEx_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn(SubCostPostedToGL_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // END;
    // ExcelBuf_gRec.NewRow;
    // //I-C0007-1301232-01-NE

    // MakeExcelTotalFooter_gFnc()
    // //I-C0007-1301232-01-NS
    // ExcelBuf_gRec.NewRow;
    // ExcelBuf_gRec.NewRow;
    // ExcelBuf_gRec.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(FORMAT(Text013_gCtx),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);

    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(TotalValueOfInvoicedQty_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(TotalValueOfInvIncreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(TotalCostOfInvDecreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    // ExcelBuf_gRec.AddColumn(TotalValueEntryCostAmtAct_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // ExcelBuf_gRec.AddColumn(TotalInvCostPostedToGL_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // IF ShowExpected THEN BEGIN
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(TotalValueOfQtyOnHand_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(TotalValueOfRcdIncreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(TotalCostOfShipDecreases_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf_gRec."Cell Type"::Text);
    //   ExcelBuf_gRec.AddColumn(TotalValueEntryCostAmtEx_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    //   ExcelBuf_gRec.AddColumn(TotalCostPostedToGL_gDec,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf_gRec."Cell Type"::Number);
    // END;
    // //I-C0007-1301232-01-NE

    // CreateExcelbook_gFnc()
    // //I-C0007-1301232-01-NS
    // ExcelBuf_gRec.CreateBookAndOpenExcel('',Text000_gCtx,Text004_gCtx,COMPANYNAME,USERID);
    // ERROR('');
    // //I-C0007-1301232-01-NE

    // SumInvPostingGroup_gFnc()
    // //I-C0007-1301232-01-NS
    // SubValueOfInvoicedQty_gDec += ValueOfInvoicedQty;
    // SubValueOfInvIncreases_gDec += ValueOfInvIncreases;
    // SubCostOfInvDecreases_gDec += CostOfInvDecreases;
    // SubValueEntryCostAmtAct_gDec += (ValueOfInvoicedQty + ValueOfInvIncreases - CostOfInvDecreases);
    // SubInvCostPostedToGL_gDec += InvCostPostedToGL;
    // SubValueOfQtyOnHand_gDec += ValueOfQtyOnHand;
    // SubValueOfRcdIncreases_gDec += ValueOfRcdIncreases;
    // SubCostOfShipDecreases_gDec += CostOfShipDecreases;
    // SubValueEntryCostAmtEx_gDec += (ValueOfQtyOnHand + ValueOfRcdIncreases - CostOfShipDecreases);
    // SubCostPostedToGL_gDec += CostPostedToGL;

    // TotalValueOfInvoicedQty_gDec += ValueOfInvoicedQty;
    // TotalValueOfInvIncreases_gDec += ValueOfInvIncreases;
    // TotalCostOfInvDecreases_gDec += CostOfInvDecreases;
    // TotalValueEntryCostAmtAct_gDec += (ValueOfInvoicedQty + ValueOfInvIncreases - CostOfInvDecreases);
    // TotalInvCostPostedToGL_gDec += InvCostPostedToGL;
    // TotalValueOfQtyOnHand_gDec += ValueOfQtyOnHand;
    // TotalValueOfRcdIncreases_gDec += ValueOfRcdIncreases;
    // TotalCostOfShipDecreases_gDec += CostOfShipDecreases;
    // TotalValueEntryCostAmtEx_gDec += (ValueOfQtyOnHand + ValueOfRcdIncreases - CostOfShipDecreases);
    // TotalCostPostedToGL_gDec += CostPostedToGL;
    // //I-C0007-1301232-01-NE

    // ClearSubTotalField_gFnc()
    // //I-C0007-1301232-01-NS
    // SubValueOfInvoicedQty_gDec := 0;
    // SubValueOfInvIncreases_gDec := 0;
    // SubCostOfInvDecreases_gDec := 0;
    // SubValueEntryCostAmtAct_gDec := 0;
    // SubInvCostPostedToGL_gDec := 0;
    // SubValueOfQtyOnHand_gDec := 0;
    // SubValueOfRcdIncreases_gDec := 0;
    // SubCostOfShipDecreases_gDec := 0;
    // SubValueEntryCostAmtEx_gDec := 0;
    // SubCostPostedToGL_gDec := 0;
    // SubCostPostedToGL_gDec := 0;
    // //I-C0007-1301232-01-NE




}

