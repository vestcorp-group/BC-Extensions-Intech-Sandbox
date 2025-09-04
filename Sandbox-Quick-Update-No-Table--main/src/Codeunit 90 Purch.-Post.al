codeunit 85654 "CU 90 Sub Purch Post"
{
    //T13919-NS
    Permissions = tabledata "QC Rcpt. Line" = rmi, tabledata "Item Ledger Entry" = rm;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnRunOnBeforeFinalizePosting, '', false, false)]
    local procedure "Purch.-Post_OnRunOnBeforeFinalizePosting"(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShipmentHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; CommitIsSuppressed: Boolean)
    var
        StageQCDetails_lRec: Record "Stage QC Details";
        QCmgmt_lCdu: Codeunit "QC Mgt";
        QCRcptHead_lRec: Record "QC Rcpt. Header";
        QCRcptHead1_lRec: Record "QC Rcpt. Header";
        QCRcptLine_lRec: Record "QC Rcpt. Line";
        PurchRcptLine_lRec: Record "Purch. Rcpt. Line";
        PurchRcptLine1_lRec: Record "Purch. Rcpt. Line";
        Ile_lRec: Record "Item Ledger Entry" temporary;
        Ile1_lRec: Record "Item Ledger Entry" temporary;
        LotNo_gCode: Code[50];
        ItemLdgrEntry_lRec: Record "Item Ledger Entry";
        ItemLdgrEntry1_lRec: Record "Item Ledger Entry";
        headUpdate_lBln: Boolean;
        QCFoundnPosted_lBln: Boolean;
    begin
        if PurchaseHeader."IC Transaction No." = 0 then exit;
        if PurchaseHeader.IsTemporary then exit;

        IF PurchRcptHeader.IsTemporary then exit; //T51170 //26032025
        headUpdate_lBln := false;
        PurchRcptLine_lRec.Reset();
        PurchRcptLine_lRec.SetRange("Document No.", PurchRcptHeader."No.");
        //T51170-NS //26032025
        PurchRcptLine_lRec.SetRange(Type, PurchRcptLine_lRec.Type::Item);
        PurchRcptLine_lRec.SetFilter(Quantity, '>%1', 0);
        //T51170-NE //26032025
        if PurchRcptLine_lRec.FindSet() then
            repeat
                Clear(Ile_lRec);
                Ile_lRec.Reset();
                Ile_lRec.DeleteAll();
                QCmgmt_lCdu.CollectItemEntryRelation_gFnc(Ile_lRec, Database::"Purch. Rcpt. Line", 0, PurchRcptLine_lRec."Document No.", '', 0, PurchRcptLine_lRec."Line No.", 0, '');
                if Ile_lRec.IsEmpty then
                    Error('Item Ledger Entry is not found against the Posted Purchase Receipt');
                if Ile_lRec.FindSet() then
                    repeat
                        Clear(headUpdate_lBln); //21-04-2025-N
                        QCRcptHead_lRec.Reset();
                        QCRcptHead_lRec.SetRange("Document No.", PurchRcptLine_lRec."Document No.");
                        QCRcptHead_lRec.SetRange("Document Line No.", PurchRcptLine_lRec."Line No.");
                        QCRcptHead_lRec.SetRange("Vendor Lot No.", Ile_lRec."Lot No.");
                        QCRcptHead_lRec.SetRange("Item Tracking", QCRcptHead_lRec."Item Tracking"::"Lot No.");
                        if QCRcptHead_lRec.FindFirst() then begin
                            QCRcptLine_lRec.Reset();
                            QCRcptLine_lRec.SetRange("No.", QCRcptHead_lRec."No.");
                            if QCRcptLine_lRec.FindSet() then
                                repeat
                                    StageQCDetails_lRec.Reset();
                                    StageQCDetails_lRec.SetRange("Purchase Order No.", PurchRcptLine_lRec."Order No.");
                                    StageQCDetails_lRec.SetRange("ILE Lot No.", Ile_lRec.CustomLotNumber);
                                    StageQCDetails_lRec.SetRange("Purchase Order Line No.", PurchRcptLine_lRec."Order Line No.");
                                    StageQCDetails_lRec.SetRange("Quality Parameter Code", QCRcptLine_lRec."Quality Parameter Code");
                                    if StageQCDetails_lRec.FindFirst() then begin
                                        QCRcptLine_lRec."Actual Text" := StageQCDetails_lRec."Actual Text";
                                        QCRcptLine_lRec."Actual Value" := StageQCDetails_lRec."Actual Value";
                                        QCRcptLine_lRec."Vendor COA Text Result" := StageQCDetails_lRec."Vendor COA Text Result";
                                        QCRcptLine_lRec."Vendor COA Value Result" := StageQCDetails_lRec."Vendor COA Value Result";
                                        QCRcptLine_lRec.Validate(Result, StageQCDetails_lRec.Result);
                                        QCRcptLine_lRec.Required := StageQCDetails_lRec.Required; //14042025
                                        QCRcptLine_lRec.Modify();
                                        QCRcptHead_lRec."Sample Collector ID" := StageQCDetails_lRec."Sample Collector ID";
                                        QCRcptHead_lRec."Sample Provider ID" := StageQCDetails_lRec."Sample Provider ID";
                                        QCRcptHead_lRec."Date of Sample Collection" := StageQCDetails_lRec."Date of Sample Collection";
                                        QCRcptHead_lRec."Sample Date and Time" := StageQCDetails_lRec."Sample Date and Time";
                                        QCRcptHead_lRec."Previous Posted QC No." := StageQCDetails_lRec."No.";
                                        headUpdate_lBln := true;
                                    end else begin  //T53429-NS
                                        QCRcptLine_lRec.Required := false;
                                        QCRcptLine_lRec.Modify();
                                    end;
                                //T53429-NE
                                until QCRcptLine_lRec.Next() = 0;
                            if headUpdate_lBln then begin
                                Clear(ItemLdgrEntry_lRec);
                                ItemLdgrEntry_lRec.Get(Ile_lRec."Entry No.");
                                ItemLdgrEntry_lRec."Accepted Quantity" := QCRcptHead_lRec."Inspection Quantity";
                                ItemLdgrEntry_lRec.Modify();
                                QCRcptHead_lRec."Quantity to Accept" := QCRcptHead_lRec."Inspection Quantity";
                                QCRcptHead_lRec."QC Date" := Today;
                                QCRcptHead_lRec.Approve := true;
                                QCRcptHead_lRec.Modify();
                            end;
                        end;
                    until Ile_lRec.Next() = 0;
                DeleteReservationEntry_gFnc(PurchaseHeader, PurchRcptLine_lRec); //25-08-2025 Skip The Issue
            until PurchRcptLine_lRec.Next() = 0;
        //<------------------------------------To Post the QC Receipt----------------------------------------------------------------------->

        QCFoundnPosted_lBln := false;
        PurchRcptLine1_lRec.Reset();
        PurchRcptLine1_lRec.SetRange("Document No.", PurchRcptHeader."No.");
        //T51170-NS //26032025
        PurchRcptLine1_lRec.SetRange(Type, PurchRcptLine1_lRec.Type::Item);
        PurchRcptLine1_lRec.SetFilter(Quantity, '>%1', 0);
        //T51170-NE //26032025
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
                        QCRcptHead1_lRec.Reset();
                        QCRcptHead1_lRec.SetRange("Document No.", PurchRcptLine1_lRec."Document No.");
                        QCRcptHead1_lRec.SetRange("Document Line No.", PurchRcptLine1_lRec."Line No.");
                        QCRcptHead1_lRec.SetRange("Vendor Lot No.", Ile1_lRec."Lot No.");
                        QCRcptHead1_lRec.SetRange("Item Tracking", QCRcptHead1_lRec."Item Tracking"::"Lot No.");
                        QCRcptHead1_lRec.SetFilter("Previous Posted QC No.", '<>%1', ''); //Hypercare-10-03-25-N
                        if QCRcptHead1_lRec.FindFirst() then begin
                            // QCRcptHead1_lRec.CheckQCCheck_gfnc();
                            QCRcptHead1_lRec.PostQCRcpt_gFnc(false);
                            QCFoundnPosted_lBln := true;
                        end;
                    until Ile1_lRec.Next() = 0;
            until PurchRcptLine1_lRec.Next() = 0;

        if (PurchRcptHeader."No." <> '') and (QCFoundnPosted_lBln) then
            Message('All the Related QC Receipts has been created and posted successfully');

        // Error('Error');
    end;

    Local procedure DeleteReservationEntry_gFnc(Ph_iRec: Record "Purchase Header"; PurchRcptLine_iRec: Record "Purch. Rcpt. Line")
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        ReservationEntry.Reset();
        ReservationEntry.SetRange("Reservation Status", ReservationEntry."Reservation Status"::Surplus);
        ReservationEntry.SetRange("Source Type", DATABASE::"Purchase Line");
        ReservationEntry.SetRange("Source ID", PurchRcptLine_iRec."Order No.");
        ReservationEntry.SetRange("Source Ref. No.", PurchRcptLine_iRec."Order Line No.");
        ReservationEntry.SetRange(Positive, true);
        if ReservationEntry.FindSet() then
            repeat
                if PurchRcptLine_iRec.Quantity = ReservationEntry.Quantity then
                    ReservationEntry.Delete();
            until ReservationEntry.Next() = 0;
    end;




    /* [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnBeforeInsertEvent', '', true, true)]
    local procedure ReservationEntryOnBeforeInsert(var Rec: Record "Reservation Entry"; RunTrigger: Boolean)
    begin
        // Your custom logic here for Debug code
        // Example: Validate fields before insert
        if rec.IsTemporary then
            exit;
        if Rec."Source ID" = 'CPJ/PO/700215' then
            Error('Reservation Entry cannot be created with negative quantity. %1', rec."Entry No.");
        // You can also modify values before insert

    end; */

    //T13919-NE
}