Report 50101 "Inventory Aged Report_SA"
{
    Caption = 'Inventory Aged Report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Description = 'T47866';
    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Global Dimension 1 Code";
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = field("No.");
                DataItemLinkReference = Item;
                RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Document Type", "Item Category Code", "Lot No.", "Serial No.";
                trigger OnPreDataItem()
                begin
                    SetCurrentkey("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
                    SetRange("Item No.", Item."No.");
                    if AsOnDate_gDte = Today then
                        SetRange(Open, true)
                    else begin
                        SetFilter("Date Filter", '..%1', AsOnDate_gDte);
                        SetFilter(Quantity, '>%1', 0);
                    end;
                    Window_gDlg.Update(3, Count);
                    CurrILE_gInt := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    CurrILE_gInt += 1;
                    Window_gDlg.Update(4, CurrILE_gInt);
                    GetSQLData_lFnc;
                end;
            }
            trigger OnPreDataItem()
            begin
                Window_gDlg.Update(1, Count);
            end;

            trigger OnAfterGetRecord()
            begin
                TotalRowCount_gInt += 1;
                Window_gDlg.Update(2, TotalRowCount_gInt);
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
                    field("Previous As On Date"; PreviousAsOnDate_gDte)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Previous As On Date';
                    }
                    field("From Date"; AsOnDate_gDte)
                    {
                        ApplicationArea = Basic;
                        Caption = 'As On Date';
                    }
                    // field("Item No."; ItemNoFilter_gCod)
                    // {
                    //     ApplicationArea = Basic;
                    //     Caption = 'Item No.';
                    //     TableRelation = Item;
                    // }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if AsOnDate_gDte = 0D then
            Error('Enter Date');

        Report.RunModal(Report::"ILE Application Found", false);
        Report.RunModal(Report::"ILE Origin Found", false);

        Commit;

        MakeExcelInfo_gFnc;
        Window_gDlg.Open(Text50000 + Text50002 + '\Current Item #2################\Item Ledger Entries #3################\Current ILE #4################Start At #5###############');
    end;

    trigger OnPostReport()
    begin
        Window_gDlg.Close;
        CreateExcelBook_gFnc;
    end;

    var
        Window_gDlg: Dialog;
        TotalRowCount_gInt: Integer;
        Text50000: label 'Getting Detail...\';
        //Text50001: label 'Connecting Database  
        Text50002: label 'Total Items          #1##################';
        CurrILE_gInt: Integer;
        AsOnDate_gDte, PreviousAsOnDate_gDte : Date;
        ItemNoFilter_gCod: Code[20];
        ExcelBuf_gRecTmp: Record "Excel Buffer" temporary;
        Text50003: label 'Export Data.....\';
        Text001: label 'Company Name';
        Text003: label 'Report ID';
        Text004: label 'User ID';
        Text005: label 'Date';
        Text006: label 'Report Name';
        Text007: label 'Inventory Aged Report';
        Text008: label 'Data';
        BlankString_gCtx: label '|''''';
        ldoc_gcode: Code[20];
        ldocdate_gdate: Date;
        UnitCost_gdec: Decimal;
        Purchase, PurchaseRtrn, PurchaseRtrnAmt, PurchaseDirectAmount, PurchaseDirect : Decimal;
        Sales: Decimal;
        Positive: Decimal;
        Nagative: Decimal;
        Output: Decimal;
        Consumption: Decimal;
        TransferRcpt, TransferShpt, SalesRtrnQty, SalesRtrnAmt, TotalRcptQty, TotalRcptAmt, TotalIssuedQty, TotalIssuedAmt : Decimal;
        PurchaseAmount: Decimal;
        SalesAmount: Decimal;
        PositiveAmount: Decimal;
        NagativeAmount: Decimal;
        OutputAmount: Decimal;
        ConsumptionAmount: Decimal;
        TransferRcptAmount, TransferShptAmount : Decimal;

    local procedure GetSQLData_lFnc()
    var
        AppQty_lDec, PrevAppQty_lDec : Decimal;
        CalCostAmt_lDec, PrevCalCostAmt_lDec : Decimal;
        ValueEntry_lRec: Record "Value Entry";
        ILE_lRec: Record "Item Ledger Entry";
    begin
        Window_gDlg.Update(5, CurrentDatetime);
        //Window_gDlg.Update(1, 'Done');

        CalCostAmt_lDec := 0;
        if AsOnDate_gDte = Today then begin
            AppQty_lDec := "Item Ledger Entry"."Remaining Quantity";
            "Item Ledger Entry".CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
            CalCostAmt_lDec := "Item Ledger Entry"."Cost Amount (Actual)" + "Item Ledger Entry"."Cost Amount (Expected)";
        end else begin
            "Item Ledger Entry".CalcFields("Inbound Quantity");
            AppQty_lDec := "Item Ledger Entry"."Inbound Quantity";
            ValueEntry_lRec.Reset;
            ValueEntry_lRec.SetCurrentkey("Item Ledger Entry No.", "Document No.", "Document Line No.");
            ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
            ValueEntry_lRec.SetFilter("Posting Date", '..%1', AsOnDate_gDte);
            if ValueEntry_lRec.FindSet then begin
                ValueEntry_lRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
                //repeat
                CalCostAmt_lDec += ValueEntry_lRec."Cost Amount (Actual)" + ValueEntry_lRec."Cost Amount (Expected)";
                //until ValueEntry_lRec.Next = 0;
            end;
        end;

        Clear(ILE_lRec);
        ILE_lRec.SetRange("Entry No.", "Item Ledger Entry"."Entry No.");
        ILE_lRec.SetFilter("Date Filter", '..%1', PreviousAsOnDate_gDte);
        if ILE_lRec.FindFirst() then begin
            ILE_lRec.CalcFields("Inbound Quantity");
            PrevAppQty_lDec := ILE_lRec."Inbound Quantity";
            ValueEntry_lRec.Reset;
            ValueEntry_lRec.SetCurrentkey("Item Ledger Entry No.", "Document No.", "Document Line No.");
            ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
            ValueEntry_lRec.SetFilter("Posting Date", '..%1', PreviousAsOnDate_gDte);
            if ValueEntry_lRec.FindSet then begin
                ValueEntry_lRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
                PrevCalCostAmt_lDec += ValueEntry_lRec."Cost Amount (Actual)" + ValueEntry_lRec."Cost Amount (Expected)";
            end;
        end;
        MakeExcelDataBody_gFnc("Item Ledger Entry", AppQty_lDec, CalCostAmt_lDec, PrevAppQty_lDec, PrevCalCostAmt_lDec);
    end;

    procedure MakeExcelInfo_gFnc()
    begin
        ExcelBuf_gRecTmp.SetUseInfoSheet;
        ExcelBuf_gRecTmp.AddInfoColumn(Format(Text001), false, true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddInfoColumn(COMPANYNAME, false, false, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddInfoColumn(Format(Text006), false, true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddInfoColumn(Format(Text007), false, false, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddInfoColumn(Format(Text003), false, true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddInfoColumn(Report::"Inventory Aged Report_SA", false, false, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddInfoColumn(Format(Text004), false, true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddInfoColumn(Format(Text005), false, true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddInfoColumn(Today, false, false, false, false, '', ExcelBuf_gRecTmp."cell type"::Date);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddInfoColumn('As on Date', false, true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddInfoColumn(AsOnDate_gDte, false, false, false, false, '', ExcelBuf_gRecTmp."cell type"::Date);
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.ClearNewRow;
        MakeExcelDataHeader_gFnc;
    end;

    procedure MakeExcelDataHeader_gFnc()
    var
        IJ_lRec: Record "Item Journal Line";
    begin
        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn('Entry No.', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Location Code', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Posting Date', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Entry Type', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Document Type', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Document No.', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Document Date', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Item No.', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Description', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Inventory Posting Group', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn(IJ_lRec.FieldCaption("Shortcut Dimension 1 Code"), false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn(IJ_lRec.FieldCaption("Shortcut Dimension 2 Code"), false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Variant Code', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Serial No.', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Lot No.', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('External Document No', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Item Category', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        //ExcelBuf_gRecTmp.AddColumn('Product Group Code', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Quantity', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Remaining Quantity (As on Today)', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Remaining Quantity (As on Date)', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Cost Amount', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Remaining Cost Amount', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        //T45701-NS
        ExcelBuf_gRecTmp.AddColumn('Average Rate', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Inv Valuation', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        //T45701-NE
        ExcelBuf_gRecTmp.AddColumn('Applied ILE No.', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Applied Doc. No.', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Applied Entry Type', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Applied Document Date ', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Diff Date', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('0-60 [Previous]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('0-60 [Current]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('61-120 [Previous]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('61-120 [Current]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('121-180 [Previous]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('121-180 [Current]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('181-360 [Previous]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('181-360 [Current]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('361-9999 [Previous]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('361-9999 [Current]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('0-60 Qty [Previous]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('0-60 Qty [Current]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('61-120 Qty [Previous]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('61-120 Qty [Current]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('121-180 Qty [Previous]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('121-180 Qty [Current]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('181-360 Qty [Previous]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('181-360 Qty [Current]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('361-9999 Qty [Previous]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('361-9999 Qty [Current]', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Purchase Qty', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Purchase Value', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Purchase Direct Qty', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Purchase Direct Cost Value', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Output Qty', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Output Value', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Positive Adj. Qty', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Positive Adj. Value', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Transfer Receipt Qty', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Transfer Receipt Value', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Sales Return Qty', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Sales Return Value', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        // ExcelBuf_gRecTmp.AddColumn('Total Receipts Qty', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        // ExcelBuf_gRecTmp.AddColumn('Total Receipts Value', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);

        ExcelBuf_gRecTmp.AddColumn('Sale Qty', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Sale Cost Value', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Consumption Qty', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Consumption Value', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Negative Adj. Qty', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Negative Adj. Value', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Transfer Shipment Qty', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Transfer Shipment Value', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Purchase Return Qty', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn('Purchase Return Value', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        // ExcelBuf_gRecTmp.AddColumn('Total Issues Qty', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        // ExcelBuf_gRecTmp.AddColumn('Total Issues Value', false, '', true, false, true, '', ExcelBuf_gRecTmp."cell type"::Text);
        // ExcelBuf_gRecTmp.AddColumn('Last Transaction Document', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        // ExcelBuf_gRecTmp.AddColumn('Last Transaction Date', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
        // ExcelBuf_gRecTmp.AddColumn('New Value', false, '', true, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);
    end;

    procedure MakeExcelDataBody_gFnc(ILE_iRec: Record "Item Ledger Entry"; AppQty_iDec: Decimal; CostAmt_iDec: Decimal; PrevAppQty_iDec: Decimal; PrevCostAmt_iDec: Decimal)
    var
        EntryNo_lInt: Integer;
        PostingDate_lDte: Date;
        OnlyQty_lDec: Decimal;
        ApplQty_lDec, PrevApplQty_lDec : Decimal;
        CostAmt_lDec, PrevCostAmt_lDec : Decimal;
        AppliedILE_lRec: Record "Item Ledger Entry";
        DocDate_lDte: Date;
        ILEOriginDetail_lRec: Record "ILE Origin Detail";
        ILECnt_lInt: Integer;
        OriginDocDate_lDate: Date;
        RemCost_lDec, PrevRemCost_lDec : Decimal;
        AgeDays_lInt, PrevAgeDays_lInt : Integer;
        TotalRemQty_lDec, PrevTotalRemQty_lDec : Decimal;
        AppliedRemQty_lDec, PrevAppliedRemQty_lDec : Decimal;
        Item_lRec: Record Item;
        InvPostGrp_lCod: Code[20];
        AgeCat1_lDec, PrevAgeCat1_lDec : Decimal;
        AgeCat2_lDec, PrevAgeCat2_lDec : Decimal;
        AgeCat3_lDec, PrevAgeCat3_lDec : Decimal;
        AgeCat4_lDec, PrevAgeCat4_lDec : Decimal;
        AgeCat5_lDec, PrevAgeCat5_lDec : Decimal;
        AgeCat1Qty_lDec, PrevAgeCat1Qty_lDec : Decimal;
        AgeCat2Qty_lDec, PrevAgeCat2Qty_lDec : Decimal;
        AgeCat3Qty_lDec, PrevAgeCat3Qty_lDec : Decimal;
        AgeCat4Qty_lDec, PrevAgeCat4Qty_lDec : Decimal;
        AgeCat5Qty_lDec, PrevAgeCat5Qty_lDec : Decimal;
        CalAgeCost_lDec, PrevCalAgeCost_lDec : Decimal;
        RemQty_lDec, PrevRemQty_lDec : Decimal;
        LastILE_lRec: Record "Item Ledger Entry";

        ValueEntry_lRec: Record "Value Entry";
        ActualAmount_lDec, PrevActualAmount_lDec : Decimal;
        ExpAmount_lDec: Decimal;
        TotalAmount_lDec, PrevTotalAmount_lDec : Decimal;
        ILEQty_lDec, PrevILEQty_lDec : Decimal;
        ItemNo_lTxt: Text;
    begin
        if (AppQty_iDec <= 0) AND (PrevAppQty_iDec <= 0) then
            exit;

        // Opening := 0;
        Purchase := 0;
        Output := 0;
        Positive := 0;
        Nagative := 0;
        TransferShpt := 0;
        TransferRcpt := 0;
        Sales := 0;
        purchaseDirect := 0;
        PurchaseDirectAmount := 0;
        // Closing := 0;
        Consumption := 0;
        PurchaseAmount := 0;
        SalesAmount := 0;
        //SalesCostAmount := 0;
        // OpeningAmount := 0;
        // ClosingAmount := 0;
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
        GetInvMoved_lFnc(ILE_iRec);

        RemCost_lDec := 0;
        ApplQty_lDec := 0;
        TotalRemQty_lDec := 0;
        AgeCat1_lDec := 0;
        AgeCat2_lDec := 0;
        AgeCat3_lDec := 0;
        AgeCat4_lDec := 0;
        AgeCat5_lDec := 0;
        AgeCat1Qty_lDec := 0;
        AgeCat2Qty_lDec := 0;
        AgeCat3Qty_lDec := 0;
        AgeCat4Qty_lDec := 0;
        AgeCat5Qty_lDec := 0;
        PrevAgeCat1_lDec := 0;
        PrevAgeCat2_lDec := 0;
        PrevAgeCat3_lDec := 0;
        PrevAgeCat4_lDec := 0;
        PrevAgeCat5_lDec := 0;
        PrevAgeCat1Qty_lDec := 0;
        PrevAgeCat2Qty_lDec := 0;
        PrevAgeCat3Qty_lDec := 0;
        PrevAgeCat4Qty_lDec := 0;
        PrevAgeCat5Qty_lDec := 0;
        AgeDays_lInt := 0;
        PrevAgeDays_lInt := 0;

        EntryNo_lInt := ILE_iRec."Entry No.";
        UnitCost_gdec := 0;

        PostingDate_lDte := ILE_iRec."Posting Date";
        OnlyQty_lDec := ILE_iRec.Quantity;



        RemQty_lDec := ILE_iRec."Remaining Quantity";
        ApplQty_lDec := AppQty_iDec;
        CostAmt_lDec := CostAmt_iDec;
        PrevApplQty_lDec := PrevAppQty_iDec;
        PrevCostAmt_lDec := PrevCostAmt_iDec;

        if OnlyQty_lDec <> 0 then
            UnitCost_gdec := CostAmt_iDec / OnlyQty_lDec
        else begin
            UnitCost_gdec := 0;
        end;


        Item_lRec.Get(ILE_iRec."Item No.");
        InvPostGrp_lCod := Item_lRec."Inventory Posting Group";

        ExcelBuf_gRecTmp.NewRow;
        ExcelBuf_gRecTmp.AddColumn(EntryNo_lInt, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Number);  //Entry No.
        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Location Code", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);  //Location Code
        ExcelBuf_gRecTmp.AddColumn(PostingDate_lDte, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Date);                  //Posting Date
        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Entry Type", false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);         //Entry Type

        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Document Type", false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);   //Document Type
        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Document No.", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);   //Document No.
        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Document Date", false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Date);   //Document Date

        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Item No.", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);            //Item No.
        ExcelBuf_gRecTmp.AddColumn(Item_lRec.Description, false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);         //Description
        ExcelBuf_gRecTmp.AddColumn(InvPostGrp_lCod, false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);                       //Inventory Posting Group
        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Global Dimension 1 Code", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);  //Shortcut Dimension 1 Code
        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Global Dimension 2 Code", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);  //Shortcut Dimension 2 Code
        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Variant Code", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Serial No.", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Lot No.", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);
        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."External Document No.", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);

        ExcelBuf_gRecTmp.AddColumn(Item_lRec."Item Category Code", false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);  //'Item Category'
        //ExcelBuf_gRecTmp.AddColumn(Item_lRec."Product Group Code Custom", false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);  //'Product Group Code'

        ExcelBuf_gRecTmp.AddColumn(OnlyQty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                 //Quantity
        ExcelBuf_gRecTmp.AddColumn(RemQty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);              //Remaining Quantity
        ExcelBuf_gRecTmp.AddColumn(ApplQty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);             //ApplQty
        ExcelBuf_gRecTmp.AddColumn(CostAmt_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);      //Cost Amount

        RemCost_lDec := ROUND((ApplQty_lDec * CostAmt_lDec) / OnlyQty_lDec, 0.01);
        PrevRemCost_lDec := ROUND((PrevApplQty_lDec * PrevCostAmt_lDec) / OnlyQty_lDec, 0.01);
        ExcelBuf_gRecTmp.AddColumn(RemCost_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);    //Remaining Cost Amt

        //T45701-NS
        if ItemNo_lTxt <> ILE_iRec."Item No." then begin
            ItemNo_lTxt := ILE_iRec."Item No.";
            ActualAmount_lDec := 0;
            ExpAmount_lDec := 0;
            TotalAmount_lDec := 0;
            ILEQty_lDec := 0;
            ValueEntry_lRec.Reset;
            ValueEntry_lRec.SetCurrentkey("Item Ledger Entry No.", "Document No.", "Document Line No.");
            ValueEntry_lRec.SetRange("Item No.", ILE_iRec."Item No.");
            ValueEntry_lRec.SetFilter("Posting Date", '..%1', AsOnDate_gDte);
            ValueEntry_lRec.SetLoadFields("Cost Amount (Actual)", "Cost Amount (Expected)", "Item Ledger Entry Quantity");
            if ValueEntry_lRec.FindSet then begin
                //repeat
                ValueEntry_lRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)", "Item Ledger Entry Quantity");
                ActualAmount_lDec := ValueEntry_lRec."Cost Amount (Actual)" + ValueEntry_lRec."Cost Amount (Expected)";
                ILEQty_lDec := ValueEntry_lRec."Item Ledger Entry Quantity";
                //until ValueEntry_lRec.Next = 0;
                TotalAmount_lDec := ActualAmount_lDec / ILEQty_lDec;
            end;
            PrevActualAmount_lDec := 0;
            PrevTotalAmount_lDec := 0;
            PrevILEQty_lDec := 0;
            ValueEntry_lRec.Reset;
            ValueEntry_lRec.SetCurrentkey("Item Ledger Entry No.", "Document No.", "Document Line No.");
            ValueEntry_lRec.SetRange("Item No.", ILE_iRec."Item No.");
            ValueEntry_lRec.SetFilter("Posting Date", '..%1', PreviousAsOnDate_gDte);
            ValueEntry_lRec.SetLoadFields("Cost Amount (Actual)", "Cost Amount (Expected)", "Item Ledger Entry Quantity");
            if ValueEntry_lRec.FindSet then begin
                ValueEntry_lRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)", "Item Ledger Entry Quantity");
                PrevActualAmount_lDec := ValueEntry_lRec."Cost Amount (Actual)" + ValueEntry_lRec."Cost Amount (Expected)";
                PrevILEQty_lDec := ValueEntry_lRec."Item Ledger Entry Quantity";
                PrevTotalAmount_lDec := PrevActualAmount_lDec / PrevILEQty_lDec;
            end;
        end;
        ExcelBuf_gRecTmp.AddColumn(TotalAmount_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);    //Remaining Cost Amt
        ExcelBuf_gRecTmp.AddColumn(TotalAmount_lDec * ApplQty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);    //Remaining Cost Amt

        //T45701-NE
        //TotalRemQty_lDec := ApplQty_lDec;
        TotalRemQty_lDec := ApplQty_lDec;
        PrevTotalRemQty_lDec := PrevApplQty_lDec;

        if not IsOriginEntry_lFnc(EntryNo_lInt) then begin
            ILECnt_lInt := 1;
            ILEOriginDetail_lRec.Reset;
            ILEOriginDetail_lRec.SetRange("ILE No.", EntryNo_lInt);
            //ILEOriginDetail_lRec.Ascending(false);
            if ILEOriginDetail_lRec.FindSet then begin
                repeat
                    AgeCat1_lDec := 0;
                    AgeCat2_lDec := 0;
                    AgeCat3_lDec := 0;
                    AgeCat4_lDec := 0;
                    AgeCat5_lDec := 0;
                    AgeCat1Qty_lDec := 0;
                    AgeCat2Qty_lDec := 0;
                    AgeCat3Qty_lDec := 0;
                    AgeCat4Qty_lDec := 0;
                    AgeCat5Qty_lDec := 0;
                    OriginDocDate_lDate := ILEOriginDetail_lRec."Applied Posting Date";
                    AppliedILE_lRec.Get(ILEOriginDetail_lRec."Applied ILE No.");

                    if ILEOriginDetail_lRec."Applied Posting Date" <= 20151231D then begin
                        OriginDocDate_lDate := AppliedILE_lRec."Document Date";
                    end;

                    if ILECnt_lInt > 1 then begin
                        ExcelBuf_gRecTmp.NewRow;
                        ExcelBuf_gRecTmp.AddColumn(EntryNo_lInt, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Number);  //Entry No.
                        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Location Code", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);  //Location Code
                        ExcelBuf_gRecTmp.AddColumn(PostingDate_lDte, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Date);                  //Posting Date
                        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Entry Type", false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);         //Entry Type
                        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Document Type", false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);   //Document Type
                        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Document No.", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);   //Document No.
                        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Document Date", false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Date);   //Document Date
                        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Item No.", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);            //Item No.
                        ExcelBuf_gRecTmp.AddColumn(Item_lRec.Description, false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);         //Description
                        ExcelBuf_gRecTmp.AddColumn(InvPostGrp_lCod, false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);                       //Inventory Posting Group
                        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Global Dimension 1 Code", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);  //Shortcut Dimension 1 Code
                        ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Global Dimension 2 Code", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);  //Shortcut Dimension 2 Code
                        ExcelBuf_gRecTmp.AddColumn(Item_lRec."Item Category Code", false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);  //'Item Category'
                        //ExcelBuf_gRecTmp.AddColumn(Item_lRec."Product Group Code Custom", false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Text);  //'Product Group Code'
                        ExcelBuf_gRecTmp.AddColumn('', false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);  //Quantity
                        ExcelBuf_gRecTmp.AddColumn('', false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);  //Remaining Quantity
                        ExcelBuf_gRecTmp.AddColumn('', false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);  //ApplQty
                        ExcelBuf_gRecTmp.AddColumn('', false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);  //Cost Amount
                        ExcelBuf_gRecTmp.AddColumn('', false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);  //RemCost
                        ExcelBuf_gRecTmp.AddColumn('', false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);  //T45701-N
                        ExcelBuf_gRecTmp.AddColumn('', false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);  //T45701-N
                    end;

                    AgeDays_lInt := AsOnDate_gDte - OriginDocDate_lDate;

                    if AgeDays_lInt < 0 then
                        AgeDays_lInt := 0;

                    PrevAgeDays_lInt := PreviousAsOnDate_gDte - OriginDocDate_lDate;

                    if PrevAgeDays_lInt < 0 then
                        PrevAgeDays_lInt := 0;

                    if ILEOriginDetail_lRec."Applied Quantity" <= TotalRemQty_lDec then begin
                        AppliedRemQty_lDec := ILEOriginDetail_lRec."Applied Quantity";
                        TotalRemQty_lDec -= AppliedRemQty_lDec;
                    end else begin
                        AppliedRemQty_lDec := TotalRemQty_lDec;
                        TotalRemQty_lDec := 0;
                    end;

                    if ILEOriginDetail_lRec."Applied Quantity" <= PrevTotalRemQty_lDec then begin
                        PrevAppliedRemQty_lDec := ILEOriginDetail_lRec."Applied Quantity";
                        PrevTotalRemQty_lDec -= PrevAppliedRemQty_lDec;
                    end else begin
                        PrevAppliedRemQty_lDec := PrevTotalRemQty_lDec;
                        PrevTotalRemQty_lDec := 0;
                    end;

                    if ApplQty_lDec <> 0 then
                        CalAgeCost_lDec := ROUND((AppliedRemQty_lDec * RemCost_lDec) / ApplQty_lDec, 0.01);

                    if PrevApplQty_lDec <> 0 then
                        PrevCalAgeCost_lDec := ROUND((PrevAppliedRemQty_lDec * PrevRemCost_lDec) / PrevApplQty_lDec, 0.01);

                    case AgeDays_lInt of
                        0 .. 60:
                            begin
                                AgeCat1_lDec := CalAgeCost_lDec;
                                AgeCat1Qty_lDec := ApplQty_lDec;
                            end;
                        61 .. 120:
                            begin
                                AgeCat2_lDec := CalAgeCost_lDec;
                                AgeCat2Qty_lDec := ApplQty_lDec;
                            end;
                        121 .. 180:
                            begin
                                AgeCat3_lDec := CalAgeCost_lDec;
                                AgeCat3Qty_lDec := ApplQty_lDec;
                            end;
                        181 .. 360:
                            begin
                                AgeCat4_lDec := CalAgeCost_lDec;
                                AgeCat4Qty_lDec := ApplQty_lDec;
                            end;
                        361 .. 9999:
                            begin
                                AgeCat5_lDec := CalAgeCost_lDec;
                                AgeCat5Qty_lDec := ApplQty_lDec;
                            end;
                    end;

                    case PrevAgeDays_lInt of
                        0 .. 60:
                            begin
                                PrevAgeCat1_lDec := PrevCalAgeCost_lDec;
                                PrevAgeCat1Qty_lDec := PrevApplQty_lDec;
                            end;
                        61 .. 120:
                            begin
                                PrevAgeCat2_lDec := PrevCalAgeCost_lDec;
                                PrevAgeCat2Qty_lDec := PrevApplQty_lDec;
                            end;
                        121 .. 180:
                            begin
                                PrevAgeCat3_lDec := PrevCalAgeCost_lDec;
                                PrevAgeCat3Qty_lDec := PrevApplQty_lDec;
                            end;
                        181 .. 360:
                            begin
                                PrevAgeCat4_lDec := PrevCalAgeCost_lDec;
                                PrevAgeCat4Qty_lDec := PrevApplQty_lDec;
                            end;
                        361 .. 9999:
                            begin
                                PrevAgeCat5_lDec := PrevCalAgeCost_lDec;
                                PrevAgeCat5Qty_lDec := PrevApplQty_lDec;
                            end;
                    end;

                    ExcelBuf_gRecTmp.AddColumn(ILEOriginDetail_lRec."Applied ILE No.", false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Number);   //Applied ILE No.
                    ExcelBuf_gRecTmp.AddColumn(ILEOriginDetail_lRec."Applied Document No.", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);  //Applied Doc. No.
                    ExcelBuf_gRecTmp.AddColumn(ILEOriginDetail_lRec."Applied Entry Type", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);  //Applied Entry Type
                    ExcelBuf_gRecTmp.AddColumn(OriginDocDate_lDate, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Date);                         //Applied Doc. Date
                    ExcelBuf_gRecTmp.AddColumn(AgeDays_lInt, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //AgeDays
                    ExcelBuf_gRecTmp.AddColumn(AgeCat1_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //0 To 90
                    ExcelBuf_gRecTmp.AddColumn(AgeCat2_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //91 To 180
                    ExcelBuf_gRecTmp.AddColumn(AgeCat3_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //181 To 270
                    ExcelBuf_gRecTmp.AddColumn(AgeCat4_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //271 To 360
                    ExcelBuf_gRecTmp.AddColumn(AgeCat5_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //360 To 9999
                    ExcelBuf_gRecTmp.AddColumn(AgeCat1Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //0 To 90     Qty
                    ExcelBuf_gRecTmp.AddColumn(AgeCat2Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //91 To 180   Qty
                    ExcelBuf_gRecTmp.AddColumn(AgeCat3Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //181 To 270  Qty
                    ExcelBuf_gRecTmp.AddColumn(AgeCat4Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //271 To 360  Qty
                    ExcelBuf_gRecTmp.AddColumn(AgeCat5Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //360 To 9999 Qty
                    ExcelBuf_gRecTmp.AddColumn(PrevAgeCat1_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //0 To 90
                    ExcelBuf_gRecTmp.AddColumn(PrevAgeCat2_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //91 To 180
                    ExcelBuf_gRecTmp.AddColumn(PrevAgeCat3_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //181 To 270
                    ExcelBuf_gRecTmp.AddColumn(PrevAgeCat4_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //271 To 360
                    ExcelBuf_gRecTmp.AddColumn(PrevAgeCat5_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //360 To 9999
                    ExcelBuf_gRecTmp.AddColumn(PrevAgeCat1Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //0 To 90     Qty
                    ExcelBuf_gRecTmp.AddColumn(PrevAgeCat2Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //91 To 180   Qty
                    ExcelBuf_gRecTmp.AddColumn(PrevAgeCat3Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //181 To 270  Qty
                    ExcelBuf_gRecTmp.AddColumn(PrevAgeCat4Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //271 To 360  Qty
                    ExcelBuf_gRecTmp.AddColumn(PrevAgeCat5Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //360 To 9999 Qty

                    ldoc_gcode := '';
                    ldocdate_gdate := 0D;
                    LastILE_lRec.Reset;
                    LastILE_lRec.SetRange("Item No.", ILE_iRec."Item No.");
                    LastILE_lRec.SetFilter("Posting Date", '<=%1', AsOnDate_gDte);
                    LastILE_lRec.SetFilter("Entry Type", '%1|%2', LastILE_lRec."entry type"::Sale, LastILE_lRec."entry type"::Consumption);
                    LastILE_lRec.SetFilter(Quantity, '<%1', 0);
                    if LastILE_lRec.FindLast then begin
                        ldoc_gcode := LastILE_lRec."Document No.";
                        ldocdate_gdate := LastILE_lRec."Posting Date";
                    end;

                    LastILE_lRec.Reset;
                    LastILE_lRec.SetRange("Item No.", ILE_iRec."Item No.");
                    LastILE_lRec.SetFilter("Posting Date", '<=%1', AsOnDate_gDte);
                    //LastILE_lRec.SetFilter("Entry Type", '%1', LastILE_lRec."entry type"::Transfer);
                    LastILE_lRec.SetRange("Entry Type", LastILE_lRec."entry type"::Transfer);
                    LastILE_lRec.SetFilter("Document Type", '<>%1', LastILE_lRec."document type"::" ");
                    LastILE_lRec.SetFilter(Quantity, '<%1', 0);
                    if LastILE_lRec.FindLast then begin
                        if ldocdate_gdate = 0D then begin
                            ldoc_gcode := LastILE_lRec."Document No.";
                            ldocdate_gdate := LastILE_lRec."Posting Date";
                        end;
                        if LastILE_lRec."Posting Date" > ldocdate_gdate then begin
                            ldoc_gcode := LastILE_lRec."Document No.";
                            ldocdate_gdate := LastILE_lRec."Posting Date";
                        end;
                    end;

                    // ExcelBuf_gRecTmp.AddColumn(ldoc_gcode, false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);      //last document no
                    // ExcelBuf_gRecTmp.AddColumn(ldocdate_gdate, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Date);   //last Document Date\
                    // ExcelBuf_gRecTmp.AddColumn(UnitCost_gdec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);

                    ExcelBuf_gRecTmp.AddColumn(Purchase, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(PurchaseAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(PurchaseDirect, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(PurchaseDirectAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(Output, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(OutputAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(Positive, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(PositiveAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(TransferRcpt, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(TransferRcptAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(SalesRtrnQty, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(SalesRtrnAmt, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    // ExcelBuf_gRecTmp.AddColumn(TotalRcptQty, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Number);
                    // ExcelBuf_gRecTmp.AddColumn(TotalRcptAmt, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Number);

                    ExcelBuf_gRecTmp.AddColumn(Sales, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(SalesAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(Consumption, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(ConsumptionAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(Nagative, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(NagativeAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(TransferShpt, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(TransferShptAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(PurchaseRtrn, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    ExcelBuf_gRecTmp.AddColumn(PurchaseRtrnAmt, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
                    // ExcelBuf_gRecTmp.AddColumn(TotalIssuedQty, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Number);
                    // ExcelBuf_gRecTmp.AddColumn(TotalIssuedAmt, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Number);
                    ILECnt_lInt += 1;
                until ILEOriginDetail_lRec.Next = 0;
            end;
        end else begin
            AgeCat1_lDec := 0;
            AgeCat2_lDec := 0;
            AgeCat3_lDec := 0;
            AgeCat4_lDec := 0;
            AgeCat5_lDec := 0;
            AgeCat1Qty_lDec := 0;
            AgeCat2Qty_lDec := 0;
            AgeCat3Qty_lDec := 0;
            AgeCat4Qty_lDec := 0;
            AgeCat5Qty_lDec := 0;
            PrevAgeCat1_lDec := 0;
            PrevAgeCat2_lDec := 0;
            PrevAgeCat3_lDec := 0;
            PrevAgeCat4_lDec := 0;
            PrevAgeCat5_lDec := 0;
            PrevAgeCat1Qty_lDec := 0;
            PrevAgeCat2Qty_lDec := 0;
            PrevAgeCat3Qty_lDec := 0;
            PrevAgeCat4Qty_lDec := 0;
            PrevAgeCat5Qty_lDec := 0;

            AgeDays_lInt := AsOnDate_gDte - ILE_iRec."Document Date";
            PrevAgeDays_lInt := PreviousAsOnDate_gDte - ILE_iRec."Document Date";

            if AgeDays_lInt < 0 then
                AgeDays_lInt := 0;

            if ApplQty_lDec <> 0 then
                CalAgeCost_lDec := ROUND((OnlyQty_lDec * RemCost_lDec) / ApplQty_lDec, 0.01)
            else
                CalAgeCost_lDec := 0;

            if PrevAgeDays_lInt < 0 then
                PrevAgeDays_lInt := 0;

            if PrevApplQty_lDec <> 0 then
                PrevCalAgeCost_lDec := ROUND((OnlyQty_lDec * RemCost_lDec) / PrevApplQty_lDec, 0.01)
            else
                PrevCalAgeCost_lDec := 0;

            case AgeDays_lInt of
                0 .. 60:
                    begin
                        AgeCat1_lDec := RemCost_lDec;
                        AgeCat1Qty_lDec := ApplQty_lDec;
                    end;
                61 .. 120:
                    begin
                        AgeCat2_lDec := RemCost_lDec;
                        AgeCat2Qty_lDec := ApplQty_lDec;
                    end;
                121 .. 180:
                    begin
                        AgeCat3_lDec := RemCost_lDec;
                        AgeCat3Qty_lDec := ApplQty_lDec;
                    end;
                181 .. 360:
                    begin
                        AgeCat4_lDec := RemCost_lDec;
                        AgeCat4Qty_lDec := ApplQty_lDec;
                    end;
                361 .. 9999:
                    begin
                        AgeCat5_lDec := RemCost_lDec;
                        AgeCat5Qty_lDec := ApplQty_lDec;
                    end;
            end;

            case PrevAgeDays_lInt of
                0 .. 60:
                    begin
                        PrevAgeCat1_lDec := PrevRemCost_lDec;
                        PrevAgeCat1Qty_lDec := PrevApplQty_lDec;
                    end;
                61 .. 120:
                    begin
                        PrevAgeCat2_lDec := PrevRemCost_lDec;
                        PrevAgeCat2Qty_lDec := PrevApplQty_lDec;
                    end;
                121 .. 180:
                    begin
                        PrevAgeCat3_lDec := PrevRemCost_lDec;
                        PrevAgeCat3Qty_lDec := PrevApplQty_lDec;
                    end;
                181 .. 360:
                    begin
                        PrevAgeCat4_lDec := PrevRemCost_lDec;
                        PrevAgeCat4Qty_lDec := PrevApplQty_lDec;
                    end;
                361 .. 9999:
                    begin
                        PrevAgeCat5_lDec := PrevRemCost_lDec;
                        PrevAgeCat5Qty_lDec := PrevApplQty_lDec;
                    end;
            end;

            ExcelBuf_gRecTmp.AddColumn(EntryNo_lInt, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Number);    //Applied ILE No.
            ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Document No.", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);    //Applied Doc. No.
            ExcelBuf_gRecTmp.AddColumn(ILE_iRec."Entry Type", false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);      //Applied Entry Type
            ExcelBuf_gRecTmp.AddColumn(PostingDate_lDte, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Date);                       //Applied Doc. Date
            ExcelBuf_gRecTmp.AddColumn(AgeDays_lInt, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                           //AgeDays
            ExcelBuf_gRecTmp.AddColumn(PrevAgeCat1_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                           //0 To 90
            ExcelBuf_gRecTmp.AddColumn(AgeCat1_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                           //0 To 90
            ExcelBuf_gRecTmp.AddColumn(PrevAgeCat2_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                           //91 To 180
            ExcelBuf_gRecTmp.AddColumn(AgeCat2_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                           //91 To 180
            ExcelBuf_gRecTmp.AddColumn(PrevAgeCat3_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                           //181 To 270
            ExcelBuf_gRecTmp.AddColumn(AgeCat3_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                           //181 To 270
            ExcelBuf_gRecTmp.AddColumn(PrevAgeCat4_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                           //271 To 360
            ExcelBuf_gRecTmp.AddColumn(AgeCat4_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                           //271 To 360
            ExcelBuf_gRecTmp.AddColumn(PrevAgeCat5_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                           //360 To 9999
            ExcelBuf_gRecTmp.AddColumn(AgeCat5_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                           //360 To 9999
            ExcelBuf_gRecTmp.AddColumn(PrevAgeCat1Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //0 To 90     Qty
            ExcelBuf_gRecTmp.AddColumn(AgeCat1Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //0 To 90     Qty
            ExcelBuf_gRecTmp.AddColumn(PrevAgeCat2Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //91 To 180   Qty
            ExcelBuf_gRecTmp.AddColumn(AgeCat2Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //91 To 180   Qty
            ExcelBuf_gRecTmp.AddColumn(PrevAgeCat3Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //181 To 270  Qty
            ExcelBuf_gRecTmp.AddColumn(AgeCat3Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //181 To 270  Qty
            ExcelBuf_gRecTmp.AddColumn(PrevAgeCat4Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //271 To 360  Qty
            ExcelBuf_gRecTmp.AddColumn(AgeCat4Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //271 To 360  Qty
            ExcelBuf_gRecTmp.AddColumn(PrevAgeCat5Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //360 To 9999 Qty
            ExcelBuf_gRecTmp.AddColumn(AgeCat5Qty_lDec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);                              //360 To 9999 Qty

            ldoc_gcode := '';
            ldocdate_gdate := 0D;
            LastILE_lRec.Reset;
            LastILE_lRec.SetRange("Item No.", ILE_iRec."Item No.");
            LastILE_lRec.SetFilter("Posting Date", '<=%1', AsOnDate_gDte);
            LastILE_lRec.SetFilter("Entry Type", '%1|%2', LastILE_lRec."entry type"::Sale, LastILE_lRec."entry type"::Consumption);
            LastILE_lRec.SetFilter(Quantity, '<%1', 0);
            if LastILE_lRec.FindLast then begin
                ldoc_gcode := LastILE_lRec."Document No.";
                ldocdate_gdate := LastILE_lRec."Posting Date";
            end;

            LastILE_lRec.Reset;
            LastILE_lRec.SetRange("Item No.", ILE_iRec."Item No.");
            LastILE_lRec.SetFilter("Posting Date", '<=%1', AsOnDate_gDte);
            //LastILE_lRec.SetFilter("Entry Type", '%1', LastILE_lRec."entry type"::Transfer);
            LastILE_lRec.SetRange("Entry Type", LastILE_lRec."entry type"::Transfer);
            LastILE_lRec.SetFilter("Document Type", '<>%1', LastILE_lRec."document type"::" ");
            LastILE_lRec.SetFilter(Quantity, '<%1', 0);
            if LastILE_lRec.FindLast then begin
                if ldocdate_gdate = 0D then begin
                    ldoc_gcode := LastILE_lRec."Document No.";
                    ldocdate_gdate := LastILE_lRec."Posting Date";
                end;
                if LastILE_lRec."Posting Date" > ldocdate_gdate then begin
                    ldoc_gcode := LastILE_lRec."Document No.";
                    ldocdate_gdate := LastILE_lRec."Posting Date";
                end;
            end;

            // ExcelBuf_gRecTmp.AddColumn(ldoc_gcode, false, '', false, false, false, '@', ExcelBuf_gRecTmp."cell type"::Text);      //last document no
            // ExcelBuf_gRecTmp.AddColumn(ldocdate_gdate, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Date);   //last Document Date
            // ExcelBuf_gRecTmp.AddColumn(UnitCost_gdec, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);

            ExcelBuf_gRecTmp.AddColumn(Purchase, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(PurchaseAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(PurchaseDirect, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(PurchaseDirectAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(Output, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(OutputAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(Positive, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(PositiveAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(TransferRcpt, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(TransferRcptAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(SalesRtrnQty, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(SalesRtrnAmt, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            // ExcelBuf_gRecTmp.AddColumn(TotalRcptQty, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Number);
            // ExcelBuf_gRecTmp.AddColumn(TotalRcptAmt, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Number);

            ExcelBuf_gRecTmp.AddColumn(Sales, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(SalesAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(Consumption, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(ConsumptionAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(Nagative, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(NagativeAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(TransferShpt, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(TransferShptAmount, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(PurchaseRtrn, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            ExcelBuf_gRecTmp.AddColumn(PurchaseRtrnAmt, false, '', false, false, false, '#,##0.00', ExcelBuf_gRecTmp."cell type"::Number);
            // ExcelBuf_gRecTmp.AddColumn(TotalIssuedQty, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Number);
            // ExcelBuf_gRecTmp.AddColumn(TotalIssuedAmt, false, '', false, false, false, '', ExcelBuf_gRecTmp."cell type"::Number);
        end;
    end;

    procedure CreateExcelbook_gFnc()
    begin
        //I-C0007-1301232-01-NS
        ExcelBuf_gRecTmp.CreateBookAndOpenExcel_gFnc('', Text007, Text008, COMPANYNAME, UserId);
        Error('');
        //I-C0007-1301232-01-NE
    end;

    local procedure IsOriginEntry_lFnc(EntryNo_iInt: Integer): Boolean
    var
        ILE_lRec: Record "Item Ledger Entry";
        ILEAppDetail_lRec: Record "ILE Application Detail";
    begin
        if "Item Ledger Entry"."Entry Type" in ["Item Ledger Entry"."entry type"::Purchase, "Item Ledger Entry"."entry type"::"Positive Adjmt.", "Item Ledger Entry"."entry type"::Output, "Item Ledger Entry"."entry type"::"Assembly Output"] then begin

            if ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Purchase) then begin
                if "Item Ledger Entry".Quantity > 0 then
                    exit(true)
                else
                    exit(false);
            end else
                exit(true);

        end else
            if ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Sale) and ("Item Ledger Entry".Quantity > 0) then begin  //Sales Ship Entry - 231627 Applied to Sales Return - 228452

                if not "Item Ledger Entry"."Origin Found" then
                    exit(true)
                else begin
                    //If it is applied its self than it is our origin entry //Example Entry no - 331559
                    ILEAppDetail_lRec.Reset;
                    ILEAppDetail_lRec.SetRange("ILE No.", "Item Ledger Entry"."Entry No.");

                    ILEAppDetail_lRec.SetRange("Applied ILE No.", "Item Ledger Entry"."Entry No.");
                    ILEAppDetail_lRec.SetRange("Create By Item Application Ent", true);
                    if ILEAppDetail_lRec.FindFirst then
                        exit(true)
                    else
                        exit(false);
                end;
            end else
                if ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Consumption) and ("Item Ledger Entry".Quantity > 0) then begin  // Reverse Consumption Entry

                    if not "Item Ledger Entry"."Origin Found" then
                        exit(true)
                    else begin
                        //If it is applied its self than it is our origin entry //Example Entry no - 499708
                        ILEAppDetail_lRec.Reset;
                        ILEAppDetail_lRec.SetRange("ILE No.", "Item Ledger Entry"."Entry No.");
                        ILEAppDetail_lRec.SetRange("Applied ILE No.", "Item Ledger Entry"."Entry No.");
                        ILEAppDetail_lRec.SetRange("Create By Item Application Ent", true);
                        if ILEAppDetail_lRec.FindFirst then
                            exit(true)
                        else
                            exit(false);
                    end;

                end else
                    exit(false);
    end;

    local procedure GetInvMoved_lFnc(ILE_iRec: Record "Item Ledger Entry")
    var
        ValueEntry_GRec: Record "Value Entry";
        Cost_lDec: Decimal;
    begin
        Cost_lDec := 0;
        ILE_iRec.CalcFields("Inbound Quantity");
        Clear(ValueEntry_GRec);
        ValueEntry_GRec.SetRange("Item Ledger Entry No.", ILE_iRec."Entry No.");
        if ValueEntry_GRec.FindSet() then begin
            ValueEntry_GRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
            Cost_lDec += ValueEntry_GRec."Cost Amount (Actual)" + ValueEntry_GRec."Cost Amount (Expected)";
        end;
        Cost_lDec := ILE_iRec.Quantity * Cost_lDec / ILE_iRec."Inbound Quantity";

        ValueEntry_GRec.Reset;
        ValueEntry_GRec.SetRange("Item Ledger Entry No.", ILE_iRec."Entry No.");
        ValueEntry_GRec.SetRange("Item No.", ILE_iRec."Item No.");
        ValueEntry_GRec.SetFilter("Location Code", ILE_iRec."Location Code");
        ValueEntry_GRec.SetRange("Posting Date", PreviousAsOnDate_gDte, AsOnDate_gDte);
        ValueEntry_GRec.SetRange("Variant Code", ILE_iRec."Variant Code");
        ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."item ledger entry type"::Purchase);
        ValueEntry_GRec.SetFilter("Document Type", '%1|%2', ValueEntry_GRec."Document Type"::"Purchase Invoice", ValueEntry_GRec."Document Type"::"Purchase Receipt");
        ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
        Purchase := ValueEntry_GRec."Item Ledger Entry Quantity";
        PurchaseAmount := ValueEntry_GRec."Cost Amount (Actual)";
        PurchaseAmount += ValueEntry_GRec."Cost Amount (Expected)";

        ValueEntry_GRec.SetFilter("Document Type", '%1|%2', ValueEntry_GRec."Document Type"::"Purchase Return Shipment", ValueEntry_GRec."Document Type"::"Purchase Credit Memo");
        ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
        PurchaseRtrn := ValueEntry_GRec."Item Ledger Entry Quantity";
        PurchaseRtrnAmt := ValueEntry_GRec."Cost Amount (Actual)";
        PurchaseRtrnAmt += ValueEntry_GRec."Cost Amount (Expected)";

        ValueEntry_GRec.SetRange("Document Type", ValueEntry_GRec."Document Type"::" ");
        ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
        PurchaseDirect := ValueEntry_GRec."Item Ledger Entry Quantity";
        PurchaseDirectAmount := Cost_lDec;
        //PurchaseDirectAmount += ValueEntry_GRec."Cost Amount (Expected)";

        ValueEntry_GRec.Reset;
        ValueEntry_GRec.SetRange("Item Ledger Entry No.", ILE_iRec."Entry No.");
        ValueEntry_GRec.SetRange("Item No.", ILE_iRec."Item No.");
        ValueEntry_GRec.SetFilter("Location Code", ILE_iRec."Location Code");
        ValueEntry_GRec.SetRange("Variant Code", ILE_iRec."Variant Code");
        ValueEntry_GRec.SetRange("Posting Date");
        ValueEntry_GRec.SetRange("Posting Date", PreviousAsOnDate_gDte, AsOnDate_gDte);
        ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."item ledger entry type"::Sale);
        ValueEntry_GRec.SetFilter("Document Type", '%1|%2', ValueEntry_GRec."Document Type"::"Sales Credit Memo", ValueEntry_GRec."Document Type"::"Sales Return Receipt");
        //ValueEntry_GRec.SetFilter("Item Ledger Entry Quantity", '>%1', 0);    //ISPL-RV O
        ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
        SalesRtrnQty := ValueEntry_GRec."Item Ledger Entry Quantity";
        SalesRtrnAmt := ValueEntry_GRec."Cost Amount (Actual)";
        SalesRtrnAmt += ValueEntry_GRec."Cost Amount (Expected)";
        ValueEntry_GRec.SetRange("Item Ledger Entry Quantity");

        ValueEntry_GRec.Reset;
        ValueEntry_GRec.SetRange("Item Ledger Entry No.", ILE_iRec."Entry No.");
        ValueEntry_GRec.SetRange("Item No.", ILE_iRec."Item No.");
        ValueEntry_GRec.SetFilter("Location Code", ILE_iRec."Location Code");
        ValueEntry_GRec.SetRange("Variant Code", ILE_iRec."Variant Code");
        ValueEntry_GRec.SetRange("Posting Date");
        ValueEntry_GRec.SetRange("Posting Date", PreviousAsOnDate_gDte, AsOnDate_gDte);
        ValueEntry_GRec.SetFilter("Item Ledger Entry Type", '%1|%2', ValueEntry_GRec."item ledger entry type"::Consumption, ValueEntry_GRec."item ledger entry type"::"Assembly Consumption");
        ValueEntry_GRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
        ConsumptionAmount := ValueEntry_GRec."Cost Amount (Actual)";
        ConsumptionAmount += ValueEntry_GRec."Cost Amount (Expected)";

        ValueEntry_GRec.Reset;
        ValueEntry_GRec.SetRange("Item Ledger Entry No.", ILE_iRec."Entry No.");
        ValueEntry_GRec.SetRange("Item No.", ILE_iRec."Item No.");
        ValueEntry_GRec.SetFilter("Location Code", ILE_iRec."Location Code");
        ValueEntry_GRec.SetRange("Variant Code", ILE_iRec."Variant Code");
        ValueEntry_GRec.SetRange("Posting Date");
        ValueEntry_GRec.SetRange("Posting Date", PreviousAsOnDate_gDte, AsOnDate_gDte);
        ValueEntry_GRec.SetFilter("Item Ledger Entry Type", '%1|%2', ValueEntry_GRec."item ledger entry type"::Output, ValueEntry_GRec."item ledger entry type"::"Assembly Output");
        ValueEntry_GRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
        OutputAmount := ValueEntry_GRec."Cost Amount (Actual)";
        OutputAmount += ValueEntry_GRec."Cost Amount (Expected)";

        ValueEntry_GRec.Reset;
        ValueEntry_GRec.SetRange("Item Ledger Entry No.", ILE_iRec."Entry No.");
        ValueEntry_GRec.SetRange("Item No.", ILE_iRec."Item No.");
        ValueEntry_GRec.SetFilter("Location Code", ILE_iRec."Location Code");
        ValueEntry_GRec.SetRange("Variant Code", ILE_iRec."Variant Code");
        ValueEntry_GRec.SetRange("Posting Date");
        ValueEntry_GRec.SetRange("Posting Date", PreviousAsOnDate_gDte, AsOnDate_gDte);
        ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."item ledger entry type"::Transfer);
        ValueEntry_GRec.SetRange("Document Type", ValueEntry_GRec."Document Type"::"Transfer Shipment");
        //ValueEntry_GRec.SetFilter("Item Ledger Entry Quantity", '<%1', 0);   //ISPL-RV O
        ValueEntry_GRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
        TransferShptAmount := ValueEntry_GRec."Cost Amount (Actual)";
        TransferShptAmount += ValueEntry_GRec."Cost Amount (Expected)";

        ValueEntry_GRec.Reset;
        ValueEntry_GRec.SetRange("Item Ledger Entry No.", ILE_iRec."Entry No.");
        ValueEntry_GRec.SetRange("Item No.", ILE_iRec."Item No.");
        ValueEntry_GRec.SetFilter("Location Code", ILE_iRec."Location Code");
        ValueEntry_GRec.SetRange("Variant Code", ILE_iRec."Variant Code");
        ValueEntry_GRec.SetRange("Posting Date");
        ValueEntry_GRec.SetRange("Posting Date", PreviousAsOnDate_gDte, AsOnDate_gDte);
        ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."item ledger entry type"::Transfer);
        ValueEntry_GRec.SetRange("Document Type", ValueEntry_GRec."Document Type"::"Transfer Receipt");
        //ISPL-RV OValueEntry_GRec.SetFilter("Item Ledger Entry Quantity", '>%1', 0);  //ISPL-RV O
        ValueEntry_GRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
        TransferRcptAmount := ValueEntry_GRec."Cost Amount (Actual)";
        TransferRcptAmount += ValueEntry_GRec."Cost Amount (Expected)";

        ValueEntry_GRec.Reset;
        ValueEntry_GRec.SetRange("Item Ledger Entry No.", ILE_iRec."Entry No.");
        ValueEntry_GRec.SetRange("Item No.", ILE_iRec."Item No.");
        ValueEntry_GRec.SetFilter("Location Code", ILE_iRec."Location Code");
        ValueEntry_GRec.SetRange("Variant Code", ILE_iRec."Variant Code");
        ValueEntry_GRec.SetRange("Posting Date");
        ValueEntry_GRec.SetRange("Posting Date", PreviousAsOnDate_gDte, AsOnDate_gDte);
        ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."item ledger entry type"::"Positive Adjmt.");
        ValueEntry_GRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
        PositiveAmount := ValueEntry_GRec."Cost Amount (Actual)";
        PositiveAmount += ValueEntry_GRec."Cost Amount (Expected)";

        ValueEntry_GRec.Reset;
        ValueEntry_GRec.SetRange("Item Ledger Entry No.", ILE_iRec."Entry No.");
        ValueEntry_GRec.SetRange("Item No.", ILE_iRec."Item No.");
        ValueEntry_GRec.SetFilter("Location Code", ILE_iRec."Location Code");
        ValueEntry_GRec.SetRange("Variant Code", ILE_iRec."Variant Code");
        ValueEntry_GRec.SetRange("Posting Date");
        ValueEntry_GRec.SetRange("Posting Date", PreviousAsOnDate_gDte, AsOnDate_gDte);
        ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."item ledger entry type"::"Negative Adjmt.");
        ValueEntry_GRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
        NagativeAmount := ValueEntry_GRec."Cost Amount (Actual)";
        NagativeAmount += ValueEntry_GRec."Cost Amount (Expected)";

        ValueEntry_GRec.Reset;
        ValueEntry_GRec.SetRange("Item Ledger Entry No.", ILE_iRec."Entry No.");
        ValueEntry_GRec.SetRange("Item No.", ILE_iRec."Item No.");
        ValueEntry_GRec.SetRange("Location Code", ILE_iRec."Location Code");
        ValueEntry_GRec.SetRange("Variant Code", ILE_iRec."Variant Code");
        ValueEntry_GRec.SetFilter("Posting Date", '<%1', PreviousAsOnDate_gDte);
        ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
        // Opening := ILE_iRec."Inbound Quantity";
        // OpeningAmount := ValueEntry_GRec."Cost Amount (Actual)";
        // OpeningAmount += ValueEntry_GRec."Cost Amount (Expected)";

        ValueEntry_GRec.SetRange("Posting Date");
        ValueEntry_GRec.SetRange("Posting Date", PreviousAsOnDate_gDte, AsOnDate_gDte);

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
        TransferShptAmount += ValueEntry_GRec."Cost Amount (Expected)";

        ValueEntry_GRec.SetRange("Item Ledger Entry Type", ValueEntry_GRec."Item Ledger Entry Type"::Transfer);
        ValueEntry_GRec.SetRange("Document Type", ValueEntry_GRec."Document Type"::"Transfer Receipt");
        ValueEntry_GRec.CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
        TransferRcpt := ValueEntry_GRec."Item Ledger Entry Quantity";
        TransferRcptAmount := ValueEntry_GRec."Cost Amount (Actual)";
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

    end;
}
