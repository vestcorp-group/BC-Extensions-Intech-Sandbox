
codeunit 50503 "COA QC 90 Sub Purch Post"
{
    //T51170-NS
    Permissions = tabledata "QC Rcpt. Line" = rmi, tabledata "Item Ledger Entry" = rm, tabledata "Purch. Rcpt. Header" = rm, tabledata "Purch. Rcpt. Line" = rm;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnRunOnBeforeFinalizePosting, '', false, false)]
    local procedure "COA_Purch.-Post_OnRunOnBeforeFinalizePosting"(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShipmentHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; CommitIsSuppressed: Boolean)
    var
        QCmgmt_lCdu: Codeunit "QC Mgt";
        QCRcptHead1_lRec: Record "QC Rcpt. Header";
        PurchRcptLine1_lRec: Record "Purch. Rcpt. Line";
        Ile1_lRec: Record "Item Ledger Entry" temporary;
        QCFoundnPosted_lBln: Boolean;
        QCSetup_lRec: Record "Quality Control Setup";
        COAPurchase_lCdu: Codeunit "Quality Control - COA";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        Item_lRec: Record Item;
        QCRequired_lBol: Boolean;
    begin
        IF PurchRcptHeader."No." = '' then
            Exit;

        if PurchaseHeader.IsTemporary then exit;
        if PurchRcptHeader.IsTemporary then exit;
        if QCSetup_lRec.get then begin
            if not QCSetup_lRec."QC Block without Location" then
                Exit;

            PurchRcptLine.RESET;
            PurchRcptLine.SetRange("Document No.", PurchRcptHeader."No.");
            PurchRcptLine.SetRange(Type, PurchRcptLine.Type::Item);
            PurchRcptLine.SetFilter(Quantity, '>%1', 0);
            IF PurchRcptLine.FindSet() Then begin
                repeat
                    Item_lRec.Get(PurchRcptLine."No.");
                    // if not Item_lRec."COA Applicable" then
                    //     exit;
                    // if Item_lRec."Allow QC in GRN" then
                    //     exit;
                    if (Item_lRec."COA Applicable") and (not Item_lRec."Allow QC in GRN") then begin
                        PurchRcptLine."QC Required" := true;
                        PurchRcptLine."QC Pending" := true;
                        PurchRcptLine.Modify();
                        if (PurchRcptLine."QC Required") then
                            COAPurchase_lCdu.CreateQCRcpt_gFnc(PurchRcptLine, false);
                    end;//T51170-N
                until PurchRcptLine.next = 0;
            End;



            //<------------------------------------To Post the QC Receipt----------------------------------------------------------------------->

            QCFoundnPosted_lBln := false;
            PurchRcptLine1_lRec.Reset();
            PurchRcptLine1_lRec.SetRange("Document No.", PurchRcptHeader."No.");
            PurchRcptLine1_lRec.SetRange(Type, PurchRcptLine1_lRec.Type::Item);
            PurchRcptLine1_lRec.SetFilter(Quantity, '>%1', 0);
            if PurchRcptLine1_lRec.FindSet() then
                repeat
                    Clear(Ile1_lRec);
                    Ile1_lRec.Reset();
                    Ile1_lRec.DeleteAll();
                    QCmgmt_lCdu.CollectItemEntryRelation_gFnc(Ile1_lRec, Database::"Purch. Rcpt. Line", 0, PurchRcptLine1_lRec."Document No.", '', 0, PurchRcptLine1_lRec."Line No.", 0, '');
                    if Ile1_lRec.IsEmpty then
                        Error('Item Ledger Entry is not found against the Posted Purchase Receipt');
                    if Ile1_lRec.FindSet() then
                        repeat
                            if Ile1_lRec."QC No." <> '' then begin
                                QCRcptHead1_lRec.Reset();
                                QCRcptHead1_lRec.SetRange("No.", Ile1_lRec."QC No.");
                                QCRcptHead1_lRec.SetRange("COA QC", true);
                                QCRcptHead1_lRec.SetRange("COA AutoPost", true);
                                if QCRcptHead1_lRec.FindFirst() then begin
                                    QCRcptHead1_lRec.CheckQCCheck_gfnc();
                                    QCRcptHead1_lRec.PostQCRcpt_gFnc(false);
                                    QCFoundnPosted_lBln := true;
                                end;
                            end;
                        until Ile1_lRec.Next() = 0;
                until PurchRcptLine1_lRec.Next() = 0;

            if (PurchRcptHeader."No." <> '') and (QCFoundnPosted_lBln) then
                Message('All the Related QC Receipts has been created and posted successfully which has COA Autopost as True');
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Quality Control - Purchase", OnBeforeInsertQCRcptLine, '', false, false)]
    local procedure OnBeforeInsertQCRcptLine_QualityControlPurchase(ItemLedgerEntry: Record "Item Ledger Entry"; var QCRcptLine: Record "QC Rcpt. Line"; QCRcptHead: Record "QC Rcpt. Header")
    var
        LotPostedVarintTestParameter: Record "Post Lot Var Testing Parameter";
        PurchRcptLineL: Record "Purch. Rcpt. Line";
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter";
        PostedLotVarintTestingParameter: Record "Post Lot Var Testing Parameter";
        Item_lRec: Record Item;//T51170-N
    begin
        //20-05-2025-Anoop T53429-N
        PurchRcptLineL.SetRange("Document No.", ItemLedgerEntry."Document No.");//GRN
        PurchRcptLineL.SetRange(Type, PurchRcptLineL.Type::Item);
        if PurchRcptLineL.FindSet() then
            repeat
                Item_lRec.get(PurchRcptLineL."No.");
                if (Item_lRec."COA Applicable") then begin
                    LotVariantTestingParameter.SetRange("Source ID", PurchRcptLineL."Order No.");
                    LotVariantTestingParameter.SetRange("Source Ref. No.", PurchRcptLineL."Order Line No.");
                    LotVariantTestingParameter.SetRange("Item No.", PurchRcptLineL."No.");
                    LotVariantTestingParameter.SetRange("Variant Code", PurchRcptLineL."Variant Code");
                    if LotVariantTestingParameter.FindSet() then
                        repeat
                            PostedLotVarintTestingParameter.Init();
                            PostedLotVarintTestingParameter.TransferFields(LotVariantTestingParameter);
                            PostedLotVarintTestingParameter."Source ID" := PurchRcptLineL."Document No.";
                            PostedLotVarintTestingParameter."Source Ref. No." := PurchRcptLineL."Line No.";

                            PostedLotVarintTestingParameter.SetRecFilter();
                            if PostedLotVarintTestingParameter.IsEmpty() then
                                PostedLotVarintTestingParameter.Insert();
                        until LotVariantTestingParameter.Next() = 0;
                end;
            until PurchRcptLineL.Next() = 0;

        LotPostedVarintTestParameter.RESET;
        LotPostedVarintTestParameter.SetRange("Source ID", ItemLedgerEntry."Document No.");
        LotPostedVarintTestParameter.SetRange("Source Ref. No.", ItemLedgerEntry."Document Line No.");
        LotPostedVarintTestParameter.SetRange("Item No.", ItemLedgerEntry."Item No.");
        LotPostedVarintTestParameter.SetRange("Variant Code", ItemLedgerEntry."Variant Code");
        LotPostedVarintTestParameter.SetRange("Lot No.", ItemLedgerEntry.CustomLotNumber);
        LotPostedVarintTestParameter.SetRange("BOE No.", ItemLedgerEntry.CustomBOENumber);
        LotPostedVarintTestParameter.Setrange(code, QCRcptLine."Quality Parameter Code");
        if LotPostedVarintTestParameter.Findfirst() then begin
            QCRcptLine."Vendor COA Text Result" := LotPostedVarintTestParameter."Vendor COA Text Result";
            QCRcptLine."Vendor COA Value Result" := LotPostedVarintTestParameter."Vendor COA Value Result";
        end;
        //20-05-2025-Anoop T53429-N
    end;


}