codeunit 50140 KMP_EventSubscriberUnit  //T12370-Full Comment
{

    EventSubscriberInstance = StaticAutomatic;
    Permissions = tabledata "Item Ledger Entry" = rm;
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInsertEvent', '', true, true)]
    local procedure UpdateCustomBOENo(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    var
        PurchaseHeaderL: Record "Purchase Header";
    begin
        if not RunTrigger then
            exit;
        if not (Rec."Document Type" in [Rec."Document Type"::Order, Rec."Document Type"::"Return Order"]) then
            exit;
        PurchaseHeaderL.get(Rec."Document Type", Rec."Document No.");
        Rec.CustomBOENumber := PurchaseHeaderL.CustomBOENumber;
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure UpdateBOENoForPurchaseRcptEntries(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        NewItemLedgEntry.CustomBOENumber := ItemJournalLine.CustomBOENumber;
        NewItemLedgEntry.CustomLotNumber := ItemJournalLine.CustomLotNumber;
        NewItemLedgEntry.BillOfExit := ItemJournalLine.BillOfExit;
        // if NewItemLedgEntry."Document Type" = NewItemLedgEntry."Document Type"::"Sales Shipment" then
        //     GetCustomBOEFromILEForSalesShipment(NewItemLedgEntry);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertTransferEntry', '', true, true)]
    local procedure UpdateLotNoInfoFromNewLot(var NewItemLedgerEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
        if ItemJournalLine.IsReclass(ItemJournalLine) then
            if (StrPos(NewItemLedgerEntry."Lot No.", '@') > 0) then begin
                NewItemLedgerEntry.CustomLotNumber := CopyStr(NewItemLedgerEntry."Lot No.", 1, StrPos(NewItemLedgerEntry."Lot No.", '@') - 1);
                NewItemLedgerEntry.CustomBOENumber := CopyStr(NewItemLedgerEntry."Lot No.", StrPos(NewItemLedgerEntry."Lot No.", '@') + 1, MaxStrLen(NewItemLedgerEntry.CustomBOENumber));
            end else
                NewItemLedgerEntry.CustomLotNumber := NewItemLedgerEntry."Lot No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterInsertEvent', '', true, true)]
    local procedure UpdateCustomBOENumerToItemTrackingLines(var Rec: Record "Tracking Specification"; RunTrigger: Boolean)//Anoop
    var
        PurchaseHdrL: Record "Purchase Header";
        TransferHdrL: Record "Transfer Header";
        ItemJournalL: Record "Item Journal Line";
        SalesHdrL: Record "Sales Header";
        ItemLedgEntryL: Record "Item Ledger Entry";
        TransferLineL: Record "Transfer Line";
        AssemblyHeaderL: Record "Assembly Header";
        ReservationEntryL: Record "Reservation Entry";
        UpdateCustomFieldL: Boolean;
    begin
        UpdateCustomFieldL := true;
        case true of
            PurchaseHdrL.Get(PurchaseHdrL."Document Type"::Order, Rec."Source ID") and (Rec.CustomBOENumber = ''):
                Rec.CustomBOENumber := PurchaseHdrL.CustomBOENumber;
            SalesHdrL.Get(SalesHdrL."Document Type"::"Return Order", Rec."Source ID"):
                if SalesHdrL.CustomBOENumber <> '' then //13876-N
                    Rec.CustomBOENumber := SalesHdrL.CustomBOENumber;

            TransferHdrL.Get(Rec."Source ID"),
            PurchaseHdrL.Get(PurchaseHdrL."Document Type"::"Return Order", Rec."Source ID"),
            SalesHdrL.Get(SalesHdrL."Document Type"::Order, Rec."Source ID"):
                begin
                    UpdateCustomFieldL := false;
                    ItemLedgEntryL.RESET;
                    ItemLedgEntryL.SETCURRENTKEY("Item No.", Open, "Variant Code", "Location Code", "Item Tracking", "Lot No.", "Serial No.");
                    ItemLedgEntryL.SETRANGE("Item No.", Rec."Item No.");
                    ItemLedgEntryL.SETRANGE("Variant Code", Rec."Variant Code");
                    ItemLedgEntryL.SETRANGE(Open, true);
                    ItemLedgEntryL.SETRANGE("Location Code", Rec."Location Code");
                    ItemLedgEntryL.SETRANGE("Lot No.", Rec."Lot No.");
                    if ItemLedgEntryL.FindFirst() then begin
                        Rec.CustomBOENumber := ItemLedgEntryL.CustomBOENumber;
                        Rec.CustomLotNumber := ItemLedgEntryL.CustomLotNumber;
                        Rec."Supplier Batch No. 2" := ItemLedgEntryL."Supplier Batch No. 2";
                        Rec."Gross Weight 2" := ItemLedgEntryL."Gross Weight 2";
                        Rec."Net Weight 2" := ItemLedgEntryL."Net Weight 2";
                    end;
                    // GetCustomBOEFromILEForTrackingSpecification(Rec); Avi : Not using CustomBOE2 hence blocked.
                end;
            // (StrLen(Rec."Source ID") <= 10):
            //     if ItemJournalL.Get(Rec."Source ID", Rec."Source Batch Name", Rec."Source Ref. No.") then
            //         if not ItemJournalL.IsReclass(ItemJournalL) then
            //             Rec.CustomBOENumber := ItemJournalL.CustomBOENumber;
            AssemblyHeaderL.Get(AssemblyHeaderL."Document Type"::Order, Rec."Source ID") and (Rec.CustomBOENumber = ''):
                Rec.CustomBOENumber := AssemblyHeaderL.CustomBOENumber;
        end;
        case true of
            TransferHdrL.Get(Rec."Source ID"):
                begin
                    UpdateCustomFieldL := false;
                    ItemLedgEntryL.RESET;
                    ItemLedgEntryL.SETCURRENTKEY("Item No.", Open, "Variant Code", "Location Code", "Item Tracking", "Lot No.", "Serial No.");
                    ItemLedgEntryL.SETRANGE("Item No.", Rec."Item No.");
                    ItemLedgEntryL.SETRANGE("Variant Code", Rec."Variant Code");
                    ItemLedgEntryL.SETRANGE(Open, true);
                    ItemLedgEntryL.SETRANGE("Location Code", Rec."Location Code");
                    ItemLedgEntryL.SETRANGE("Lot No.", Rec."Lot No.");
                    if ItemLedgEntryL.FindFirst() then begin
                        Rec.CustomBOENumber := ItemLedgEntryL.CustomBOENumber;
                        Rec.CustomLotNumber := ItemLedgEntryL.CustomLotNumber;
                        Rec."Supplier Batch No. 2" := ItemLedgEntryL."Supplier Batch No. 2";
                        Rec."Gross Weight 2" := ItemLedgEntryL."Gross Weight 2";
                        Rec."Net Weight 2" := ItemLedgEntryL."Net Weight 2";
                    end;
                end;
        end;
        if UpdateCustomFieldL then begin
            if Rec.CustomLotNumber = '' then
                Rec.CustomLotNumber := Rec."Lot No.";
            if (Rec."Lot No." <> (Rec.CustomLotNumber + '@' + Rec.CustomBOENumber)) and (Rec.CustomBOENumber > '') and (Rec.CustomLotNumber > '') then
                Rec."Lot No." := Rec.CustomLotNumber + '@' + Rec.CustomBOENumber;
        end;
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnBeforeReservEntryInsert', '', true, true)]
    local procedure UpdateCustomLotNumberToResevationEntry(var ReservationEntry: Record "Reservation Entry")
    begin
        if (ReservationEntry."Lot No." > '') then
            if (STRPOS(ReservationEntry."Lot No.", '@') > 0) then begin
                ReservationEntry.CustomLotNumber := CopyStr(ReservationEntry."Lot No.", 1, StrPos(ReservationEntry."Lot No.", '@') - 1);
                ReservationEntry.CustomBOENumber := CopyStr(ReservationEntry."Lot No.", StrPos(ReservationEntry."Lot No.", '@') + 1, MaxStrLen(ReservationEntry.CustomBOENumber));
            end else
                ReservationEntry.CustomLotNumber := ReservationEntry."Lot No.";
        // Item Reclass
        if (ReservationEntry."New Lot No." > '') then
            if (STRPOS(ReservationEntry."New Lot No.", '@') > 0) then begin
                ReservationEntry."New Custom Lot No." := CopyStr(ReservationEntry."New Lot No.", 1, StrPos(ReservationEntry."New Lot No.", '@') - 1);
                ReservationEntry."New Custom BOE No." := CopyStr(ReservationEntry."New Lot No.", StrPos(ReservationEntry."New Lot No.", '@') + 1, MaxStrLen(ReservationEntry."New Custom BOE No."));
            end else
                ReservationEntry."New Custom Lot No." := ReservationEntry."New Lot No.";
    end;

    [EventSubscriber(ObjectType::Table, database::"Reservation Entry", 'OnBeforeModifyEvent', '', true, true)]
    local procedure OnBeforeModifyReservEntry(var Rec: Record "Reservation Entry")
    begin
        if (Rec."Lot No." > '') then
            if (STRPOS(Rec."Lot No.", '@') > 0) then begin
                Rec.CustomLotNumber := CopyStr(Rec."Lot No.", 1, StrPos(Rec."Lot No.", '@') - 1);
                Rec.CustomBOENumber := CopyStr(Rec."Lot No.", StrPos(Rec."Lot No.", '@') + 1, MaxStrLen(Rec.CustomBOENumber));
            end else
                Rec.CustomLotNumber := Rec."Lot No.";
        // Item Reclass
        if (Rec."New Lot No." > '') then
            if (STRPOS(Rec."New Lot No.", '@') > 0) then begin
                Rec."New Custom Lot No." := CopyStr(Rec."New Lot No.", 1, StrPos(Rec."New Lot No.", '@') - 1);
                Rec."New Custom BOE No." := CopyStr(Rec."New Lot No.", StrPos(Rec."New Lot No.", '@') + 1, MaxStrLen(Rec."New Custom BOE No."));
            end else
                Rec."New Custom Lot No." := Rec."New Lot No.";
    end;

    [EventSubscriber(ObjectType::Table, database::"Reservation Entry", 'OnBeforeInsertEvent', '', true, true)]
    local procedure OnBeforeInsertReservEntry(var Rec: Record "Reservation Entry")
    begin

        if (Rec."Lot No." > '') then
            if (STRPOS(Rec."Lot No.", '@') > 0) then begin
                Rec.CustomLotNumber := CopyStr(Rec."Lot No.", 1, StrPos(Rec."Lot No.", '@') - 1);
                Rec.CustomBOENumber := CopyStr(Rec."Lot No.", StrPos(Rec."Lot No.", '@') + 1, MaxStrLen(Rec.CustomBOENumber));
            end else
                Rec.CustomLotNumber := Rec."Lot No.";
        // Item Reclass
        if (Rec."New Lot No." > '') then
            if (STRPOS(Rec."New Lot No.", '@') > 0) then begin
                Rec."New Custom Lot No." := CopyStr(Rec."New Lot No.", 1, StrPos(Rec."New Lot No.", '@') - 1);
                Rec."New Custom BOE No." := CopyStr(Rec."New Lot No.", StrPos(Rec."New Lot No.", '@') + 1, MaxStrLen(Rec."New Custom BOE No."));
            end else
                Rec."New Custom Lot No." := Rec."New Lot No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", 'OnAfterInsertEvent', '', true, true)]
    local procedure CopyCustomBOENoFromHdr(var Rec: Record "Transfer Line"; RunTrigger: Boolean)
    var
        TransferHdrL: Record "Transfer Header";
    begin
        if not RunTrigger then
            exit;
        TransferHdrL.get(Rec."Document No.");
        Rec.CustomBOENumber := TransferHdrL.CustomBOENumber;
        Rec.Modify();
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', true, true)]
    local procedure UpdateCustomBOENoFromSalesHdr(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        SalesHeaderL: Record "Sales Header";
    begin
        if not RunTrigger then
            exit;
        SalesHeaderL.Get(Rec."Document Type", Rec."Document No.");
        Rec.CustomBOENumber := SalesHeaderL.CustomBOENumber;
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnQueryClosePageEvent', '', true, true)]
    local procedure UpdateCustomBOENoFromTrackingLines(var Rec: Record "Tracking Specification")
    var
        TransferLinesL: Record "Transfer Line";
        PurchaseLineL: Record "Purchase Line";
        SalesLineL: Record "Sales Line";
    begin
        case true of
            TransferLinesL.Get(Rec."Source ID", Rec."Source Ref. No."):
                begin
                    TransferLinesL.CustomBOENumber := Rec.CustomBOENumber;
                    TransferLinesL.Modify();
                end;
            PurchaseLineL.Get(PurchaseLineL."Document Type"::"Return Order", Rec."Source ID", Rec."Source Ref. No."):
                begin
                    PurchaseLineL.CustomBOENumber := Rec.CustomBOENumber;
                    PurchaseLineL.Modify();
                end;
            SalesLineL.Get(SalesLineL."Document Type"::Order, Rec."Source ID", Rec."Source Ref. No."):
                begin
                    SalesLineL.CustomBOENumber := Rec.CustomBOENumber;
                    SalesLineL.Modify();
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertSetupTempSplitItemJnlLine', '', true, true)]
    local procedure UpdateItemJournalCustomBOEandLotNoFromTrackingSpec(var TempItemJournalLine: Record "Item Journal Line"; var TempTrackingSpecification: Record "Tracking Specification")
    begin
        TempItemJournalLine.CustomLotNumber := TempTrackingSpecification.CustomLotNumber;
        TempItemJournalLine.CustomBOENumber := TempTrackingSpecification.CustomBOENumber;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterCreateItemJnlLine', '', true, true)]
    local procedure CopyCustomBOENoFromTransferLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line")
    begin
        ItemJournalLine.CustomBOENumber := TransferLine.CustomBOENumber;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforePostItemJournalLine', '', true, true)]
    local procedure CopyCustomBOENoFromTranferReceipt(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line")
    begin
        ItemJournalLine.CustomBOENumber := TransferLine.CustomBOENumber;
    end;

    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", 'OnAfterCreateShptHeader', '', true, true)]
    local procedure CustumBOENoUpdateToWarehouseShipment(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WarehouseRequest: Record "Warehouse Request")
    var
        TransferHdrL: Record "Transfer Header";
    begin
        case WarehouseRequest."Source Document" of
            WarehouseRequest."Source Document"::"Outbound Transfer":
                begin
                    TransferHdrL.Get(WarehouseRequest."Source No.");
                    // WarehouseShipmentHeader.cus
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", 'OnAfterCreateRcptHeader', '', true, true)]
    local procedure UpdateBOENoFromPurchaseHeader(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; PurchaseLine: Record "Purchase Line"; WarehouseRequest: Record "Warehouse Request")
    var
        TransferHdrL: Record "Transfer Header";
    begin
        case WarehouseRequest."Source Document" of
            WarehouseRequest."Source Document"::"Outbound Transfer":
                begin
                    TransferHdrL.Get(WarehouseRequest."Source No.");
                    WarehouseReceiptHeader.CustomBOENumber := TransferHdrL.CustomBOENumber;
                end;
            WarehouseRequest."Source Document"::"Purchase Order":
                WarehouseReceiptHeader.CustomBOENumber := PurchaseLine.CustomBOENumber;
        end;
    end;

    //BC26 Upg -OS
    // [EventSubscriber(ObjectType::Codeunit, codeunit::"Whse.-Create Source Document", 'OnPurchLine2ReceiptLineOnAfterSetQtysOnRcptLine', '', true, true)]
    // local procedure UpdateBOENoFromHeader(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; PurchaseLine: Record "Purchase Line")
    // begin
    //     WarehouseReceiptLine.CustomBOENumber := PurchaseLine.CustomBOENumber;
    // end;
    //BC26 Upg -OE
    //BC26 Upg -NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchases Warehouse Mgt.", OnPurchLine2ReceiptLineOnAfterSetQtysOnRcptLine, '', false, false)]
    local procedure "Purchases Warehouse Mgt._OnPurchLine2ReceiptLineOnAfterSetQtysOnRcptLine"(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; PurchaseLine: Record "Purchase Line")
    begin
        WarehouseReceiptLine.CustomBOENumber := PurchaseLine.CustomBOENumber;
    end;
    //BC26 Upg -NE

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', true, true)]
    //     local procedure DisablePostingOptionPurchase(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean)
    //     begin
    //         HideDialog := true;
    //         CASE PurchaseHeader."Document Type" OF
    //             PurchaseHeader."Document Type"::Order:
    //                 begin
    //                     Selection := STRMENU(ReceiveInvoiceQst, 1);
    //                     IF Selection = 0 THEN begin
    //                         IsHandled := true;
    //                         EXIT;
    //                     end;
    //                     PurchaseHeader.Receive := true;
    //                 end;
    //             PurchaseHeader."Document Type"::"Return Order":
    //                 begin
    //                     Selection := STRMENU(ReceiveInvoiceQst_Sales, 1);
    //                     IF Selection = 0 THEN begin
    //                         IsHandled := true;
    //                         EXIT;
    //                     end;
    //                     PurchaseHeader.Ship := true;
    //                 end;
    //         end;
    //     end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", 'OnBeforeConfirmPost', '', true, true)]
    //     local procedure DisablePostingOptionPurchasePrint(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean)
    //     begin
    //         HideDialog := true;
    //         CASE PurchaseHeader."Document Type" OF
    //             PurchaseHeader."Document Type"::Order:
    //                 begin
    //                     Selection := STRMENU(ReceiveInvoiceQst, 1);
    //                     IF Selection = 0 THEN begin
    //                         IsHandled := true;
    //                         EXIT;
    //                     end;
    //                     PurchaseHeader.Receive := true;
    //                 end;
    //             PurchaseHeader."Document Type"::"Return Order":
    //                 begin
    //                     Selection := STRMENU(ReceiveInvoiceQst_Sales, 1);
    //                     IF Selection = 0 THEN begin
    //                         IsHandled := true;
    //                         EXIT;
    //                     end;
    //                     PurchaseHeader.Ship := true;
    //                 end;
    //         end;
    //     end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', true, true)]
    //     local procedure DisablePostingOptionSales(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean)
    //     begin
    //         //PSP 06-05-20
    //         if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
    //             exit;
    //         //PSP 06-05-20
    //         HideDialog := true;
    //         CASE SalesHeader."Document Type" OF
    //             SalesHeader."Document Type"::Order:
    //                 BEGIN
    //                     Selection_Sales := STRMENU(ReceiveInvoiceQst_Sales, 1);
    //                     IF Selection_Sales = 0 THEN begin
    //                         IsHandled := true;
    //                         EXIT;
    //                     end;
    //                     SalesHeader.Ship := true;
    //                 end;
    //             SalesHeader."Document Type"::"Return Order":
    //                 BEGIN
    //                     Selection_Sales := STRMENU(ReceiveInvoiceQst, 1);
    //                     IF Selection_Sales = 0 THEN begin
    //                         IsHandled := true;
    //                         EXIT;
    //                     end;
    //                     SalesHeader.Receive := true;
    //                 end;
    //         end;
    //     end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforeConfirmPost', '', true, true)]
    //     local procedure DisablePostingOptionSalesPrint(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean)
    //     begin
    //         HideDialog := true;
    //         CASE SalesHeader."Document Type" OF
    //             SalesHeader."Document Type"::Order:
    //                 BEGIN
    //                     Selection_Sales := STRMENU(ReceiveInvoiceQst_Sales, 1);
    //                     IF Selection_Sales = 0 THEN begin
    //                         IsHandled := true;
    //                         EXIT;
    //                     end;
    //                     SalesHeader.Ship := true;
    //                 end;
    //             SalesHeader."Document Type"::"Return Order":
    //                 BEGIN
    //                     Selection_Sales := STRMENU(ReceiveInvoiceQst, 1);
    //                     IF Selection_Sales = 0 THEN begin
    //                         IsHandled := true;
    //                         EXIT;
    //                     end;
    //                     SalesHeader.Receive := true;
    //                 end;
    //         end;
    //     end;

    local procedure GetCustomBOEFromILEForTrackingSpecification(var TrackingSpecificationP: Record "Tracking Specification")
    var
        ItemLedgEntryL: Record "Item Ledger Entry";
        AppliedQty: Decimal;
    begin
        TrackingSpecificationP.CustomBOENumber2 := '';
        ItemLedgEntryL.RESET;
        ItemLedgEntryL.SETCURRENTKEY("Item No.", Open, "Variant Code", "Location Code", "Item Tracking", "Lot No.", "Serial No.");
        ItemLedgEntryL.SETRANGE("Item No.", TrackingSpecificationP."Item No.");
        ItemLedgEntryL.SETRANGE("Variant Code", TrackingSpecificationP."Variant Code");
        ItemLedgEntryL.SETRANGE(Open, true);
        ItemLedgEntryL.SETRANGE("Location Code", TrackingSpecificationP."Location Code");
        ItemLedgEntryL.SETRANGE("Lot No.", TrackingSpecificationP."Lot No.");
        if ItemLedgEntryL.FindFirst() then
            repeat
                if TrackingSpecificationP.CustomBOENumber2 > '' then
                    TrackingSpecificationP.CustomBOENumber2 += ',';
                ItemLedgEntryL.CALCFIELDS("Reserved Quantity");
                AppliedQty += ItemLedgEntryL."Remaining Quantity" - ItemLedgEntryL."Reserved Quantity";
                TrackingSpecificationP.CustomBOENumber2 += ItemLedgEntryL.CustomBOENumber;
                ItemLedgEntryL.Next(1);
            until abs(TrackingSpecificationP."Qty. to Handle (Base)") <= AppliedQty;
    end;

    local procedure GetCustomBOEFromILEForSalesShipment(var ItemLedgEntryP: Record "Item Ledger Entry")
    var
        ItemLedgEntryL: Record "Item Ledger Entry";
        AppliedQty: Decimal;
    begin
        ItemLedgEntryL.RESET;
        ItemLedgEntryL.SETCURRENTKEY("Item No.", Open, "Variant Code", "Location Code", "Item Tracking", "Lot No.", "Serial No.");
        ItemLedgEntryL.SETRANGE("Item No.", ItemLedgEntryP."Item No.");
        ItemLedgEntryL.SETRANGE("Variant Code", ItemLedgEntryP."Variant Code");
        ItemLedgEntryL.SETRANGE(Open, true);
        ItemLedgEntryL.SETRANGE("Location Code", ItemLedgEntryP."Location Code");
        ItemLedgEntryL.SETRANGE("Lot No.", ItemLedgEntryP."Lot No.");
        if ItemLedgEntryL.FindFirst() then
            repeat
                if ItemLedgEntryP.CustomBOENumber2 > '' then
                    ItemLedgEntryP.CustomBOENumber2 += ',';
                ItemLedgEntryL.CALCFIELDS("Reserved Quantity");
                AppliedQty += ItemLedgEntryL."Remaining Quantity" - ItemLedgEntryL."Reserved Quantity";
                ItemLedgEntryP.CustomBOENumber2 += ItemLedgEntryL.CustomBOENumber;
                ItemLedgEntryL.Next(1);
            until abs(ItemLedgEntryP.Quantity) <= AppliedQty;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnTransferItemLedgToTempRecOnBeforeInsert', '', true, true)]
    local procedure UpdateCustomBOEandLOTNoFromILE(var TempGlobalReservEntry: Record "Reservation Entry"; ItemLedgerEntry: Record "Item Ledger Entry"; TrackingSpecification: Record "Tracking Specification")
    begin
        // moved  from fetchingSupplNoOnSales extension
        TempGlobalReservEntry."Supplier Batch No. 2" := ItemLedgerEntry."Supplier Batch No. 2";
        TempGlobalReservEntry."Manufacturing Date 2" := ItemLedgerEntry."Manufacturing Date 2";
        TempGlobalReservEntry."Expiry Period 2" := ItemLedgerEntry."Expiry Period 2";
        TempGlobalReservEntry."Net Weight 2" := ItemLedgerEntry."Net Weight 2";
        TempGlobalReservEntry."Gross Weight 2" := ItemLedgerEntry."Gross Weight 2";

        //From Isys
        TempGlobalReservEntry.CustomBOENumber := ItemLedgerEntry.CustomBOENumber;
        TempGlobalReservEntry.CustomLotNumber := ItemLedgerEntry.CustomLotNumber;

        TempGlobalReservEntry."Manufacturing Date 2" := ItemLedgerEntry."Manufacturing Date 2";
        TempGlobalReservEntry."Expiry Period 2" := ItemLedgerEntry."Expiry Period 2";
        if TrackingSpecification.IsReclass() then begin
            TempGlobalReservEntry."New Custom BOE No." := ItemLedgerEntry.CustomBOENumber;
            TempGlobalReservEntry."New Custom Lot No." := ItemLedgerEntry.CustomLotNumber;
            if ItemLedgerEntry.CustomBOENumber = '' then
                TempGlobalReservEntry."New Lot No." := ItemLedgerEntry.CustomLotNumber
            else
                TempGlobalReservEntry."New Lot No." := ItemLedgerEntry.CustomLotNumber + '@' + ItemLedgerEntry.CustomBOENumber;
        end;
    end;


    // moved  from fetchingSupplNoOnSales extension
    [EventSubscriber(ObjectType::Codeunit, 6501, 'OnAfterAssistEditTrackingNo', '', false, false)]
    procedure ShowonTrackingSpec(VAR TrackingSpecification: Record "Tracking Specification"; VAR TempGlobalEntrySummary: Record "Entry Summary" TEMPORARY)
    begin
        TrackingSpecification."Supplier Batch No. 2" := TempGlobalEntrySummary."Supplier Batch No. 2";
        TrackingSpecification.CustomBOENumber := TempGlobalEntrySummary.CustomBOENumber;
        TrackingSpecification.CustomLotNumber := TempGlobalEntrySummary.CustomLotNumber;
        TrackingSpecification."Manufacturing Date 2" := TempGlobalEntrySummary."Manufacturing Date 2";
        TrackingSpecification."Expiry Period 2" := TempGlobalEntrySummary."Expiry Period 2";
        TrackingSpecification."Net Weight 2" := TempGlobalEntrySummary."Net Weight 2";
        TrackingSpecification."Gross Weight 2" := TempGlobalEntrySummary."Gross Weight 2";
        //TempGlobalEntrySummary.MODIFY;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnAfterCreateEntrySummary2', '', true, true)]
    local procedure UpdateCustomBOEandLotNoFromReservatioEntry(var TempGlobalEntrySummary: Record "Entry Summary"; var TempGlobalReservEntry: Record "Reservation Entry")
    var
        ItemLedgerEntryL: Record "Item Ledger Entry";
    begin
        //Moved From fetchingSupplNoOnSales
        TempGlobalEntrySummary."Supplier Batch No. 2" := TempGlobalReservEntry."Supplier Batch No. 2";
        TempGlobalEntrySummary."Manufacturing Date 2" := TempGlobalReservEntry."Manufacturing Date 2";
        TempGlobalEntrySummary."Expiry Period 2" := TempGlobalReservEntry."Expiry Period 2";
        TempGlobalEntrySummary."Net Weight 2" := TempGlobalReservEntry."Net Weight 2";
        TempGlobalEntrySummary."Gross Weight 2" := TempGlobalReservEntry."Gross Weight 2";

        //From Isys
        TempGlobalEntrySummary.CustomBOENumber := TempGlobalReservEntry.CustomBOENumber;
        TempGlobalEntrySummary.CustomLotNumber := TempGlobalReservEntry.CustomLotNumber;
        // Select entries
        If (TempGlobalReservEntry."Source Type" = Database::"Item Ledger Entry") and
            ItemLedgerEntryL.Get(TempGlobalReservEntry."Source Ref. No.")
        then
            TempGlobalEntrySummary."Posting Date" := ItemLedgerEntryL."Posting Date";
        OnBeforeModifyEnrtySummary(TempGlobalEntrySummary, TempGlobalReservEntry);
        TempGlobalEntrySummary.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnAfterTransferExpDateFromSummary', '', true, true)]
    local procedure UpdateCustomBOEandLotNoForTrackingLineFromEntrySummary(var TrackingSpecification: Record "Tracking Specification"; var TempEntrySummary: Record "Entry Summary")
    begin
        TrackingSpecification.CustomBOENumber := TempEntrySummary.CustomBOENumber;
        TrackingSpecification.CustomLotNumber := TempEntrySummary.CustomLotNumber;
        TrackingSpecification."Supplier Batch No. 2" := TempEntrySummary."Supplier Batch No. 2";
        TrackingSpecification."Manufacturing Date 2" := TempEntrySummary."Manufacturing Date 2";
        TrackingSpecification."Expiry Period 2" := TempEntrySummary."Expiry Period 2";
        if TrackingSpecification.IsReclass() then begin
            TrackingSpecification."New Custom BOE No." := TempEntrySummary.CustomBOENumber;
            TrackingSpecification."New Custom Lot No." := TempEntrySummary.CustomLotNumber;
            if TempEntrySummary.CustomBOENumber = '' then
                TrackingSpecification."New Lot No." := TempEntrySummary.CustomLotNumber
            else
                TrackingSpecification."New Lot No." := TempEntrySummary.CustomLotNumber + '@' + TempEntrySummary.CustomBOENumber;
        end;
    end;


    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnAddReservEntriesToTempRecSetOnBeforeInsert, '', false, false)]
    local procedure "Item Tracking Lines_OnAddReservEntriesToTempRecSetOnBeforeInsert"(var TempTrackingSpecification: Record "Tracking Specification" temporary; ReservationEntry: Record "Reservation Entry"; SwapSign: Boolean; Color: Integer)
    begin
        TempTrackingSpecification.CustomBOENumber := ReservationEntry.CustomBOENumber;
        TempTrackingSpecification."Expiration Date" := ReservationEntry."Expiration Date";

    end;


    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesHeader', '', true, true)]
    local procedure UpdateBillOfExitFromSalesHeader(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header")
    begin
        ItemJnlLine.BillOfExit := SalesHeader.BillOfExit;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLine', '', true, true)]
    local procedure UpdateBillOfExitFromSalesInvoice(var SalesLine: Record "Sales Line")
    var
        ItemLedgerEnterL: Record "Item Ledger Entry";
    begin
        ItemLedgerEnterL.SetRange("Document Type", ItemLedgerEnterL."Document Type"::"Sales Shipment");
        ItemLedgerEnterL.SetRange("Document No.", SalesLine."Shipment No.");
        ItemLedgerEnterL.SetRange("Document Line No.", SalesLine."Shipment Line No.");
        if ItemLedgerEnterL.FindSet() then
            repeat
                ItemLedgerEnterL.BillOfExit := SalesLine.BillOfExit;
                ItemLedgerEnterL.Modify();
            until ItemLedgerEnterL.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnBeforeInsertInvLineFromShptLine', '', true, true)]
    local procedure UpdateBillOfExitFromSalesShipmentToSalesInvLine(var SalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    var
        ItemLedgerEnterL: Record "Item Ledger Entry";
    begin
        ItemLedgerEnterL.SetRange("Document Type", ItemLedgerEnterL."Document Type"::"Sales Shipment");
        ItemLedgerEnterL.SetRange("Document No.", SalesShptLine."Document No.");
        ItemLedgerEnterL.SetRange("Document Line No.", SalesShptLine."Line No.");
        if ItemLedgerEnterL.FindFirst() then
            SalesLine.BillOfExit := ItemLedgerEnterL.BillOfExit;

        SalesLine.HSNCode := SalesShptLine.HSNCode;
        SalesLine.CountryOfOrigin := SalesShptLine.CountryOfOrigin;
        SalesLine.LineHSNCode := SalesShptLine.LineHSNCode;
        SalesLine.LineCountryOfOrigin := SalesShptLine.LineCountryOfOrigin;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'BillOfExit', true, true)]
    local procedure UpdateBillOfExitToSalesInLineFromSalesInvHdr(var Rec: Record "Sales Header")
    var
        SalesLineL: Record "Sales Line";
    begin
        SalesLineL.SetRange("Document Type", Rec."Document Type");
        SalesLineL.SetRange("Document No.", Rec."No.");
        SalesLineL.ModifyAll(BillOfExit, Rec.BillOfExit);
    end;


    //PackingListExtChange
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Unit Price', true, true)]
    local procedure UpdateUnitPriceFromUnitPriceExtVat(var Rec: Record "Sales Line")
    begin
        Rec."Unit Price Base UOM 2" := Rec."Unit Price" / rec."Qty. per Unit of Measure";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Management", 'OnAfterInitReservEntry', '', true, true)]
    local procedure CopyCustomLotAndBOENumberToResvEntry(ItemLedgerEntry: Record "Item Ledger Entry"; var ReservEntry: Record "Reservation Entry")
    begin
        ReservEntry.CustomBOENumber := ItemLedgerEntry.CustomBOENumber;
        ReservEntry.CustomLotNumber := ItemLedgerEntry.CustomLotNumber;
        ReservEntry."Supplier Batch No. 2" := ItemLedgerEntry."Supplier Batch No. 2";
    end;

    // Event to copy the values from Sales shipment to Invoice during Get Shipment lines.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", 'OnAfterInsertLine', '', true, true)]
    local procedure UpdateHeaderfieldsFromSalesShipment(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line") //T-12855 Event Uncommented
    var
        SalesHdrL: Record "Sales Header";
        SalesShpHdrL: Record "Sales Shipment Header";
        Salesheader2: Record "Sales Header";
    begin
        SalesHdrL.get(SalesLine."Document Type", SalesLine."Document No."); //T-12855
        SalesShpHdrL.get(SalesShptLine."Document No."); //T-12855
        Salesheader2.get(Salesheader2."Document Type"::Order, SalesShptLine."Order No.");
        //         //PackingListExtChange
        SalesHdrL.Validate("Ship-to Code", SalesShpHdrL."Ship-to Code");
        // Validate("Bill-to Customer No.", SalesShpHdrL."Bill-to Customer No.");
        SalesHdrL."Payment Terms Code" := SalesShpHdrL."Payment Terms Code";
        SalesHdrL."Payment Method Code" := SalesShpHdrL."Payment Method Code";
        SalesHdrL."External Document No." := SalesShpHdrL."External Document No.";
        SalesHdrL."Shipment Method Code" := SalesShpHdrL."Shipment Method Code";
        SalesHdrL."Transaction Specification" := SalesShpHdrL."Transaction Specification";
        SalesHdrL."Exit Point" := SalesShpHdrL."Exit Point";
        SalesHdrL."Shipping Agent Code" := SalesShpHdrL."Shipping Agent Code";
        SalesHdrL."Transport Method" := SalesShpHdrL."Transport Method";
        SalesHdrL."Area" := SalesShpHdrL."Area";
        SalesHdrL."Inspection Required 2" := SalesShpHdrL."Inspection Required 2";
        SalesHdrL."Legalization Required 2" := SalesShpHdrL."Legalization Required 2";
        SalesHdrL."Order Date" := SalesShpHdrL."Order Date";
        SalesHdrL."Bank on Invoice 2" := SalesShpHdrL."Bank on Invoice 2"; //T-12855
        SalesHdrL."Due Date" := SalesShpHdrL."Due Date";
        SalesHdrL."Maximum Allowed Due days" := Salesheader2."Maximum Allowed Due days";
        SalesHdrL."Salesperson Code" := SalesShpHdrL."Salesperson Code";

        SalesHdrL.Modify();

        //IC Sales flow 05-02-2020 start
        SalesLine."IC Customer" := SalesShptLine."IC Customer";
        SalesLine."IC Related SO" := SalesShptLine."IC Related SO";
        //Hypercare-12-03-2025-OS-NetWtGrossWt
        // SalesLine."Net Weight" := SalesShptLine."Net Weight";
        // SalesLine."Gross Weight" := SalesShptLine."Gross Weight";
        //Hypercare-12-03-2025-OE-NetWtGrossWt
        SalesLine.Modify();

        //IC Sales flow 05-02-2020 end

    end;



    //     // [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnAfterCreatePurchDocument', '', true, true)]
    //     // local procedure CopyItemTrackingRecords(var PurchaseHeader: Record "Purchase Header"; ICInboxPurchaseHeader: Record "IC Inbox Purchase Header")
    //     // var
    //     //     ICPartner: Record "IC Partner";
    //     //     PartnerTrackingLineL: Record "Tracking Specification";
    //     //     ReserEntryL: Record "Reservation Entry";
    //     //     SalesHeaderL: Record "Sales Header";
    //     //     PurcLineL: Record "Purchase Line";
    //     //     EntryNoL: Integer;
    //     //     SalesShipmentLine: Record "Sales Shipment Line";
    //     //     Createres: Codeunit "Create Reserv. Entry";
    //     //     ILE: Record "Item Ledger Entry";
    //     // begin
    //     /*if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
    //         exit;
    //     If not ICPartner.Get(ICInboxPurchaseHeader."IC Partner Code") then
    //         exit;
    //     ReserEntryL.Reset();
    //     if ReserEntryL.FindLast() then
    //         EntryNoL := ReserEntryL."Entry No.";
    //     IF (ICPartner."Inbox Type" = ICPartner."Inbox Type"::Database) and (ICPartner."Inbox Details" > '') then begin
    //         SalesHeaderL.ChangeCompany(ICPartner."Inbox Details");
    //         PartnerTrackingLineL.ChangeCompany(ICPartner."Inbox Details");

    //         SalesShipmentLine.ChangeCompany(ICPartner."Inbox Details");
    //         if SalesHeaderL.Get(SalesHeaderL."Document Type"::Order, ICInboxPurchaseHeader."No.") then;
    //         SalesShipmentLine.SetRange("Order No.", ICInboxPurchaseHeader."No.");
    //         if SalesShipmentLine.FindSet() then begin
    //             ILE.SetRange("Document Type", ILE."Document Type"::"Sales Shipment");
    //             ILE.SetRange("Document No.", SalesShipmentLine."Document No.");
    //             repeat
    //                 if PurcLineL.Get(PurchaseHeader."Document Type", PurchaseHeader."No.", ILE."Document Line No.") then begin
    //                     EntryNoL += 1;
    //                     ReserEntryL.Init();
    //                     // ReserEntryL.TransferFields(ILE);
    //                     ReserEntryL.Validate("Item No.", ILE."Item No.");
    //                     ReserEntryL."Reservation Status" := ReserEntryL."Reservation Status"::Surplus;
    //                     ReserEntryL."Item Ledger Entry No." := 0;
    //                     ReserEntryL.SetSource(Database::"Purchase Line", PurcLineL."Document Type", PurcLineL."Document No.", PurcLineL."Line No.", '', 0);
    //                     R
    //                     ReserEntryL."Expected Receipt Date" := PurcLineL."Expected Receipt Date";
    //                     ReserEntryL.Validate("Quantity (Base)", Abs(ile.Quantity));
    //                     ReserEntryL.Positive := true;
    //                     ReserEntryL.CustomBOENumber := '';
    //                     If StrPos(ILE."Lot No.", '@') > 0 then
    //                         ReserEntryL."Lot No." := COPYSTR(ILE."Lot No.", 1, STRPOS(ILE."Lot No.", '@') - 1)
    //                     else
    //                         ReserEntryL."Lot No." := ILE."Lot No.";
    //                     ReserEntryL.CustomLotNumber := ReserEntryL."Lot No.";
    //                     ReserEntryL."Entry No." := EntryNoL;
    //                     ReserEntryL.Insert(true);
    //                     PurcLineL."Location Code" := ReserEntryL."Location Code";
    //                     PurcLineL.Modify();
    //                 end;
    //             until ILE.Next() = 0;
    //         end;
    //         */
    //     // PartnerTrackingLineL.SetRange("Source Type", Database::"Sales Line");
    //     // PartnerTrackingLineL.SetRange("Source Subtype", SalesHeaderL."Document Type"::Order);
    //     // PartnerTrackingLineL.SetRange("Source ID", SalesHeaderL."No.");
    //     // if PartnerTrackingLineL.FindSet() then
    //     //     repeat
    //     //         if PurcLineL.Get(PurchaseHeader."Document Type", PurchaseHeader."No.", PartnerTrackingLineL."Source Ref. No.") then begin
    //     //             EntryNoL += 1;
    //     //             ReserEntryL.Init();
    //     //             ReserEntryL.TransferFields(PartnerTrackingLineL);
    //     //             ReserEntryL."Reservation Status" := ReserEntryL."Reservation Status"::Surplus;
    //     //             ReserEntryL."Item Ledger Entry No." := 0;
    //     //             ReserEntryL.SetSource(Database::"Purchase Line", PurcLineL."Document Type", PurcLineL."Document No.", PurcLineL."Line No.", '', 0);
    //     //             ReserEntryL."Expected Receipt Date" := PurcLineL."Expected Receipt Date";
    //     //             ReserEntryL.Validate("Quantity (Base)", Abs(PartnerTrackingLineL."Quantity (Base)"));
    //     //             ReserEntryL.Positive := true;
    //     //             ReserEntryL.CustomBOENumber := '';

    //     //             If StrPos(PartnerTrackingLineL."Lot No.", '@') > 0 then
    //     //                 ReserEntryL."Lot No." := COPYSTR(PartnerTrackingLineL."Lot No.", 1, STRPOS(PartnerTrackingLineL."Lot No.", '@') - 1)
    //     //             else
    //     //                 ReserEntryL."Lot No." := PartnerTrackingLineL."Lot No.";

    //     //             ReserEntryL.CustomLotNumber := ReserEntryL."Lot No.";
    //     //             ReserEntryL."Entry No." := EntryNoL;
    //     //             ReserEntryL.Insert();
    //     //             PurcLineL."Location Code" := ReserEntryL."Location Code";
    //     //             PurcLineL.Modify();
    //     //         end;
    //     //     until PartnerTrackingLineL.Next() = 0;
    //     // end;
    //     // end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnCreateOutboxSalesDocTransOnAfterICOutBoxSalesLineInsert', '', true, true)]
    //     local procedure OnCreateOutboxSalesDocTransOnAfterICOutBoxSalesLineInsert(var ICOutboxSalesLine: Record "IC Outbox Sales Line"; SalesLine: Record "Sales Line")
    //     begin

    //         ICOutBoxSalesLine."Variant Code" := SalesLine."Variant Code";
    //         ICOutBoxSalesLine.Modify();
    //     end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnAfterICOutBoxSalesLineInsert', '', true, true)]
    //     local procedure OnAfterICOutBoxSalesLineInsert(var SalesLine: Record "Sales Line"; var ICOutboxSalesLine: Record "IC Outbox Sales Line")
    //     begin
    //         ICOutBoxSalesLine."Variant Code" := SalesLine."Variant Code";
    //         ICOutBoxSalesLine.Modify();
    //     end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnAfterICInboxPurchLineInsert', '', true, true)]
    //     local procedure OnAfterICInboxPurchLineInsert(var ICInboxPurchaseLine: Record "IC Inbox Purchase Line"; ICOutboxSalesLine: Record "IC Outbox Sales Line")
    //     begin
    //         ICInboxPurchaseLine."Variant Code" := ICOutboxSalesLine."Variant Code";
    //         ICInboxPurchaseLine.Modify();

    //     end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnCreatePurchLinesOnAfterModify', '', true, true)]
    //     local procedure OnCreatePurchLinesOnAfterModify(var PurchaseLine: Record "Purchase Line"; ICInboxPurchLine: Record "IC Inbox Purchase Line")
    //     begin
    //         PurchaseLine."Variant Code" := ICInboxPurchLine."Variant Code";
    //         PurchaseLine.Modify();
    //     end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnCreatePurchLinesOnAfterTransferFields', '', true, true)]
    //     local procedure OnCreatePurchLinesOnAfterTransferFields(var PurchaseLine: Record "Purchase Line"; ICInboxPurchLine: Record "IC Inbox Purchase Line")
    //     begin
    //         PurchaseLine."Variant Code" := ICInboxPurchLine."Variant Code";
    //         //PurchaseLine.Modify();
    //     end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnAfterCreatePurchLines', '', true, true)]
    //     local procedure OnAfterCreatePurchLines(ICInboxPurchLine: Record "IC Inbox Purchase Line"; var PurchLine: Record "Purchase Line")
    //     begin
    //         PurchLine."Variant Code" := ICInboxPurchLine."Variant Code";
    //         PurchLine.Modify();
    //     end;

    //ICTransaction Testing Rakshith & Mayank 25-02-2025

    //T13919-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, OnCreatePurchDocumentOnBeforePurchHeaderModify, '', false, false)]
    local procedure ICInboxOutboxMgt_OnCreatePurchDocumentOnBeforePurchHeaderModify(var PurchHeader: Record "Purchase Header"; ICInboxPurchHeader: Record "IC Inbox Purchase Header")
    begin
        PurchHeader."IC Transaction No." := ICInboxPurchHeader."IC Transaction No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, OnCreateSalesDocumentOnBeforeSalesHeaderModify, '', false, false)]
    local procedure ICInboxOutboxMgt_OnCreateSalesDocumentOnBeforeSalesHeaderModify(var SalesHeader: Record "Sales Header"; ICInboxSalesHeader: Record "IC Inbox Sales Header"; var ICDocDim: Record "IC Document Dimension")
    begin
        SalesHeader."IC Transaction No." := ICInboxSalesHeader."IC Transaction No.";
    end;


    /* [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyEventSalesHeader(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
        HandledICInboxSalesLine: Record "Handled IC Inbox Sales Line";
        Text0001: Label 'You cannot modify because this is Inter Commpany Transaction.';
    begin

        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;

        SalesHeader.Reset();
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        if SalesHeader."IC Transaction No." = 0 then
            exit;

        if Rec."IC Partner Ref. Type" = Rec."IC Partner Ref. Type"::"Cross Reference" then begin //Hypercare-09-04-2025-N
            HandledICInboxSalesLine.Reset();
            HandledICInboxSalesLine.SetRange("IC Transaction No.", SalesHeader."IC Transaction No.");
            HandledICInboxSalesLine.SetRange("Document Type", HandledICInboxSalesLine."Document Type"::Order);
            HandledICInboxSalesLine.SetFilter("IC Partner Reference", '<>%1', '');
            HandledICInboxSalesLine.SetRange("Line No.", Rec."Line No.");//09042025 ABA
            if HandledICInboxSalesLine.FindFirst() then begin

                if Rec.Quantity <> HandledICInboxSalesLine.Quantity then
                    Error(Text0001);
                if Rec."Unit of Measure Code" <> HandledICInboxSalesLine."Unit of Measure Code" then
                    Error(Text0001);
                if HandledICInboxSalesLine."IC Partner Ref. Type" = HandledICInboxSalesLine."IC Partner Ref. Type"::"Cross Reference" then
                    if Rec."IC Item Reference No." <> HandledICInboxSalesLine."IC Item Reference No." then
                        Error(Text0001);
            end;

            if Rec."No." <> xRec."No." then
                Error(Text0001);
            if Rec."Variant Code" <> xRec."Variant Code" then
                Error(Text0001);
            if Rec."Line Amount" <> xRec."Line Amount" then
                Error(Text0001);
            if Rec."Unit Price" <> xRec."Unit Price" then
                Error(Text0001);
            if Rec."Line Discount Amount" <> xRec."Line Discount Amount" then
                Error(Text0001);
            if Rec."Inv. Discount Amount" <> xRec."Inv. Discount Amount" then
                Error(Text0001);
            if Rec."Line Discount %" <> xRec."Line Discount %" then
                Error(Text0001);
        end;//Hypercare-09-04-2025-N
    End; */
    /* [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyEventPurchaseHeader(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; RunTrigger: Boolean)
    var
        PurchaseHeader: Record "Purchase Header";
        HandledICInboxPurchLine: Record "Handled IC Inbox Purch. Line";
        Text0001: Label 'You cannot modify because this is Inter Commpany Transaction.';
    begin

        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;

        PurchaseHeader.Reset();
        PurchaseHeader.Get(Rec."Document Type", Rec."Document No.");
        if PurchaseHeader."IC Transaction No." = 0 then
            exit;

        if Rec."IC Partner Ref. Type" = Rec."IC Partner Ref. Type"::"Cross Reference" then begin //Hypercare-09-04-2025-N
            HandledICInboxPurchLine.Reset();
            HandledICInboxPurchLine.SetRange("IC Transaction No.", PurchaseHeader."IC Transaction No.");
            HandledICInboxPurchLine.SetRange("Document Type", HandledICInboxPurchLine."Document Type"::Order);
            HandledICInboxPurchLine.SetRange("Line No.", Rec."Line No.");
            HandledICInboxPurchLine.SetFilter("IC Partner Reference", '<>%1', '');
            if HandledICInboxPurchLine.FindFirst() then begin

                if Rec.Quantity <> HandledICInboxPurchLine.Quantity then
                    Error(Text0001);
                if Rec."Unit of Measure Code" <> HandledICInboxPurchLine."Unit of Measure Code" then
                    Error(Text0001);
                if HandledICInboxPurchLine."IC Partner Ref. Type" = HandledICInboxPurchLine."IC Partner Ref. Type"::"Cross Reference" then
                    if Rec."IC Item Reference No." <> HandledICInboxPurchLine."IC Item Reference No." then
                        Error(Text0001);
            end;

            if Rec."No." <> xRec."No." then
                Error(Text0001);
            if Rec."Variant Code" <> xRec."Variant Code" then
                Error(Text0001);
            if Rec."Line Amount" <> xRec."Line Amount" then
                Error(Text0001);
            if Rec."Direct Unit Cost" <> xRec."Direct Unit Cost" then
                Error(Text0001);
            if Rec."Line Discount Amount" <> xRec."Line Discount Amount" then
                Error(Text0001);
            if Rec."Inv. Discount Amount" <> xRec."Inv. Discount Amount" then
                Error(Text0001);
            if Rec."Line Discount %" <> xRec."Line Discount %" then
                Error(Text0001);
        end;//Hypercare-09-04-2025-N
    end; */
    //T13919-NE

    //T13919-OS
    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnAfterCreatePurchDocument', '', true, true)]  //Hypercare use later-Anoop-Dhiren   07-03-2025 moved in to Quick Extenson
    procedure ICtrackingLineCopy(var PurchaseHeader: Record "Purchase Header"; ICInboxPurchaseHeader: Record "IC Inbox Purchase Header")
    var
        ICPartner: Record "IC Partner";
        PartnerTrackingLineL: Record "Tracking Specification";
        ReserEntryL: Record "Reservation Entry";
        SalesHeaderL: Record "Sales Header";
        PurchLine: Record "Purchase Line";
        EntryNoL: Integer;
        SalesShipmentLine: Record "Sales Shipment Line";
        //Createres: Codeunit "Create Reserv. Entry";
        ILE: Record "Item Ledger Entry";

    begin
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
            PurchLine.SetRange("Document No.", PurchaseHeader."No.");
            if PurchLine.FindSet() then begin
                repeat
                    if ICPartner.Get(ICInboxPurchaseHeader."IC Partner Code") then;
                    if ICPartner."Data Exchange Type" = ICPartner."Data Exchange Type"::Database then begin

                        SalesShipmentLine.ChangeCompany(ICPartner."Inbox Details");
                        ILE.ChangeCompany(ICPartner."Inbox Details");
                        SalesShipmentLine.SetRange("Order No.", ICInboxPurchaseHeader."No.");
                        SalesShipmentLine.SetRange("Line No.", PurchLine."Line No.");
                        if SalesShipmentLine.FindSet() then begin
                            repeat
                                ILE.SetRange("Document No.", SalesShipmentLine."Document No.");
                                ILE.SetRange("Document Type", ILE."Document Type"::"Sales Shipment");
                                ILE.SetRange("Document Line No.", SalesShipmentLine."Line No.");
                                if ILE.FindSet() then begin
                                    repeat
                                        EntryNoL := ReserEntryL.GetLastEntryNo() + 1;
                                        ReserEntryL.SetSource(Database::"Purchase Line", PurchLine."Document Type".AsInteger(), PurchLine."Document No.", PurchLine."Line No.", '', 0);//30-04-2022-Added As Integer with Enum
                                        ReserEntryL."Entry No." := EntryNoL;
                                        // ReserEntryL."Source ID" := PurchLine."Document No.";
                                        // ReserEntryL."Source Ref. No." := PurchLine."Line No.";
                                        ReserEntryL.Validate("Item No.", PurchLine."No.");
                                        ReserEntryL.Validate(Quantity, Abs(ILE.Quantity));
                                        ReserEntryL.Validate("Quantity (Base)", Abs(ILE.Quantity));
                                        ReserEntryL."Reservation Status" := ReserEntryL."Reservation Status"::Surplus;
                                        ReserEntryL."Item Ledger Entry No." := 0;
                                        ReserEntryL.Validate(CustomLotNumber, ILE.CustomLotNumber);
                                        ReserEntryL."Location Code" := SalesShipmentLine."Location Code";
                                        ReserEntryL."Lot No." := ILE.CustomLotNumber;
                                        ReserEntryL."Supplier Batch No. 2" := ILE."Supplier Batch No. 2";
                                        ReserEntryL."Expiration Date" := ILE."Expiration Date";
                                        ReserEntryL."Manufacturing Date 2" := ile."Manufacturing Date 2";
                                        ReserEntryL."Expiry Period 2" := ILE."Expiry Period 2";
                                        ReserEntryL."Variant Code" := ILE."Variant Code";                                        
                                        if ReserEntryL.Insert() then;
                                        PurchLine."Location Code" := SalesShipmentLine."Location Code";
                                        PurchLine.Modify();
                                    until ILE.Next() = 0;
                                end;
                            until SalesShipmentLine.Next() = 0;
                        end;
                    end;
                //Note: We have written API Base Intercompany Code in Quick Update Extension
                until PurchLine.Next() = 0;
            end;
        end;
        // end;
    end; */ //ICTransaction Testing Rakshith & Mayank 25-02-2025

    //T13919-OE

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnBeforeActionEvent', 'Post', true, true)]
    local procedure CheckBOEBeforePostEvent(var Rec: Record "Purchase Header")
    begin
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;
        Rec.TestField(CustomBOENumber);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnBeforeActionEvent', 'Post and &Print', true, true)]
    local procedure CheckBOEBeforePostandPrintEvent(var Rec: Record "Purchase Header")
    begin
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;
        Rec.TestField(CustomBOENumber);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Assembly Line", 'OnAfterValidateEvent', 'Quantity', true, true)]
    local procedure AssemblyLine_OnAfterQtyValidate(var Rec: Record "Assembly Line"; CurrFieldNo: Integer)
    var
        UnitofMeasureL: Record "Unit of Measure";
    begin
        // if CurrFieldNo <> Rec.FieldNo(Quantity) then
        //     exit;
        if UnitofMeasureL.Get(Rec."Unit of Measure Code") and
            not UnitofMeasureL."Decimal Allowed" and
            ((Rec.Quantity mod 1) <> 0) and
            (Rec.Quantity > 0)
        then
            Rec.Quantity := Round(Rec.Quantity, 1, '>');
        Rec."Quantity (Base)" := Rec.Quantity;
        Rec.InitRemainingQty();
        Rec.validate("Quantity to Consume", Rec.Quantity);
        if Rec.Modify() then;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Assembly Header", 'OnAfterValidateEvent', 'Quantity', true, true)]
    procedure AssemblyHeader_OnAfterQtyValidate(var Rec: Record "Assembly Header"; CurrFieldNo: Integer)
    var
        AssemblyLineL: Record "Assembly Line";
        UnitofMeasureL: Record "Unit of Measure";
    begin
        if CurrFieldNo <> Rec.FieldNo(Quantity) then
            exit;
        AssemblyLineL.SetRange("Document Type", Rec."Document Type");
        AssemblyLineL.SetRange("Document No.", Rec."No.");
        if AssemblyLineL.FindSet() then
            repeat
                if UnitofMeasureL.Get(AssemblyLineL."Unit of Measure Code") and
                    not UnitofMeasureL."Decimal Allowed" and
                    ((Rec.Quantity * AssemblyLineL."Quantity per" mod 1) <> 0) and
                    (Rec.Quantity * AssemblyLineL."Quantity per" > 0) and
                    (AssemblyLineL."Quantity Per" > 0)
                then
                    AssemblyLineL.Quantity := Round(Rec.Quantity * AssemblyLineL."Quantity per", 1, '>')
                else
                    AssemblyLineL.Quantity := (Rec.Quantity * AssemblyLineL."Quantity per");
                AssemblyLineL."Quantity (Base)" := AssemblyLineL.Quantity;
                AssemblyLineL.InitRemainingQty();
                AssemblyLineL.validate("Quantity to Consume", AssemblyLineL.Quantity);
                AssemblyLineL.Modify();
            until AssemblyLineL.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Assembly Header", 'OnAfterValidateEvent', 'Item No.', true, true)]
    local procedure AssemblyHeader_OnAfterItemNoValidate(var Rec: Record "Assembly Header"; CurrFieldNo: Integer)
    var
        AssemblyLineL: Record "Assembly Line";
        UnitofMeasureL: Record "Unit of Measure";
    begin
        if CurrFieldNo <> Rec.FieldNo("Item No.") then
            exit;
        if Rec.Quantity = 0 then
            exit;
        AssemblyLineL.SetRange("Document Type", Rec."Document Type");
        AssemblyLineL.SetRange("Document No.", Rec."No.");
        if AssemblyLineL.FindSet() then
            repeat
                if UnitofMeasureL.Get(AssemblyLineL."Unit of Measure Code") and
                    not UnitofMeasureL."Decimal Allowed" and
                    ((Rec.Quantity * AssemblyLineL."Quantity per" mod 1) <> 0) and
                    (Rec.Quantity * AssemblyLineL."Quantity per" > 0) and
                    (AssemblyLineL."Quantity Per" > 0)
                then
                    AssemblyLineL.validate(Quantity, Round(Rec.Quantity * AssemblyLineL."Quantity per", 1, '>'))
                else
                    AssemblyLineL.validate(Quantity, (Rec.Quantity * AssemblyLineL."Quantity per"));
                AssemblyLineL.validate("Quantity to Consume", AssemblyLineL.Quantity);
                AssemblyLineL.Modify();
            until AssemblyLineL.Next() = 0;
    end;

    /*Hypercare Old Code 27-02-2025   //Moved to Exim Extension
     [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Quantity', true, true)]
      local procedure SalesLine_OnBeforeQtyValidate(var Rec: Record "Sales Line"; CurrFieldNo: Integer)
      var
          NetweightL: Decimal;
          GrossWeightL: Decimal;
      begin
          CheckWhetherDecimalsAllowed(rec);
          if CalculateNetAndGrossWeight(Rec."Unit of Measure Code", Rec."No.", Rec.Quantity, NetweightL, GrossWeightL) then begin
              Rec."Net Weight" := NetweightL;
              Rec."Gross Weight" := GrossWeightL;
          end;
      end; 

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateEvent', 'Quantity', true, true)]
    local procedure PurchaseLine_OnBeforeQtyValidate(var Rec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
    begin
        CheckWhetherDecimalsAllowed(rec);
        if CalculateNetAndGrossWeight(Rec."Unit of Measure Code", Rec."No.", Rec.Quantity, NetweightL, GrossWeightL) then begin
            Rec."Net Weight" := NetweightL;
            Rec."Gross Weight" := GrossWeightL;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", 'OnBeforeValidateEvent', 'Quantity', true, true)]
    local procedure TransferLine_OnBeforeQtyValidate(var Rec: Record "Transfer Line"; CurrFieldNo: Integer)
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
    begin
        CheckWhetherDecimalsAllowed(rec);
        if CalculateNetAndGrossWeight(Rec."Unit of Measure Code", Rec."Item No.", Rec.Quantity, NetweightL, GrossWeightL) then begin
            Rec."Net Weight" := NetweightL;
            Rec."Gross Weight" := GrossWeightL;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnBeforeValidateEvent', 'Quantity', true, true)]
    local procedure ItemJournalLine_OnBeforeQtyValidate(var Rec: Record "Item Journal Line"; CurrFieldNo: Integer)
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
    begin
        CheckWhetherDecimalsAllowed(rec);
        if CalculateNetAndGrossWeight(Rec."Unit of Measure Code", Rec."Item No.", Rec.Quantity, NetweightL, GrossWeightL) then begin
            Rec."Net Weight 2" := NetweightL;
            Rec."Gross Weight 2" := GrossWeightL;
        end;
    end;

*/
    local procedure CheckWhetherDecimalsAllowed(VariantP: Variant)
    var
        RecRefL: RecordRef;
        AssemblyLineL: Record "Assembly Line";
        SalesLineL: Record "Sales Line";
        PurchaseLineL: Record "Purchase Line";
        TransferLineL: Record "Transfer Line";
        ItemJournalLineL: Record "Item Journal Line";
        UnitofMeasureL: Record "Unit of Measure";
        UnitofMeasureCode: code[20];
        QuantityL: Decimal;
    begin
        RecRefL.GetTable(VariantP);
        case RecRefL.Number of
            Database::"Sales Line":
                begin
                    RecRefL.SetTable(SalesLineL);
                    UnitofMeasureCode := SalesLineL."Unit of Measure Code";
                    QuantityL := SalesLineL.Quantity;
                end;
            Database::"Purchase Line":
                begin
                    RecRefL.SetTable(PurchaseLineL);
                    UnitofMeasureCode := PurchaseLineL."Unit of Measure Code";
                    QuantityL := PurchaseLineL.Quantity;
                end;
            Database::"Transfer Line":
                begin
                    RecRefL.SetTable(TransferLineL);
                    UnitofMeasureCode := TransferLineL."Unit of Measure Code";
                    QuantityL := TransferLineL.Quantity;
                end;
            Database::"Item Journal Line":
                begin
                    RecRefL.SetTable(ItemJournalLineL);
                    UnitofMeasureCode := ItemJournalLineL."Unit of Measure Code";
                    QuantityL := ItemJournalLineL.Quantity;
                end;
        end;
        if (UnitofMeasureCode = '') or (QuantityL = 0) then
            exit;
        UnitofMeasureL.Get(UnitofMeasureCode);
        if not UnitofMeasureL."Decimal Allowed" and ((QuantityL mod 1) <> 0) then
            Error(StrSubstNo(UnitofMeasureErr, UnitofMeasureCode));
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterMoveFields', '', true, true)]
    local procedure CopyCustomizedFieldsWhenModify(var ReservEntry: Record "Reservation Entry"; var TrkgSpec: Record "Tracking Specification")
    begin
        ReservEntry."New Custom Lot No." := TrkgSpec."New Custom Lot No.";
        ReservEntry."New Custom BOE No." := TrkgSpec."New Custom BOE No.";
        ReservEntry."Manufacturing Date 2" := TrkgSpec."Manufacturing Date 2";
        ReservEntry."Expiry Period 2" := TrkgSpec."Expiry Period 2";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterEntriesAreIdentical', '', true, true)]
    local procedure CheckIfCustomizedFieldareChanged(ReservEntry1: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry"; var IdenticalArray: array[2] of Boolean)
    begin
        IdenticalArray[2] := (IdenticalArray[2] and
                                (ReservEntry1."Expiry Period 2" = ReservEntry2."Expiry Period 2") and
                                (ReservEntry1."Manufacturing Date 2" = ReservEntry2."Manufacturing Date 2"));
    end;

    //     //PSP 03-02-2020
    //     [EventSubscriber(ObjectType::Page, Page::"Blanket Assembly Order Cust.", 'OnAfterGetCurrRecordEvent', '', True, True)]
    //     local procedure BlanketAssOrderQtyUpdate(var Rec: Record "Assembly Header")
    //     var
    //         PostedQty: Decimal;
    //         AssemblyHeaderL: Record "Assembly Header";
    //         PostedAssOrderL: Record "Posted Assembly Header";
    //         PostedAssLineL: Record "Posted Assembly Line";
    //         Qty: Decimal;
    //         LineQty: Decimal;
    //         AssemblyLineL: Record "Assembly Line";
    //     begin

    //         PostedQty := 0;
    //         PostedAssOrderL.SetRange("Blanket Assembly Order No.", Rec."No.");
    //         PostedAssOrderL.SetRange(Reversed, false); //PSP 26-04-20
    //         if PostedAssOrderL.FindFirst() then
    //             repeat
    //                 if PostedAssOrderL."Order No." <> '' then
    //                     PostedQty += PostedAssOrderL.Quantity;
    //             until PostedAssOrderL.Next() = 0;

    //         Qty := 0;
    //         AssemblyHeaderL.Reset();
    //         AssemblyHeaderL.SetRange("Document Type", AssemblyHeaderL."Document Type"::Order);
    //         AssemblyHeaderL.SetRange("Blanket Assembly Order No.", Rec."No.");
    //         if AssemblyHeaderL.FindFirst() then
    //             repeat
    //                 if AssemblyHeaderL."Blanket Assembly Order No." <> '' then begin
    //                     Qty += AssemblyHeaderL."Remaining Quantity";
    //                 end;
    //             until AssemblyHeaderL.Next() = 0;

    //         if Rec."No." <> '' then begin
    //             Rec."Quantity Ordered" := PostedQty + Qty;
    //             Rec.Modify();
    //         end;

    //         /*  //PSP 26-04-20
    //          AssemblyLineL.SetRange("Document Type", Rec."Document Type");
    //          AssemblyLineL.SetRange("Document No.", Rec."No.");
    //          if AssemblyLineL.FindSet() then
    //              repeat
    //                  AssemblyLineL."Consumed Quantity" := PostedQty;
    //                  AssemblyLineL."Remaining Quantity" := AssemblyLineL.Quantity - AssemblyLineL."Consumed Quantity";
    //                  AssemblyLineL.Modify();
    //              until AssemblyLineL.Next() = 0;
    //          //PSP 26-04-20 */

    //     end;

    procedure CalculateNetAndGrossWeight(UnitOfMeasureCodeP: code[20]; ItemNoP: Code[20]; QuantityP: Decimal; var NetWeightP: Decimal; var GrossWeightP: Decimal): Boolean
    var
        ItemUoML: Record "Item Unit of Measure";
        UnitofMeasureL: Record "Unit of Measure";
        BaseUOMQtyL: Decimal;
    begin
        if not UnitofMeasureL.Get(UnitOfMeasureCodeP) then
            exit(false);
        if UnitofMeasureL."Decimal Allowed" then
            exit(false);
        ItemUoML.Get(ItemNoP, UnitOfMeasureCodeP);
        NetWeightP := QuantityP * ItemUoML."Net Weight";
        // if NetWeightP < 100 then
        //     exit(false);
        GrossWeightP := NetWeightP;
        BaseUOMQtyL := QuantityP * ItemUoML."Qty. per Unit of Measure";
        ItemUoML.Reset();
        ItemUoML.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
        ItemUoML.Ascending(true);
        ItemUoML.SetRange("Item No.", ItemNoP);
        if NetWeightP < 100 then begin
            if ItemUoML.FindFirst() then
                GrossWeightP += Round(BaseUOMQtyL / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";
        end else
            if ItemUoML.FindSet() then
                repeat
                    UnitofMeasureL.Get(ItemUoML.Code);
                    if not UnitofMeasureL."Decimal Allowed" then
                        GrossWeightP += Round(BaseUOMQtyL / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";
                until ItemUoML.Next() = 0;
        exit(true);
    end;



    [BusinessEvent(true)]
    local procedure OnBeforeModifyEnrtySummary(var TempGlobalEntrySummary: Record "Entry Summary"; var TempGlobalReservEntry: Record "Reservation Entry")
    begin
    end;

    local procedure CalculateNetAndGrossWeight1(var SalesLineP: Record "Sales Line")
    var
        ItemUoML: Record "Item Unit of Measure";
        UnitofMeasureL: Record "Unit of Measure";
        BaseUOMQtyL: Decimal;
    begin
        if SalesLineP.Type <> SalesLineP.Type::Item then
            exit;
        if not UnitofMeasureL.Get(SalesLineP."Unit of Measure Code") then
            exit;
        if UnitofMeasureL."Decimal Allowed" then
            exit;
        ItemUoML.Get(SalesLineP."No.", SalesLineP."Unit of Measure Code");
        //Hypercare-12-03-2025-OS-NetWtGrossWt
        // SalesLineP."Net Weight" := SalesLineP.Quantity * ItemUoML."Net Weight";
        // SalesLineP."Gross Weight" := SalesLineP."Net Weight";
        //Hypercare-12-03-2025-OE-NetWtGrossWt
        BaseUOMQtyL := SalesLineP.Quantity * ItemUoML."Qty. per Unit of Measure";
        ItemUoML.Reset();
        ItemUoML.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
        ItemUoML.Ascending(true);
        ItemUoML.SetRange("Item No.", SalesLineP."No.");
        if ItemUoML.FindSet() then
            repeat
                UnitofMeasureL.Get(ItemUoML.Code);
                if not UnitofMeasureL."Decimal Allowed" then
                    SalesLineP."Gross Weight" += Round(BaseUOMQtyL / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";
            until ItemUoML.Next() = 0;

    end;
    // Start Issue - 59
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Receipt", 'OnBeforeTransferLineToPurchaseDoc', '', true, true)]
    local procedure CopyValuesFromPurchRec_OnGetReceiptLines(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    begin
        //PSP_ 30-01-2020
        /*  with PurchaseHeader do begin
             validate("Document Date", PurchRcptHeader."Supplier Invoice Date");
             Modify();
         end; */
    end;
    // Stop Issue - 59
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', true, true)]
    local procedure CorrectLotAndBOEInformation(var ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        if strpos(ItemLedgerEntry."Lot No.", '@') > 0 then begin
            ItemLedgerEntry.CustomLotNumber := CopyStr(ItemLedgerEntry."Lot No.", 1, StrPos(ItemLedgerEntry."Lot No.", '@') - 1);
            ItemLedgerEntry.CustomBOENumber := CopyStr(ItemLedgerEntry."Lot No.", StrPos(ItemLedgerEntry."Lot No.", '@') + 1, StrLen(ItemLedgerEntry."Lot No."));
        end;
    end;
    //     //PSP 07-05-20 Ass Order Item Tracking Qty Issue start
    //     [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterInitFromAsmHeader', '', true, true)]
    //     local procedure OnAfterInitFromAsmHeader(var TrackingSpecification: Record "Tracking Specification"; AssemblyHeader: Record "Assembly Header")
    //     begin
    //         if AssemblyHeader.Quantity <> TrackingSpecification."Quantity (Base)" then
    //             TrackingSpecification."Quantity (Base)" := AssemblyHeader.Quantity;
    //     end;
    //     //PSP 07-05-20 end

    //     //PSP 10-05-20 Blanket Ass Order Consumed Qty and Remaining Qty start
    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnAfterPostedAssemblyLineInsert', '', true, true)]
    //     local procedure OnAfterPostedAssemblyLineInsert(var PostedAssemblyLine: Record "Posted Assembly Line"; AssemblyLine: Record "Assembly Line")
    //     Var
    //         AssemblyLineL: Record "Assembly Line";
    //         PostedAssHeaderL: Record "Posted Assembly Header";
    //     begin
    //         if AssemblyLineL.Get(AssemblyLineL."Document Type"::"Blanket Order", PostedAssemblyLine."Blanket Assembly Order No.", PostedAssemblyLine."Blanket Ass. Order Line No.") then begin
    //             AssemblyLineL."Consumed Quantity" := AssemblyLineL."Consumed Quantity" + PostedAssemblyLine.Quantity;
    //             AssemblyLineL."Remaining Quantity" := AssemblyLineL.Quantity - AssemblyLineL."Consumed Quantity";
    //             AssemblyLineL.Modify();
    //         end;
    //     end;
    //     //PSP 10-05-20 Blanket Ass Order Consumed Qty and Remaining Qty end

    //     //PSP 10-05-2020 Assembly Order Delete issue after posting start
    //     [EventSubscriber(ObjectType::Table, Database::"Assembly Header", 'OnAfterInitRemaining', '', true, true)]
    //     local procedure OnAfterInitRemaining(var AssemblyHeader: Record "Assembly Header"; CallingFieldNo: Integer)
    //     begin
    //         AssemblyHeader."Remaining Quantity (Base)" := AssemblyHeader."Remaining Quantity";
    //     end;
    //     //PSP 10-05-2020 Assembly Order Delete issue after posting end

    //     //PSP 12-05-2020 Consumed Qty modify in Blanket Ass Order Line based on Posted Reversed Condition start
    //     [EventSubscriber(ObjectType::Page, Page::"Posted Assembly Order", 'OnAfterGetCurrRecordEvent', '', true, true)]
    //     local procedure MyProcedure(var Rec: Record "Posted Assembly Header")
    //     var
    //         PostedAssLineL: Record "Posted Assembly Line";
    //         AssemblyLineL: Record "Assembly Line";
    //     begin

    //         if Rec.Reversed = true then begin
    //             PostedAssLineL.SetRange("Document No.", Rec."No.");
    //             if PostedAssLineL.FindSet() then
    //                 repeat
    //                     if AssemblyLineL.Get(AssemblyLineL."Document Type"::"Blanket Order", PostedAssLineL."Blanket Assembly Order No.", PostedAssLineL."Blanket Ass. Order Line No.") then begin
    //                         AssemblyLineL."Consumed Quantity" := AssemblyLineL."Consumed Quantity" - PostedAssLineL.Quantity;
    //                         AssemblyLineL.Modify();
    //                     end;
    //                 until PostedAssLineL.Next() = 0;
    //         end;
    //     end;

    //PSP 12-05-2020 Consumed Qty modify in Blanket Ass Order Line based on Posted Reversed Condition end
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyTrackingFromTrackingSpec', '', true, true)]
    local procedure OnAfterCopyTrackingFromTrackingSpec(var ReservationEntry: Record "Reservation Entry"; TrackingSpecification: Record "Tracking Specification")
    begin
        ReservationEntry."Analysis Date" := TrackingSpecification."Analysis Date";
        ReservationEntry."Manufacturing Date 2" := TrackingSpecification."Manufacturing Date 2";
        ReservationEntry."Expiry Period 2" := TrackingSpecification."Expiry Period 2";
        ReservationEntry."Supplier Batch No. 2" := TrackingSpecification."Supplier Batch No. 2";
        ReservationEntry.CustomBOENumber := TrackingSpecification.CustomBOENumber;//HyperCare

    end;

    // Moved From PDCnOthers
    [EventSubscriber(ObjectType::Page, 6510, 'OnRegisterChangeOnAfterCreateReservEntry', '', false, false)]
    procedure CreateReserEntryForNewFields(var ReservEntry: Record "Reservation Entry"; TrackingSpecification: Record "Tracking Specification")
    begin
        ReservEntry."Supplier Batch No. 2" := TrackingSpecification."Supplier Batch No. 2";
        ReservEntry."Manufacturing Date 2" := TrackingSpecification."Manufacturing Date 2";
        ReservEntry."Expiry Period 2" := TrackingSpecification."Expiry Period 2";
        ReservEntry."Gross Weight 2" := TrackingSpecification."Gross Weight 2";
        ReservEntry."Net Weight 2" := TrackingSpecification."Net Weight 2";
        ReservEntry.CustomBOENumber := TrackingSpecification.CustomBOENumber;//HyperCare
        ReservEntry.Modify;
    end;

    // Moved From PDCnOthers
    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforeInsertSetupTempSplitItemJnlLine', '', false, false)]
    procedure CopyNewFieldstoIJLFromTrackingSpec(var TempTrackingSpecification: Record "Tracking Specification" temporary; var TempItemJournalLine: Record "Item Journal Line" temporary; var PostItemJnlLine: Boolean)
    begin
        TempItemJournalLine."Supplier Batch No. 2" := TempTrackingSpecification."Supplier Batch No. 2";
        TempItemJournalLine."Manufacturing Date 2" := TempTrackingSpecification."Manufacturing Date 2";
        TempItemJournalLine."Expiry Period 2" := TempTrackingSpecification."Expiry Period 2";
        TempItemJournalLine."Gross Weight 2" := TempTrackingSpecification."Gross Weight 2";
        TempItemJournalLine."Net Weight 2" := TempTrackingSpecification."Net Weight 2";
        TempItemJournalLine.CustomBOENumber := TempTrackingSpecification.CustomBOENumber;//HyperCare
    end;

    // Moved From PDCnOthers
    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitItemLedgEntry', '', false, false)]
    procedure CopyNewFieldstoILEfromIJ(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin
        NewItemLedgEntry."Supplier Batch No. 2" := ItemJournalLine."Supplier Batch No. 2";
        NewItemLedgEntry."Manufacturing Date 2" := ItemJournalLine."Manufacturing Date 2";
        NewItemLedgEntry."Expiry Period 2" := ItemJournalLine."Expiry Period 2";
        NewItemLedgEntry."Gross Weight 2" := ItemJournalLine."Gross Weight 2";
        NewItemLedgEntry."Net Weight 2" := ItemJournalLine."Net Weight 2";
        NewItemLedgEntry.CustomBOENumber := ItemJournalLine.CustomBOENumber;//HyperCare
    end;

    //     [EventSubscriber(ObjectType::Table, Database::"Record Link", 'OnBeforeModifyEvent', '', true, true)]
    //     local procedure DontdeleteNote(var Rec: Record "Record Link"; var xRec: Record "Record Link")
    //     begin
    //         // if UserId = xRec."User ID" then
    //         //     exit else begin
    //         //     Error('you are not allowed to delete');
    //         // end;

    //     end;

    var
        //         ReceiveInvoiceQst_Sales: Label '&Ship';
        //         ReceiveInvoiceQst: Label '&Receive';
        UnitofMeasureErr: Label 'The decimal value is not allowed for the unit of measure code %1';
    //         Selection_Sales: Integer;
    //         Selection: Integer;
    //         NoteManagement: Codeunit "Type Helper";    
}