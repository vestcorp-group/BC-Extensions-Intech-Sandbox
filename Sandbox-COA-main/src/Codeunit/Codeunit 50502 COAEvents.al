codeunit 50502 COAEvents//T12370-Full Comment //T13935-N
{
    //25-06-2022- Start
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Line-Reserve", 'OnBeforeRunItemTrackingLinesPage', '', false, false)]
    local procedure OnBeforeRunItemTrackingLinesPage(var ItemTrackingLines: Page "Item Tracking Lines"; var IsHandled: Boolean);
    begin
        Commit();
        IsHandled := true;
        ItemTrackingLines.RunModal();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    local procedure OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer);
    var
        RecLines: Record "Purchase Line";
        RecResEntry: Record "Reservation Entry";
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        ItemRec_lrec: Record item;//T51170-N
    begin
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then exit;

        Clear(RecLines);
        RecLines.SetRange("Document Type", PurchaseHeader."Document Type");
        RecLines.SetRange("Document No.", PurchaseHeader."No.");
        RecLines.SetRange(Type, RecLines.Type::Item);
        RecLines.SetRange("Posting Group", 'PD');
        if RecLines.FindSet() then
        //comment
        begin  //AJAY >>
            repeat
                //T51170-NS
                ItemRec_lrec.get(RecLines."No.");
                if not ItemRec_lrec."COA Applicable" then
                    exit;
                //T51170-NE
                IF RecLines."Variant Code" = '' THEN begin
                    Clear(RecResEntry);
                    RecResEntry.SetRange("Item No.", RecLines."No.");
                    RecResEntry.SetRange("Source Type", Database::"Purchase Line");
                    RecResEntry.SetRange("Source Subtype", RecLines."Document Type".AsInteger());
                    RecResEntry.SetRange("Source ID", RecLines."Document No.");
                    RecResEntry.SetRange("Source Ref. No.", RecLines."Line No.");
                    RecResEntry.SetRange("Variant Code", RecLines."Variant Code");
                    if RecResEntry.FindSet() then
                     //comment
                     begin
                        repeat
                            Clear(LotVariantTestingParameter);
                            LotVariantTestingParameter.SetRange("Source ID", RecResEntry."Source ID");
                            LotVariantTestingParameter.SetRange("Source Ref. No.", RecResEntry."Source Ref. No.");
                            LotVariantTestingParameter.SetRange("Item No.", RecResEntry."Item No.");
                            LotVariantTestingParameter.SetRange("Variant Code", RecResEntry."Variant Code");
                            LotVariantTestingParameter.SetRange("Lot No.", RecResEntry.CustomLotNumber);
                            LotVariantTestingParameter.SetRange("BOE No.", RecResEntry.CustomBOENumber);
                            LotVariantTestingParameter.SetFilter("Actual Value", '<>%1', '');
                            if not LotVariantTestingParameter.FindFirst() then
                                if RecResEntry.CustomLotNumber <> '' then //added by bayas
                                    Error('%1 must be defined for Document Type %2, No.:%3, Line No.:%4, Lot No.:%5', LotVariantTestingParameter.TableCaption, RecLines."Document Type", RecLines."No.", RecLines."Line No.", RecResEntry.CustomLotNumber);
                        until RecResEntry.Next() = 0;
                    end;
                END ELSE begin
                    Clear(RecResEntry);
                    RecResEntry.SetRange("Item No.", RecLines."No.");
                    RecResEntry.SetRange("Source Type", Database::"Purchase Line");
                    RecResEntry.SetRange("Source Subtype", RecLines."Document Type".AsInteger());
                    RecResEntry.SetRange("Source ID", RecLines."Document No.");
                    RecResEntry.SetRange("Source Ref. No.", RecLines."Line No.");
                    RecResEntry.SetRange("Variant Code", RecLines."Variant Code");
                    if RecResEntry.FindSet() then
                     //comment
                     begin
                        repeat
                            Clear(LotVariantTestingParameter);
                            LotVariantTestingParameter.SetRange("Source ID", RecResEntry."Source ID");
                            LotVariantTestingParameter.SetRange("Source Ref. No.", RecResEntry."Source Ref. No.");
                            LotVariantTestingParameter.SetRange("Item No.", RecResEntry."Item No.");
                            LotVariantTestingParameter.SetRange("Variant Code", RecResEntry."Variant Code");
                            LotVariantTestingParameter.SetRange("Lot No.", RecResEntry.CustomLotNumber);
                            LotVariantTestingParameter.SetRange("BOE No.", RecResEntry.CustomBOENumber);
                            LotVariantTestingParameter.SetFilter("Actual Value", '<>%1', '');
                            if not LotVariantTestingParameter.FindFirst() then
                                if RecResEntry.CustomLotNumber <> '' then //added by bayas
                                    Error('%1 must be defined for Document Type %2, No.:%3, Line No.:%4, Lot No.:%5', LotVariantTestingParameter.TableCaption, RecLines."Document Type", RecLines."No.", RecLines."Line No.", RecResEntry.CustomLotNumber);
                        until RecResEntry.Next() = 0;
                    end;
                end;
            until RecLines.Next() = 0;
        end;
    end; //AJAY <<

    //added for credit memo

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesCrMemoLineInsert', '', false, false)]
    local procedure OnAfterSalesCrMemoLineInsert(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header");
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        PostedLotVariantTestingParameter: Record "Post Lot Var Testing Parameter"; //AJAY
        Item_lRec: Record item;//T51170-N
    begin //AJAY >>
        if SalesLine."Document Type" <> SalesLine."Document Type"::"Credit Memo" then exit;
        LotVariantTestingParameter.SetRange("Source ID", SalesLine."Document No.");
        LotVariantTestingParameter.SetRange("Source Ref. No.", SalesLine."Line No.");
        LotVariantTestingParameter.SetRange("Variant Code", SalesLine."Variant Code");
        if LotVariantTestingParameter.FINDSET() then
            repeat
                //T51170-NS
                Item_lRec.get(LotVariantTestingParameter."Item No.");
                if (Item_lRec."COA Applicable") then begin
                    //T51170-NE
                    PostedLotVariantTestingParameter.Init();
                    PostedLotVariantTestingParameter.TransferFields(LotVariantTestingParameter);
                    PostedLotVariantTestingParameter."Source ID" := SalesCrMemoLine."Document No.";
                    PostedLotVariantTestingParameter."Source Ref. No." := SalesCrMemoLine."Line No.";
                    //PostedLotVariantTestingParameter."Variant Code" := SalesCrMemoLine."Variant Code";
                    IF PostedLotVariantTestingParameter.Insert() then;
                    LotVariantTestingParameter.Delete();
                End;//T51170-N
            until LotVariantTestingParameter.Next() = 0;
    end;  //AJAY <<

    //added for transfer shipment
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterInsertTransShptLine', '', false, false)]
    local procedure OnAfterInsertTransShptLine(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; TransShptHeader: Record "Transfer Shipment Header");
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        PostedLotVariantTestingParameter: Record "Post Lot Var Testing Parameter"; //AJAY
        Item_lRec: Record item;//T51170-N
    begin //AJAY >>

        if TransShptLine.Quantity <> 0 then begin//T51170-N
            LotVariantTestingParameter.SetRange("Source ID", TransLine."Document No.");
            LotVariantTestingParameter.SetRange("Source Ref. No.", TransLine."Line No.");
            LotVariantTestingParameter.SetRange("Variant Code", TransLine."Variant Code");
            if LotVariantTestingParameter.FINDSET() then
                repeat
                    //T51170-NS
                    Item_lRec.get(LotVariantTestingParameter."Item No.");
                    if (Item_lRec."COA Applicable") then begin
                        //T51170-NE
                        PostedLotVariantTestingParameter.Init();
                        PostedLotVariantTestingParameter.TransferFields(LotVariantTestingParameter);
                        PostedLotVariantTestingParameter."Source ID" := TransShptLine."Document No.";
                        PostedLotVariantTestingParameter."Source Ref. No." := TransShptLine."Line No.";
                        //PostedLotVariantTestingParameter."Variant Code" := TransShptLine."Variant Code";
                        //T51170-NS
                        PostedLotVariantTestingParameter.SetRecFilter();
                        if PostedLotVariantTestingParameter.IsEmpty() then
                            PostedLotVariantTestingParameter.Insert();
                        //T51170-NE
                    end;//T51170-N
                until LotVariantTestingParameter.Next() = 0;
        end;//T51170-N
    end; //AJAY <<

    //added for transfer Receipt
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnAfterInsertTransRcptLine', '', false, false)]
    local procedure OnAfterInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header");
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        PostedLotVariantTestingParameter: Record "Post Lot Var Testing Parameter"; //AJAY
        Item_lRec: Record item;//T51170-N
    begin //AJAY >>
        if TransRcptLine.Quantity <> 0 then begin//T51170-N
            LotVariantTestingParameter.SetRange("Source ID", TransLine."Document No.");
            LotVariantTestingParameter.SetRange("Source Ref. No.", TransLine."Line No.");
            LotVariantTestingParameter.SetRange("Variant Code", TransLine."Variant Code");
            if LotVariantTestingParameter.FINDSET() then
                repeat
                    //T51170-NS
                    Item_lRec.get(LotVariantTestingParameter."Item No.");
                    if (Item_lRec."COA Applicable") then begin
                        //T51170-NE
                        PostedLotVariantTestingParameter.Init();
                        PostedLotVariantTestingParameter.TransferFields(LotVariantTestingParameter);
                        PostedLotVariantTestingParameter."Source ID" := TransRcptLine."Document No.";
                        PostedLotVariantTestingParameter."Source Ref. No." := TransRcptLine."Line No.";
                        //PostedLotVariantTestingParameter."Variant Code" := TransRcptLine."Variant Code";
                        //T51170-NS
                        PostedLotVariantTestingParameter.SetRecFilter();
                        if PostedLotVariantTestingParameter.IsEmpty() then
                            PostedLotVariantTestingParameter.Insert();
                        //T51170-NE
                    end;//T51170-N
                until LotVariantTestingParameter.Next() = 0;
        end;//T51170-N
    end; //AJAY >>

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeDeleteOneTransferHeader', '', false, false)]
    local procedure OnBeforeDeleteOneTransferHeader(TransferHeader: Record "Transfer Header"; var DeleteOne: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header");
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        PostedLotVariantTestingParameter: Record "Post Lot Var Testing Parameter"; //AJAY
    begin
        LotVariantTestingParameter.SetRange("Source ID", TransferHeader."No.");
        if LotVariantTestingParameter.FINDSET() then
            LotVariantTestingParameter.DeleteAll();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterPostItemJnlLine', '', false, false)]
    local procedure OnAfterPostItemJnlLine(var Sender: Codeunit "Item Jnl.-Post Line"; var
                                                                                           ItemJournalLine: Record "Item Journal Line";
                                                                                           ItemLedgerEntry: Record "Item Ledger Entry";

    var
        ValueEntryNo: Integer;

    var
        InventoryPostingToGL: Codeunit "Inventory Posting To G/L";
        CalledFromAdjustment: Boolean;
        CalledFromInvtPutawayPick: Boolean;

    var
        ItemRegister: Record "Item Register";

    var
        ItemLedgEntryNo: Integer;

    var
        ItemApplnEntryNo: Integer);
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        PostedLotVariantTestingParameter: Record "Post Lot Var Testing Parameter"; //AJAY
        a: Page 393;
        Item_lRec: Record item;//T51170-N
    begin //AJAY >>
        if (ItemJournalLine."Journal Template Name" <> '') and (ItemJournalLine."Journal Batch Name" <> '') then begin//T51170-N
            if not (ItemJournalLine."Entry Type" IN [ItemJournalLine."Entry Type"::"Positive Adjmt.", ItemJournalLine."Entry Type"::Transfer]) then exit;

            LotVariantTestingParameter.SetRange("Source ID", ItemJournalLine."Journal Template Name");
            LotVariantTestingParameter.SetRange("Source Ref. No.", ItemJournalLine."Line No.");
            LotVariantTestingParameter.SetRange("Item No.", ItemJournalLine."Item No.");
            LotVariantTestingParameter.SetRange("Variant Code", ItemJournalLine."Variant Code");
            //LotVariantTestingParameter.SetRange("Lot No.",ItemJournalLine."Lot No.");
            //LotVariantTestingParameter.SetRange("BOE No.", ItemJournalLine.CustomBOENumber);
            if LotVariantTestingParameter.FINDSET() then
                repeat
                    //T51170-NS
                    Item_lRec.get(LotVariantTestingParameter."Item No.");
                    if (Item_lRec."COA Applicable") then begin
                        //T51170-NE
                        PostedLotVariantTestingParameter.Init();
                        PostedLotVariantTestingParameter.TransferFields(LotVariantTestingParameter);
                        PostedLotVariantTestingParameter."Source ID" := ItemLedgerEntry."Document No.";
                        PostedLotVariantTestingParameter."Source Ref. No." := ItemLedgerEntry."Document Line No.";
                        //PostedLotVariantTestingParameter."Variant Code" := ItemLedgerEntry."Variant Code";
                        IF PostedLotVariantTestingParameter.Insert() then;
                        LotVariantTestingParameter.Delete();
                    End;//T51170-N
                until LotVariantTestingParameter.Next() = 0;
        end;//T51170-N
    end; //AJAY >>
    //25-06-2022- End

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeSalesShptLineInsert', '', false, false)]
    local procedure OnBeforeSalesShptLineInsert(var SalesShptLine: Record "Sales Shipment Line"; SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; CommitIsSupressed: Boolean; DropShptPostBuffer: Record "Drop Shpt. Post. Buffer");
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        PostedLotVariantTestingParameter: Record "Post Lot Var Testing Parameter"; //AJAY
        Item_lRec: Record item;//T51170-NItem_lRec: Record item;//T51170-N
    begin //AJAY >>
        Clear(LotVariantTestingParameter);
        LotVariantTestingParameter.SetRange("Source ID", SalesLine."Document No.");
        LotVariantTestingParameter.SetRange("Source Ref. No.", SalesLine."Line No.");
        LotVariantTestingParameter.SetRange("Item No.", SalesLine."No.");
        LotVariantTestingParameter.SetRange("Variant Code", SalesLine."Variant Code");
        if LotVariantTestingParameter.FINDSET() then
            repeat
                //T51170-NS
                Item_lRec.get(LotVariantTestingParameter."Item No.");
                if (Item_lRec."COA Applicable") then begin
                    //T51170-NE
                    PostedLotVariantTestingParameter.Init();
                    PostedLotVariantTestingParameter.TransferFields(LotVariantTestingParameter);
                    PostedLotVariantTestingParameter."Source ID" := SalesShptLine."Document No.";
                    PostedLotVariantTestingParameter."Source Ref. No." := SalesShptLine."Line No.";
                    //PostedLotVariantTestingParameter."Variant Code" := SalesShptLine."Variant Code";
                    IF PostedLotVariantTestingParameter.Insert() then;
                end;//T51170-N
            //LOTTestParameter.Delete();
            until LotVariantTestingParameter.Next() = 0;
    end; //AJAY >>
}
