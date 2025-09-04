codeunit 80010 Evnet_Codeunit//T12370-Full Comment  T12573-N
{
    Permissions = TableData "Item Ledger Entry" = rm, TableData "Value Entry" = rm;

    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnAfterCopyItemJnlLineFromPurchHeader', '', true, true)]
    local procedure CopyItemJnlLineFromPurchHeader(VAR ItemJnlLine: Record "Item Journal Line"; PurchHeader: Record "Purchase Header")
    var
    begin
        if (PurchHeader."Buy-from IC Partner Code" = '') then
            ItemJnlLine."Group GRN Date" := PurchHeader."Posting Date";
    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnAfterCopyItemJnlLineFromPurchLine', '', true, true)]
    local procedure CopyItemJnlLineFromPurchLine(VAR ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")
    var
        PurchaseHeader: Record "Purchase Header";
        ICPartner: Record "IC Partner";
        ILE: Record "Item Ledger Entry";
        SaleShipmentLine: Record "Sales Shipment line";
        SalesInv: Record "Sales Invoice Header";
        CurrentComp: Text[100];
        Compinfo: Record "Company Information";
    begin
        // if Compinfo.Get() then
        //     CurrentComp := Compinfo.Name;
        if PurchaseHeader.Get(PurchLine."Document Type", PurchLine."Document No.") then
            if (PurchaseHeader."Buy-from IC Partner Code" <> '') then Begin
                if ICPartner.Get(PurchaseHeader."Buy-from IC Partner Code") then begin
                    if (ICPartner."Inbox Type" = ICPartner."Inbox Type"::Database) and (ICPartner."Data Exchange Type" = ICPartner."Data Exchange Type"::Database) then begin //Hypercare API Related Changes
                        SaleShipmentLine.ChangeCompany(ICPartner."Inbox Details");
                        SaleShipmentLine.SetRange("Order No.", PurchaseHeader."Vendor Order No.");
                        SaleShipmentLine.SetRange("Order Line No.", PurchLine."Line No.");
                        SaleShipmentLine.SetRange("No.", PurchLine."No.");
                        if SaleShipmentLine.FindFirst() then begin
                            ILE.ChangeCompany(ICPartner."Inbox Details");
                            ILE.SetRange("Document Type", ILE."Document Type"::"Sales Shipment");
                            ILE.SetRange("Document No.", SaleShipmentLine."Document No.");
                            ILE.SetRange("Document Line No.", SaleShipmentLine."Line No.");
                            ILE.SetRange("Source No.", SaleShipmentLine."Sell-to Customer No.");
                            ILE.SetRange("Item No.", SaleShipmentLine."No.");
                            if ItemJnlLine."Lot No." <> '' then
                                ILE.SetRange("Lot No.", ItemJnlLine."Lot No.");
                            if ILE.FindFirst() then
                                ItemJnlLine."Group GRN Date" := ILE."Group GRN Date";
                        end;
                    end;
                end;
            end;
    end;

    [EventSubscriber(ObjectType::Table, 121, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnAfterInsrt_PurchRcpt_Line(VAR Rec: Record "Purch. Rcpt. Line"; RunTrigger: Boolean)
    var
        VendorRec: Record Vendor;
        PurchaseRcptHeder: Record 120;
        ICPartner: Record "IC Partner";
        Compinfo: Record "Company Information";
        CurrentComp: Text[100];
        ILE: Record "Item Ledger Entry";
        ILE2: Record "Item Ledger Entry";
        SaleShipmentLine: Record "Sales Shipment line";
        ItemApplicationEntry: Record "Item Application Entry";
    begin
        if rec.IsTemporary then
            exit;//Hypercare
        // Compinfo.Get();
        // CurrentComp := Compinfo.Name;
        CurrentComp := CompanyName;
        if PurchaseRcptHeder.Get(Rec."Document No.") then begin
            if VendorRec.Get(PurchaseRcptHeder."Buy-from Vendor No.") And (VendorRec."IC Partner Code" <> '') then begin
                if ICPartner.Get(VendorRec."IC Partner Code") then begin
                    if (ICPartner."Inbox Type" = ICPartner."Inbox Type"::Database) and (ICPartner."Inbox Details" <> '') and (ICPartner."Data Exchange Type" = ICPartner."Data Exchange Type"::Database) then begin//Hyper Dhiren-Anoop
                        ILE.Reset();
                        ILE.SetRange("Document No.", Rec."Document No.");
                        ILE.SetRange("Document Line No.", Rec."Line No.");
                        if ILE.FindSet() then
                            repeat
                            begin
                                SaleShipmentLine.Reset();
                                SaleShipmentLine.ChangeCompany(ICPartner."Inbox Details");
                                SaleShipmentLine.SetRange("Order No.", PurchaseRcptHeder."Vendor Order No.");
                                SaleShipmentLine.SetRange("Order Line No.", Rec."Line No.");
                                SaleShipmentLine.SetRange("No.", Rec."No.");
                                if SaleShipmentLine.FindSet() then
                                    repeat
                                    begin
                                        ILE2.Reset();
                                        ILE2.ChangeCompany(ICPartner."Inbox Details");
                                        ILE2.SetRange("Document No.", SaleShipmentLine."Document No.");
                                        ILE2.SetRange("Document Line No.", SaleShipmentLine."Line No.");
                                        ILE2.SetRange("Item No.", SaleShipmentLine."No.");
                                        if ILE.CustomLotNumber <> '' then
                                            ILE2.SetRange(CustomLotNumber, ILE.CustomLotNumber);
                                        if ILE2.FindFirst() then begin
                                            ILE."Group GRN Date" := ILE2."Group GRN Date";
                                            ILE.Modify();
                                        end else begin
                                            ItemApplicationEntry.Reset();
                                            ItemApplicationEntry.SetRange("Item Ledger Entry No.", ILE."Entry No.");
                                            if ItemApplicationEntry.FindFirst() and (ItemApplicationEntry."Outbound Item Entry No." <> 0) then begin
                                                ILE2.Reset();
                                                ILE2.ChangeCompany(CurrentComp);
                                                if ILE2.Get(ItemApplicationEntry."Outbound Item Entry No.") then begin
                                                    ILE."Group GRN Date" := ILE2."Group GRN Date";
                                                    ILE.Modify();
                                                end;
                                            end;
                                        end;
                                    end;
                                    until SaleShipmentLine.Next() = 0;
                            end;
                            until ILE.Next() = 0;
                    end;
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesShptLineInsert', '', true, true)]
    local procedure OnAfterSalesShptLineInsert(VAR SalesShipmentLine: Record "Sales Shipment Line"; SalesLine: Record "Sales Line"; ItemShptLedEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSuppressed: Boolean; SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        ItemApplictionEntry: Record "Item Application Entry";
        ItemApplictionEntryRec: Record "Item Application Entry";
        ILE: Record "Item Ledger Entry";
        ILE2: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
    begin
        if SalesShipmentLine.IsTemporary then//Hypercare
            exit;

        ILE.Reset();
        ILE.SetRange("Document No.", SalesShipmentLine."Document No.");
        ILE.SetRange("Document Line No.", SalesShipmentLine."Line No.");
        if ILE.FindSet() then
            repeat begin
                ItemApplictionEntry.Reset();
                ItemApplictionEntry.SetRange("Item Ledger Entry No.", ILE."Entry No.");
                if ItemApplictionEntry.FindFirst() then begin
                    ILE2.Reset();
                    if ILE2.Get(ItemApplictionEntry."Inbound Item Entry No.") then begin
                        ILE."Group GRN Date" := ILE2."Group GRN Date";
                        ValueEntry.Reset();
                        ValueEntry.SetRange("Item Ledger Entry No.", ILE."Entry No.");
                        if ValueEntry.FindSet() then
                            repeat
                                ValueEntry."Group GRN Date" := ILE2."Group GRN Date";
                                ValueEntry.Modify();
                            until ValueEntry.Next() = 0;
                        ILE.Modify();
                    end;
                end;
            end;
            until ILE.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesInvLineInsert', '', true, true)]
    local procedure OnAfterSalesInvLineInsert(VAR SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSuppressed: Boolean)
    var
        ItemApplictionEntry: Record "Item Application Entry";
        ItemApplictionEntryRec: Record "Item Application Entry";
        ILE: Record "Item Ledger Entry";
        ILE2: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
    begin
        if SalesInvLine.IsTemporary then//Hypercare
            exit;
        ILE.Reset();
        ILE.SetRange("Document No.", SalesInvLine."Document No.");
        ILE.SetRange("Document Line No.", SalesInvLine."Line No.");
        if ILE.FindSet() then
            repeat
            begin
                ItemApplictionEntry.Reset();
                ItemApplictionEntry.SetRange("Item Ledger Entry No.", ILE."Entry No.");
                if ItemApplictionEntry.FindFirst() then begin
                    ILE2.Reset();
                    if ILE2.Get(ItemApplictionEntry."Inbound Item Entry No.") then begin
                        ILE."Group GRN Date" := ILE2."Group GRN Date";
                        ValueEntry.Reset();
                        ValueEntry.SetRange("Item Ledger Entry No.", ILE."Entry No.");
                        if ValueEntry.FindSet() then
                            repeat
                                ValueEntry."Group GRN Date" := ILE2."Group GRN Date";
                                ValueEntry.Modify();
                            until ValueEntry.Next() = 0;
                        ILE.Modify();
                    end;
                end;
            end;
            until ILE.Next() = 0;
    end;
    //02/26/2020
    [EventSubscriber(ObjectType::Table, 5745, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnAfterTransferShipmetLine(VAR Rec: Record "Transfer Shipment Line"; RunTrigger: Boolean)
    var
        ItemApplicationEntry: Record "Item Application Entry";
        ItemLedgerEntr1: Record "Item Ledger Entry";
        ItemLedgerEntr2: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
    begin
        if rec.IsTemporary then//Hypercare
            exit;
        ItemLedgerEntr1.Reset();
        ItemLedgerEntr1.SetRange("Entry Type", ItemLedgerEntr1."Entry Type"::Transfer);
        ItemLedgerEntr1.SetRange("Document Type", ItemLedgerEntr1."Document Type"::"Transfer Shipment");
        ItemLedgerEntr1.SetRange("Document No.", Rec."Document No.");
        ItemLedgerEntr1.SetRange("Document Line No.", Rec."Line No.");
        if ItemLedgerEntr1.FindSet() then
            repeat
                if (ItemLedgerEntr1.Positive = false) then begin
                    ItemApplicationEntry.Reset();
                    ItemApplicationEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntr1."Entry No.");
                    if ItemApplicationEntry.FindFirst() then begin
                        ItemLedgerEntr2.Reset();
                        if ItemLedgerEntr2.Get(ItemApplicationEntry."Inbound Item Entry No.") then begin
                            ItemLedgerEntr1."Group GRN Date" := ItemLedgerEntr2."Group GRN Date";
                            ValueEntry.Reset();
                            ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntr1."Entry No.");
                            if ValueEntry.FindSet() then
                                repeat
                                begin
                                    ValueEntry."Group GRN Date" := ItemLedgerEntr2."Group GRN Date";
                                    ValueEntry.Modify();
                                end;
                                until ValueEntry.Next() = 0;
                            ItemLedgerEntr1.Modify();
                        end;
                    end;
                end
                else
                    if (ItemLedgerEntr1.Positive = true) then begin
                        ItemApplicationEntry.Reset();
                        ItemApplicationEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntr1."Entry No.");
                        if ItemApplicationEntry.FindFirst() then begin
                            ItemLedgerEntr2.Reset();
                            if ItemLedgerEntr2.Get(ItemApplicationEntry."Outbound Item Entry No.") then begin
                                ItemLedgerEntr1."Group GRN Date" := ItemLedgerEntr2."Group GRN Date";
                                ValueEntry.Reset();
                                ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntr1."Entry No.");
                                if ValueEntry.FindSet() then
                                    repeat
                                    begin
                                        ValueEntry."Group GRN Date" := ItemLedgerEntr2."Group GRN Date";
                                        ValueEntry.Modify();
                                    end;
                                    until ValueEntry.Next() = 0;
                                ItemLedgerEntr1.Modify();
                            end;
                        end;
                    end;
            until ItemLedgerEntr1.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInsertItemLedgEntry', '', true, true)]
    local procedure OnAfterInsertILE(VAR ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; VAR ItemLedgEntryNo: Integer; VAR ValueEntryNo: Integer; VAR ItemApplnEntryNo: Integer)
    var
        ItemApplicationEntry: Record "Item Application Entry";
        ILE1: Record "Item Ledger Entry";
        ILE2: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        ValueEntry2: Record "Value Entry";
    Begin

        if ItemLedgerEntry."Group GRN Date" = 0D then begin
            if ItemLedgerEntry.Positive = false then begin
                ItemApplicationEntry.Reset();
                ItemApplicationEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
                if ItemApplicationEntry.FindFirst() then begin
                    if ILE1.Get(ItemApplicationEntry."Inbound Item Entry No.") and (ItemApplicationEntry."Inbound Item Entry No." <> 0) then begin
                        ItemLedgerEntry."Group GRN Date" := ILE1."Group GRN Date";
                        ItemLedgerEntry.Modify();
                        if (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Transfer) and ((ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Transfer Receipt") OR (ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::" ")) then begin
                            ILE2.Reset();
                            if ILE2.Get(ItemLedgerEntry."Entry No." + 1) then begin
                                ILE2."Group GRN Date" := ILE1."Group GRN Date";
                                ILE2.Modify();
                            end;
                        end;
                    end;
                end;
            end
            else
                if ItemLedgerEntry.Positive = true then begin
                    ItemApplicationEntry.Reset();
                    ItemApplicationEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
                    if ItemApplicationEntry.FindFirst() then begin
                        if ItemApplicationEntry."Outbound Item Entry No." <> 0 then begin
                            if ILE1.Get(ItemApplicationEntry."Outbound Item Entry No.") then begin
                                ItemLedgerEntry."Group GRN Date" := ILE1."Group GRN Date";
                                ItemLedgerEntry.Modify();
                            end;
                        end
                        else
                            if ItemApplicationEntry."Outbound Item Entry No." = 0 then begin
                                ItemLedgerEntry."Group GRN Date" := ItemJournalLine."Posting Date";
                                ItemLedgerEntry.Modify();
                            end;
                        // end;
                    end
                    else
                        if not ItemApplicationEntry.FindFirst() then begin
                            ItemLedgerEntry."Group GRN Date" := ItemJournalLine."Posting Date";
                            ItemLedgerEntry.Modify();
                        end;
                end;

        end;
    End;

    [EventSubscriber(ObjectType::Table, 115, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnafterSalesCreditMemoLine(VAR Rec: Record "Sales Cr.Memo Line"; RunTrigger: Boolean)
    var
        ItemApplicationEntry: Record "Item Application Entry";
        ILE1: Record "Item Ledger Entry";
        ILE2: Record "Item Ledger Entry";
        valueEntry: Record "Value Entry";
    begin
        ILE1.Reset();
        ILE1.SetRange("Document No.", Rec."Document No.");
        ILE1.SetRange("Document Line No.", Rec."Line No.");
        if ILE1.FindSet() then
            repeat
            begin
                ItemApplicationEntry.Reset();
                ItemApplicationEntry.SetRange("Item Ledger Entry No.", ILE1."Entry No.");
                if ItemApplicationEntry.FindFirst() then begin
                    ILE2.Reset();
                    if ILE2.Get(ItemApplicationEntry."Outbound Item Entry No.") then begin
                        ILE1."Group GRN Date" := ILE2."Group GRN Date";
                        valueEntry.Reset();
                        valueEntry.SetRange("Item Ledger Entry No.", ILE1."Entry No.");
                        if valueEntry.FindSet() then
                            repeat
                                valueEntry."Group GRN Date" := ILE2."Group GRN Date";
                                valueEntry.Modify();
                            until valueEntry.Next() = 0;
                        ILE1.Modify();
                    end;
                end;
            end;
            until ILE1.Next() = 0;

    end;

    [EventSubscriber(ObjectType::Table, 125, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnafterPurchaseCreditMemoLine(VAR Rec: Record "Purch. Cr. Memo Line"; RunTrigger: Boolean)
    var
        ItemApplicationEntry: Record "Item Application Entry";
        ILE1: Record "Item Ledger Entry";
        ILE2: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
    begin
        ILE1.SetRange("Document No.", Rec."Document No.");
        ILE1.SetRange("Document Line No.", Rec."Line No.");
        if ILE1.FindSet() then
            repeat
            begin
                ItemApplicationEntry.Reset();
                ItemApplicationEntry.SetRange("Item Ledger Entry No.", ILE1."Entry No.");
                if ItemApplicationEntry.FindFirst() then begin
                    ILE2.Reset();
                    if ILE2.Get(ItemApplicationEntry."Inbound Item Entry No.") then begin
                        ILE1."Group GRN Date" := ILE2."Group GRN Date";
                        valueEntry.Reset();
                        valueEntry.SetRange("Item Ledger Entry No.", ILE1."Entry No.");
                        if valueEntry.FindSet() then
                            repeat
                                valueEntry."Group GRN Date" := ILE2."Group GRN Date";
                                valueEntry.Modify();
                            until valueEntry.Next() = 0;
                        ILE1.Modify();
                    end;
                end;
            end;
            until ILE1.Next() = 0;

    end;

    [EventSubscriber(ObjectType::Table, 6661, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnafterSalesReturnReceiptLine(VAR Rec: Record "Return Receipt Line"; RunTrigger: Boolean)
    var
        ItemApplicationEntry: Record "Item Application Entry";
        ILE1: Record "Item Ledger Entry";
        ILE2: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
    begin
        ILE1.SetRange("Document No.", Rec."Document No.");
        ILE1.SetRange("Document Line No.", Rec."Line No.");
        if ILE1.FindSet() then
            repeat
            begin
                ItemApplicationEntry.Reset();
                ItemApplicationEntry.SetRange("Item Ledger Entry No.", ILE1."Entry No.");
                if ItemApplicationEntry.FindFirst() then begin
                    ILE2.Reset();
                    if ILE2.Get(ItemApplicationEntry."Outbound Item Entry No.") then begin
                        ILE1."Group GRN Date" := ILE2."Group GRN Date";
                        valueEntry.Reset();
                        valueEntry.SetRange("Item Ledger Entry No.", ILE1."Entry No.");
                        if valueEntry.FindSet() then
                            repeat
                                valueEntry."Group GRN Date" := ILE2."Group GRN Date";
                                valueEntry.Modify();
                            until valueEntry.Next() = 0;
                        ILE1.Modify();
                    end;
                end;
            end;
            until ILE1.Next() = 0;

    end;

    [EventSubscriber(ObjectType::Table, 6651, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnafterPurchaseReturnShipmetLine(VAR Rec: Record "Return Shipment Line"; RunTrigger: Boolean)
    var
        ItemApplicationEntry: Record "Item Application Entry";
        ILE1: Record "Item Ledger Entry";
        ILE2: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
    begin
        ILE1.SetRange("Document No.", Rec."Document No.");
        ILE1.SetRange("Document Line No.", Rec."Line No.");
        if ILE1.FindSet() then
            repeat
            begin
                ItemApplicationEntry.Reset();
                ItemApplicationEntry.SetRange("Item Ledger Entry No.", ILE1."Entry No.");
                if ItemApplicationEntry.FindFirst() then begin
                    ILE2.Reset();
                    if ILE2.Get(ItemApplicationEntry."Inbound Item Entry No.") then begin
                        ILE1."Group GRN Date" := ILE2."Group GRN Date";
                        valueEntry.Reset();
                        valueEntry.SetRange("Item Ledger Entry No.", ILE1."Entry No.");
                        if valueEntry.FindSet() then
                            repeat
                                valueEntry."Group GRN Date" := ILE2."Group GRN Date";
                                valueEntry.Modify();
                            until valueEntry.Next() = 0;
                        ILE1.Modify();
                    end;
                end;
            end;
            until ILE1.Next() = 0;

    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInsertValueEntry', '', true, true)]
    local procedure OnAfterInsertVE(VAR ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; VAR ItemLedgerEntry: Record "Item Ledger Entry"; VAR ValueEntryNo: Integer)
    var
        ILE: Record "Item Ledger Entry";
    Begin
        if ILE.Get(ValueEntry."Item Ledger Entry No.") then begin
            if ILE."Group GRN Date" <> 0D then begin
                ValueEntry."Group GRN Date" := ILE."Group GRN Date";
                ValueEntry.Modify();
            end;
        end;
    End;
    //02/26/2020

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure InitILE(VAR NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; VAR ItemLedgEntryNo: Integer)
    var
    Begin
        NewItemLedgEntry."Group GRN Date" := ItemJournalLine."Group GRN Date";
    End;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitValueEntry', '', true, true)]
    local procedure InitVE(VAR ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line"; VAR ValueEntryNo: Integer)
    Begin
        ValueEntry."Group GRN Date" := ItemJournalLine."Group GRN Date";
    End;

    var
        myInt: Integer;
}