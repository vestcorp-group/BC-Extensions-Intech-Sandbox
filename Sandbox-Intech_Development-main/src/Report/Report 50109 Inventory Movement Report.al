report 50109 "Inventory Movement Report"
{
    Caption = 'Inventory Movement Report(All Entities)';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Description = 'T47531';
    dataset
    {
        dataitem(Company; Company)
        {
            dataitem("Value Entry"; "Value Entry")
            {
                RequestFilterFields = "Item No.", "Location Code";

                trigger OnAfterGetRecord()
                begin
                    Opening := 0;
                    Purchase := 0;
                    Output := 0;
                    Positive := 0;
                    Nagative := 0;
                    TransferShpt := 0;
                    TransferRcpt := 0;
                    Sales := 0;
                    Closing := 0;
                    Consumption := 0;
                    PurchaseAmount := 0;
                    SalesAmount := 0;
                    //SalesCostAmount := 0;
                    OpeningAmount := 0;
                    ClosingAmount := 0;
                    ConsumptionAmount := 0;
                    OutputAmount := 0;
                    PositiveAmount := 0;
                    NagativeAmount := 0;
                    TransferRcptAmount := 0;
                    TransferShptAmount := 0;
                    PurchaseRtrn := 0;
                    PurchaseRtrnAmt := 0;
                    SalesRtrnQty := 0;
                    SalesRtrnAmt := 0;

                    if (ItemNo_gCod = "Value Entry"."Item No.") and ("Value Entry"."Location Code" = LocCode_gCod) and (Variant_gCod = "Value Entry"."Variant Code") then
                        CurrReport.Skip();

                    ItemNo_gCod := "Value Entry"."Item No.";
                    LocCode_gCod := "Value Entry"."Location Code";
                    Variant_gCod := "Value Entry"."Variant Code";

                    ValueEntry_GRec.Reset;
                    ValueEntry_GRec.ChangeCompany(Company.Name);
                    ValueEntry_GRec.SetRange("Item No.", "Value Entry"."Item No.");
                    ValueEntry_GRec.SetFilter("Location Code", "Value Entry"."Location Code");
                    ValueEntry_GRec.SetRange("Posting Date", StartDate_gDte, EndDate_gDte);
                    ValueEntry_GRec.SetRange("Variant Code", "Value Entry"."Variant Code");
                    ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."item ledger entry type"::Purchase);
                    ValueEntry_GRec.SetFilter("Document Type", '%1|%2', ValueEntry_GRec."Document Type"::"Purchase Invoice", ValueEntry_GRec."Document Type"::"Purchase Receipt");
                    ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
                    Purchase := ValueEntry_GRec."Item Ledger Entry Quantity";
                    PurchaseAmount := ValueEntry_GRec."Cost Amount (Actual)";
                    if InclExpCost_gBln then
                        PurchaseAmount += ValueEntry_GRec."Cost Amount (Expected)";

                    ValueEntry_GRec.SetFilter("Document Type", '%1|%2', ValueEntry_GRec."Document Type"::"Purchase Return Shipment", ValueEntry_GRec."Document Type"::"Purchase Credit Memo");
                    ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
                    PurchaseRtrn := ValueEntry_GRec."Item Ledger Entry Quantity";
                    PurchaseRtrnAmt := ValueEntry_GRec."Cost Amount (Actual)";
                    if InclExpCost_gBln then
                        PurchaseRtrnAmt += ValueEntry_GRec."Cost Amount (Expected)";


                    ValueEntry_GRec.Reset;
                    ValueEntry_GRec.ChangeCompany(Company.Name);
                    ValueEntry_GRec.SetRange("Item No.", "Value Entry"."Item No.");
                    ValueEntry_GRec.SetFilter("Location Code", "Value Entry"."Location Code");
                    ValueEntry_GRec.SetRange("Variant Code", "Value Entry"."Variant Code");
                    ValueEntry_GRec.SetRange("Posting Date");
                    ValueEntry_GRec.SetRange("Posting Date", StartDate_gDte, EndDate_gDte);
                    ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."item ledger entry type"::Sale);
                    ValueEntry_GRec.SetFilter("Document Type", '%1|%2', ValueEntry_GRec."Document Type"::"Sales Credit Memo", ValueEntry_GRec."Document Type"::"Sales Return Receipt");
                    //ValueEntry_GRec.SetFilter("Item Ledger Entry Quantity", '>%1', 0);    //ISPL-RV O
                    ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
                    SalesRtrnQty := ValueEntry_GRec."Item Ledger Entry Quantity";
                    SalesRtrnAmt := ValueEntry_GRec."Cost Amount (Actual)";
                    if InclExpCost_gBln then
                        SalesRtrnAmt += ValueEntry_GRec."Cost Amount (Expected)";
                    ValueEntry_GRec.SetRange("Item Ledger Entry Quantity");

                    ValueEntry_GRec.Reset;
                    ValueEntry_GRec.ChangeCompany(Company.Name);
                    ValueEntry_GRec.SetRange("Item No.", "Value Entry"."Item No.");
                    ValueEntry_GRec.SetFilter("Location Code", "Value Entry"."Location Code");
                    ValueEntry_GRec.SetRange("Variant Code", "Value Entry"."Variant Code");
                    ValueEntry_GRec.SetRange("Posting Date");
                    ValueEntry_GRec.SetRange("Posting Date", StartDate_gDte, EndDate_gDte);
                    ValueEntry_GRec.SetFilter("Item Ledger Entry Type", '%1|%2', ValueEntry_GRec."item ledger entry type"::Consumption, ValueEntry_GRec."item ledger entry type"::"Assembly Consumption");
                    ValueEntry_GRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
                    ConsumptionAmount := ValueEntry_GRec."Cost Amount (Actual)";
                    if InclExpCost_gBln then
                        ConsumptionAmount += ValueEntry_GRec."Cost Amount (Expected)";

                    ValueEntry_GRec.Reset;
                    ValueEntry_GRec.ChangeCompany(Company.Name);
                    ValueEntry_GRec.SetRange("Item No.", "Value Entry"."Item No.");
                    ValueEntry_GRec.SetFilter("Location Code", "Value Entry"."Location Code");
                    ValueEntry_GRec.SetRange("Variant Code", "Value Entry"."Variant Code");
                    ValueEntry_GRec.SetRange("Posting Date");
                    ValueEntry_GRec.SetRange("Posting Date", StartDate_gDte, EndDate_gDte);
                    ValueEntry_GRec.SetFilter("Item Ledger Entry Type", '%1|%2', ValueEntry_GRec."item ledger entry type"::Output, ValueEntry_GRec."item ledger entry type"::"Assembly Output");
                    ValueEntry_GRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
                    OutputAmount := ValueEntry_GRec."Cost Amount (Actual)";
                    if InclExpCost_gBln then
                        OutputAmount += ValueEntry_GRec."Cost Amount (Expected)";

                    ValueEntry_GRec.Reset;
                    ValueEntry_GRec.ChangeCompany(Company.Name);
                    ValueEntry_GRec.SetRange("Item No.", "Value Entry"."Item No.");
                    ValueEntry_GRec.SetFilter("Location Code", "Value Entry"."Location Code");
                    ValueEntry_GRec.SetRange("Variant Code", "Value Entry"."Variant Code");
                    ValueEntry_GRec.SetRange("Posting Date");
                    ValueEntry_GRec.SetRange("Posting Date", StartDate_gDte, EndDate_gDte);
                    ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."item ledger entry type"::Transfer);
                    ValueEntry_GRec.SetRange("Document Type", ValueEntry_GRec."Document Type"::"Transfer Shipment");
                    //ValueEntry_GRec.SetFilter("Item Ledger Entry Quantity", '<%1', 0);   //ISPL-RV O
                    ValueEntry_GRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
                    TransferShptAmount := ValueEntry_GRec."Cost Amount (Actual)";
                    if InclExpCost_gBln then
                        TransferShptAmount += ValueEntry_GRec."Cost Amount (Expected)";

                    ValueEntry_GRec.Reset;
                    ValueEntry_GRec.ChangeCompany(Company.Name);
                    ValueEntry_GRec.SetRange("Item No.", "Value Entry"."Item No.");
                    ValueEntry_GRec.SetFilter("Location Code", "Value Entry"."Location Code");
                    ValueEntry_GRec.SetRange("Variant Code", "Value Entry"."Variant Code");
                    ValueEntry_GRec.SetRange("Posting Date");
                    ValueEntry_GRec.SetRange("Posting Date", StartDate_gDte, EndDate_gDte);
                    ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."item ledger entry type"::Transfer);
                    ValueEntry_GRec.SetRange("Document Type", ValueEntry_GRec."Document Type"::"Transfer Receipt");
                    //ISPL-RV OValueEntry_GRec.SetFilter("Item Ledger Entry Quantity", '>%1', 0);  //ISPL-RV O
                    ValueEntry_GRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
                    TransferRcptAmount := ValueEntry_GRec."Cost Amount (Actual)";
                    if InclExpCost_gBln then
                        TransferRcptAmount += ValueEntry_GRec."Cost Amount (Expected)";

                    ValueEntry_GRec.Reset;
                    ValueEntry_GRec.ChangeCompany(Company.Name);
                    ValueEntry_GRec.SetRange("Item No.", "Value Entry"."Item No.");
                    ValueEntry_GRec.SetFilter("Location Code", "Value Entry"."Location Code");
                    ValueEntry_GRec.SetRange("Variant Code", "Value Entry"."Variant Code");
                    ValueEntry_GRec.SetRange("Posting Date");
                    ValueEntry_GRec.SetRange("Posting Date", StartDate_gDte, EndDate_gDte);
                    ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."item ledger entry type"::"Positive Adjmt.");
                    ValueEntry_GRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
                    PositiveAmount := ValueEntry_GRec."Cost Amount (Actual)";
                    if InclExpCost_gBln then
                        PositiveAmount += ValueEntry_GRec."Cost Amount (Expected)";

                    ValueEntry_GRec.Reset;
                    ValueEntry_GRec.ChangeCompany(Company.Name);
                    ValueEntry_GRec.SetRange("Item No.", "Value Entry"."Item No.");
                    ValueEntry_GRec.SetFilter("Location Code", "Value Entry"."Location Code");
                    ValueEntry_GRec.SetRange("Variant Code", "Value Entry"."Variant Code");
                    ValueEntry_GRec.SetRange("Posting Date");
                    ValueEntry_GRec.SetRange("Posting Date", StartDate_gDte, EndDate_gDte);
                    ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."item ledger entry type"::"Negative Adjmt.");
                    ValueEntry_GRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
                    NagativeAmount := ValueEntry_GRec."Cost Amount (Actual)";
                    if InclExpCost_gBln then
                        NagativeAmount += ValueEntry_GRec."Cost Amount (Expected)";

                    ValueEntry_GRec.Reset;
                    ValueEntry_GRec.ChangeCompany(Company.Name);
                    ValueEntry_GRec.SetRange("Item No.", "Value Entry"."Item No.");
                    ValueEntry_GRec.SetRange("Location Code", "Value Entry"."Location Code");
                    ValueEntry_GRec.SetRange("Variant Code", "Value Entry"."Variant Code");
                    ValueEntry_GRec.SetFilter("Posting Date", '<%1', StartDate_gDte);
                    ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
                    Opening := ValueEntry_GRec."Item Ledger Entry Quantity";
                    OpeningAmount := ValueEntry_GRec."Cost Amount (Actual)";
                    if InclExpCost_gBln then
                        OpeningAmount += ValueEntry_GRec."Cost Amount (Expected)";

                    ValueEntry_GRec.SetRange("Posting Date");
                    ValueEntry_GRec.SetRange("Posting Date", StartDate_gDte, EndDate_gDte);

                    ValueEntry_GRec.SetFilter("Item Ledger Entry Type", '%1|%2', ValueEntry_GRec."Item Ledger Entry Type"::Output, ValueEntry_GRec."Item Ledger Entry Type"::"Assembly Output");
                    ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity");
                    Output := ValueEntry_GRec."Item Ledger Entry Quantity";

                    ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."Item Ledger Entry Type"::"Positive Adjmt.");
                    ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity");
                    Positive := ValueEntry_GRec."Item Ledger Entry Quantity";

                    ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."Item Ledger Entry Type"::Sale);
                    ValueEntry_GRec.SetFilter("Document Type", '%1|%2', ValueEntry_GRec."Document Type"::"Sales Invoice", ValueEntry_GRec."Document Type"::"Sales Shipment");
                    ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
                    Sales := ValueEntry_GRec."Item Ledger Entry Quantity";
                    SalesAmount := ValueEntry_GRec."Cost Amount (Actual)";
                    if InclExpCost_gBln then
                        SalesAmount += ValueEntry_GRec."Cost Amount (Expected)";
                    ValueEntry_GRec.SetRange("Item Ledger Entry Quantity");

                    ValueEntry_GRec.SetRange("Document Type");
                    ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."Item Ledger Entry Type"::"Negative Adjmt.");
                    ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity");
                    Nagative := ValueEntry_GRec."Item Ledger Entry Quantity";

                    ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."Item Ledger Entry Type"::Transfer);
                    ValueEntry_GRec.SetRange("Document Type", ValueEntry_GRec."Document Type"::"Transfer Shipment");
                    ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
                    TransferShpt := ValueEntry_GRec."Item Ledger Entry Quantity";
                    TransferShptAmount := ValueEntry_GRec."Cost Amount (Actual)";
                    if InclExpCost_gBln then
                        TransferShptAmount += ValueEntry_GRec."Cost Amount (Expected)";

                    ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."Item Ledger Entry Type"::Transfer);
                    ValueEntry_GRec.SetRange("Document Type", ValueEntry_GRec."Document Type"::"Transfer Receipt");
                    ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
                    TransferRcpt := ValueEntry_GRec."Item Ledger Entry Quantity";
                    TransferRcptAmount := ValueEntry_GRec."Cost Amount (Actual)";
                    if InclExpCost_gBln then
                        TransferRcptAmount += ValueEntry_GRec."Cost Amount (Expected)";
                    //ValueEntry_GRec.SetRange("Item Ledger Entry Quantity");

                    ValueEntry_GRec.SetRange("Document Type");
                    ValueEntry_GRec.SetFilter("Item Ledger Entry Type", '%1|%2', ValueEntry_GRec."Item Ledger Entry Type"::Consumption, ValueEntry_GRec."Item Ledger Entry Type"::"Assembly Consumption");
                    ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity");
                    Consumption := ValueEntry_GRec."Item Ledger Entry Quantity";

                    TotalRcptQty := Purchase + Output + Positive + TransferRcpt + SalesRtrnQty;
                    TotalRcptAmt := PurchaseAmount + OutputAmount + PositiveAmount + TransferRcptAmount + SalesRtrnAmt;

                    TotalIssuedQty := Sales + Consumption + Nagative + TransferShpt + PurchaseRtrn;
                    TotalIssuedAmt := SalesAmount + ConsumptionAmount + NagativeAmount + TransferShptAmount + PurchaseRtrnAmt;

                    Closing := Opening + TotalIssuedQty + TotalRcptQty;
                    ClosingAmount := OpeningAmount + TotalIssuedAmt + TotalRcptAmt;

                    Curr_gInt += 1;
                    Win_gDlg.Update(2, Curr_gInt);

                    if not ((Opening = 0) and (OpeningAmount = 0) and
                    (Sales = 0) and (Consumption = 0) and (Nagative = 0) and (TransferShpt = 0) and (PurchaseRtrn = 0) and (TotalIssuedAmt = 0) and
                    (TotalRcptQty = 0) and (Purchase = 0) and (Output = 0) and (Positive = 0) and (TransferRcpt = 0) and (SalesRtrnQty = 0) and
                    (TotalRcptAmt = 0) and (PurchaseAmount = 0) and (OutputAmount = 0) and (PositiveAmount = 0) and (TransferRcptAmount = 0) and (SalesRtrnAmt = 0) and (Closing = 0) and (ClosingAmount = 0)) then
                        MakeExcelDataBody_lFnc();
                end;

                trigger OnPostDataItem()
                begin
                    Win_gDlg.Close();
                end;

                trigger OnPreDataItem()
                begin
                    SetCurrentKey("Item No.", "Location Code", "Variant Code");

                    if FilterLoc_gTxt <> '' then
                        SetFilter("Location Code", FilterLoc_gTxt)
                    else
                        SetFilter("Location Code", '<>%1', '');

                    SetFilter("Posting Date", '<=%1', EndDate_gDte);
                    Win_gDlg.Open('Total #1#############\Current #2##############');
                    Win_gDlg.Update(1, Count);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                "Value Entry".ChangeCompany(Company.Name);
            end;
        }
    }
    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Start Date"; StartDate_gDte)
                    {
                        ApplicationArea = Basic;
                    }
                    field("End Date"; EndDate_gDte)
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            if EndDate_gDte < StartDate_gDte then
                                Error('End date Greater than End Date');
                        end;
                    }
                    field(FilterLoc_gTxt; FilterLoc_gTxt)
                    {
                        ApplicationArea = All;
                        Caption = 'Location Filter';
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Loc_lPge: Page "Location List";
                            Loc_lRec: Record Location;
                        begin
                            Clear(Loc_lRec);
                            Clear(Loc_lPge);
                            Loc_lPge.LookupMode(true);
                            Loc_lPge.Editable(false);
                            Loc_lPge.SetTableView(Loc_lRec);
                            if Loc_lPge.RunModal() = Action::LookupOK then begin
                                FilterLoc_gTxt := Loc_lPge.GetSelectionFilter();
                            end;
                        end;
                    }
                    field(InclExpCost_gBln; InclExpCost_gBln)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Expected Cost';
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
        J: Integer;
        I: Integer;
        Opening: Decimal;
        Purchase, PurchaseRtrn, PurchaseRtrnAmt : Decimal;
        Sales: Decimal;
        Closing: Decimal;
        Positive: Decimal;
        Nagative: Decimal;
        Output: Decimal;
        Consumption: Decimal;
        TransferRcpt, TransferShpt, SalesRtrnQty, SalesRtrnAmt, TotalRcptQty, TotalRcptAmt, TotalIssuedQty, TotalIssuedAmt : Decimal;
        PurchaseAmount: Decimal;
        SalesAmount: Decimal;
        //SalesCostAmount: Decimal;
        OpeningAmount: Decimal;
        ClosingAmount: Decimal;
        PositiveAmount: Decimal;
        NagativeAmount: Decimal;
        OutputAmount: Decimal;
        ConsumptionAmount: Decimal;
        TransferRcptAmount, TransferShptAmount : Decimal;
        ItemLedger_GRec: Record "Item Ledger Entry";
        ValueEntry_GRec: Record "Value Entry";
        ItemNo_gCod, LocCode_gCod, Variant_gCod : Code[20];
        InclExpCost_gBln: Boolean;
        FilterLoc_gTxt: Text;

    local procedure MakeExcelDataInfo_lFnc()
    begin
        ExcelBuffer_gRecTmp.SetUseInfoSheet();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text002), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(COMPANYNAME, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text003), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(Report::"Inventory Movement Report", false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text005), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text006), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(Today, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn('Filter', false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(CopyStr("Value Entry".GetFilters, 1, 250), false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.ClearNewRow();
        MakeExcelDataHeader_lFnc();
    end;

    local procedure MakeExcelDataHeader_lFnc()
    begin
        // ExcelBuffer_gRecTmp.NewRow();
        // ExcelBuffer_gRecTmp.AddColumn('Company :' + CompanyName, false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        // ExcelBuffer_gRecTmp.NewRow();
        // ExcelBuffer_gRecTmp.AddColumn('Filters :' + Format(StartDate_gDte) + '..' + Format(EndDate_gDte), false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn('Entity', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Item No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Item Variant', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Location', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Item Category', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Inventory Posting Group', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Base UOM', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Op.Bal Qty', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Op.Bal Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Purchase Qty', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Purchase Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Output Qty', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Output Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Positive Adj. Qty', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Positive Adj. Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Transfer Receipt Qty', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Transfer Receipt Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Sales Return Qty', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Sales Return Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Total Receipts Qty', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Total Receipts Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);

        ExcelBuffer_gRecTmp.AddColumn('Sale Qty', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Sale Cost Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Consumption Qty', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Consumption Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Negative Adj. Qty', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Negative Adj. Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Transfer Shipment Qty', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Transfer Shipment Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Purchase Return Qty', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Purchase Return Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Total Issues Qty', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Total Issues Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Closing Balance Qty', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Closing Balance Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        // ExcelBuffer_gRecTmp.AddColumn('', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        // ExcelBuffer_gRecTmp.AddColumn('Sales Value', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
    end;

    local procedure MakeExcelDataBody_lFnc()
    var
        Item_lRec: Record Item;
    begin
        Clear(Item_lRec);
        if Item_lRec.get("Value Entry"."Item No.") then;
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn(Company.name , false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Value Entry"."Item No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Value Entry"."Variant Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Value Entry"."Location Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn(Item_lRec.Description, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn(Item_lRec."Item Category Code", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn(Item_lRec."Inventory Posting Group", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn(Item_lRec."Base Unit of Measure", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);

        ExcelBuffer_gRecTmp.AddColumn(Opening, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(OpeningAmount, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);

        ExcelBuffer_gRecTmp.AddColumn(Purchase, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(PurchaseAmount, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(Output, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(OutputAmount, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(Positive, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(PositiveAmount, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(TransferRcpt, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(TransferRcptAmount, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(SalesRtrnQty, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(SalesRtrnAmt, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(TotalRcptQty, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(TotalRcptAmt, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);

        ExcelBuffer_gRecTmp.AddColumn(Sales, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(SalesAmount, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(Consumption, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(ConsumptionAmount, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(Nagative, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(NagativeAmount, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(TransferShpt, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(TransferShptAmount, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(PurchaseRtrn, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(PurchaseRtrnAmt, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(TotalIssuedQty, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(TotalIssuedAmt, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);

        ExcelBuffer_gRecTmp.AddColumn(Closing, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(ClosingAmount, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        // ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        // ExcelBuffer_gRecTmp.AddColumn(SalesAmount, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
    end;

    local procedure CreateExcelBook_lFnc()
    begin
        ExcelBuffer_gRecTmp.CreateNewBook('Inventory Movement Report');
        ExcelBuffer_gRecTmp.WriteSheet('Inventory Movement Report', CompanyName, UserId);
        ExcelBuffer_gRecTmp.SetFriendlyFilename('Inventory Movement Report');
        ExcelBuffer_gRecTmp.CloseBook();
        ExcelBuffer_gRecTmp.OpenExcel();
        Error('');
    end;
}

