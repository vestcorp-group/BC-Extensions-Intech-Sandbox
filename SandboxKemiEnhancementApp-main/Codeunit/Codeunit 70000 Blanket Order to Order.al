codeunit 70000 "Blanket Order to Order"//T12370-Full Comment UAT 12-12-2024
{
    TableNo = "Sales Header";
    EventSubscriberInstance = StaticAutomatic;
    Permissions = tabledata 32 = rm, tabledata "Sales Shipment Header" = rm, tabledata "Sales Invoice Header" = rm;

    trigger OnRun()
    begin

    end;

    // [EventSubscriber(ObjectType::Page, 43, 'OnAfterValidateEvent', 'Transaction Specification', false, false)]
    // procedure MakeEditable(VAR Rec: Record "Sales Header"; VAR xRec: Record "Sales Header")
    // var
    //     EditInsuranceNoBool: Boolean;
    // begin
    //     Rec.EditInsurancePolicyNo(EditInsuranceNoBool);
    //     // Page.Update(true);
    // end;


    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Transaction Specification', false, false)]
    procedure Changeboolvalue(var Rec: Record "Sales Header")
    begin
        if (Rec."Transaction Specification" = 'DDP') and (Rec."Duty Exemption") then begin
            //Error('Make Duty Exemption disable first');
            Rec."Duty Exemption" := false;
            Rec.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Duty Exemption', false, false)]
    procedure ChangeDutyExemption(var Rec: Record "Sales Header")
    begin
        if Rec."Duty Exemption" then
            if Rec."Transaction Specification" = 'DDP' then
                Error('Incoterm is DDP.');
    end;


    [EventSubscriber(ObjectType::Codeunit, 87, 'OnBeforeSalesOrderHeaderModify', '', false, false)]
    procedure BlanketOrderToOrder(VAR SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesHeader: Record "Sales Header")
    begin
        SalesOrderHeader."Duty Exemption" := BlanketOrderSalesHeader."Duty Exemption";
    end;

    //GK
    // [EventSubscriber(ObjectType::Page, 507, 'OnAfterActionEvent', 'Archi&ve Document', false, false)]
    // procedure BlanketOrderToOrderArchive(VAR Rec: Record "Sales Header")
    // var
    //     salesArchiveRemarks: Record "Sales Archive Remarks";
    //     salesOrderRemarks: Record "Sales Order Remarks";
    // begin
    //     salesOrderRemarks.SetRange("Document No.", Rec."No.");
    //     if salesOrderRemarks.FindSet() then
    //         repeat
    //             salesArchiveRemarks.Init();
    //             salesArchiveRemarks."Document Type" := salesArchiveRemarks."Document Type"::"Blanket Order";
    //             salesArchiveRemarks."No." := salesOrderRemarks."Document No.";
    //             salesArchiveRemarks."Document Line No." := salesOrderRemarks."Document Line No.";
    //             salesArchiveRemarks."Line No." := salesOrderRemarks."Line No.";
    //             salesArchiveRemarks.Remarks := salesOrderRemarks.Comments;
    //             salesArchiveRemarks."Doc. No. Occurance" := Rec."Doc. No. Occurrence";
    //             salesArchiveRemarks."Version No." := Rec."No. of Archived Versions";
    //             salesArchiveRemarks.Insert();
    //         until salesOrderRemarks.Next() = 0;
    // end;

    //GK   
    // [EventSubscriber(ObjectType::Page, 507, 'OnAfterActionEvent', 'MakeOrder', false, false)]
    // procedure BlanketTOSalesOrder(var Rec: Record "Sales Header")
    // var
    //     FromsalesOrderRemarks: Record "Sales Order Remarks";
    //     tosalesOrderRemarks: Record "Sales Order Remarks";
    //     salesline: Record "Sales Line";
    //     orderNo: Code[20];
    // begin
    //     salesline.SetRange("Blanket Order No.", rec."No.");
    //     if salesline.FindFirst() then begin
    //         orderNo := salesline."Document No.";
    //         FromsalesOrderRemarks.Reset();
    //         FromsalesOrderRemarks.SetRange("Document No.", Rec."No.");
    //         if FromsalesOrderRemarks.FindSet() then
    //             repeat
    //                 tosalesOrderRemarks.Init();
    //                 tosalesOrderRemarks.TransferFields(FromsalesOrderRemarks);
    //                 tosalesOrderRemarks."Document Type" := tosalesOrderRemarks."Document Type"::Order;
    //                 tosalesOrderRemarks."Document No." := orderNo;
    //                 tosalesOrderRemarks.Insert();
    //             until FromsalesOrderRemarks.Next() = 0;
    //     end;
    // end;


    [EventSubscriber(ObjectType::Table, 37, 'OnAfterInsertEvent', '', false, false)]
    local procedure SalesInvoiceRemarks(VAR Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        SalesRemarksNo: Code[20];
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        salesHeader: Record "Sales Header";
        salesHeader2: Record "Sales Header";
        OrderNo: Code[20];
    begin
        if Rec.IsTemporary then
            exit;
        if (Rec."Document Type" = Rec."Document Type"::Invoice) and (Rec."Shipment No." <> '') then begin
            SalesShipmentLine.Reset();
            SalesShipmentLine.SetRange("Document No.", Rec."Shipment No.");
            SalesShipmentLine.SetRange(Type, SalesShipmentLine.Type::Item);
            if SalesShipmentLine.FindFirst() then begin
                OrderNo := SalesShipmentLine."Order No.";
                salesHeader.SetRange("No.", Rec."Document No.");
                if salesHeader.FindFirst() then begin
                    salesHeader."Remarks Order No." := OrderNo;
                    salesHeader2.Reset();
                    if salesHeader2.Get(salesHeader2."Document Type"::Order, OrderNo) then begin
                        salesHeader."Duty Exemption" := salesHeader2."Duty Exemption";
                        salesHeader."Sales Order Date" := salesHeader2."Order Date";
                        // salesHeader."Transaction Specification" := salesHeader2."Transaction Specification";
                        //SD::GK
                        if SalesShipmentHeader.Get(SalesShipmentLine."Document No.") then begin
                            salesHeader."Shipment Term" := SalesShipmentHeader."Shipment Term";
                            salesHeader."Insurance Policy No." := SalesShipmentHeader."Insurance Policy No.";
                            salesHeader."Transaction Specification" := SalesShipmentHeader."Transaction Specification";
                        end;
                        //SD::GK
                    end;
                    salesHeader.Modify();
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterInsertEvent', '', false, false)]
    local procedure SalesOrderDate(VAR Rec: Record "Sales Header"; RunTrigger: Boolean)
    begin
        Rec."Sales Order Date" := Rec."Order Date";
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Page, 42, 'OnAfterActionEvent', 'Post', false, false)]
    procedure ModifyCustomBoEandLotNo(var Rec: Record "Sales Header")
    var
        SalesShipmentLineRec: Record "Sales Shipment Line";
        ShipmentDocNo: Code[20];
        ItemLedgerEntry: Record "Item Ledger Entry";
        NewLotNoString: Code[50];
        CustomLotNo: Code[20];
        CustomBoENo: Code[20];
        positionInt: Integer;
        TotalLength: Integer;
    begin
        SalesShipmentLineRec.SetRange("Order No.", rec."No.");
        if SalesShipmentLineRec.FindFirst() then begin
            ShipmentDocNo := SalesShipmentLineRec."Document No.";
            ItemLedgerEntry.SetRange("Document No.", ShipmentDocNo);
            if ItemLedgerEntry.FindFirst() then begin
                positionInt := StrPos(ItemLedgerEntry."Lot No.", '@');
                if positionInt <> 0 then begin
                    repeat
                        positionInt := StrPos(ItemLedgerEntry."Lot No.", '@');
                        TotalLength := StrLen(ItemLedgerEntry."Lot No.");
                        CustomLotNo := CopyStr(ItemLedgerEntry."Lot No.", 1, (positionInt - 1));
                        CustomBoENo := CopyStr(ItemLedgerEntry."Lot No.", (positionInt + 1), TotalLength);
                        ItemLedgerEntry.CustomLotNumber := CustomLotNo;
                        ItemLedgerEntry.CustomBOENumber := CustomBoENo;
                        ItemLedgerEntry.Modify();

                    until ItemLedgerEntry.Next() = 0;
                end;
            end;
        end;
    end;

    // [EventSubscriber(ObjectType::Page, 42, 'OnAfterActionEvent', 'Archive Document', false, false)]
    // procedure OrderToOrderArchive(VAR Rec: Record "Sales Header")
    // var
    //     salesArchiveRemarks: Record "Sales Archive Remarks";
    //     salesOrderRemarks: Record "Sales Order Remarks";
    // begin
    //     salesOrderRemarks.Reset();
    //     salesOrderRemarks.SetRange("Document No.", Rec."No.");
    //     if salesOrderRemarks.FindSet() then begin
    //         salesArchiveRemarks.SetRange("No.", salesOrderRemarks."Document No.");
    //         if not salesArchiveRemarks.FindSet() then
    //             repeat
    //                 salesArchiveRemarks.Init();
    //                 salesArchiveRemarks."Document Type" := salesArchiveRemarks."Document Type"::Order;
    //                 salesArchiveRemarks."No." := salesOrderRemarks."Document No.";
    //                 salesArchiveRemarks."Document Line No." := salesOrderRemarks."Document Line No.";
    //                 salesArchiveRemarks."Line No." := salesOrderRemarks."Line No.";
    //                 salesArchiveRemarks.Remarks := salesOrderRemarks.Comments;
    //                 salesArchiveRemarks."Doc. No. Occurance" := Rec."Doc. No. Occurrence";
    //                 salesArchiveRemarks."Version No." := Rec."No. of Archived Versions";
    //                 salesArchiveRemarks.Insert();
    //             until salesOrderRemarks.Next() = 0;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, 5063, 'OnAfterStoreSalesDocument', '', false, false)]
    procedure ArchiveSalesOrder(var SalesHeader: Record "Sales Header"; var SalesHeaderArchive: Record "Sales Header Archive")

    var
        salesArchiveRemarks: Record "Sales Archive Remarks";
        salesOrderRemarks: Record "Sales Order Remarks";
    begin
        salesOrderRemarks.Reset();
        if SalesHeader."Document Type" = SalesHeader."Document Type"::"Blanket Order" then
            salesOrderRemarks.SetRange("Document Type", salesOrderRemarks."Document Type"::"Blanket Order")
        else
            if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
                salesOrderRemarks.SetRange("Document Type", salesOrderRemarks."Document Type"::Order);

        salesOrderRemarks.SetRange("Document No.", SalesHeader."No.");
        if salesOrderRemarks.FindSet() then begin
            SalesHeaderArchive.SetRange("Document Type", SalesHeaderArchive."Document Type");
            salesArchiveRemarks.SetRange("No.", salesOrderRemarks."Document No.");
            salesArchiveRemarks.SetRange("Version No.", SalesHeaderArchive."Version No.");
            if not salesArchiveRemarks.FindSet() then
                repeat
                    salesArchiveRemarks.Init();
                    salesArchiveRemarks."Document Type" := SalesHeaderArchive."Document Type".AsInteger();//30-04-2022-added asinteger with enum
                    salesArchiveRemarks."No." := salesOrderRemarks."Document No.";
                    salesArchiveRemarks."Document Line No." := salesOrderRemarks."Document Line No.";
                    salesArchiveRemarks."Line No." := salesOrderRemarks."Line No.";
                    salesArchiveRemarks.Remarks := salesOrderRemarks.Comments;
                    salesArchiveRemarks."Doc. No. Occurance" := SalesHeaderArchive."Doc. No. Occurrence";
                    salesArchiveRemarks."Version No." := SalesHeaderArchive."Version No.";
                    salesArchiveRemarks.Insert();
                until salesOrderRemarks.Next() = 0;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesShptHeaderInsert', '', false, false)]
    local procedure TransferRemarksOrderNoShipment(SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header")
    var
        SalesOrderRemarks: Record "Sales Order Remarks";
        ToSalesOrderRemarks: Record "Sales Order Remarks";
    begin
        SalesShipmentHeader."Remarks Order No." := SalesShipmentHeader."No.";
        SalesShipmentHeader.Modify();
        SalesOrderRemarks.Reset();
        SalesOrderRemarks.SetRange("Document No.", SalesHeader."No.");
        SalesOrderRemarks.SETRANGE("Document Type", SalesOrderRemarks."Document Type"::Shipment);
        IF SalesOrderRemarks.FindFirst() then
            Repeat
                ToSalesOrderRemarks.Init();
                ToSalesOrderRemarks.TransferFields(SalesOrderRemarks);
                ToSalesOrderRemarks."Document No." := SalesShipmentHeader."No.";
                ToSalesOrderRemarks.Insert();
            until SalesOrderRemarks.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesInvHeaderInsert', '', false, false)]
    local procedure TransferRemarksOrderNoInvoice(SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header")
    begin
        SalesInvHeader."Remarks Order No." := SalesInvHeader."No.";
        SalesInvHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesInvLineInsert', '', false, false)]
    local procedure TransferRemarksfromSalesInvoiceLine(SalesLine: Record "Sales Line"; var SalesInvLine: Record "Sales Invoice Line")
    var
        SalesOrderRemarks: Record "Sales Order Remarks";
        ToSalesOrderRemarks: Record "Sales Order Remarks";
        SalesOrderNo: Code[20];
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesOrderRemarksDuplicate: Record "Sales Order Remarks";
    begin

        if (SalesInvLine.Type = SalesInvLine.Type::Item) and (SalesInvLine."Shipment No." <> '') then begin
            SalesShipmentHeader.Get(SalesInvLine."Shipment No.");
            SalesOrderNo := SalesShipmentHeader."Order No.";

            SalesOrderRemarksDuplicate.Reset();
            SalesOrderRemarksDuplicate.SETRANGE("Document No.", SalesInvLine."Document No.");
            if NOT SalesOrderRemarksDuplicate.FindSet() then begin

                SalesOrderRemarks.Reset();
                SalesOrderRemarks.SetRange("Document No.", SalesOrderNo);
                SalesOrderRemarks.SETRANGE("Document Type", SalesOrderRemarks."Document Type"::Invoice);
                IF SalesOrderRemarks.FindFirst() then
                    Repeat
                        ToSalesOrderRemarks.Init();
                        ToSalesOrderRemarks.TransferFields(SalesOrderRemarks);
                        ToSalesOrderRemarks."Document No." := SalesInvLine."Document No.";
                        ToSalesOrderRemarks.Insert();
                    until SalesOrderRemarks.Next() = 0;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 87, 'OnAfterInsertAllSalesOrderLines', '', false, false)]
    procedure BlanketOrderRemarksSORemarks(BlanketOrderSalesHeader: Record "Sales Header"; OrderSalesHeader: Record "Sales Header")
    var
        FromsalesOrderRemarks: Record "Sales Order Remarks";
        tosalesOrderRemarks: Record "Sales Order Remarks";
        salesline: Record "Sales Line";
        orderNo: Code[20];
    begin
        FromsalesOrderRemarks.Reset();
        FromsalesOrderRemarks.SetRange("Document No.", BlanketOrderSalesHeader."No.");
        if FromsalesOrderRemarks.FindSet() then
            repeat
                tosalesOrderRemarks.Init();
                tosalesOrderRemarks.TransferFields(FromsalesOrderRemarks);
                tosalesOrderRemarks."Document Type" := tosalesOrderRemarks."Document Type"::Order;
                tosalesOrderRemarks."Document No." := OrderSalesHeader."No.";
                tosalesOrderRemarks.Insert();
            until FromsalesOrderRemarks.Next() = 0;
    end;

    // [EventSubscriber(ObjectType::Codeunit, 5063, 'OnAfterStoreSalesDocument', '', false, false)]
    // procedure MyProcedure(VAR SalesHeader: Record "Sales Header"; VAR SalesHeaderArchive: Record "Sales Header Archive")
    // var
    //     salesArchiveRemarks: Record "Sales Archive Remarks";
    //     salesOrderRemarks: Record "Sales Order Remarks";
    // begin
    //     salesOrderRemarks.Reset();
    //     salesOrderRemarks.SetRange("Document No.", SalesHeader."No.");
    //     if salesOrderRemarks.FindSet() then begin
    //         salesArchiveRemarks.SetRange("No.", salesOrderRemarks."Document No.");
    //         if not salesArchiveRemarks.FindSet() then
    //             repeat
    //                 salesArchiveRemarks.Init();
    //                 salesArchiveRemarks."Document Type" := salesArchiveRemarks."Document Type"::Order;
    //                 salesArchiveRemarks."No." := salesOrderRemarks."Document No.";
    //                 salesArchiveRemarks."Document Line No." := salesOrderRemarks."Document Line No.";
    //                 salesArchiveRemarks."Line No." := salesOrderRemarks."Line No.";
    //                 salesArchiveRemarks.Remarks := salesOrderRemarks.Comments;
    //                 salesArchiveRemarks."Doc. No. Occurance" := SalesHeader."Doc. No. Occurrence";
    //                 salesArchiveRemarks."Version No." := SalesHeaderArchive."Version No.";
    //                 salesArchiveRemarks.Insert();
    //             until salesOrderRemarks.Next() = 0;
    //     end;
    // end;
    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure ShipmentCountEvent(VAR SalesHeader: Record "Sales Header"; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean)
    var
        SalesShipHdr_Var: Record "Sales Shipment Header";
        SalesHeader_var: Record "Sales Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesInvoiceHdr_VAR: Record "Sales Invoice Header";
        saleslineRec: Record "Sales Line";
    begin
        if SalesShipHdr_Var.GET(SalesShptHdrNo) then begin
            SalesShipmentLine.SetRange("Document No.", SalesShipHdr_Var."No.");
            SalesShipmentLine.SetFilter("Blanket Order No.", '<>%1', '');
            if SalesShipmentLine.findfirst then
                if SalesHeader_var.Get(SalesHeader_var."Document Type"::"Blanket Order", SalesShipmentLine."Blanket Order No.") then begin
                    SalesShipHdr_Var."Shipment Count" := SalesHeader_var."Shipment Count" + 1;
                    SalesShipHdr_Var.Modify();

                    IF SalesInvoiceHdr_VAR.GET(SalesInvHdrNo) then begin
                        SalesInvoiceHdr_VAR."Shipment Count" := SalesHeader_var."Shipment Count" + 1;
                        SalesInvoiceHdr_VAR.Modify();
                    end;

                    SalesHeader_var."Shipment Count" += 1;
                    SalesHeader_var.Modify();
                end;

        end;
        // if SalesInvoiceHdr_VAR.GET(SalesInvHdrNo) then begin
        //     saleslineRec.reset;
        //     saleslineRec.setrange("Document Type", saleslineRec."Document Type"::Order);
        //     saleslineRec.setrange("Document No.", SalesInvoiceHdr_VAR."Order No.");
        //     if saleslineRec.FindFirst() then begin
        //         if SalesHeader_var.Get(SalesHeader_var."Document Type"::"Blanket Order", saleslineRec."Blanket Order No.") then begin
        //             SalesShipHdr_Var."Shipment Count" := SalesHeader_var."Shipment Count" + 1;
        //             SalesShipHdr_Var.Modify();
        //             SalesHeader_var."Shipment Count" += 1;
        //             SalesHeader_var.Modify();
        //         end;
        //     end;

        // end;
    end;

    procedure UpdateILEforCustomBOEnLOT()
    var
        itemLedgerEntry: Record "Item Ledger Entry";
        itemLedgerEntry2: Record "Item Ledger Entry";
        NewLotNoString: Code[50];
        CustomLotNo: Code[20];
        CustomBoENo: Code[20];
        positionInt: Integer;
        TotalLength: Integer;
        ProgressText: Label 'Processing record...#1#########';
        ProgressWindow: Dialog;
        NoOfRecs: Integer;
        CurrRec: Integer;

    begin

        itemLedgerEntry.Reset();
        itemLedgerEntry.SetFilter(CustomLotNumber, '=%1', '');


        if itemLedgerEntry.FindSet() then begin
            ProgressWindow.Open(ProgressText);
            NoOfRecs := itemLedgerEntry.Count;
            repeat
                positionInt := StrPos(ItemLedgerEntry."Lot No.", '@');
                if positionInt <> 0 then begin
                    TotalLength := StrLen(ItemLedgerEntry."Lot No.");
                    CustomLotNo := CopyStr(ItemLedgerEntry."Lot No.", 1, (positionInt - 1));
                    CustomBoENo := CopyStr(ItemLedgerEntry."Lot No.", (positionInt + 1), TotalLength);
                    ItemLedgerEntry.CustomLotNumber := CustomLotNo;
                    ItemLedgerEntry.CustomBOENumber := CustomBoENo;
                    ItemLedgerEntry.Modify();
                    CurrRec += 1;
                    IF NoOfRecs <= 100 THEN
                        ProgressWindow.UPDATE(1, (CurrRec / NoOfRecs * 10000) DIV 1)
                    ELSE
                        IF CurrRec MOD (NoOfRecs DIV 100) = 0 THEN
                            ProgressWindow.UPDATE(1, (CurrRec / NoOfRecs * 10000) DIV 1);
                end;
            until itemLedgerEntry.Next() = 0;
            ProgressWindow.Close();
        end;

        itemLedgerEntry2.Reset();
        itemLedgerEntry2.SetFilter(CustomBOENumber, '=%1', '');
        if itemLedgerEntry2.FindSet() then begin
            ProgressWindow.Open(ProgressText);
            NoOfRecs := itemLedgerEntry2.Count;
            repeat
                positionInt := StrPos(itemLedgerEntry2."Lot No.", '@');
                if positionInt <> 0 then begin
                    TotalLength := StrLen(itemLedgerEntry2."Lot No.");
                    CustomLotNo := CopyStr(itemLedgerEntry2."Lot No.", 1, (positionInt - 1));
                    CustomBoENo := CopyStr(itemLedgerEntry2."Lot No.", (positionInt + 1), TotalLength);
                    itemLedgerEntry2.CustomLotNumber := CustomLotNo;
                    itemLedgerEntry2.CustomBOENumber := CustomBoENo;
                    itemLedgerEntry2.Modify();
                    CurrRec += 1;
                    IF NoOfRecs <= 100 THEN
                        ProgressWindow.UPDATE(1, (CurrRec / NoOfRecs * 10000) DIV 1)
                    ELSE
                        IF CurrRec MOD (NoOfRecs DIV 100) = 0 THEN
                            ProgressWindow.UPDATE(1, (CurrRec / NoOfRecs * 10000) DIV 1);
                end;
            until itemLedgerEntry2.Next() = 0;
            ProgressWindow.Close();
        end;
    end;

    var
        DocType: Option;
        DocNo: Code[20];
}