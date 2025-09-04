XmlPort 50100 "Export ILE"
{
    Caption = 'Export ILE';
    Direction = Export;
    FieldSeparator = '<TAB>';
    //FieldSeparator = ',';
    Format = VariableText;
    TableSeparator = '<NewLine>';
    Description = 'T50324';

    schema
    {
        textelement(root)
        {
            XmlName = 'Root';
            tableelement(Integer; Integer)
            {
                XmlName = 'ItemLedgerEntryHeader';
                SourceTableView = sorting(Number) where(Number = const(1));
                textelement(PostingDateTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        PostingDateTitle := ItemLedgerEntry_gRec.FieldCaption("Posting Date");
                    end;
                }
                textelement(EntryTypeTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        EntryTypeTitle := ItemLedgerEntry_gRec.FieldCaption("Entry Type");
                    end;
                }
                textelement(DocumentTypeTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        DocumentTypeTitle := ItemLedgerEntry_gRec.FieldCaption("Document Type");
                    end;
                }
                textelement(DocumentNoTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        DocumentNoTitle := ItemLedgerEntry_gRec.FieldCaption("Document No.");
                    end;
                }
                textelement(ItemNoTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        ItemNoTitle := ItemLedgerEntry_gRec.FieldCaption("Item No.");
                    end;
                }
                textelement(FilterTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        FilterTitle := 'Filter';
                    end;
                }
                textelement(VariantCodeTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        VariantCodeTitle := 'Variant Code';
                    end;
                }
                textelement(DescriptionTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        DescriptionTitle := ItemLedgerEntry_gRec.FieldCaption(Description);
                    end;
                }
                textelement(GlobalDimension1CodeTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        GlobalDimension1CodeTitle := ItemLedgerEntry_gRec.FieldCaption("Global Dimension 1 Code");
                    end;
                }
                textelement(GlobalDimension2CodeTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        GlobalDimension2CodeTitle := ItemLedgerEntry_gRec.FieldCaption("Global Dimension 2 Code");
                    end;
                }


                textelement(ANalysisDtTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        ANalysisDtTitle := 'Analysis Date';
                    end;
                }
                textelement(LocationCodeTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        LocationCodeTitle := ItemLedgerEntry_gRec.FieldCaption("Location Code");
                    end;
                }
                // textelement(COstCenterTitle)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         COstCenterTitle := 'Cost Center';
                //     end;
                // }
                textelement(UOMTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        UOMTitle := 'Unit of Measure Code';
                    end;
                }
                textelement(QuantityTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        QuantityTitle := ItemLedgerEntry_gRec.FieldCaption(Quantity);
                    end;
                }
                textelement(LotNoTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        LotNoTitle := 'Custom Lot No.';
                    end;
                }
                textelement(CustomBOENoTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CustomBOENoTitle := 'Custom BOE No.';
                    end;
                }
                textelement(BOETitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        BOETitle := 'Bill of Exit';
                    end;
                }
                textelement(SupplierBatchTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        SupplierBatchTitle := 'Supplier Batch No.';
                    end;
                }
                textelement(ExpirationDateTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        ExpirationDateTitle := 'Expiry Period';
                    end;
                }
                textelement(NetWtTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        NetWtTitle := 'Net Weight';
                    end;
                }
                textelement(GrossWtTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        GrossWtTitle := 'Gross Weight';
                    end;
                }
                textelement(InvoicedQuantityTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        InvoicedQuantityTitle := ItemLedgerEntry_gRec.FieldCaption("Invoiced Quantity");
                    end;
                }
                textelement(RemainingQuantityTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        RemainingQuantityTitle := ItemLedgerEntry_gRec.FieldCaption("Remaining Quantity");
                    end;
                }
                textelement(SalesAmountActualTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        SalesAmountActualTitle := ItemLedgerEntry_gRec.FieldCaption("Sales Amount (Actual)");
                    end;
                }

                textelement(CostAmountActualTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CostAmountActualTitle := ItemLedgerEntry_gRec.FieldCaption("Cost Amount (Actual)");
                    end;
                }
                textelement(CostAmountExpTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CostAmountExpTitle := ItemLedgerEntry_gRec.FieldCaption("Cost Amount (Expected)");
                    end;
                }
                textelement(CostAmountNonInvtblTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CostAmountNonInvtblTitle := ItemLedgerEntry_gRec.FieldCaption("Cost Amount (Non-Invtbl.)");
                    end;
                }
                textelement(OpenTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        OpenTitle := ItemLedgerEntry_gRec.FieldCaption(Open);
                    end;
                }
                textelement(OrderTypeTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        OrderTypeTitle := ItemLedgerEntry_gRec.FieldCaption("Order Type");
                    end;
                }
                textelement(QCNoTitle)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QCNoTitle := ItemLedgerEntry_gRec.FieldCaption("QC No.");
                    end;
                }
                textelement(PostedQCNoTitle)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        PostedQCNoTitle := ItemLedgerEntry_gRec.FieldCaption("Posted QC No.");
                    end;
                }
                textelement(QCRelationTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        QCRelationTitle := ItemLedgerEntry_gRec.FieldCaption("QC Relation Entry No.");
                    end;
                }
                textelement(EntryNoTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        EntryNoTitle := ItemLedgerEntry_gRec.FieldCaption("Entry No.");
                    end;
                }
                // textelement(MarketTitle)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         MarketTitle := ItemLedgerEntry_gRec.FieldCaption(Market);
                //     end;
                // }

                // textelement(CatTitle)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         CatTitle := ItemLedgerEntry_gRec.FieldCaption(Category);
                //     end;
                // }
                // textelement(SubCat1Title)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         SubCat1Title := ItemLedgerEntry_gRec.FieldCaption(SubCategory1);
                //     end;
                // }

                // textelement(SubCat2Title)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         SubCat2Title := ItemLedgerEntry_gRec.FieldCaption(SubCategory2);
                //     end;
                // }

                textelement(GrpGRNDtTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        GrpGRNDtTitle := ItemLedgerEntry_gRec.FieldCaption("Group GRN Date");
                    end;
                }
                textelement(ManufDtTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        ManufDtTitle := ItemLedgerEntry_gRec.FieldCaption("Manufacturing Date 2");
                    end;
                }
                textelement(InboundQtyTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        InboundQtyTitle := 'Inbound Qty';
                    end;
                }

                textelement(RemCostTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        RemCostTitle := 'Remaining Cost';
                    end;
                }
                textelement(GlobalDimension3CodeTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        GlobalDimension3CodeTitle := GLSetup_gRec."Shortcut Dimension 3 Code";
                    end;
                }
                textelement(GlobalDimension4CodeTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        GlobalDimension4CodeTitle := GLSetup_gRec."Shortcut Dimension 4 Code";
                    end;
                }
                textelement(GlobalDimension5CodeTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        GlobalDimension5CodeTitle := GLSetup_gRec."Shortcut Dimension 5 Code";
                    end;
                }
                textelement(GlobalDimension6CodeTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        GlobalDimension6CodeTitle := GLSetup_gRec."Shortcut Dimension 6 Code";
                    end;
                }
                textelement(GlobalDimension7CodeTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        GlobalDimension7CodeTitle := GLSetup_gRec."Shortcut Dimension 7 Code";
                    end;
                }
                textelement(GlobalDimension8CodeTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        GlobalDimension8CodeTitle := GLSetup_gRec."Shortcut Dimension 8 Code";
                    end;
                }
                // textelement(DocumentDateTitle)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         DocumentDateTitle := ItemLedgerEntry_gRec.FieldCaption("Document Date");
                //     end;
                // }



                // textelement(DocumentLineNoTitle)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         DocumentLineNoTitle := ItemLedgerEntry_gRec.FieldCaption("Document Line No.");
                //     end;
                // }

                // // textelement(ItemDescriptionTitle)
                // // {

                // //     trigger OnBeforePassVariable()
                // //     begin
                // //         ItemDescriptionTitle := ItemLedgerEntry_gRec.FieldCaption("Item Description 1");
                // //     end;
                // // }
                // // textelement(ItemDescription2Title)
                // // {

                // //     trigger OnBeforePassVariable()
                // //     begin
                // //         ItemDescription2Title := ItemLedgerEntry_gRec.FieldCaption("Item Description 2");
                // //     end;
                // // }
                // textelement(ReturnReasonCodeTitle)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         ReturnReasonCodeTitle := ItemLedgerEntry_gRec.FieldCaption("Return Reason Code");
                //     end;
                // }



                // textelement(SerialNoTitle)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         SerialNoTitle := ItemLedgerEntry_gRec.FieldCaption("Serial No.");
                //     end;
                // }




                // textelement(ShippedQtyNotReturnedTitle)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         ShippedQtyNotReturnedTitle := ItemLedgerEntry_gRec.FieldCaption("Shipped Qty. Not Returned");
                //     end;
                // }
                // textelement(SalesAmountExpectedTitle)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         SalesAmountExpectedTitle := ItemLedgerEntry_gRec.FieldCaption("Sales Amount (Expected)");
                //     end;
                // }


                // textelement(CompletelyInvoicedTitle)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         CompletelyInvoicedTitle := ItemLedgerEntry_gRec.FieldCaption("Completely Invoiced");
                //     end;
                // }

                // textelement(DropShipmentTitle)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         DropShipmentTitle := ItemLedgerEntry_gRec.FieldCaption("Drop Shipment");
                //     end;
                // }

                // textelement(OrderNoTitle)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         OrderNoTitle := ItemLedgerEntry_gRec.FieldCaption("Order No.");
                //     end;
                // }
                // textelement(ExternalDocumentNoTitle)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         ExternalDocumentNoTitle := ItemLedgerEntry_gRec.FieldCaption("External Document No.");
                //     end;
                // }
                // textelement(SourceNoTitle)
                // {

                //     trigger OnBeforePassVariable()
                //     begin
                //         SourceNoTitle := ItemLedgerEntry_gRec.FieldCaption("Source No.");
                //     end;
                // }
            }
            tableelement("Item Ledger Entry"; "Item Ledger Entry")
            {
                RequestFilterFields = "Item No.", "Posting Date", "Date Filter";
                XmlName = 'ItemLedgerEntry';
                SourceTableView = sorting("Entry No.");

                fieldelement(PostingDate; "Item Ledger Entry"."Posting Date")
                {
                }
                fieldelement(EntryType; "Item Ledger Entry"."Entry Type")
                {
                }
                fieldelement(DocumentType; "Item Ledger Entry"."Document Type")
                {
                }
                fieldelement(DocumentNo; "Item Ledger Entry"."Document No.")
                {
                }
                fieldelement(ItemNo; "Item Ledger Entry"."Item No.")
                {
                }
                textelement(InvPostingGrp_gCod)
                {
                }
                fieldelement(VariantCode; "Item Ledger Entry"."Variant Code")
                {
                }
                fieldelement(Description; "Item Ledger Entry".Description)
                {
                }
                fieldelement(GlobalDimension1Code; "Item Ledger Entry"."Global Dimension 1 Code")
                {
                }
                fieldelement(GlobalDimension2Code; "Item Ledger Entry"."Global Dimension 2 Code")
                {
                }
                fieldelement(ANalysisDt; "Item Ledger Entry"."Analysis Date")
                {
                }
                fieldelement(LocationCode; "Item Ledger Entry"."Location Code")
                {
                }
                fieldelement(UOMCode; "Item Ledger Entry"."Unit of Measure Code")
                {
                }
                fieldelement(Quantity; "Item Ledger Entry".Quantity)
                {
                }
                fieldelement(LotNo; "Item Ledger Entry".CustomLotNumber)
                {
                }
                fieldelement(CustomBOENo; "Item Ledger Entry".CustomBOENumber)
                {
                }
                fieldelement(BOE; "Item Ledger Entry".BillOfExit)
                {
                }
                fieldelement(SupplierBatch; "Item Ledger Entry"."Supplier Batch No. 2")
                {
                }
                fieldelement(ExpiryPeriod; "Item Ledger Entry"."Expiry Period 2")
                {
                }
                fieldelement(NetWt; "Item Ledger Entry"."Net Weight 2")
                {
                }
                fieldelement(GrossWt; "Item Ledger Entry"."Gross Weight 2")
                {
                }
                fieldelement(InvoicedQuantity; "Item Ledger Entry"."Invoiced Quantity")
                {
                }
                fieldelement(RemainingQuantity; "Item Ledger Entry"."Remaining Quantity")
                {
                }
                fieldelement(SalesAmountActual; "Item Ledger Entry"."Sales Amount (Actual)")
                {
                }
                // fieldelement(CostAmountExpected; "Item Ledger Entry"."Cost Amount (Expected)")
                // {

                fieldelement(CostAmountActual; "Item Ledger Entry"."Cost Amount (Actual)")
                {
                }
                fieldelement(CostAmountExp; "Item Ledger Entry"."Cost Amount (Expected)")
                {
                }
                fieldelement(CostAmountNonInvtbl; "Item Ledger Entry"."Cost Amount (Non-Invtbl.)")
                {
                }
                fieldelement(Open; "Item Ledger Entry".Open)
                {
                }
                fieldelement(OrderType; "Item Ledger Entry"."Order Type")
                {
                }

                fieldelement(QCNo; "Item Ledger Entry"."QC No.")
                {
                }
                fieldelement(PostedQCNo; "Item Ledger Entry"."Posted QC No.")
                {
                }
                fieldelement(QCRelation; "Item Ledger Entry"."QC Relation Entry No.")
                {
                }
                fieldelement(EntryNo; "Item Ledger Entry"."Entry No.")
                {
                }

                fieldelement(GroupGRNDate; "Item Ledger Entry"."Group GRN Date")
                {
                }
                fieldelement(ManufacturingDate; "Item Ledger Entry"."Manufacturing Date 2")
                {
                }
                textelement(InboundQty)
                {
                }
                textelement(RemainingCost)
                {
                }
                textelement(GlobalDimension3Code)
                {
                }
                textelement(GlobalDimension4Code)
                {
                }
                textelement(GlobalDimension5Code)
                {
                }
                textelement(GlobalDimension6Code)
                {
                }
                textelement(GlobalDimension7Code)
                {
                }
                textelement(GlobalDimension8Code)
                {
                }
                // fieldelement(DocumentDate; "Item Ledger Entry"."Document Date")
                // {
                // }


                // fieldelement(DocumentLineNo; "Item Ledger Entry"."Document Line No.")
                // {
                // }

                // fieldelement(ItemDescription; "Item Ledger Entry"."Item Description 1")
                // {
                // }
                // fieldelement(ItemDescription2; "Item Ledger Entry"."Item Description 2")
                // {
                // }
                // fieldelement(ReturnReasonCode; "Item Ledger Entry"."Return Reason Code")
                // {
                // }


                // fieldelement(ExpirationDate; "Item Ledger Entry"."Expiration Date")
                // {
                // }
                // fieldelement(SerialNo; "Item Ledger Entry"."Serial No.")
                // {
                // }
                // fieldelement(LotNo; "Item Ledger Entry"."Lot No.")
                // {
                // }
                // fieldelement(LocationCode; "Item Ledger Entry"."Location Code")
                // {
                // }


                // fieldelement(ShippedQtyNotReturned; "Item Ledger Entry"."Shipped Qty. Not Returned")
                // {
                // }
                // fieldelement(SalesAmountExpected; "Item Ledger Entry"."Sales Amount (Expected)")
                // {
                // }

                // fieldelement(CompletelyInvoiced; "Item Ledger Entry"."Completely Invoiced")
                // {
                // }

                // fieldelement(DropShipment; "Item Ledger Entry"."Drop Shipment")
                // {
                // }

                // fieldelement(OrderNo; "Item Ledger Entry"."Order No.")
                // {
                // }
                // fieldelement(ExternalDocumentNo; "Item Ledger Entry"."External Document No.")
                // {
                // }
                // // fieldelement(QCNo; "Item Ledger Entry"."QC No.")
                // // {
                // // }
                // // fieldelement(PostedQCNo; "Item Ledger Entry"."Posted QC No.")
                // // {
                // // }
                // fieldelement(SourceNo; "Item Ledger Entry"."Source No.")
                // {
                // }

                trigger OnAfterGetRecord()
                var
                    DimensionSetEntry_lRec: Record "Dimension Set Entry";
                    ValueEntry_lRec: Record "value Entry";
                    CostAmt_gDec, Inbo_gDec : Decimal;
                    ILE_lRec: record "Item Ledger Entry";
                    ToDt_lDte: Date;
                begin
                    Curr_gIn += 1;
                    Window_gDlg.Update(2, Curr_gIn);

                    Clear(Item);
                    Item.Get("Item Ledger Entry"."Item No.");
                    Clear(InvPostingGrp_gCod);
                    InvPostingGrp_gCod := Item."Inventory Posting Group";
                    // "Item Ledger Entry".CalcFields("Item Description 1", "Item Description 2");
                    if FilterInvPostGrp_gTxt <> '' then begin
                        if not (InvPostingGrp_gCod in [FilterInvPostGrp_gTxt]) then
                            currXMLport.Skip();
                    end;

                    GlobalDimension3Code := '';
                    GlobalDimension4Code := '';
                    GlobalDimension5Code := '';
                    GlobalDimension6Code := '';
                    GlobalDimension7Code := '';
                    GlobalDimension8Code := '';

                    if DimensionSetEntry_lRec.Get("Item Ledger Entry"."Dimension Set ID", GLSetup_gRec."Shortcut Dimension 3 Code") then
                        GlobalDimension3Code := DimensionSetEntry_lRec."Dimension Value Code";

                    if DimensionSetEntry_lRec.Get("Item Ledger Entry"."Dimension Set ID", GLSetup_gRec."Shortcut Dimension 4 Code") then
                        GlobalDimension4Code := DimensionSetEntry_lRec."Dimension Value Code";

                    if DimensionSetEntry_lRec.Get("Item Ledger Entry"."Dimension Set ID", GLSetup_gRec."Shortcut Dimension 5 Code") then
                        GlobalDimension5Code := DimensionSetEntry_lRec."Dimension Value Code";

                    if DimensionSetEntry_lRec.Get("Item Ledger Entry"."Dimension Set ID", GLSetup_gRec."Shortcut Dimension 6 Code") then
                        GlobalDimension6Code := DimensionSetEntry_lRec."Dimension Value Code";

                    if DimensionSetEntry_lRec.Get("Item Ledger Entry"."Dimension Set ID", GLSetup_gRec."Shortcut Dimension 7 Code") then
                        GlobalDimension7Code := DimensionSetEntry_lRec."Dimension Value Code";

                    if DimensionSetEntry_lRec.Get("Item Ledger Entry"."Dimension Set ID", GLSetup_gRec."Shortcut Dimension 8 Code") then
                        GlobalDimension8Code := DimensionSetEntry_lRec."Dimension Value Code";

                    InboundQty := '';
                    RemainingCost := '';
                    RemainingCost_gDec := 0;
                    InboundQty_gDec := 0;
                    CostAmt_gDec := 0;
                    Inbo_gDec := 0;
                    Clear(ILE_lRec);
                    ILE_lRec.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                    ILE_lRec.SetFilter("Date Filter", '..%1', "Item Ledger Entry".GetRangeMax("Date Filter"));
                    ILE_lRec.SetFilter("Inbound Quantity", '>%1', 0);
                    ILE_lRec.SetRange("Entry No.", "Item Ledger Entry"."Entry No.");
                    if ILE_lRec.FindSet() then begin
                        repeat
                            ILE_lRec.CalcFields("Inbound Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)");
                            //  CostAmt_gDec += ILE_lRec."Cost Amount (Actual)" + ILE_lRec."Cost Amount (Expected)";
                            Inbo_gDec += ILE_lRec."Inbound Quantity";
                        until ILE_lRec.Next = 0;
                    end;

                    ValueEntry_lRec.Reset;
                    ValueEntry_lRec.SetCurrentkey("Item Ledger Entry No.", "Document No.", "Document Line No.");
                    ValueEntry_lRec.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                    ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    ValueEntry_lRec.SetFilter("Posting Date", '..%1', "Item Ledger Entry".GetRangeMax("Date Filter"));
                    ValueEntry_lRec.SetLoadFields("Cost Amount (Actual)", "Cost Amount (Expected)", "Item Ledger Entry Quantity");
                    if ValueEntry_lRec.FindSet then begin
                        ValueEntry_lRec.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
                        CostAmt_gDec := ValueEntry_lRec."Cost Amount (Actual)" + ValueEntry_lRec."Cost Amount (Expected)";
                        // PrevILEQty_lDec := ValueEntry_lRec."Item Ledger Entry Quantity";
                        // PrevTotalAmount_lDec := PrevActualAmount_lDec / PrevILEQty_lDec;
                    end;

                    if "Item Ledger Entry".Quantity <> 0 then
                        RemainingCost_gDec := (CostAmt_gDec / "Item Ledger Entry".Quantity) * Inbo_gDec;

                    //if Evaluate(RemainingCost_gDec, RemainingCost) then;
                    RemainingCost := Format(RemainingCost_gDec);
                    //if Evaluate(Inbo_gDec, InboundQty) then;
                    InboundQty := Format(Inbo_gDec);
                end;

                trigger OnPreXmlItem()
                begin
                    if "Item Ledger Entry".GetFilter("Date Filter") = '' then
                        Error('Please select the date filter');

                    //"Item Ledger Entry".SetRange("posting Date", FromDt_gDte, ToDate_gDte);
                    // "Item Ledger Entry".SetFilter("Remaining Quantity", '>%1', 0);
                    "Item Ledger Entry".SetFilter("Inbound Quantity", '>%1', 0);
                    Window_gDlg.Update(1, "Item Ledger Entry".Count);
                end;
            }
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

                    // field("Date Filter"; DateFilter_gTxt)
                    // {
                    //     ApplicationArea = Basic;
                    //     Caption = 'Date Filter';

                    //     trigger OnValidate()
                    //     begin
                    //         if DateFilter_gTxt <> '' then begin
                    //             ApplicationManagement.MakeDateFilter(DateFilter_gTxt);
                    //             IF DateFilter_gTxt <> '' Then
                    //                 GLAccountDateFilter_gRec.SetFilter("Date Filter", DateFilter_gTxt);

                    //             DateFilter_gTxt := GLAccountDateFilter_gRec.GetFilter("Date Filter");
                    //             FromDt_gDte := GLAccountDateFilter_gRec.GetRangeMin("Date Filter");
                    //             ToDate_gDte := GLAccountDateFilter_gRec.GetRangemax("Date Filter");
                    //         end else begin
                    //             FromDt_gDte := 0D;
                    //             ToDate_gDte := 0D;
                    //         end;
                    //     end;
                    // }

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

        actions
        {
        }
    }
    trigger OnPostXmlPort()
    begin
        Window_gDlg.Close();
    end;

    trigger OnPreXmlPort()
    begin
        Window_gDlg.Open('Total Lines #1###########\Current Line #2##########');
        GLSetup_gRec.Get();

        if DateFilter_gTxt <> '' then begin
            ApplicationManagement.MakeDateFilter(DateFilter_gTxt);
            IF DateFilter_gTxt <> '' Then
                GLAccountDateFilter_gRec.SetFilter("Date Filter", DateFilter_gTxt);

            DateFilter_gTxt := GLAccountDateFilter_gRec.GetFilter("Date Filter");
            FromDt_gDte := GLAccountDateFilter_gRec.GetRangeMin("Date Filter");
            ToDate_gDte := GLAccountDateFilter_gRec.GetRangemax("Date Filter");
        end else begin
            FromDt_gDte := 0D;
            ToDate_gDte := 0D;
        end;

        // if DateFilter_gTxt = '' then error('Please select the date filter');

    end;

    var
        GLSetup_gRec: Record "General Ledger Setup";
        ItemLedgerEntry_gRec: Record "Item Ledger Entry";
        Window_gDlg: Dialog;
        Curr_gIn: Integer;
        Item: Record Item;
        InboundQty_gDec, RemainingCost_gDec : Decimal;
        FromDt_gDte: Date;
        ToDate_gDte: Date;
        DateFilter_gTxt: text;

        GLAccountDateFilter_gRec: Record "G/L Account";
        ApplicationManagement: Codeunit "Filter Tokens";
        FilterInvPostGrp_gTxt: Text;
}

