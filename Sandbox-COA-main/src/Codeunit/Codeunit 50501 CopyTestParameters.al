codeunit 50501 CopyTestParameters//T12370-Full Comment //T13935-N
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnAfterInsertTransRcptLine', '', true, true)]
    local procedure TransferOrderCopyTestParameters(TransLine: Record "Transfer Line"; var TransRcptLine: Record "Transfer Receipt Line")
    var
        LotPostedVariantTestParameter: Record "Post Lot Var Testing Parameter"; //AJAY
        LotVariantTestParameter: Record "Lot Variant Testing Parameter"; //AJAY
        Item_lRec: Record item;//T51170-N
    begin //AJAY >>
        LotVariantTestParameter.SetRange("Source ID", TransLine."Document No.");
        LotVariantTestParameter.SetRange("Source Ref. No.", TransLine."Line No.");
        LotVariantTestParameter.SetRange("Variant Code", TransLine."Variant Code");
        if LotVariantTestParameter.FINDSET() then
            repeat
                //T51170-NS
                Item_lRec.get(LotVariantTestParameter."Item No.");
                if (Item_lRec."COA Applicable") then begin
                    //T51170-NE
                    LotPostedVariantTestParameter.Init();
                    LotPostedVariantTestParameter.TransferFields(LotVariantTestParameter);
                    LotPostedVariantTestParameter."Source ID" := TransRcptLine."Document No.";
                    LotPostedVariantTestParameter."Source Ref. No." := TransRcptLine."Line No.";
                    //LotPostedVariantTestParameter."Variant Code" := TransLine."Variant Code";
                    IF LotPostedVariantTestParameter.Insert() then;
                    LotVariantTestParameter.Delete();
                end;//T51170-N
            until LotVariantTestParameter.Next() = 0;
    end;  //AJAY <<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Sales Shipment Line", 'OnAfterNewSalesShptLineInsert', '', true, true)]
    local procedure ShipmentCopyTestParameter(OldSalesShipmentLine: Record "Sales Shipment Line"; var NewSalesShipmentLine: Record "Sales Shipment Line")
    var
        LOTPostedVariantTestParameterFrom: Record "Post Lot Var Testing Parameter";  //AJAY
        LOTPostedVariantTestParameterTo: Record "Post Lot Var Testing Parameter";    //AJAY
        Item_lRec: Record item;//T51170-N
    begin  //AJAY >>
        LOTPostedVariantTestParameterFrom.SetRange("Source ID", OldSalesShipmentLine."Document No.");
        LOTPostedVariantTestParameterFrom.SetRange("Source Ref. No.", OldSalesShipmentLine."Line No.");
        LOTPostedVariantTestParameterFrom.SetRange("Variant Code", OldSalesShipmentLine."Variant Code");
        if LOTPostedVariantTestParameterFrom.FINDSET() then
            repeat
                //T51170-NS
                Item_lRec.get(LOTPostedVariantTestParameterFrom."Item No.");
                if (Item_lRec."COA Applicable") then begin
                    //T51170-NE
                    LOTPostedVariantTestParameterTo.Init();
                    LOTPostedVariantTestParameterTo.TransferFields(LOTPostedVariantTestParameterFrom);
                    LOTPostedVariantTestParameterTo."Source Ref. No." := NewSalesShipmentLine."Line No.";
                    LOTPostedVariantTestParameterTo.Validate(Code, LOTPostedVariantTestParameterFrom.Code); //NEW CODE
                                                                                                            //LOTPostedVariantTestParameterTo."Variant Code" := NewSalesShipmentLine."Variant Code";
                    IF LOTPostedVariantTestParameterTo.Insert() then;
                end;//T51170-N
            until LOTPostedVariantTestParameterFrom.Next() = 0;
    end; //AJAY <<
    //T51170-NS 01042025
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", OnAfterNewPurchRcptLineInsert, '', false, false)]
    local procedure "Undo Purchase Receipt Line_OnAfterNewPurchRcptLineInsert"(var NewPurchRcptLine: Record "Purch. Rcpt. Line"; OldPurchRcptLine: Record "Purch. Rcpt. Line"; var TempGlobalItemEntryRelation: Record "Item Entry Relation" temporary; var SkipInsertItemEntryRelation: Boolean)
    var
        LOTPostedVariantTestParameterFrom: Record "Post Lot Var Testing Parameter";  //AJAY
        LOTPostedVariantTestParameterTo: Record "Post Lot Var Testing Parameter";    //AJAY
        Item_lRec: Record item;//T51170-N
    begin
        LOTPostedVariantTestParameterFrom.SetRange("Source ID", OldPurchRcptLine."Document No.");
        LOTPostedVariantTestParameterFrom.SetRange("Source Ref. No.", OldPurchRcptLine."Line No.");
        LOTPostedVariantTestParameterFrom.SetRange("Variant Code", OldPurchRcptLine."Variant Code");
        if LOTPostedVariantTestParameterFrom.FINDSET() then
            repeat
                //T51170-NS
                Item_lRec.get(LOTPostedVariantTestParameterFrom."Item No.");
                if (Item_lRec."COA Applicable") then begin
                    //T51170-NE
                    LOTPostedVariantTestParameterTo.Init();
                    LOTPostedVariantTestParameterTo.TransferFields(LOTPostedVariantTestParameterFrom);
                    LOTPostedVariantTestParameterTo."Source Ref. No." := NewPurchRcptLine."Line No.";
                    LOTPostedVariantTestParameterTo.Validate(Code, LOTPostedVariantTestParameterFrom.Code); //NEW CODE

                    IF LOTPostedVariantTestParameterTo.Insert() then;
                end;//T51170-N
            until LOTPostedVariantTestParameterFrom.Next() = 0;

    end;

    //T51170-NE

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLines', '', true, true)]
    local procedure SalesReturnPostTestParamter(var SalesHeader: Record "Sales Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        SalesCreditMemoLine: Record "Sales Cr.Memo Line";
        SalesReturnReceiptLine: Record "Return Receipt Line";
        LotVariantTestParameter: Record "Lot Variant Testing Parameter";  //AJAY 
        LOTPostedVariantTestParameter: Record "Post Lot Var Testing Parameter";  //AJAY
        Item_lRec: Record item;//T51170-N

    begin
        if ReturnReceiptHeader."No." = '' then exit;
        SalesReturnReceiptLine.SetRange("Document No.", ReturnReceiptHeader."No.");
        if SalesReturnReceiptLine.FindSet() then
            repeat //AJAY >>
                LotVariantTestParameter.SetRange("Source ID", SalesHeader."No.");
                LotVariantTestParameter.SetRange("Source Ref. No.", SalesReturnReceiptLine."Line No.");
                LotVariantTestParameter.SetRange("Variant Code", SalesReturnReceiptLine."Variant Code");
                if LotVariantTestParameter.FindSet() then
                    repeat
                        //T51170-NS
                        Item_lRec.get(LotVariantTestParameter."Item No.");
                        if (Item_lRec."COA Applicable") then begin
                            //T51170-NE
                            LOTPostedVariantTestParameter.Init();
                            LOTPostedVariantTestParameter.TransferFields(LotVariantTestParameter);
                            LOTPostedVariantTestParameter."Source ID" := SalesReturnReceiptLine."Document No.";
                            LOTPostedVariantTestParameter."Source Ref. No." := SalesReturnReceiptLine."Line No.";
                            //LOTPostedVariantTestParameter."Variant Code" := SalesReturnReceiptLine."Variant Code";
                            if LOTPostedVariantTestParameter.Insert() then;
                        end;//T51170-N
                    until LotVariantTestParameter.Next() = 0;
            until SalesReturnReceiptLine.Next() = 0; //AJAY <<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Management", 'OnCopyItemLedgEntryTrkgToDocLine', '', true, true)]
    local procedure CopyTestParameterfromPostedParameter2(var ItemLedgerEntry: Record "Item Ledger Entry"; var ReservationEntry: Record "Reservation Entry")
    var
        LotVariantTestParameter: Record "Lot Variant Testing Parameter";  //AJAY 
        LOTPostedVariantTestParameter: Record "Post Lot Var Testing Parameter";  //AJAY
        Item_lRec: Record Item;//T51170-N
    begin
        //if ReservationEntry."Appl.-from Item Entry" <> 0 then //AJAY >>
        ItemLedgerEntry.SetRange("Entry No.", ReservationEntry."Appl.-from Item Entry");
        if ItemLedgerEntry.FindSet() then begin
            LOTPostedVariantTestParameter.SetRange("Source ID", ItemLedgerEntry."Document No.");
            LOTPostedVariantTestParameter.SetRange("Source Ref. No.", ItemLedgerEntry."Document Line No.");
            LOTPostedVariantTestParameter.SetRange("Item No.", ItemLedgerEntry."Item No.");
            LOTPostedVariantTestParameter.SetRange("Variant Code", ItemLedgerEntry."Variant Code");
            if LOTPostedVariantTestParameter.FindSet() then
                repeat
                    //T51170-NS
                    Item_lRec.get(LOTPostedVariantTestParameter."Item No.");
                    if (Item_lRec."COA Applicable") then begin
                        //T51170-NE
                        LotVariantTestParameter.Init();
                        LotVariantTestParameter.TransferFields(LOTPostedVariantTestParameter);
                        LotVariantTestParameter."Source ID" := ReservationEntry."Source ID";
                        //LotVariantTestParameter.Validate(Code, LOTPostedVariantTestParameter.Code); //NEW CODE
                        LotVariantTestParameter."Source Ref. No." := ReservationEntry."Source Ref. No.";
                        //LotVariantTestParameter."Variant Code" := ReservationEntry."Variant Code";
                        if LotVariantTestParameter.Insert() then;
                    end;//T51170-N
                until LOTPostedVariantTestParameter.Next() = 0;
        end; //AJAY <<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Management", 'OnAfterSynchronizeItemTracking2', '', true, true)]
    local procedure CopyTPWhenDropShipment(FromReservEntry: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry")
    var
        SalesLineRec: Record "Sales Line";
        ReservationFrom: Record "Reservation Entry";
        ReservationToRec: Record "Reservation Entry";
        LOTVariantTestParameterFrom: Record "Lot Variant Testing Parameter";  //AJAY
        LOTVariantTestParameterTo: Record "Lot Variant Testing Parameter";    //AJAY
        Item_lRec: Record Item;//T51170-N
    begin
        //AJAY >>
        ReservationFrom.SetRange("Source ID", FromReservEntry."Source ID");
        ReservationFrom.SetRange("Source Ref. No.", FromReservEntry."Source Ref. No.");
        ReservationFrom.SetRange("Item No.", FromReservEntry."Item No.");
        ReservationFrom.SetRange("Variant Code", FromReservEntry."Variant Code");
        if ReservationFrom.FindSet() then begin
            repeat
                LOTVariantTestParameterFrom.SetRange("Source ID", FromReservEntry."Source ID");
                LOTVariantTestParameterFrom.SetRange("Source Ref. No.", FromReservEntry."Source Ref. No.");
                LOTVariantTestParameterFrom.SetRange("Item No.", FromReservEntry."Item No.");
                LOTVariantTestParameterFrom.SetRange("Variant Code", FromReservEntry."Variant Code");
                LOTVariantTestParameterFrom.SetRange("Lot No.", ReservationFrom.CustomLotNumber);
                LOTVariantTestParameterFrom.SetRange("BOE No.", ReservationFrom.CustomBOENumber);
                if LOTVariantTestParameterFrom.FindSet() then begin
                    repeat
                        LOTVariantTestParameterTo.SetRange("Source ID", ReservEntry2."Source ID");
                        LOTVariantTestParameterTo.SetRange("Source Ref. No.", ReservEntry2."Source Ref. No.");
                        LOTVariantTestParameterTo.SetRange("Item No.", LOTVariantTestParameterFrom."Item No.");
                        LOTVariantTestParameterTo.SetRange("Variant Code", LOTVariantTestParameterFrom."Variant Code");
                        LOTVariantTestParameterTo.SetRange("Lot No.", LOTVariantTestParameterFrom."Lot No.");
                        LOTVariantTestParameterTo.SetRange("BOE No.", LOTVariantTestParameterFrom."BOE No.");
                        LOTVariantTestParameterTo.SetRange(Code, LOTVariantTestParameterFrom.Code);
                        if LOTVariantTestParameterTo.FindSet() then begin
                            repeat
                                //T51170-NS
                                Item_lRec.get(LOTVariantTestParameterTo."Item No.");
                                if (Item_lRec."COA Applicable") then begin
                                    //T51170-NE
                                    if LOTVariantTestParameterFrom."Actual Value" <> '' then
                                        LOTVariantTestParameterTo.Validate("Actual Value", LOTVariantTestParameterFrom."Actual Value");
                                    if LOTVariantTestParameterTo.Modify() then;
                                end;//T51170-N
                            until LOTVariantTestParameterTo.Next() = 0;
                        end;
                    until LOTVariantTestParameterFrom.Next() = 0;
                end;
            until ReservationFrom.Next() = 0;
        end;
        begin
            LOTVariantTestParameterTo.Reset();
            LOTVariantTestParameterTo.SetRange("Source ID", ReservEntry2."Source ID");
            LOTVariantTestParameterTo.SetRange("Source Ref. No.", ReservEntry2."Source Ref. No.");
            LOTVariantTestParameterTo.SetRange("Item No.", ReservEntry2."Item No.");
            LOTVariantTestParameterTo.SetRange("Variant Code", ReservEntry2."Variant Code");
            if LOTVariantTestParameterTo.FindSet() then begin
                repeat
                    LOTVariantTestParameterFrom.Reset();
                    //T51170-NS
                    Item_lRec.get(LOTVariantTestParameterTo."Item No.");
                    if (Item_lRec."COA Applicable") then begin
                        //T51170-NE
                        if not LOTVariantTestParameterFrom.Get(FromReservEntry."Source ID", FromReservEntry."Source Ref. No.", LOTVariantTestParameterTo."Item No.", LOTVariantTestParameterTo."Variant Code", LOTVariantTestParameterTo."Lot No.", LOTVariantTestParameterTo."BOE No.", LOTVariantTestParameterTo.Code) then begin
                            LOTVariantTestParameterTo.Delete();
                        end;
                    end;//T51170-N
                until LOTVariantTestParameterTo.Next() = 0;
            end;
        end;
    END;
    //AJAY <<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterSalesShptLineInsert', '', true, true)]
    local procedure CancelSalesInvoice(SalesOrderLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    var
        LotVariantTestParameter: Record "Lot Variant Testing Parameter";  //AJAY 
        LOTPostedVariantTestParameter: Record "Post Lot Var Testing Parameter";  //AJAY
        Item_lRec: Record Item;//T51170-N
    begin
        if SalesShptLine."Document No." <> '' then begin //AJAY
            LotVariantTestParameter.SetRange("Source ID", SalesOrderLine."Document No.");
            LotVariantTestParameter.SetRange("Source Ref. No.", SalesOrderLine."Line No.");
            LotVariantTestParameter.SetRange("Variant Code", SalesOrderLine."Variant Code");
            if LotVariantTestParameter.FindSet() then
                repeat
                    //T51170-NS
                    Item_lRec.get(LotVariantTestParameter."Item No.");
                    if (Item_lRec."COA Applicable") then begin
                        //T51170-NE
                        LOTPostedVariantTestParameter.Init();
                        LOTPostedVariantTestParameter.TransferFields(LotVariantTestParameter);
                        LOTPostedVariantTestParameter."Source ID" := SalesShptLine."Document No.";
                        LOTPostedVariantTestParameter."Source Ref. No." := SalesShptLine."Line No.";
                        //LOTPostedVariantTestParameter."Variant Code" := SalesShptLine."Variant Code";
                        LOTPostedVariantTestParameter.SetRecFilter();
                        if LOTPostedVariantTestParameter.IsEmpty() then
                            LOTPostedVariantTestParameter.Insert();
                    end;//T51170-N
                until LotVariantTestParameter.Next() = 0;
        end; //AJAY
    end;

    // Nasif
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterInsertEvent', '', true, true)]
    local procedure OnInsertLotInsertTP(var Rec: Record "Reservation Entry")
    var
        itemTestingParameter: Record "Item Testing Parameter";
        ItemVariantTestingParameter: Record "Item Variant Testing Parameter";  //AJAY
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter";    //AJAY
        QCSpecificationHeader_lRec: Record "QC Specification Header";//T13935-N
        QCSpecificationLine_lRec: Record "QC Specification Line";//T13935-N
        Item_lRec: Record Item;//T13935-N
    begin
        if rec.IsTemporary then
            exit;
        //T13935-NS      Old Code converted in to new Code
        if Not Item_lRec.Get(Rec."Item No.") then
            exit;
        // if not Item_lRec."COA Applicable" then
        //     exit;
        if Item_lRec."COA Applicable" then begin//T51170-N
            QCSpecificationHeader_lRec.Reset();
            QCSpecificationHeader_lRec.SetRange("No.", Item_lRec."Item Specification Code");
            // QCSpecificationHeader_lRec.SetRange(Status, QCSpecificationHeader_lRec.Status::Certified);
            if QCSpecificationHeader_lRec.FindFirst() then begin
                QCSpecificationHeader_lRec.TestField(QCSpecificationHeader_lRec.Status, QCSpecificationHeader_lRec.Status::Certified);
                QCSpecificationLine_lRec.Reset();
                QCSpecificationLine_lRec.SetRange("Item Specifiction Code", QCSpecificationHeader_lRec."No.");
                if QCSpecificationLine_lRec.FindSet() then begin
                    repeat
                        LotVariantTestingParameter.SetRange("Source ID", Rec."Source ID");
                        LotVariantTestingParameter.SetRange("Source Ref. No.", Rec."Source Ref. No.");
                        LotVariantTestingParameter.SetRange("Item No.", Rec."Item No.");
                        if Rec."Variant Code" <> '' then
                            LotVariantTestingParameter.SetRange("Variant Code", rec."Variant Code")
                        else
                            LotVariantTestingParameter.SetRange("Variant Code", '');
                        LotVariantTestingParameter.SetRange("Lot No.", Rec.CustomLotNumber);
                        LotVariantTestingParameter.SetRange("BOE No.", Rec.CustomBOENumber);
                        LotVariantTestingParameter.SetRange(Code, QCSpecificationLine_lRec."Quality Parameter Code");
                        if Not LotVariantTestingParameter.FindFirst then begin
                            LotVariantTestingParameter.Init();
                            LotVariantTestingParameter."Source ID" := Rec."Source ID";
                            LotVariantTestingParameter."Source Ref. No." := Rec."Source Ref. No.";
                            LotVariantTestingParameter."Item No." := Rec."Item No.";
                            LotVariantTestingParameter."Variant Code" := rec."Variant Code"; //Blank/Value
                            LotVariantTestingParameter."Lot No." := Rec.CustomLotNumber;
                            LotVariantTestingParameter."BOE No." := Rec.CustomBOENumber;
                            // LotVariantTestingParameter.Code := QCSpecificationLine_lRec."Item Specifiction Code";//QC Specification Code
                            // LotVariantTestingParameter."Testing Parameter" := QCSpecificationLine_lRec."Quality Parameter Code";
                            //T51170-NS
                            LotVariantTestingParameter.Code := QCSpecificationLine_lRec."Quality Parameter Code";
                            LotVariantTestingParameter."Testing Parameter" := QCSpecificationLine_lRec.Description;
                            LotVariantTestingParameter."Testing Parameter Code" := QCSpecificationLine_lRec."Method Description";
                            //T51170-NE
                            LotVariantTestingParameter.Minimum := QCSpecificationLine_lRec."Min.Value";
                            LotVariantTestingParameter.Maximum := QCSpecificationLine_lRec."Max.Value";
                            LotVariantTestingParameter.Value2 := QCSpecificationLine_lRec."Text Value";
                            //LotVariantTestingParameter."Data Type" := itemTestingParameter."Data Type"; Need to discuss
                            //LotVariantTestingParameter.Symbol := itemTestingParameter.Symbol;Need to discuss
                            LotVariantTestingParameter."Of Spec" := Rec."Of Spec";
                            //LotVariantTestingParameter.Priority := itemTestingParameter.Priority;Need to discuss
                            //LotVariantTestingParameter."Show in COA" := QCSpecificationLine_lRec.Print;
                            //LotVariantTestingParameter."Default Value" := itemTestingParameter."Default Value"; Need to discuss

                            //T51170-NS
                            LotVariantTestingParameter."Show in COA" := QCSpecificationLine_lRec."Show in COA";
                            LotVariantTestingParameter."Default Value" := QCSpecificationLine_lRec."Default Value";
                            LotVariantTestingParameter.Type := QCSpecificationLine_lRec.Type;
                            LotVariantTestingParameter."Rounding Precision" := QCSpecificationLine_lRec."Rounding Precision";
                            //T51170-NE
                            LotVariantTestingParameter."Decimal Places" := QCSpecificationLine_lRec."Decimal Places";//T52614-N
                            IF LotVariantTestingParameter.Insert then;
                        end;
                    until QCSpecificationLine_lRec.next = 0;
                end;
            end;
            //T13935-NE  Old Code converted in to new Code 
        end;//T51170-N     
    end;
    // Nasif
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterInsertEvent', '', true, true)]
    local procedure OnItemTrackingInsert(var Rec: Record "Tracking Specification")
    var
        itemTestingParameter: Record "Item Testing Parameter";
        ItemVariantTestingParameter: Record "Item Variant Testing Parameter";  //AJAY
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter";    //AJAY
        QCSpecificationHeader_lRec: Record "QC Specification Header";//T13935-N
        QCSpecificationLine_lRec: Record "QC Specification Line";//T13935-N
        Item_lRec: Record Item;//T13935-N
    begin
        //
        IF REC."Variant Code" = '' THEN BEGIN
            if rec.IsTemporary then begin
                if (Rec."Source Type" = 39) OR (Rec."Source Type" = 83) then begin
                    //T13935-NS
                    Item_lRec.Get(Rec."Item No.");
                    // if not Item_lRec."COA Applicable" then
                    //     exit;
                    if Item_lRec."COA Applicable" then begin//T51170-N
                        QCSpecificationHeader_lRec.Reset();
                        QCSpecificationHeader_lRec.SetRange("No.", Item_lRec."Item Specification Code");
                        // QCSpecificationHeader_lRec.SetRange(Status, QCSpecificationHeader_lRec.Status::Certified);
                        if QCSpecificationHeader_lRec.FindFirst() then begin
                            QCSpecificationHeader_lRec.TestField(QCSpecificationHeader_lRec.Status, QCSpecificationHeader_lRec.Status::Certified);
                            QCSpecificationLine_lRec.Reset();
                            QCSpecificationLine_lRec.SetRange("Item Specifiction Code", QCSpecificationHeader_lRec."No.");
                            if QCSpecificationLine_lRec.FindSet() then begin
                                repeat
                                    LotVariantTestingParameter.SetRange("Source ID", Rec."Source ID");
                                    LotVariantTestingParameter.SetRange("Source Ref. No.", Rec."Source Ref. No.");
                                    LotVariantTestingParameter.SetRange("Item No.", Rec."Item No.");
                                    LotVariantTestingParameter.SetRange("Variant Code", '');
                                    LotVariantTestingParameter.SetRange("Lot No.", Rec.CustomLotNumber);
                                    LotVariantTestingParameter.SetRange("BOE No.", Rec.CustomBOENumber);
                                    LotVariantTestingParameter.SetRange(Code, QCSpecificationLine_lRec."Quality Parameter Code");
                                    if Not LotVariantTestingParameter.FindFirst then begin
                                        LotVariantTestingParameter.Init();
                                        LotVariantTestingParameter."Source ID" := Rec."Source ID";
                                        LotVariantTestingParameter."Source Ref. No." := Rec."Source Ref. No.";
                                        LotVariantTestingParameter."Item No." := Rec."Item No.";
                                        LotVariantTestingParameter."Variant Code" := rec."Variant Code"; //Blank/Value
                                        LotVariantTestingParameter."Lot No." := Rec.CustomLotNumber;
                                        LotVariantTestingParameter."BOE No." := Rec.CustomBOENumber;
                                        //LotVariantTestingParameter.Code := QCSpecificationLine_lRec."Quality Parameter Code";
                                        // LotVariantTestingParameter."Testing Parameter" := QCSpecificationLine_lRec.Description;
                                        //T51170-NS
                                        LotVariantTestingParameter.Code := QCSpecificationLine_lRec."Quality Parameter Code";
                                        LotVariantTestingParameter."Testing Parameter" := QCSpecificationLine_lRec.Description;
                                        LotVariantTestingParameter."Testing Parameter Code" := QCSpecificationLine_lRec."Method Description";
                                        //T51170-NE
                                        LotVariantTestingParameter.Minimum := QCSpecificationLine_lRec."Min.Value";
                                        LotVariantTestingParameter.Maximum := QCSpecificationLine_lRec."Max.Value";
                                        LotVariantTestingParameter.Value2 := QCSpecificationLine_lRec."Text Value";
                                        LotVariantTestingParameter."Testing Parameter Code" := QCSpecificationLine_lRec."Method Description";//new
                                                                                                                                             //LotVariantTestingParameter."Data Type" := itemTestingParameter."Data Type"; Need to discuss
                                                                                                                                             //LotVariantTestingParameter.Symbol := itemTestingParameter.Symbol;Need to discuss
                                        LotVariantTestingParameter."Of Spec" := Rec."Of Spec";
                                        //LotVariantTestingParameter.Priority := itemTestingParameter.Priority;Need to discuss
                                        //LotVariantTestingParameter."Show in COA" := QCSpecificationLine_lRec.Print;
                                        //LotVariantTestingParameter."Default Value" := itemTestingParameter."Default Value"; Need to discuss
                                        //T51170-NS
                                        LotVariantTestingParameter."Show in COA" := QCSpecificationLine_lRec."Show in COA";
                                        LotVariantTestingParameter."Default Value" := QCSpecificationLine_lRec."Default Value";
                                        LotVariantTestingParameter.Type := QCSpecificationLine_lRec.Type;
                                        LotVariantTestingParameter."Rounding Precision" := QCSpecificationLine_lRec."Rounding Precision";
                                        LotVariantTestingParameter."Decimal Places" := QCSpecificationLine_lRec."Decimal Places";//T52614-N
                                        //T51170-NE
                                        IF LotVariantTestingParameter.Insert then;
                                    end;
                                until QCSpecificationLine_lRec.next = 0;
                            end;
                        end;
                        //T13935-NE
                    end;
                end;//T51170-N
            end;
        END;

        //AJAY >>
        IF REC."Variant Code" <> '' THEN BEGIN
            if rec.IsTemporary then begin
                if (Rec."Source Type" = 39) OR (Rec."Source Type" = 83) then begin

                    Item_lRec.Get(Rec."Item No.");
                    // if not Item_lRec."COA Applicable" then
                    //     exit;
                    if Item_lRec."COA Applicable" then begin//T51170-N

                        QCSpecificationHeader_lRec.Reset();
                        QCSpecificationHeader_lRec.SetRange("No.", Item_lRec."Item Specification Code");
                        // QCSpecificationHeader_lRec.SetRange(Status, QCSpecificationHeader_lRec.Status::Certified);
                        if QCSpecificationHeader_lRec.FindFirst() then begin
                            QCSpecificationHeader_lRec.TestField(QCSpecificationHeader_lRec.Status, QCSpecificationHeader_lRec.Status::Certified);
                            QCSpecificationLine_lRec.Reset();
                            QCSpecificationLine_lRec.SetRange("Item Specifiction Code", QCSpecificationHeader_lRec."No.");
                            if QCSpecificationLine_lRec.FindSet() then begin
                                repeat
                                    LotVariantTestingParameter.SetRange("Source ID", Rec."Source ID");
                                    LotVariantTestingParameter.SetRange("Source Ref. No.", Rec."Source Ref. No.");
                                    LotVariantTestingParameter.SetRange("Item No.", Rec."Item No.");
                                    LotVariantTestingParameter.SetRange("Variant Code", rec."Variant Code");
                                    LotVariantTestingParameter.SetRange("Lot No.", Rec.CustomLotNumber);
                                    LotVariantTestingParameter.SetRange("BOE No.", Rec.CustomBOENumber);
                                    LotVariantTestingParameter.SetRange(Code, QCSpecificationLine_lRec."Quality Parameter Code");
                                    if Not LotVariantTestingParameter.FindFirst then begin
                                        LotVariantTestingParameter.Init();
                                        LotVariantTestingParameter."Source ID" := Rec."Source ID";
                                        LotVariantTestingParameter."Source Ref. No." := Rec."Source Ref. No.";
                                        LotVariantTestingParameter."Item No." := Rec."Item No.";
                                        LotVariantTestingParameter."Variant Code" := rec."Variant Code"; //Blank/Value
                                        LotVariantTestingParameter."Lot No." := Rec.CustomLotNumber;
                                        LotVariantTestingParameter."BOE No." := Rec.CustomBOENumber;
                                        //LotVariantTestingParameter.Code := QCSpecificationLine_lRec."Quality Parameter Code";
                                        // LotVariantTestingParameter."Testing Parameter" := QCSpecificationLine_lRec.Description;
                                        //T51170-NS
                                        LotVariantTestingParameter.Code := QCSpecificationLine_lRec."Quality Parameter Code";
                                        LotVariantTestingParameter."Testing Parameter" := QCSpecificationLine_lRec.Description;
                                        LotVariantTestingParameter."Testing Parameter Code" := QCSpecificationLine_lRec."Method Description";
                                        //T51170-NE

                                        LotVariantTestingParameter.Minimum := QCSpecificationLine_lRec."Min.Value";
                                        LotVariantTestingParameter.Maximum := QCSpecificationLine_lRec."Max.Value";
                                        LotVariantTestingParameter.Value2 := QCSpecificationLine_lRec."Text Value";
                                        LotVariantTestingParameter."Testing Parameter Code" := QCSpecificationLine_lRec."Method Description";//new
                                                                                                                                             //LotVariantTestingParameter."Data Type" := itemTestingParameter."Data Type"; Need to discuss
                                                                                                                                             //LotVariantTestingParameter.Symbol := itemTestingParameter.Symbol;Need to discuss
                                        LotVariantTestingParameter."Of Spec" := Rec."Of Spec";
                                        //LotVariantTestingParameter.Priority := itemTestingParameter.Priority;Need to discuss
                                        // LotVariantTestingParameter."Show in COA" := QCSpecificationLine_lRec.Print;
                                        //LotVariantTestingParameter."Default Value" := itemTestingParameter."Default Value"; Need to discuss
                                        //T51170-NS
                                        LotVariantTestingParameter."Show in COA" := QCSpecificationLine_lRec."Show in COA";
                                        LotVariantTestingParameter."Default Value" := QCSpecificationLine_lRec."Default Value";
                                        LotVariantTestingParameter.Type := QCSpecificationLine_lRec.Type;
                                        LotVariantTestingParameter."Rounding Precision" := QCSpecificationLine_lRec."Rounding Precision";
                                        LotVariantTestingParameter."Decimal Places" := QCSpecificationLine_lRec."Decimal Places";//T52614-N
                                        //T51170-NE
                                        IF LotVariantTestingParameter.Insert then;
                                    end;
                                until QCSpecificationLine_lRec.next = 0;
                            end;
                        end;
                    end;
                End;//T51170-N
            end;
        END; //AJAY <<
    end;
}
