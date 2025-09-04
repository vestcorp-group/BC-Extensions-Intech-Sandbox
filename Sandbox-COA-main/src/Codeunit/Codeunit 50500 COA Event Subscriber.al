codeunit 50500 "COA Event Subscriber"//T12370-Full Comment //T13935-N
{
    // EventSubscriberInstance = StaticAutomatic;

    var
        c: Codeunit "Purch. Post Invoice";

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchLines', '', true, true)]//30-04-2022
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterProcessPurchLines', '', true, true)]//30-04-2022   
    local procedure CopyTestingParameters(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        PurchRcptLineL: Record "Purch. Rcpt. Line";
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        PostedLotVarintTestingParameter: Record "Post Lot Var Testing Parameter"; //AJAY
        Item_lRec: Record Item;//T51170-N
    begin
        if PurchRcptHeader."No." = '' then
            exit;
        PurchRcptLineL.SetRange("Document No.", PurchRcptHeader."No.");
        PurchRcptLineL.SetRange(Type, PurchRcptLineL.Type::Item);
        if PurchRcptLineL.FindSet() then
            repeat //AJAY >>
                //T51170-NS
                Item_lRec.get(PurchRcptLineL."No.");
                // if not Item_lRec."COA Applicable" then
                //     exit;
                if (Item_lRec."COA Applicable") then begin
                    //T51170-NE
                    LotVariantTestingParameter.SetRange("Source ID", PurchHeader."No.");
                    LotVariantTestingParameter.SetRange("Source Ref. No.", PurchRcptLineL."Order Line No.");
                    LotVariantTestingParameter.SetRange("Item No.", PurchRcptLineL."No.");
                    LotVariantTestingParameter.SetRange("Variant Code", PurchRcptLineL."Variant Code");
                    if LotVariantTestingParameter.FindSet() then
                        repeat
                            PostedLotVarintTestingParameter.Init();
                            PostedLotVarintTestingParameter.TransferFields(LotVariantTestingParameter);
                            PostedLotVarintTestingParameter."Source ID" := PurchRcptLineL."Document No.";
                            PostedLotVarintTestingParameter."Source Ref. No." := PurchRcptLineL."Line No.";
                            //PostedLotVarintTestingParameter."Variant Code" := PurchRcptLineL."Variant Code";
                            PostedLotVarintTestingParameter.SetRecFilter();
                            if PostedLotVarintTestingParameter.IsEmpty() then
                                PostedLotVarintTestingParameter.Insert();
                        until LotVariantTestingParameter.Next() = 0;
                end;//T51170-N
            until PurchRcptLineL.Next() = 0; //AJAY <<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnAfterPostedAssemblyLineInsert', '', true, true)]
    local procedure CopyParameters_OnAfterAssemblyLinePost(var PostedAssemblyLine: Record "Posted Assembly Line"; AssemblyLine: Record "Assembly Line")
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY 
        PostedLotVarintTestingParameter: Record "Post Lot Var Testing Parameter"; //AJAY
        Item_lRec: Record item;//T51170-N
    begin //AJAY >>
        LotVariantTestingParameter.SetRange("Source ID", AssemblyLine."Document No.");
        LotVariantTestingParameter.SetRange("Source Ref. No.", AssemblyLine."Line No.");
        LotVariantTestingParameter.SetRange("Item No.", AssemblyLine."No.");
        LotVariantTestingParameter.SetRange("Variant Code", AssemblyLine."Variant Code");
        if LotVariantTestingParameter.FindSet() then
            repeat
                //T51170-NS
                Item_lRec.get(LotVariantTestingParameter."Item No.");
                // if not Item_lRec."COA Applicable" then
                //     exit;
                if (Item_lRec."COA Applicable") then begin
                    //T51170-NE
                    PostedLotVarintTestingParameter.Init();
                    PostedLotVarintTestingParameter.TransferFields(LotVariantTestingParameter);
                    PostedLotVarintTestingParameter."Source ID" := PostedAssemblyLine."Document No.";
                    PostedLotVarintTestingParameter."Source Ref. No." := PostedAssemblyLine."Line No.";
                    //PostedLotVarintTestingParameter."Variant Code" := PostedAssemblyLine."Variant Code";
                    PostedLotVarintTestingParameter.SetRecFilter();
                    if PostedLotVarintTestingParameter.IsEmpty() then
                        PostedLotVarintTestingParameter.Insert();
                end;//T51170-N
            until LotVariantTestingParameter.Next() = 0;
    end; //AJAY <<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnAfterPostedAssemblyHeaderModify', '', true, true)]
    local procedure CopyParameter_OnAfterAssemblyHdrPost(var PostedAssemblyHeader: Record "Posted Assembly Header"; AssemblyHeader: Record "Assembly Header")
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        PostedLotVarintTestingParameter: Record "Post Lot Var Testing Parameter"; //AJAY
        Item_lRec: Record Item;//51170-N
    begin //AJAY >>
        LotVariantTestingParameter.SetRange("Source ID", AssemblyHeader."No.");
        LotVariantTestingParameter.SetRange("Source Ref. No.", 0);
        LotVariantTestingParameter.SetRange("Item No.", AssemblyHeader."Item No.");
        LotVariantTestingParameter.SetRange("Variant Code", AssemblyHeader."Variant Code");
        if LotVariantTestingParameter.FindSet() then
            repeat
                //T51170-NS
                Item_lRec.get(LotVariantTestingParameter."Item No.");
                // if not Item_lRec."COA Applicable" then
                //     exit;
                if (Item_lRec."COA Applicable") then begin
                    //T51170-NE
                    PostedLotVarintTestingParameter.Init();
                    PostedLotVarintTestingParameter.TransferFields(LotVariantTestingParameter);
                    PostedLotVarintTestingParameter."Source ID" := PostedAssemblyHeader."No.";
                    PostedLotVarintTestingParameter."Source Ref. No." := 0;
                    PostedLotVarintTestingParameter.SetRecFilter();
                    if PostedLotVarintTestingParameter.IsEmpty() then
                        PostedLotVarintTestingParameter.Insert();
                end;//T51170-N
            until LotVariantTestingParameter.Next() = 0;
    end; //AJAY <<

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterDeleteEvent', '', true, true)]
    local procedure DeleteTestingParameters(var Rec: Record "Purchase Header"; RunTrigger: Boolean)
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter";
    begin
        LotVariantTestingParameter.SetRange("Source ID", Rec."No.");
        //LotVariantTestingParameter.SetRange("Source Ref. No.", Rec."Line No.");
        LotVariantTestingParameter.DeleteAll();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Assembly Line", 'OnAfterDeleteEvent', '', true, true)]
    local procedure DeleteTestingParameter_AssemblyLine(var Rec: Record "Assembly Line"; RunTrigger: Boolean)
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
    begin //AJAY
        LotVariantTestingParameter.SetRange("Source ID", Rec."Document No.");
        LotVariantTestingParameter.SetRange("Source Ref. No.", Rec."Line No.");
        LotVariantTestingParameter.SetRange("Item No.", Rec."No.");
        LotVariantTestingParameter.SetRange("Variant Code", Rec."Variant Code");
        LotVariantTestingParameter.DeleteAll();
    end; //AJAY

    [EventSubscriber(ObjectType::Table, Database::"Assembly Header", 'OnAfterDeleteEvent', '', true, true)]
    local procedure DeleteTestingParameter_AssemblyHdr(var Rec: Record "Assembly Header"; RunTrigger: Boolean)
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
    begin //AJAY >       
        LotVariantTestingParameter.SetRange("Source ID", Rec."No.");
        LotVariantTestingParameter.SetRange("Source Ref. No.", 0);
        LotVariantTestingParameter.SetRange("Item No.", Rec."Item No.");
        LotVariantTestingParameter.SetRange("Variant Code", Rec."Variant Code");
        LotVariantTestingParameter.DeleteAll();
    end; //AJAY

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnSelectEntriesOnAfterTransferFields', '', true, true)]
    local procedure CopyIfTestingParameter_OnSelectEntries(var TempTrackingSpec: Record "Tracking Specification"; var TrackingSpecification: Record "Tracking Specification")
    var
        myInt: Integer;
    begin
        CopyTestingParametersFromPostedLot(TrackingSpecification);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnAfterAssistEditTrackingNo', '', true, true)]
    local procedure CopyIfTestingParameter_OnAfterAssistEditLotNo(var TrackingSpecification: Record "Tracking Specification")
    begin
        CopyTestingParametersFromPostedLot(TrackingSpecification);
    end;

    procedure CopyTestingParametersFromPostedLot(var TrackingSpecification: Record "Tracking Specification")
    var
        Item_lRec: Record item;//T51170-N
        ItemLedgEntryL: Record "Item Ledger Entry";
        ItemJnLineL: Record "Item Journal Line";
        ShowOfSpecWarningL: Boolean;
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter";  //AJAY
        PostedLotVariantTestingParameter: Record "Post Lot Var Testing Parameter"; //AJAY
        PostedLotVariantTestingParameter2: Record "Post Lot Var Testing Parameter"; //AJAY
        PostedLotTestingParameter: Record "Posted Lot Testing Parameter"; //AJAY
    begin  //AJAY >>
        ItemLedgEntryL.RESET;
        ItemLedgEntryL.SETCURRENTKEY("Item No.", Open, "Variant Code", "Location Code", "Item Tracking",
        "Lot No.", "Serial No.");
        ItemLedgEntryL.SETRANGE("Item No.", TrackingSpecification."Item No.");
        ItemLedgEntryL.SETRANGE("Variant Code", TrackingSpecification."Variant Code");
        ItemLedgEntryL.SETRANGE(Open, TRUE);
        ItemLedgEntryL.SETRANGE("Location Code", TrackingSpecification."Location Code");
        ItemLedgEntryL.SetRange("Lot No.", TrackingSpecification."Lot No.");
        If ItemLedgEntryL.FindFirst() then begin
            //T51170-NS
            Item_lRec.get(ItemLedgEntryL."Item No.");
            // if not Item_lRec."COA Applicable" then
            //     exit;
            if (Item_lRec."COA Applicable") then begin
                //T51170-NE
                PostedLotVariantTestingParameter2.SetRange("Source ID", ItemLedgEntryL."Document No.");
                PostedLotVariantTestingParameter2.SetRange("Source Ref. No.", ItemLedgEntryL."Document Line No.");
                PostedLotVariantTestingParameter2.SetRange("Item No.", ItemLedgEntryL."Item No.");
                PostedLotVariantTestingParameter2.SetRange("Variant Code", ItemLedgEntryL."Variant Code");
                PostedLotVariantTestingParameter2.SetRange("Lot No.", ItemLedgEntryL.CustomLotNumber);
                PostedLotVariantTestingParameter2.SetRange("BOE No.", ItemLedgEntryL.CustomBOENumber);
                IF PostedLotVariantTestingParameter2.FindFirst THEN BEGIN
                    PostedLotVariantTestingParameter.SetRange("Source ID", ItemLedgEntryL."Document No.");
                    PostedLotVariantTestingParameter.SetRange("Source Ref. No.", ItemLedgEntryL."Document Line No.");
                    PostedLotVariantTestingParameter.SetRange("Item No.", ItemLedgEntryL."Item No.");
                    PostedLotVariantTestingParameter.SetRange("Variant Code", ItemLedgEntryL."Variant Code");
                    PostedLotVariantTestingParameter.SetRange("Lot No.", ItemLedgEntryL.CustomLotNumber);
                    PostedLotVariantTestingParameter.SetRange("BOE No.", ItemLedgEntryL.CustomBOENumber);
                    if PostedLotVariantTestingParameter.Findset() then
                        repeat
                            LotVariantTestingParameter.Init();
                            LotVariantTestingParameter.TransferFields(PostedLotVariantTestingParameter);
                            LotVariantTestingParameter."Source ID" := TrackingSpecification."Source ID";
                            LotVariantTestingParameter."Source Ref. No." := TrackingSpecification."Source Ref. No.";
                            LotVariantTestingParameter."BOE No." := TrackingSpecification.CustomBOENumber;////@@@
                            if LotVariantTestingParameter.Insert() then;
                            if LotVariantTestingParameter."Of Spec" then
                                ShowOfSpecWarningL := true;
                        until PostedLotVariantTestingParameter.Next() = 0;
                end;//T51170-N
            END ELSE begin
                PostedLotTestingParameter.SetRange("Source ID", ItemLedgEntryL."Document No.");
                PostedLotTestingParameter.SetRange("Source Ref. No.", ItemLedgEntryL."Document Line No.");
                PostedLotTestingParameter.SetRange("Item No.", ItemLedgEntryL."Item No.");
                //PostedLotTestingParameter.SetRange("Variant Code", ItemLedgEntryL."Variant Code");
                PostedLotTestingParameter.SetRange("Lot No.", ItemLedgEntryL.CustomLotNumber);
                PostedLotTestingParameter.SetRange("BOE No.", ItemLedgEntryL.CustomBOENumber);
                if PostedLotTestingParameter.Findset() then
                    repeat
                        //T51170-NS
                        Item_lRec.get(PostedLotTestingParameter."Item No.");
                        // if not Item_lRec."COA Applicable" then
                        //     exit;
                        if (Item_lRec."COA Applicable") then begin
                            //T51170-NE
                            LotVariantTestingParameter.Init();
                            LotVariantTestingParameter.TransferFields(PostedLotTestingParameter);
                            LotVariantTestingParameter."Source ID" := TrackingSpecification."Source ID";
                            LotVariantTestingParameter."Source Ref. No." := TrackingSpecification."Source Ref. No.";
                            LotVariantTestingParameter."BOE No." := TrackingSpecification.CustomBOENumber;////@@@
                            LotVariantTestingParameter."Variant Code" := TrackingSpecification."Variant Code"; //new code added
                            if LotVariantTestingParameter.Insert() then;
                            if LotVariantTestingParameter."Of Spec" then
                                ShowOfSpecWarningL := true;
                        end;//T51170-N
                    until PostedLotTestingParameter.Next() = 0;
            end;
            if ShowOfSpecWarningL then
                Message('The Lot No. %1 and BOE No. %2 is off spec!', TrackingSpecification.CustomLotNumber, TrackingSpecification.CustomBOENumber);
        end;
    end;  //AJAY

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertTransferEntry', '', true, true)]
    local procedure CopyingTestingParametersfromItmRec(var ItemJournalLine: Record "Item Journal Line"; var NewItemLedgerEntry: Record "Item Ledger Entry")
    var
        Item_lRec: Record Item;//T51170-N
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        PostedLotVariantTestingParameter: Record "Post Lot Var Testing Parameter"; //AJAY
    begin //AJAY >>
        if ItemJournalLine.IsReclass(ItemJournalLine) then
            LotVariantTestingParameter.SetRange("Source ID", 'TRANSFER')
        else
            LotVariantTestingParameter.SetRange("Source ID", NewItemLedgerEntry."Document No.");
        LotVariantTestingParameter.SetRange("Source Ref. No.", ItemJournalLine."Line No.");
        LotVariantTestingParameter.SetRange("Item No.", ItemJournalLine."Item No.");
        LotVariantTestingParameter.SetRange("Variant Code", ItemJournalLine."Variant Code");
        LotVariantTestingParameter.SetRange("Lot No.", NewItemLedgerEntry.CustomLotNumber);
        if LotVariantTestingParameter.FindSet() then
            repeat
                //T51170-NS
                Item_lRec.get(LotVariantTestingParameter."Item No.");
                // if not Item_lRec."COA Applicable" then
                //     exit;
                if (Item_lRec."COA Applicable") then begin
                    //T51170-NE
                    PostedLotVariantTestingParameter.Init();
                    PostedLotVariantTestingParameter.TransferFields(LotVariantTestingParameter);
                    PostedLotVariantTestingParameter."Source ID" := NewItemLedgerEntry."Document No.";
                    PostedLotVariantTestingParameter."Source Ref. No." := NewItemLedgerEntry."Document Line No.";
                    //PostedLotVariantTestingParameter."Variant Code" := NewItemLedgerEntry."Variant Code";
                    PostedLotVariantTestingParameter.SetRecFilter();
                    if PostedLotVariantTestingParameter.IsEmpty() then
                        PostedLotVariantTestingParameter.Insert();
                end;//T51170-N
            until LotVariantTestingParameter.Next() = 0;
    end; //AJAY

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLines', '', true, true)]
    local procedure TransferTestingParameter_OnAftPostSalesLines(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header")
    var
        Item_lRec: Record Item;//T51170-N
        SalesShipmentLineL: Record "Sales Shipment Line";
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        PostedLotVariantTestingParameter: Record "Post Lot Var Testing Parameter"; //AJAY
    begin
        if SalesShipmentHeader."No." = '' then
            exit;
        SalesShipmentLineL.SetRange("Document No.", SalesShipmentHeader."No.");
        if SalesShipmentLineL.FindSet() then
            repeat //AJAY >>
                LotVariantTestingParameter.SetRange("Source ID", SalesHeader."No.");
                LotVariantTestingParameter.SetRange("Source Ref. No.", SalesShipmentLineL."Order Line No.");
                LotVariantTestingParameter.SetRange("Item No.", SalesShipmentLineL."No.");
                LotVariantTestingParameter.SetRange("Variant Code", SalesShipmentLineL."Variant Code");
                if LotVariantTestingParameter.FindSet() then
                    repeat
                        Item_lRec.get(LotVariantTestingParameter."Item No.");
                        // if not Item_lRec."COA Applicable" then
                        //     exit;
                        if (Item_lRec."COA Applicable") then begin
                            PostedLotVariantTestingParameter.Init();
                            PostedLotVariantTestingParameter.TransferFields(LotVariantTestingParameter);
                            PostedLotVariantTestingParameter."Source ID" := SalesShipmentLineL."Document No.";
                            PostedLotVariantTestingParameter."Source Ref. No." := SalesShipmentLineL."Line No.";
                            //PostedLotVariantTestingParameter."Variant Code" := SalesShipmentLineL."Variant Code";
                            PostedLotVariantTestingParameter.SetRecFilter();
                            if PostedLotVariantTestingParameter.IsEmpty() then
                                PostedLotVariantTestingParameter.Insert();
                        end;//T51170-N
                    until LotVariantTestingParameter.Next() = 0;
            until SalesShipmentLineL.Next() = 0;
    end; //AJAY <<

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterDeleteEvent', '', true, true)]
    local procedure DeleteTestingParametersFromSales(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
    begin //AJAY >>
        LotVariantTestingParameter.SetRange("Source ID", Rec."No.");
        LotVariantTestingParameter.SetRange("Source Ref. No.", Rec."Line No.");
        LotVariantTestingParameter.SetRange("Item No.", Rec."No.");
        LotVariantTestingParameter.SetRange("Variant Code", Rec."Variant Code");
        LotVariantTestingParameter.DeleteAll();
    end; //AJAY <<

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterDeleteEvent', '', true, true)]
    local procedure DeleteTestingParameter_IJL(var Rec: Record "Item Journal Line")
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
    begin //AJAY >>
        if Rec.IsReclass(Rec) then
            LotVariantTestingParameter.SetRange("Source ID", 'TRANSFER')
        else
            LotVariantTestingParameter.SetRange("Source ID", Rec."Document No.");
        LotVariantTestingParameter.SetRange("Source Ref. No.", Rec."Line No.");
        LotVariantTestingParameter.SetRange("Item No.", Rec."Item No.");
        LotVariantTestingParameter.SetRange("Variant Code", Rec."Variant Code");
        LotVariantTestingParameter.SetRange("Lot No.", Rec.CustomLotNumber);
        LotVariantTestingParameter.DeleteAll();
    end; //AJAY <<

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'CustomBOENumber', true, true)]
    local procedure ChangeTestingParametersExist(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        TempLotVariantTestingParameter: Record "Lot Variant Testing Parameter" temporary; //AJAY
    begin
        if xRec.CustomBOENumber = Rec.CustomBOENumber then
            exit;
        //AJAY
        LotVariantTestingParameter.SetRange("Source ID", Rec."No.");
        if LotVariantTestingParameter.FindSet() then
            repeat
                TempLotVariantTestingParameter.Init();
                TempLotVariantTestingParameter := LotVariantTestingParameter;
                TempLotVariantTestingParameter."BOE No." := Rec.CustomBOENumber;
                if TempLotVariantTestingParameter.Insert() then;
            until LotVariantTestingParameter.Next() = 0;
        LotVariantTestingParameter.DeleteAll();
        TempLotVariantTestingParameter.Reset();
        if TempLotVariantTestingParameter.FindSet() then
            repeat
                LotVariantTestingParameter.Init();
                LotVariantTestingParameter := TempLotVariantTestingParameter;
                if LotVariantTestingParameter.Insert() then;
            until TempLotVariantTestingParameter.Next() = 0;
        //AJAY    
        UpdateOfSpecInReservEntry(Rec);
    end;

    local procedure UpdateOfSpecInReservEntry(PurchHdrP: Record "Purchase Header")
    var
        ReservEntryL: Record "Reservation Entry";
    begin
        ReservEntryL.SetSourceFilter(Database::"Purchase Line", PurchHdrP."Document Type".AsInteger(), PurchHdrP."No.", -1, false);//30-04-2022-added asinteger with enum
        if ReservEntryL.FindSet() then
            repeat
                ReservEntryL.Modify(); // OnBeforeModify trigger will run to update Of Spec
            until ReservEntryL.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnAfterCreatePurchDocument', '', true, true)]
    local procedure IntercompanyTransfer_CopyTestingParameters(var PurchaseHeader: Record "Purchase Header"; ICInboxPurchaseHeader: Record "IC Inbox Purchase Header")
    var
        // ICPartnerL: Record "IC Partner";
        SalesHeaderL: Record "Sales Header";
        PurcLineL: Record "Purchase Line";
        PartnerTrackingLineL: Record "Tracking Specification";
        ItemLedgerEntryL: Record "Item Ledger Entry";
        SalesShipmentLine: Record "Sales Shipment Line";
        PurchLine: Record "Purchase Line";
        ICPartner: Record "IC Partner";
        ILE: Record "Item Ledger Entry";
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        PostedLotVariantTestingParameter: Record "Post Lot Var Testing Parameter"; //AJAY
        SICduQCCOA_lCdu: Codeunit "COA_QC_SI";//T51170
    begin
        // if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
        //     exit;
        If not ICPartner.Get(ICInboxPurchaseHeader."IC Partner Code") then
            exit;
        if ICPartner."Data Exchange Type" <> ICPartner."Data Exchange Type"::Database then
            exit;
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
            PurchLine.SetRange("Document No.", PurchaseHeader."No.");
            if PurchLine.FindSet() then begin
                repeat //AJAY >>
                    if ICPartner.Get(ICInboxPurchaseHeader."IC Partner Code") then;
                    SalesShipmentLine.ChangeCompany(ICPartner."Inbox Details");
                    ILE.ChangeCompany(ICPartner."Inbox Details");
                    PostedLotVariantTestingParameter.ChangeCompany(ICPartner."Inbox Details");
                    SalesShipmentLine.SetRange("Order No.", ICInboxPurchaseHeader."No.");
                    SalesShipmentLine.SetRange("Line No.", PurchLine."Line No.");
                    if SalesShipmentLine.FindSet() then begin
                        repeat
                            ILE.SetRange("Document No.", SalesShipmentLine."Document No.");
                            ILE.SetRange("Document Type", ILE."Document Type"::"Sales Shipment");
                            ILE.SetRange("Document Line No.", SalesShipmentLine."Line No.");
                            if ILE.FindSet() then begin
                                repeat
                                    SICduQCCOA_lCdu.ClearProcess_gFnc();//T51170-N
                                    PostedLotVariantTestingParameter.SetRange("Source ID", ILE."Document No.");
                                    PostedLotVariantTestingParameter.SetRange("Source Ref. No.", ILE."Document Line No.");
                                    PostedLotVariantTestingParameter.SetRange("Item No.", Ile."Item No.");
                                    PostedLotVariantTestingParameter.SetRange("Variant Code", ILE."Variant Code");
                                    PostedLotVariantTestingParameter.SetRange("Lot No.", ILE.CustomLotNumber);
                                    PostedLotVariantTestingParameter.SetRange("BOE No.", ILE.CustomBOENumber);
                                    if PostedLotVariantTestingParameter.FindSet() then
                                        repeat
                                            SICduQCCOA_lCdu.SetProcess_gFnc(true);
                                            if LotVariantTestingParameter.Get(PurchLine."Document No.", PurchLine."Line No.", PurchLine."No.", PurchLine."Variant Code", PostedLotVariantTestingParameter."Lot No.", '', PostedLotVariantTestingParameter.Code) then begin
                                                /* if PostedLotVariantTestingParameter."Actual Value" <> '' then
                                                    LotVariantTestingParameter.Validate("Actual Value", PostedLotVariantTestingParameter."Actual Value"); */ //T51170-N
                                                                                                                                                             //T51170-NS
                                                if LotVariantTestingParameter.Type = LotVariantTestingParameter.Type::Text then
                                                    LotVariantTestingParameter.Validate("Vendor COA Text Result", PostedLotVariantTestingParameter."Vendor COA Text Result")
                                                else
                                                    LotVariantTestingParameter.Validate("Vendor COA Value Result", PostedLotVariantTestingParameter."Vendor COA Value Result");
                                                //T51170-NE
                                                if LotVariantTestingParameter.Modify() then;
                                            end
                                            else begin
                                                LotVariantTestingParameter.Init();
                                                LotVariantTestingParameter.TransferFields(PostedLotVariantTestingParameter);
                                                LotVariantTestingParameter."BOE No." := '';
                                                /*  LotVariantTestingParameter."Source ID" := PurcLineL."Document No.";
                                                 LotVariantTestingParameter."Source Ref. No." := PurcLineL."Line No.";
                                                 LotVariantTestingParameter."Variant Code" := PurcLineL."Variant Code"; *///T51170-O old code is not working
                                                LotVariantTestingParameter."Source ID" := PurchLine."Document No.";
                                                LotVariantTestingParameter."Source Ref. No." := PurchLine."Line No.";
                                                LotVariantTestingParameter."Variant Code" := PurchLine."Variant Code";
                                                if LotVariantTestingParameter.Insert() then;
                                            end;
                                        until PostedLotVariantTestingParameter.Next() = 0;
                                    SICduQCCOA_lCdu.ClearProcess_gFnc();//T51170-N
                                until ILE.Next() = 0;
                            end;
                        until SalesShipmentLine.Next() = 0;
                    end;
                until PurchLine.Next() = 0;
            end; //AJAY <<
        end;
    end;

    [EventSubscriber(ObjectType::Page, 6510, 'OnRegisterChangeOnAfterCreateReservEntry', '', false, false)]
    procedure OnAfterCreateReservEntry_UpdateAnalysisDate(var ReservEntry: Record "Reservation Entry"; TrackingSpecification: Record "Tracking Specification")
    begin
        ReservEntry."Analysis Date" := TrackingSpecification."Analysis Date";
        ReservEntry."Of Spec" := TrackingSpecification."Of Spec";
        //05-07-2022 -start
        /* ReservEntry."Expiration Date" := TrackingSpecification."Expiration Date";
        ReservEntry."Expiry Period 2" := TrackingSpecification."Expiry Period 2";
        ReservEntry."Manufacturing Date 2" := TrackingSpecification."Manufacturing Date 2"; */ //T13935-O
                                                                                               //05-07-2022-end
        ReservEntry.Modify;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertSetupTempSplitItemJnlLine', '', false, false)]
    procedure OnBeforeInsertIJL_UpdateAnalysisDate(var TempTrackingSpecification: Record "Tracking Specification" temporary; var TempItemJournalLine: Record "Item Journal Line" temporary; var PostItemJnlLine: Boolean)
    begin
        TempItemJournalLine."Analysis Date" := TempTrackingSpecification."Analysis Date";
        TempItemJournalLine."Of Spec" := TempTrackingSpecification."Of Spec";
        if not TempItemJournalLine."Of Spec" then
            TempItemJournalLine."Of Spec" := CheckOfSpecFromBackEnd(TempTrackingSpecification);

        //05-07-2022-start
        /*  TempItemJournalLine."Manufacturing Date 2" := TempTrackingSpecification."Manufacturing Date 2";
         TempItemJournalLine."Expiration Period" := TempTrackingSpecification."Expiry Period 2";
         TempItemJournalLine."Expiry Period 2" := TempTrackingSpecification."Expiry Period 2";
         TempItemJournalLine."Expiration Date" := TempTrackingSpecification."Expiration Date"; *///T13935-O
                                                                                                 //05-07-2022-end
    end;

    local procedure CheckOfSpecFromBackEnd(var TempTrackingSpecification: Record "Tracking Specification"): Boolean
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
    begin  //AJAY >>
        LotVariantTestingParameter.Reset();
        //LotVariantTestingParameter.SetRange("Source ID", TempTrackingSpecification."Source ID");
        //LotVariantTestingParameter.SetRange("Source Ref. No.", TempTrackingSpecification."Source Ref. No.");
        LotVariantTestingParameter.SetRange("Item No.", TempTrackingSpecification."Item No.");
        LotVariantTestingParameter.SetRange("Variant Code", TempTrackingSpecification."Variant Code");
        LotVariantTestingParameter.SetRange("Lot No.", TempTrackingSpecification.CustomLotNumber);
        LotVariantTestingParameter.SetRange("BOE No.", TempTrackingSpecification.CustomBOENumber);
        LotVariantTestingParameter.SetRange("Of Spec", true);
        Exit(not LotVariantTestingParameter.IsEmpty);
    end; //AJAY <<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    procedure OnInitILE_UpdateAnalysisDate(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin
        NewItemLedgEntry."Analysis Date" := ItemJournalLine."Analysis Date";
        NewItemLedgEntry."Of Spec" := ItemJournalLine."Of Spec";

        //05-07-2022-start
        /* NewItemLedgEntry."Manufacturing Date 2" := ItemJournalLine."Manufacturing Date 2";
        NewItemLedgEntry."Expiry Period 2" := ItemJournalLine."Expiry Period 2";
        NewItemLedgEntry."Expiration Date" := ItemJournalLine."Expiration Date"; */ //T13935-O
                                                                                    //05-07-2022-end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnTransferItemLedgToTempRecOnBeforeInsert', '', true, true)]
    local procedure ReservEntry_UpdateAnalysisDate(var TempGlobalReservEntry: Record "Reservation Entry"; ItemLedgerEntry: Record "Item Ledger Entry"; TrackingSpecification: Record "Tracking Specification")
    begin
        TempGlobalReservEntry."Analysis Date" := ItemLedgerEntry."Analysis Date";
        TempGlobalReservEntry."Of Spec" := ItemLedgerEntry."Of Spec";
        //05-07-2022-start
        /*  TempGlobalReservEntry."Expiration Date" := ItemLedgerEntry."Expiration Date";
         TempGlobalReservEntry."Expiry Period 2" := ItemLedgerEntry."Expiry Period 2";
         TempGlobalReservEntry."Manufacturing Date 2" := ItemLedgerEntry."Manufacturing Date 2"; *///T13935-O
                                                                                                   //05-07-2022-end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::KMP_EventSubscriberUnit, 'OnBeforeModifyEnrtySummary', '', true, true)]
    local procedure EntrySummary_CopyAnalysisDate(var TempGlobalEntrySummary: Record "Entry Summary"; var TempGlobalReservEntry: Record "Reservation Entry")
    begin
        TempGlobalEntrySummary."Analysis Date" := TempGlobalReservEntry."Analysis Date";
        TempGlobalEntrySummary."Of Spec" := TempGlobalReservEntry."Of Spec";

        //05-07-2022-start
        /* TempGlobalEntrySummary."Manufacturing Date 2" := TempGlobalReservEntry."Manufacturing Date 2";
        TempGlobalEntrySummary."Expiration Date" := TempGlobalReservEntry."Expiration Date";
        TempGlobalEntrySummary."Expiry Period 2" := TempGlobalReservEntry."Expiry Period 2"; *///T13935-O
                                                                                               //05-07-2022 -end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnAfterTransferExpDateFromSummary', '', true, true)]
    local procedure TrackingSpecification_UpdateAnalysisDate(var TrackingSpecification: Record "Tracking Specification"; var TempEntrySummary: Record "Entry Summary")
    begin
        TrackingSpecification."Analysis Date" := TempEntrySummary."Analysis Date";
        TrackingSpecification."Of Spec" := TempEntrySummary."Of Spec";
        //05-07-2022-start
        /*  TrackingSpecification."Manufacturing Date 2" := TempEntrySummary."Manufacturing Date 2";
         TrackingSpecification."Expiration Date" := TempEntrySummary."Expiration Date";
         TrackingSpecification."Expiry Period 2" := TempEntrySummary."Expiry Period 2"; *///T13935-O
                                                                                          //05-07-2022 -end
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Testing Parameters", 'OnAfterValidateEvent', 'Minimum', true, true)]
    local procedure SymbolValidatemin(var Rec: Record "Item Testing Parameter"; var xRec: Record "Item Testing Parameter")
    begin
        if (Rec."Data Type" <> Rec."Data Type"::Alphanumeric) and (Rec.Minimum <> 0) and (Rec.Maximum = 0) then begin
            Rec.Symbol := Rec.Symbol::">";
            Rec.Modify();
        end else
            if (Rec."Data Type" <> Rec."Data Type"::Alphanumeric) and (Rec.Minimum = 0) and (Rec.Maximum <> 0) then begin
                Rec.Symbol := Rec.Symbol::"<";
                Rec.Modify();
            end else begin
                Rec.Symbol := Rec.Symbol::" ";
                Rec.Modify();
            end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Testing Parameters", 'OnAfterValidateEvent', 'Maximum', true, true)]
    local procedure SymbolValidateMax(var Rec: Record "Item Testing Parameter"; var xRec: Record "Item Testing Parameter")
    begin

        if (Rec."Data Type" <> Rec."Data Type"::Alphanumeric) and (Rec.Minimum <> 0) and (Rec.Maximum = 0) then begin
            Rec.Symbol := Rec.Symbol::">";
            Rec.Modify();
        end else
            if (Rec."Data Type" <> Rec."Data Type"::Alphanumeric) and (Rec.Minimum = 0) and (Rec.Maximum <> 0) then begin
                Rec.Symbol := Rec.Symbol::"<";
                Rec.Modify();
            end else begin
                Rec.Symbol := Rec.Symbol::" ";
                Rec.Modify();
            end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnBeforeValidateEvent', 'CustomLotNumber', true, true)]
    local procedure CheckTestingParameter_OnBeforeValidateLotNo(var Rec: Record "Tracking Specification"; var xRec: Record "Tracking Specification")
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        TestingParameterExistMsg: Label 'On changing the lot no. the testing parameters will be deleted.\\Do you want to continue?';
    begin  //AJAY >>
        if xRec.CustomLotNumber <> '' then
            if Rec.CustomLotNumber <> xRec.CustomLotNumber then begin
                LotVariantTestingParameter.SetRange("Source ID", Rec."Source ID");
                LotVariantTestingParameter.SetRange("Source Ref. No.", Rec."Source Ref. No.");
                LotVariantTestingParameter.SetRange("Item No.", Rec."Item No.");
                LotVariantTestingParameter.SetRange("Variant Code", Rec."Variant Code");
                LotVariantTestingParameter.SetRange("Lot No.", xRec.CustomLotNumber);
                LotVariantTestingParameter.SetRange("BOE No.", Rec.CustomBOENumber);
                if not LotVariantTestingParameter.IsEmpty then
                    if not Confirm(TestingParameterExistMsg) then
                        Error('')
                    else
                        Rec."Of Spec" := false;
            end; //AJAY <<      
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnBeforeDeleteRecord', '', true, true)]
    local procedure CheckTestingParameter_OnBeforeDelete(var TrackingSpecification: Record "Tracking Specification")
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        TestingParameterExistMsg: Label 'On deleting the record the testing parameters will be deleted.\\Do you want to continue?';
    begin  //AJAY >>
        if TrackingSpecification.CustomLotNumber <> '' then begin
            LotVariantTestingParameter.SetRange("Source ID", TrackingSpecification."Source ID");
            LotVariantTestingParameter.SetRange("Source Ref. No.", TrackingSpecification."Source Ref. No.");
            LotVariantTestingParameter.SetRange("Item No.", TrackingSpecification."Item No.");
            LotVariantTestingParameter.SetRange("Variant Code", TrackingSpecification."Variant Code");
            LotVariantTestingParameter.SetRange("Lot No.", TrackingSpecification.CustomLotNumber);
            LotVariantTestingParameter.SetRange("BOE No.", TrackingSpecification.CustomBOENumber);
            if not LotVariantTestingParameter.IsEmpty then begin
                LotVariantTestingParameter.DeleteAll(true);
                // TrackingSpecification."Of Spec" := false;
            end;
        end; //AJAY
    end;

    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnBeforeInsertEvent', '', true, true)]
    local procedure OnBeforeInsertEvent_ReservEntry(var Rec: Record "Reservation Entry")
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
    begin  //AJAY >>
        if rec.IsTemporary then
            exit;
        LotVariantTestingParameter.Reset();
        LotVariantTestingParameter.SetRange("Source ID", Rec."Source ID");
        LotVariantTestingParameter.SetRange("Source Ref. No.", Rec."Source Ref. No.");
        LotVariantTestingParameter.SetRange("Item No.", Rec."Item No.");
        LotVariantTestingParameter.SetRange("Variant Code", Rec."Variant Code");
        LotVariantTestingParameter.SetRange("Lot No.", Rec.CustomLotNumber);
        LotVariantTestingParameter.SetRange("BOE No.", Rec.CustomBOENumber);
        LotVariantTestingParameter.SetRange("Of Spec", true);
        Rec."Of Spec" := not LotVariantTestingParameter.IsEmpty;
    end; //AJAY <<

    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnBeforeModifyEvent', '', true, true)]
    local procedure OnBeforeModifyEvent_ReservEntry(var Rec: Record "Reservation Entry")
    var
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
    begin  //AJAY >>
        if rec.IsTemporary then
            exit;
        LotVariantTestingParameter.Reset();
        LotVariantTestingParameter.SetRange("Source ID", Rec."Source ID");
        LotVariantTestingParameter.SetRange("Source Ref. No.", Rec."Source Ref. No.");
        LotVariantTestingParameter.SetRange("Item No.", Rec."Item No.");
        LotVariantTestingParameter.SetRange("Variant Code", Rec."Variant Code");
        LotVariantTestingParameter.SetRange("Lot No.", Rec.CustomLotNumber);
        LotVariantTestingParameter.SetRange("BOE No.", Rec.CustomBOENumber);
        LotVariantTestingParameter.SetRange("Of Spec", true);
        Rec."Of Spec" := not LotVariantTestingParameter.IsEmpty;
    end; //AJAY <<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnBeforePostCorrectionItemJnLine', '', true, true)]
    local procedure OnBeforePostCorrectionItemJnLine(VAR ItemJournalLine: Record "Item Journal Line"; var TempItemLedgEntry: Record "Item Ledger Entry")
    begin
        ItemJournalLine."Of Spec" := TempItemLedgEntry."Of Spec";
    end;

    //08-07-2022-start
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterValidateEvent', 'Lot No.', false, false)]
    local procedure OnAfterValidateLotNumber(var Rec: Record "Tracking Specification"; var xRec: Record "Tracking Specification")
    begin
        if (Rec."Lot No." <> '') AND (Rec."Source Type" = Database::"Item Journal Line") then
            CopyTestingParametersFromPostedLot(Rec);
    end;
    //08-07-2022-end

    //20-07-2022-start
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterValidateEvent', 'New Custom Lot No.', false, false)]
    local procedure OnValidateOfNewLotNumber(var Rec: Record "Tracking Specification"; var xRec: Record "Tracking Specification")
    var
        Item_lRec: Record Item;//T51170-N
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        LotVariantTestingParameter2: Record "Lot Variant Testing Parameter"; //AJAY
    begin //AJAY >>
        if Rec."New Custom Lot No." <> '' then begin
            Clear(LotVariantTestingParameter);
            LotVariantTestingParameter.SetRange("Source ID", Rec."Source ID");
            LotVariantTestingParameter.SetRange("Source Ref. No.", Rec."Source Ref. No.");
            LotVariantTestingParameter.SetRange("Item No.", Rec."Item No.");
            LotVariantTestingParameter.SetRange("Variant Code", Rec."Variant Code");
            LotVariantTestingParameter.SetRange("BOE No.", Rec.CustomBOENumber);
            LotVariantTestingParameter.SetRange("Lot No.", Rec.CustomLotNumber);
            if LotVariantTestingParameter.FindSet() then
                repeat
                    //T51170-NS
                    Item_lRec.get(Rec."Item No.");
                    if Item_lRec."COA Applicable" then begin
                        //T51170-NE
                        LotVariantTestingParameter2.Init();
                        LotVariantTestingParameter2.TransferFields(LotVariantTestingParameter);
                        LotVariantTestingParameter2.SetRange("Source ID", Rec."Source ID");
                        LotVariantTestingParameter2.SetRange("Source Ref. No.", Rec."Source Ref. No.");
                        LotVariantTestingParameter2.SetRange("Item No.", Rec."Item No.");
                        LotVariantTestingParameter2.SetRange("Variant Code", Rec."Variant Code");
                        LotVariantTestingParameter2."Lot No." := Rec."New Custom Lot No.";
                        LotVariantTestingParameter2."BOE No." := Rec."New Custom BOE No.";
                        if LotVariantTestingParameter2.Insert() then;
                    end;//T51170-N
                until LotVariantTestingParameter.Next() = 0;
        end else begin
            //T51170-NS
            Item_lRec.get(Rec."Item No.");
            // if not Item_lRec."COA Applicable" then
            //     exit;
            if Item_lRec."COA Applicable" then begin
                //T51170-NE
                Clear(LotVariantTestingParameter);
                LotVariantTestingParameter.SetRange("Source ID", Rec."Source ID");
                LotVariantTestingParameter.SetRange("Source Ref. No.", Rec."Source Ref. No.");
                LotVariantTestingParameter.SetRange("Item No.", Rec."Item No.");
                LotVariantTestingParameter.SetRange("Variant Code", Rec."Variant Code");
                LotVariantTestingParameter.SetRange("Lot No.", Rec."New Lot No.");
                LotVariantTestingParameter.SetRange("BOE No.", Rec."New Custom BOE No.");
                if LotVariantTestingParameter.FindSet() then
                    LotVariantTestingParameter.DeleteAll();
            end;//T51170-N
        end;
    end; //AJAY <<
         //20-07-2022-end
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterCopyTrackingFromItemLedgEntry', '', false, false)]
    local procedure OnAfterCopyTrackingFromItemLedgEntry(var TrackingSpecification: Record "Tracking Specification"; ItemLedgerEntry: Record "Item Ledger Entry");
    var
        a: Page "Posted Sales Invoice";
    begin
        /* TrackingSpecification."Manufacturing Date 2" := ItemLedgerEntry."Manufacturing Date 2";
        TrackingSpecification."Expiration Date" := ItemLedgerEntry."Expiration Date";
        TrackingSpecification."Expiry Period 2" := ItemLedgerEntry."Expiry Period 2";
        TrackingSpecification."New Expiration Date" := ItemLedgerEntry."Expiration Date"; *///T13935-O
        TrackingSpecification."Analysis Date" := ItemLedgerEntry."Analysis Date";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyTrackingFromItemLedgEntry', '', false, false)]
    local procedure OnAfterCopyTrackingFromItemLedgEntryRS(var ReservationEntry: Record "Reservation Entry"; ItemLedgerEntry: Record "Item Ledger Entry");
    begin
        /*  ReservationEntry."Manufacturing Date 2" := ItemLedgerEntry."Manufacturing Date 2";
         ReservationEntry."Expiration Date" := ItemLedgerEntry."Expiration Date";
         ReservationEntry."Expiry Period 2" := ItemLedgerEntry."Expiry Period 2";
         ReservationEntry."New Expiration Date" := ItemLedgerEntry."Expiration Date"; *///T13935-O
        ReservationEntry."Analysis Date" := ItemLedgerEntry."Analysis Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl. Line-Reserve", 'OnBeforeCallItemTracking', '', false, false)]
    local procedure OnBeforeCallItemTracking(var ItemJournalLine: Record "Item Journal Line"; IsReclass: Boolean; var IsHandled: Boolean);
    var
        TrackingSpecification: Record "Tracking Specification";
        ReservEntry: Record "Reservation Entry";
        ItemTrackingLines: Page "Item Tracking Lines";
        Text006: Label 'You cannot define item tracking on %1 %2';
    begin
        IsHandled := true;
        ItemJournalLine.TestField("Item No.");
        if not ItemJournalLine.ItemPosting then begin
            ReservEntry.InitSortingAndFilters(false);
            ItemJournalLine.SetReservationFilters(ReservEntry);
            ReservEntry.ClearTrackingFilter;
            if ReservEntry.IsEmpty() then
                Error(Text006, ItemJournalLine.FieldCaption("Operation No."), ItemJournalLine."Operation No.");
        end;
        TrackingSpecification.InitFromItemJnlLine(ItemJournalLine);
        if IsReclass then
            ItemTrackingLines.SetRunMode("Item Tracking Run Mode"::Reclass);
        ItemTrackingLines.SetSourceSpec(TrackingSpecification, ItemJournalLine."Posting Date");
        ItemTrackingLines.SetInbound(ItemJournalLine.IsInbound);
        Commit();
        ItemTrackingLines.RunModal();
    end;

    /*  [EventSubscriber(ObjectType::Table, Database::"Post Lot Var Testing Parameter", OnBeforeInsertEvent, '', false, false)]
    local procedure PostLotVarTestingParameter(RunTrigger: Boolean;var Rec: Record "Post Lot Var Testing Parameter");
    begin
        Message('PostLOtok');
    end;
     [EventSubscriber(ObjectType::Table, Database::"Lot Variant Testing Parameter", OnBeforeInsertEvent, '', false, false)]
    local procedure LotVarTestingParameter(RunTrigger: Boolean;var Rec: Record "Lot Variant Testing Parameter");
    begin
        Message('Lotok');
    end; */
}
