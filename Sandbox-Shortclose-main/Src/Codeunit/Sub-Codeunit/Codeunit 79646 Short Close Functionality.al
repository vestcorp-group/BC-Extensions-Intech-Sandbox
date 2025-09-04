codeunit 79646 "Short Close Functionality"
{
    Description = 'T12084';
    SingleInstance = true;
    Permissions = tabledata "Warehouse Entry" = rimd,
    tabledata "Warehouse Shipment Line" = rm,
    tabledata "Whse. Item Tracking Line" = rmd,
    tabledata "Registered Whse. Activity Line" = rmd,
    tabledata "Posted Whse. Shipment Line" = rim,
    tabledata "Item Ledger Entry" = rim;

    var
        PurchaseLine_gRec: Record "Purchase Line";
        Text33029337_gLbl: Label 'The Process has been interrupted to respect the User Decision.';
        Text33029339_gLbl: Label 'Due to Short Close';
        SHortClsRsnLabel_gLbl: Label 'Short Close Reason cannot be blank. Please Select Short Close Reason.';
        WarehouseShipNo_gCod: Code[20];
        WarehouseReceptNo_gCod: Code[20];
        WarehouseActivityNo_gCod: Code[20];

        RegisteredWhseActivityLine: Record "Registered Whse. Activity Line";

    procedure InsertSalesForeCloseLine_gFnc(var SalesLine_vRec: Record "Sales Line"; Var Salesheader: Record "Sales Header"; ConfMsgReq: Boolean)
    var
        ShortCloseSetup: Record "Short Close Setup";
        SalesHeader_lRec: Record "Sales Header";
        ShortCloseReason_lRpt: Report "Short Close Reason RP";
        IsReportRun_lBln: Boolean;
        SelectedShrtClsReason_lCod: Code[20];
        SLQty_lDec: Decimal;
        SLOutSndQty_lDec: Decimal;
        SLFinalQty_lDec: Decimal;
        BinCode: Code[20];
        UnitPrice: Decimal;
        //MBOSOImp_lRec: Record "MBO PO Import";
        SalesLnDelete_lRec: Record "Sales Line";
        WarehouseShipmentLine_lRec: Record "Warehouse Shipment Line";
        WarhouActivityLine_lRec: Record "Warehouse Activity Line";
        SalesLine_lRec: Record "Sales Line";
        Text33029735_Lbl: Label 'Sales Line with Type = ''%1'' cannot be Short Closed.', Comment = '%1=Type';
        Text33029736_Lbl: Label 'Do you want to Shortclose Sales Line for Item No. = ''%1'' Line No. = ''%2'' ?', Comment = '%1=Item No.';
        Text33029737_Lbl: Label 'There is no "Outstanding Quantity" for Item No. = ''%1''.', Comment = '%1=Item No.';
        ReservationEntry_lRec: Record "Reservation Entry";
        ReservationEntry2_lRec: Record "Reservation Entry";
        PurchaseLine: Record "Purchase Line";
        Text007lLbl: Label 'Qty. Picked = %1 is greater than Qty. Shipped = %2. If you delete the Warehouse Shipment Line, the items will remain in the shipping area until you put them away.\Related Item Tracking information defined during pick will be deleted.\Do you still want to delete the Warehouse Shipment Line?';
        SkipShortClose: Boolean;
        ItemChargeAssignmentSales_lRec: Record "Item Charge Assignment (Sales)";
    begin
        ShortCloseSetup.GET();
        ShortCloseSetup.TESTFIELD("Allow Sales Short Close", TRUE);
        //  IF NOT (SalesLine_vRec.Type = SalesLine_vRec.Type::Item) THEN //Hypercare 27022025
        if (SalesLine_vRec.Type = SalesLine_vRec.Type::" ") THEN //Hypercare 27022025
            ERROR(Text33029735_Lbl, SalesLine_vRec.Type);

        // IF CONFIRM(STRSUBSTNO(Text33029736_Lbl, SalesLine_vRec."No.", SalesLine_vRec."Line No."), true) THEN begin  //T50307-O

        IF SalesLine_vRec."Outstanding Quantity" = 0 THEN
            ERROR(Text33029737_Lbl, SalesLine_vRec."No.");

        ShortClose := true;
        //SalesHeader_lRec.TESTFIELD(Status, SalesHeader_lRec.Status::Open);    //T50307-O

        SalesLine_vRec.TESTFIELD(SalesLine_vRec."Short Close Boolean", FALSE);

        if ConfMsgReq then begin        //T50307-N
            Clear(ShortCloseReason_lRpt);
            ShortCloseReason_lRpt.RunModal();
            IsReportRun_lBln := ShortCloseReason_lRpt.IsReportRun();

            SelectedShrtClsReason_lCod := ShortCloseReason_lRpt.GetReasonCode_gFnc();
            if SelectedShrtClsReason_lCod = '' then
                Error(SHortClsRsnLabel_gLbl);

            if not IsReportRun_lBln then
                exit;
        end;   //T50307-N

        SkipShortClose := false;
        WarehouseShipNo_gCod := '';
        WarehouseShipmentLine_lRec.Reset();
        WarehouseShipmentLine_lRec.SetRange("Source Document", WarehouseShipmentLine_lRec."Source Document"::"Sales Order");
        WarehouseShipmentLine_lRec.SetRange("Source Type", 37);
        WarehouseShipmentLine_lRec.SetRange("Source Subtype", 1);
        WarehouseShipmentLine_lRec.SetRange("Source No.", SalesLine_vRec."Document No.");
        WarehouseShipmentLine_lRec.SetRange("Source Line No.", SalesLine_vRec."Line No.");
        IF WarehouseShipmentLine_lRec.FindFirst() then
            repeat
                if not SkipShortClose then
                    if WarehouseShipmentLine_lRec."Qty. Shipped" < WarehouseShipmentLine_lRec."Qty. Picked" then
                        if not Confirm(Text007lLbl, true, WarehouseShipmentLine_lRec."Qty. Picked", WarehouseShipmentLine_lRec."Qty. Shipped") then
                            SkipShortClose := true;
            until WarehouseShipmentLine_lRec.Next() = 0;

        if not SkipShortClose then begin
            BinCode := SalesLine_vRec."Bin Code";
            UnitPrice := SalesLine_vRec."Unit Price";
            SLQty_lDec := SalesLine_vRec.Quantity;
            SLOutSndQty_lDec := SalesLine_vRec."Outstanding Quantity";
            SLFinalQty_lDec := ABS(SalesLine_vRec.Quantity - SLOutSndQty_lDec);
            SalesLine_vRec.Validate("Short Closed Qty", SLOutSndQty_lDec);

            //WarehouseShipment
            WarehouseShipNo_gCod := '';
            WarehouseShipmentLine_lRec.Reset();
            WarehouseShipmentLine_lRec.SetRange("Source Document", WarehouseShipmentLine_lRec."Source Document"::"Sales Order");
            WarehouseShipmentLine_lRec.SetRange("Source Type", 37);
            WarehouseShipmentLine_lRec.SetRange("Source Subtype", 1);
            WarehouseShipmentLine_lRec.SetRange("Source No.", SalesLine_vRec."Document No.");
            WarehouseShipmentLine_lRec.SetRange("Source Line No.", SalesLine_vRec."Line No.");
            IF WarehouseShipmentLine_lRec.FindFirst() then
                repeat
                    WarehouseShipNo_gCod := WarehouseShipmentLine_lRec."No.";
                    //Delete Header If Not any Line Exist
                    WarehouseShipmentLine_lRec.Delete();
                    DeleteWarhShip(WarehouseShipNo_gCod);
                until WarehouseShipmentLine_lRec.Next() = 0;

            //Inventory Pick
            WarehouseActivityNo_gCod := '';
            WarhouActivityLine_lRec.Reset();
            WarhouActivityLine_lRec.Setfilter("Activity Type", '%1|%2', WarhouActivityLine_lRec."Activity Type"::"Invt. Pick", WarhouActivityLine_lRec."Activity Type"::Pick);
            WarhouActivityLine_lRec.SetRange("Source Document", WarhouActivityLine_lRec."Source Document"::"Sales Order");
            WarhouActivityLine_lRec.SetRange("Source Type", 37);
            WarhouActivityLine_lRec.SetRange("Source Subtype", 1);
            WarhouActivityLine_lRec.SetRange("Source No.", SalesLine_vRec."Document No.");
            WarhouActivityLine_lRec.SetRange("Source Line No.", SalesLine_vRec."Line No.");
            IF WarhouActivityLine_lRec.FindSet() then
                repeat
                    ActivityType := WarhouActivityLine_lRec."Activity Type";
                    WarehouseActivityNo_gCod := WarhouActivityLine_lRec."No.";
                    //Delete Header If Not any Line Exist
                    WarhouActivityLine_lRec.Delete();
                    DeleteWarhActivity(ActivityType, WarehouseActivityNo_gCod);
                until WarhouActivityLine_lRec.Next() = 0;


            // RegisteredWhseActivityLine.Reset();
            // RegisteredWhseActivityLine.SetFilter("Activity Type", '%1|%2', RegisteredWhseActivityLine."Activity Type"::"Invt. Pick", RegisteredWhseActivityLine."Activity Type"::Pick);
            // RegisteredWhseActivityLine.SetRange("Source Document", RegisteredWhseActivityLine."Source Document"::"Sales Order");
            // RegisteredWhseActivityLine.SetRange("Source Type", 37);
            // RegisteredWhseActivityLine.SetRange("Source Subtype", 1);
            // RegisteredWhseActivityLine.SetRange("Source No.", SalesLine_vRec."Document No.");
            // RegisteredWhseActivityLine.SetRange("Source Line No.", SalesLine_vRec."Line No.");
            // IF RegisteredWhseActivityLine.FindSet() then
            //     Error('Registered Pick Already exist for Document No. %1 Line No. %2', SalesLine_vRec."Document No.", SalesLine_vRec."Line No.");



            ReservationEntry_lRec.Reset();
            ReservationEntry_lRec.SetRange("Source Type", 37);
            ReservationEntry_lRec.SetRange("Source ID", SalesLine_vRec."Document No.");
            ReservationEntry_lRec.SetRange("Source Ref. No.", SalesLine_vRec."Line No.");
            if ReservationEntry_lRec.FindFirst() then begin
                ReservationEntry2_lRec.Reset();
                ReservationEntry2_lRec.SetRange("Entry No.", ReservationEntry_lRec."Entry No.");
                ReservationEntry2_lRec.SetRange("Reservation Status", ReservationEntry2_lRec."Reservation Status"::Reservation);
                ReservationEntry2_lRec.SetRange("Item No.", ReservationEntry_lRec."Item No.");
                if ReservationEntry_lRec.Positive then
                    ReservationEntry2_lRec.SetRange(Positive, false)
                else
                    ReservationEntry2_lRec.SetRange(Positive, true);
                if ReservationEntry2_lRec.FindFirst() then
                    ReservationEntry2_lRec.DeleteAll(true);
                ReservationEntry_lRec.Delete(true);
            end;


            SalesLine_lRec.validate("Purchase Order No.", '');
            SalesLine_lRec.Validate("Purch. Order Line No.", 0);

            PurchaseLine.Reset();
            PurchaseLine.SetRange("Sales Order No.", SalesLine_vRec."Document No.");
            PurchaseLine.SetRange("Sales Order Line No.", SalesLine_vRec."Line No.");
            if PurchaseLine.FindSet() then
                repeat
                    PurchaseLine.Validate("Purchasing Code", '');
                    PurchaseLine.Validate("Sales Order No.", '');
                    PurchaseLine.Validate("Sales Order Line No.", 0);
                    PurchaseLine.Validate("Drop Shipment", false);
                    PurchaseLine.Validate("Special Order", false);
                    PurchaseLine.Validate("Special Order Sales No.", '');
                    PurchaseLine.Validate("Special Order Sales Line No.", 0);
                    PurchaseLine.Modify();

                    ReservationEntry_lRec.Reset();
                    ReservationEntry_lRec.SetRange("Source Type", 39);
                    ReservationEntry_lRec.SetRange("Source ID", PurchaseLine."Document No.");
                    ReservationEntry_lRec.SetRange("Source Ref. No.", PurchaseLine."Line No.");
                    if ReservationEntry_lRec.FindFirst() then
                        ReservationEntry_lRec.Delete(true);

                until PurchaseLine.Next() = 0;


            PurchaseLine.Reset();
            PurchaseLine.SetRange("Special Order Sales No.", SalesLine_vRec."Document No.");
            PurchaseLine.SetRange("Special Order Sales Line No.", SalesLine_vRec."Line No.");
            if PurchaseLine.FindSet() then
                repeat
                    PurchaseLine.Validate("Purchasing Code", '');
                    PurchaseLine.Validate("Sales Order No.", '');
                    PurchaseLine.Validate("Sales Order Line No.", 0);
                    PurchaseLine.Validate("Drop Shipment", false);
                    PurchaseLine.Validate("Special Order", false);
                    PurchaseLine.Validate("Special Order Sales No.", '');
                    PurchaseLine.Validate("Special Order Sales Line No.", 0);
                    PurchaseLine.Modify();

                    ReservationEntry_lRec.Reset();
                    ReservationEntry_lRec.SetRange("Source Type", 39);
                    ReservationEntry_lRec.SetRange("Source ID", PurchaseLine."Document No.");
                    ReservationEntry_lRec.SetRange("Source Ref. No.", PurchaseLine."Line No.");
                    if ReservationEntry_lRec.FindFirst() then
                        ReservationEntry_lRec.Delete(true);
                until PurchaseLine.Next() = 0;

            //Hypercare 27022025-NS
            // if SalesLine_vRec.Type = SalesLine_vRec.Type::"Charge (Item)" then begin
            //     ItemChargeAssignmentSales_lRec.Reset();
            //     ItemChargeAssignmentSales_lRec.SetRange("Document Type", SalesLine_vRec."Document Type");
            //     ItemChargeAssignmentSales_lRec.SetRange("Document No.", SalesLine_vRec."Document No.");
            //     ItemChargeAssignmentSales_lRec.SetRange("Document Line No.", SalesLine_vRec."Line No.");
            //     ItemChargeAssignmentSales_lRec.SetRange("Item Charge No.", SalesLine_vRec."No.");
            //     ItemChargeAssignmentSales_lRec.SetFilter("Qty. Assigned", '<> %1', 0);
            //     if ItemChargeAssignmentSales_lRec.FindSet() then
            //         ItemChargeAssignmentSales_lRec.DeleteAll();
            // end;
            //Hypercare 27022025-NE

            SalesLine_vRec.Validate("Purchase Order No.", '');
            SalesLine_vRec.Validate("Purch. Order Line No.", 0);
            SalesLine_vRec.SuspendStatusCheck(true);
            SalesLine_vRec.Validate(Quantity, SLFinalQty_lDec);
            SalesLine_vRec.Validate("Completely Shipped", True);
            // SalesLine_vRec.Validate("Bin Code", BinCode);
            // SalesLine_vRec.Validate("Unit Price", UnitPrice);
            // if ConfMsgReq then  //T50307-N
            //     SalesLine_vRec."Short Close Reason" := SelectedShrtClsReason_lCod;
            SalesLine_vRec."Short Close Boolean" := true;
            //SalesLine_vRec.Validate("Drop Shipment", false);
            SalesLine_vRec."Drop Shipment" := false;
            SalesLine_vRec.Validate("Special Order", false);
            SalesLine_vRec.Validate("Special Order Purchase No.", '');
            SalesLine_vRec.Validate("Special Order Purch. Line No.", 0);
            if SalesLine_vRec.Type = SalesLine_vRec.Type::Item then //Hypercare 27022025
                SalesLine_vRec.Validate("Purchasing Code", '');
            SalesLine_vRec."Short Close Approval Required" := false;  //T50307-N
            SalesLine_vRec.MODIFY();



            // if ConfMsgReq then  //T50307-N
            //     SalesHeader_lRec.validate("Short Close Reason", SelectedShrtClsReason_lCod);

            Salesheader."Short Close Boolean" := true;
            Salesheader."Short Close Approval Required" := false;  //T50307-N
            Salesheader.Modify(true);


            // //Header Short Close
            // SalesLine_lRec.RESET();
            // SalesLine_lRec.SETRANGE("Document Type", SalesHeader_lRec."Document Type");
            // SalesLine_lRec.SETRANGE("Document No.", SalesHeader_lRec."No.");
            // SalesLine_lRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
            // IF Not SalesLine_lRec.FindFirst() THEN begin


            //     //Delete MBO PO
            //     // SalesLnDelete_lRec.Reset();
            //     // SalesLnDelete_lRec.SetRange("Document Type", SalesHeader_lRec."Document Type");
            //     // SalesLnDelete_lRec.SetRange("Document No.", SalesHeader_lRec."No.");
            //     // SalesLnDelete_lRec.SetFilter("Import PO Line No.", '<>%1', 0);
            //     // if SalesLnDelete_lRec.FindSet() then begin
            //     //     repeat
            //     //         MBOSOImp_lRec.Reset();
            //     //         MBOSOImp_lRec.SetRange("SO No.", SalesLnDelete_lRec."Document No.");
            //     //         MBOSOImp_lRec.SetRange("Entry No.", SalesLnDelete_lRec."Import PO Line No.");
            //     //         if MBOSOImp_lRec.FindFirst() then
            //     //             MBOSOImp_lRec.Delete();
            //     //     until SalesLnDelete_lRec.Next() = 0;
            //     // end;
            // end;
        end;
        // end;   //T50307-O
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeTestStatusOpen', '', false, false)]
    local procedure "Sales Line_OnBeforeTestStatusOpen"(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var StatusCheckSuspended: Boolean)
    begin
        if SalesLine."Short Close Approval Required" then
            IsHandled := true;
    end;

    procedure ForeCLoseSalesDocument(SalesHeader_iRec: Record "Sales Header")
    var
        SalesHeader_lRec: Record "Sales Header";
        SalesLine_lRec: Record "Sales Line";
        ShortCloseFun_lCdu: Codeunit "Short Close Functionality";
        ShortCloseSetup: Record "Short Close Setup";
        ShortCloseReason_lRpt: Report "Short Close Reason RP";
        IsReportRun_lBln: Boolean;
        SelectedShrtClsReason_lCod: Code[20];
        SLQty_lDec: Decimal;
        SLOutSndQty_lDec: Decimal;
        SLFinalQty_lDec: Decimal;
        BinCode: Code[20];
        UnitPrice: Decimal;
        ///MBOSOImp_lRec: Record "MBO PO Import";
        SalesLnDelete_lRec: Record "Sales Line";
        WarehouseShipmentLine_lRec: Record "Warehouse Shipment Line";
        WarhouActivityLine_lRec: Record "Warehouse Activity Line";
        Text33029350_Lbl: Label 'Do you want to ShortClose Sales Order %1?', Comment = '%1=SO';
        Text33029351_Lbl: Label 'Sales Order %1 Short Closed successfully.\Document has been moved to Short Closed Document List.', Comment = '%1=SO';
        Text33029737_Lbl: Label 'There is no "Outstanding Quantity" for Item No. = ''%1''.', Comment = '%1=Item No.';
        IsShortClose_lBln: Boolean;
        Text33029353_Lbl: Label 'There is not any outstanding Qty is available.Sales Order %1 is not Short Closed.';
        Text007lLbl: Label 'Qty. Picked = %1 is greater than Qty. Shipped = %2. If you delete the Warehouse Shipment Line, the items will remain in the shipping area until you put them away.\Related Item Tracking information defined during pick will be deleted.\Do you still want to delete the Warehouse Shipment Line?';
        ReservationEntry_lRec: Record "Reservation Entry";
        ReservationEntry2_lRec: Record "Reservation Entry";
        PurchaseLine: Record "Purchase Line";
        SkipShortClose: Boolean;
    begin
        ShortCloseSetup.GET();
        ShortCloseSetup.TESTFIELD("Allow Sales Short Close", TRUE);

        SalesHeader_lRec.GET(SalesHeader_iRec."Document Type", SalesHeader_iRec."No.");
        SalesHeader_lRec.TESTFIELD("Short Close Boolean", FALSE);
        //SalesHeader_lRec.TESTFIELD(Status, SalesHeader_lRec.Status::Open);

        IF CONFIRM(STRSUBSTNO(Text33029350_Lbl, SalesHeader_lRec."No."), true) THEN begin

            ShortClose := true;

            Clear(ShortCloseReason_lRpt);
            ShortCloseReason_lRpt.RunModal();
            IsReportRun_lBln := ShortCloseReason_lRpt.IsReportRun();

            SelectedShrtClsReason_lCod := ShortCloseReason_lRpt.GetReasonCode_gFnc();
            if SelectedShrtClsReason_lCod = '' then
                Error(SHortClsRsnLabel_gLbl);

            if not IsReportRun_lBln then
                exit;

            SalesLine_lRec.RESET();
            SalesLine_lRec.SETRANGE("Document Type", SalesHeader_lRec."Document Type");
            SalesLine_lRec.SETRANGE("Document No.", SalesHeader_lRec."No.");
            // SalesLine_lRec.SETRANGE(Type, SalesLine_lRec.Type::Item);//Hypercare 27022025
            SalesLine_lRec.SETFILTER(Type, '<>%1', SalesLine_lRec.Type::" "); //Hypercare 27022025
            SalesLine_lRec.SETRANGE("Short Close Boolean", FALSE);
            SalesLine_lRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
            IF not SalesLine_lRec.FINDSET() THEN
                Error(Text33029353_Lbl, SalesHeader_lRec."No.");

            SkipShortClose := false;
            SalesLine_lRec.RESET();
            SalesLine_lRec.SETRANGE("Document Type", SalesHeader_lRec."Document Type");
            SalesLine_lRec.SETRANGE("Document No.", SalesHeader_lRec."No.");
            // SalesLine_lRec.SETRANGE(Type, SalesLine_lRec.Type::Item);//Hypercare 27022025
            SalesLine_lRec.SETFILTER(Type, '<>%1', SalesLine_lRec.Type::" "); //Hypercare 27022025
            SalesLine_lRec.SETRANGE("Short Close Boolean", FALSE);
            SalesLine_lRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
            IF SalesLine_lRec.FINDSET(TRUE, TRUE) THEN
                REPEAT
                    WarehouseShipNo_gCod := '';
                    WarehouseShipmentLine_lRec.Reset();
                    WarehouseShipmentLine_lRec.SetRange("Source Document", WarehouseShipmentLine_lRec."Source Document"::"Sales Order");
                    WarehouseShipmentLine_lRec.SetRange("Source Type", 37);
                    WarehouseShipmentLine_lRec.SetRange("Source Subtype", 1);
                    WarehouseShipmentLine_lRec.SetRange("Source No.", SalesLine_lRec."Document No.");
                    WarehouseShipmentLine_lRec.SetRange("Source Line No.", SalesLine_lRec."Line No.");
                    if WarehouseShipmentLine_lRec.FindSet() then
                        repeat
                            if not SkipShortClose then
                                if WarehouseShipmentLine_lRec."Qty. Shipped" < WarehouseShipmentLine_lRec."Qty. Picked" then
                                    if not Confirm(Text007lLbl, true, WarehouseShipmentLine_lRec."Qty. Picked", WarehouseShipmentLine_lRec."Qty. Shipped") then
                                        SkipShortClose := true;
                        until WarehouseShipmentLine_lRec.Next() = 0;

                    if not SkipShortClose then begin

                        BinCode := '';
                        UnitPrice := 0;
                        SLQty_lDec := 0;
                        SLOutSndQty_lDec := 0;
                        SLFinalQty_lDec := 0;

                        BinCode := SalesLine_lRec."Bin Code";
                        UnitPrice := SalesLine_lRec."Unit Price";
                        SLQty_lDec := SalesLine_lRec.Quantity;
                        SLOutSndQty_lDec := SalesLine_lRec."Outstanding Quantity";
                        SLFinalQty_lDec := ABS(SalesLine_lRec.Quantity - SLOutSndQty_lDec);
                        SalesLine_lRec.Validate("Short Closed Qty", SLOutSndQty_lDec);

                        ReservationEntry_lRec.Reset();
                        ReservationEntry_lRec.SetRange("Source Type", 37);
                        ReservationEntry_lRec.SetRange("Source ID", SalesLine_lRec."Document No.");
                        ReservationEntry_lRec.SetRange("Source Ref. No.", SalesLine_lRec."Line No.");
                        if ReservationEntry_lRec.FindFirst() then begin
                            ReservationEntry2_lRec.Reset();
                            ReservationEntry2_lRec.SetRange("Entry No.", ReservationEntry_lRec."Entry No.");
                            ReservationEntry2_lRec.SetRange("Reservation Status", ReservationEntry2_lRec."Reservation Status"::Reservation);
                            ReservationEntry2_lRec.SetRange("Item No.", ReservationEntry_lRec."Item No.");
                            if ReservationEntry_lRec.Positive then
                                ReservationEntry2_lRec.SetRange(Positive, false)
                            else
                                ReservationEntry2_lRec.SetRange(Positive, true);
                            if ReservationEntry2_lRec.FindFirst() then
                                ReservationEntry2_lRec.DeleteAll(true);
                            ReservationEntry_lRec.Delete(true);
                        end;

                        //WarehouseShipment
                        WarehouseShipNo_gCod := '';
                        WarehouseShipmentLine_lRec.Reset();
                        WarehouseShipmentLine_lRec.SetRange("Source Document", WarehouseShipmentLine_lRec."Source Document"::"Sales Order");
                        WarehouseShipmentLine_lRec.SetRange("Source Type", 37);
                        WarehouseShipmentLine_lRec.SetRange("Source Subtype", 1);
                        WarehouseShipmentLine_lRec.SetRange("Source No.", SalesLine_lRec."Document No.");
                        WarehouseShipmentLine_lRec.SetRange("Source Line No.", SalesLine_lRec."Line No.");
                        IF WarehouseShipmentLine_lRec.FindFirst() then
                            repeat
                                WarehouseShipNo_gCod := WarehouseShipmentLine_lRec."No.";
                                //Delete Header If Not any Line Exist
                                WarehouseShipmentLine_lRec.Delete();
                                DeleteWarhShip(WarehouseShipNo_gCod);
                            until WarehouseShipmentLine_lRec.Next() = 0;

                        //Inventory Pick
                        WarehouseActivityNo_gCod := '';
                        WarhouActivityLine_lRec.Reset();
                        WarhouActivityLine_lRec.Setfilter("Activity Type", '%1|%2', WarhouActivityLine_lRec."Activity Type"::"Invt. Pick", WarhouActivityLine_lRec."Activity Type"::Pick);
                        WarhouActivityLine_lRec.SetRange("Source Document", WarhouActivityLine_lRec."Source Document"::"Sales Order");
                        WarhouActivityLine_lRec.SetRange("Source Type", 37);
                        WarhouActivityLine_lRec.SetRange("Source Subtype", 1);
                        WarhouActivityLine_lRec.SetRange("Source No.", SalesLine_lRec."Document No.");
                        WarhouActivityLine_lRec.SetRange("Source Line No.", SalesLine_lRec."Line No.");
                        IF WarhouActivityLine_lRec.Findset() then
                            repeat
                                ActivityType := WarhouActivityLine_lRec."Activity Type";
                                WarehouseActivityNo_gCod := WarhouActivityLine_lRec."No.";
                                //Delete Header If Not any Line Exist
                                WarhouActivityLine_lRec.Delete();
                                DeleteWarhActivity(ActivityType, WarehouseActivityNo_gCod);
                            until WarhouActivityLine_lRec.Next() = 0;


                        // RegisteredWhseActivityLine.Reset();
                        // RegisteredWhseActivityLine.SetFilter("Activity Type", '%1|%2', RegisteredWhseActivityLine."Activity Type"::"Invt. Pick", RegisteredWhseActivityLine."Activity Type"::Pick);
                        // RegisteredWhseActivityLine.SetRange("Source Document", RegisteredWhseActivityLine."Source Document"::"Sales Order");
                        // RegisteredWhseActivityLine.SetRange("Source Type", 37);
                        // RegisteredWhseActivityLine.SetRange("Source Subtype", 1);
                        // RegisteredWhseActivityLine.SetRange("Source No.", SalesLine_lRec."Document No.");
                        // RegisteredWhseActivityLine.SetRange("Source Line No.", SalesLine_lRec."Line No.");
                        // IF RegisteredWhseActivityLine.FindSet() then
                        //     Error('Registered Pick already exist for Document No. %1 Line No. %2', SalesLine_lRec."Document No.", SalesLine_lRec."Line No.");


                        SalesLine_lRec.Validate("Purchasing Code", '');
                        SalesLine_lRec.Validate("Special Order", false);
                        SalesLine_lRec.Validate("Special Order Purchase No.", '');
                        SalesLine_lRec.Validate("Special Order Purch. Line No.", 0);

                        SalesLine_lRec.validate("Purchase Order No.", '');
                        SalesLine_lRec.Validate("Purch. Order Line No.", 0);
                        SalesLine_lRec.Validate(Quantity, SLFinalQty_lDec);
                        SalesLine_lRec.Validate("Completely Shipped", True);
                        // SalesLine_lRec.Validate("Bin Code", BinCode);
                        // SalesLine_lRec.Validate("Unit Price", UnitPrice);
                        SalesLine_lRec.validate("Short Close Reason", SelectedShrtClsReason_lCod);
                        SalesLine_lRec."Short Close Boolean" := true;
                        SalesLine_lRec."Short Close Approval Required" := false;  //T50307-N
                        SalesLine_lRec."Drop Shipment" := false;


                        IsShortClose_lBln := true;
                        SalesLine_lRec.Modify(true);

                        PurchaseLine.Reset();
                        PurchaseLine.SetRange("Sales Order No.", SalesLine_lRec."Document No.");
                        PurchaseLine.SetRange("Sales Order Line No.", SalesLine_lRec."Line No.");
                        if PurchaseLine.FindSet() then
                            repeat
                                PurchaseLine.Validate("Purchasing Code", '');
                                PurchaseLine.Validate("Drop Shipment", false);
                                PurchaseLine.Validate("Sales Order No.", '');
                                PurchaseLine.Validate("Sales Order Line No.", 0);
                                PurchaseLine.Validate("Purchasing Code", '');
                                PurchaseLine.Validate("Special Order", false);
                                PurchaseLine.Validate("Special Order Sales No.", '');
                                PurchaseLine.Validate("Special Order Sales Line No.", 0);
                                PurchaseLine.Modify();

                                ReservationEntry_lRec.Reset();
                                ReservationEntry_lRec.SetRange("Source Type", 39);
                                ReservationEntry_lRec.SetRange("Source ID", PurchaseLine."Document No.");
                                ReservationEntry_lRec.SetRange("Source Ref. No.", PurchaseLine."Line No.");
                                if ReservationEntry_lRec.FindFirst() then
                                    ReservationEntry_lRec.Delete(true);
                            until PurchaseLine.Next() = 0;

                        PurchaseLine.Reset();
                        PurchaseLine.SetRange("Special Order Sales No.", SalesLine_lRec."Document No.");
                        PurchaseLine.SetRange("Special Order Sales Line No.", SalesLine_lRec."Line No.");
                        if PurchaseLine.FindSet() then
                            repeat
                                PurchaseLine.Validate("Purchasing Code", '');
                                PurchaseLine.Validate("Drop Shipment", false);
                                PurchaseLine.Validate("Sales Order No.", '');
                                PurchaseLine.Validate("Sales Order Line No.", 0);
                                PurchaseLine.Validate("Purchasing Code", '');
                                PurchaseLine.Validate("Special Order", false);
                                PurchaseLine.Validate("Special Order Sales No.", '');
                                PurchaseLine.Validate("Special Order Sales Line No.", 0);
                                PurchaseLine.Modify();

                                ReservationEntry_lRec.Reset();
                                ReservationEntry_lRec.SetRange("Source Type", 39);
                                ReservationEntry_lRec.SetRange("Source ID", PurchaseLine."Document No.");
                                ReservationEntry_lRec.SetRange("Source Ref. No.", PurchaseLine."Line No.");
                                if ReservationEntry_lRec.FindFirst() then
                                    ReservationEntry_lRec.Delete(true);
                            until PurchaseLine.Next() = 0;

                    end;
                UNTIL SalesLine_lRec.NEXT() = 0;

            Commit();

            if not SkipShortClose then
                if IsShortClose_lBln then begin
                    SalesHeader_lRec.validate("Short Close Reason", SelectedShrtClsReason_lCod);
                    SalesHeader_lRec."Short Close Boolean" := true;
                    SalesHeader_iRec."Short Close Approval Required" := false;  //T50307-N


                    // //Delete MBO PO
                    // SalesLnDelete_lRec.Reset();
                    // SalesLnDelete_lRec.SetRange("Document Type", SalesHeader_lRec."Document Type");
                    // SalesLnDelete_lRec.SetRange("Document No.", SalesHeader_lRec."No.");
                    // SalesLnDelete_lRec.SetFilter("Import PO Line No.", '<>%1', 0);
                    // if SalesLnDelete_lRec.FindSet() then begin
                    //     repeat
                    //         MBOSOImp_lRec.Reset();
                    //         MBOSOImp_lRec.SetRange("SO No.", SalesLnDelete_lRec."Document No.");
                    //         MBOSOImp_lRec.SetRange("Entry No.", SalesLnDelete_lRec."Import PO Line No.");
                    //         if MBOSOImp_lRec.FindFirst() then
                    //             MBOSOImp_lRec.Delete();
                    //     until SalesLnDelete_lRec.Next() = 0;
                    // end;

                    SalesHeader_lRec.Modify(true);


                    if IsShortClose_lBln then
                        MESSAGE(Text33029351_Lbl, SalesHeader_lRec."No.")

                end;
        end;
    end;

    procedure InsertPurchaeForeCloseLine_gFnc(var
                                                  PurchaseLine_vRec: Record "Purchase Line")
    var
        ShortCloseSetup: Record "Short Close Setup";
        PurchaseHeader_lRec: Record "Purchase Header";
        ShortCloseReason_lRpt: Report "Short Close Reason RP";
        IsReportRun_lBln: Boolean;
        SelectedShrtClsReason_lCod: Code[20];
        PLQty_lDec: Decimal;
        PLOutSndQty_lDec: Decimal;
        PLFinalQty_lDec: Decimal;
        BinCode: Code[20];
        UnitPrice: Decimal;
        WarehouseReceiptLine_lRec: Record "Warehouse Receipt Line";
        WarhouActivityLine_lRec: Record "Warehouse Activity Line";
        PurchaseLine_lRec: Record "Purchase Line";
        Text33029735_Lbl: Label 'Purchase Line with Type = ''%1'' cannot be Short Closed.', Comment = '%1=Type';
        Text33029736_Lbl: Label 'Do you want to Shortclose Purchase Line for Item No. = ''%1'' Line No. = ''%2'' ?', Comment = '%1=Item No.';
        Text33029737_Lbl: Label 'There is no "Outstanding Quantity" for Item No. = ''%1''.', Comment = '%1=Item No.';
        ReservationEntry_lRec: Record "Reservation Entry";
        ReservationEntry2_lRec: Record "Reservation Entry";
        SalesLine: Record "Sales Line";
    begin
        ShortCloseSetup.GET();
        ShortCloseSetup.TESTFIELD("Allow Purchase Short Close", TRUE);
        // IF NOT (PurchaseLine_vRec.Type = PurchaseLine_vRec.Type::Item) THEN //Hypercare 27022025
        IF (PurchaseLine_vRec.Type = PurchaseLine_vRec.Type::" ") THEN //Hypercare 27022025
            ERROR(Text33029735_Lbl, PurchaseLine_vRec.Type);
        if not PurchaseHeader_lRec."ShortClose Approval" then begin//T50306
            IF not CONFIRM(STRSUBSTNO(Text33029736_Lbl, PurchaseLine_vRec."No.", PurchaseLine_vRec."Line No."), true) THEN
                exit;
        end;
        IF PurchaseLine_vRec."Outstanding Quantity" = 0 THEN
            ERROR(Text33029737_Lbl, PurchaseLine_vRec."No.");

        PurchaseHeader_lRec.GET(PurchaseLine_vRec."Document Type", PurchaseLine_vRec."Document No.");
        if not PurchaseHeader_lRec."ShortClose Approval" then//T50306
            PurchaseHeader_lRec.TESTFIELD(Status, PurchaseHeader_lRec.Status::Open);

        PurchaseLine_vRec.TESTFIELD(PurchaseLine_vRec."Short Close Boolean", FALSE);
        if not PurchaseHeader_lRec."ShortClose Approval" then begin//T50306

            Clear(ShortCloseReason_lRpt);
            ShortCloseReason_lRpt.RunModal();
            IsReportRun_lBln := ShortCloseReason_lRpt.IsReportRun();

            SelectedShrtClsReason_lCod := ShortCloseReason_lRpt.GetReasonCode_gFnc();
            if SelectedShrtClsReason_lCod = '' then
                Error(SHortClsRsnLabel_gLbl);

            if not IsReportRun_lBln then
                exit;
        end;// T50306
        BinCode := PurchaseLine_vRec."Bin Code";
        UnitPrice := PurchaseLine_vRec."Unit Cost";
        PLQty_lDec := PurchaseLine_vRec.Quantity;
        PLOutSndQty_lDec := PurchaseLine_vRec."Outstanding Quantity";
        PLFinalQty_lDec := ABS(PurchaseLine_vRec.Quantity - PLOutSndQty_lDec);
        PurchaseLine_vRec.Validate("Short Closed Qty", PLOutSndQty_lDec);

        //WarehouseReceipt
        WarehouseReceptNo_gCod := '';
        WarehouseReceiptLine_lRec.Reset();
        WarehouseReceiptLine_lRec.SetRange("Source Document", WarehouseReceiptLine_lRec."Source Document"::"Purchase Order");
        WarehouseReceiptLine_lRec.SetRange("Source Type", 39);
        WarehouseReceiptLine_lRec.SetRange("Source Subtype", 1);
        WarehouseReceiptLine_lRec.SetRange("Source No.", PurchaseLine_vRec."Document No.");
        WarehouseReceiptLine_lRec.SetRange("Source Line No.", PurchaseLine_vRec."Line No.");
        IF WarehouseReceiptLine_lRec.FindFirst() then begin
            WarehouseReceptNo_gCod := WarehouseReceiptLine_lRec."No.";
            //Delete Header If Not any Line Exist
            WarehouseReceiptLine_lRec.Delete();
            DeleteWarhReceipt(WarehouseReceptNo_gCod);
        end;

        //Inventory Pick
        WarehouseActivityNo_gCod := '';
        WarhouActivityLine_lRec.Reset();
        WarhouActivityLine_lRec.Setfilter("Activity Type", '%1|%2', WarhouActivityLine_lRec."Activity Type"::"Invt. Pick", WarhouActivityLine_lRec."Activity Type"::"Put-away");
        WarhouActivityLine_lRec.SetRange("Source Document", WarhouActivityLine_lRec."Source Document"::"Purchase Order");
        WarhouActivityLine_lRec.SetRange("Source Type", 39);
        WarhouActivityLine_lRec.SetRange("Source Subtype", 1);
        WarhouActivityLine_lRec.SetRange("Source No.", PurchaseLine_vRec."Document No.");
        WarhouActivityLine_lRec.SetRange("Source Line No.", PurchaseLine_vRec."Line No.");
        IF WarhouActivityLine_lRec.FindSet() then
            repeat
                ActivityType := WarhouActivityLine_lRec."Activity Type";
                WarehouseActivityNo_gCod := WarhouActivityLine_lRec."No.";
                //Delete Header If Not any Line Exist
                WarhouActivityLine_lRec.Delete();
                DeleteWarhActivity(ActivityType, WarehouseActivityNo_gCod);
            until WarhouActivityLine_lRec.Next() = 0;


        ReservationEntry_lRec.Reset();
        ReservationEntry_lRec.SetRange("Source Type", 37);
        ReservationEntry_lRec.SetRange("Source ID", PurchaseLine_vRec."Document No.");
        ReservationEntry_lRec.SetRange("Source Ref. No.", PurchaseLine_vRec."Line No.");
        if ReservationEntry_lRec.FindFirst() then begin
            ReservationEntry2_lRec.Reset();
            ReservationEntry2_lRec.SetRange("Entry No.", ReservationEntry_lRec."Entry No.");
            ReservationEntry2_lRec.SetRange("Reservation Status", ReservationEntry2_lRec."Reservation Status"::Reservation);
            ReservationEntry2_lRec.SetRange("Item No.", ReservationEntry_lRec."Item No.");
            if ReservationEntry_lRec.Positive then
                ReservationEntry2_lRec.SetRange(Positive, false)
            else
                ReservationEntry2_lRec.SetRange(Positive, true);
            if ReservationEntry2_lRec.FindFirst() then
                ReservationEntry2_lRec.DeleteAll(true);
            ReservationEntry_lRec.Delete(true);
        end;



        PurchaseLine_vRec.Validate(Quantity, PLFinalQty_lDec);
        PurchaseLine_vRec.Validate("Completely Received", True);
        // PurchaseLine_vRec.Validate("Bin Code", BinCode);
        // PurchaseLine_vRec.Validate("Unit Price", UnitPrice);
        PurchaseLine_vRec.validate("Short Close Reason", SelectedShrtClsReason_lCod);
        PurchaseLine_vRec."Short Close Boolean" := true;

        PurchaseLine_vRec.Validate("Special Order", false);
        PurchaseLine_vRec.Validate("Special Order Sales No.", '');
        PurchaseLine_vRec.Validate("Special Order Sales Line No.", 0);

        PurchaseLine_vRec."Drop Shipment" := false;
        PurchaseLine_vRec.Validate("Sales Order No.", '');
        PurchaseLine_vRec.Validate("Sales Order Line No.", 0);
        PurchaseLine_vRec.Validate("Purchasing Code", '');
        PurchaseLine_vRec.MODIFY();

        SalesLine.Reset();
        SalesLine.SetRange("Purchase Order No.", PurchaseLine_vRec."Document No.");
        SalesLine.SetRange("Purch. Order Line No.", PurchaseLine_vRec."Line No.");
        if SalesLine.FindSet() then
            repeat
                SalesLine.Validate("Purchasing Code", '');
                SalesLine."Purchase Order No." := '';
                SalesLine."Purch. Order Line No." := 0;
                SalesLine.Validate("Drop Shipment", false);
                SalesLine.Validate("Special Order", false);
                SalesLine.Validate("Special Order Purchase No.", '');
                SalesLine.Validate("Special Order Purch. Line No.", 0);
                SalesLine.Modify();

                ReservationEntry_lRec.Reset();
                ReservationEntry_lRec.SetRange("Source Type", 37);
                ReservationEntry_lRec.SetRange("Source ID", SalesLine."Document No.");
                ReservationEntry_lRec.SetRange("Source Ref. No.", SalesLine."Line No.");
                if ReservationEntry_lRec.FindFirst() then
                    ReservationEntry_lRec.Delete(true);
            until SalesLine.Next() = 0;


        SalesLine.Reset();
        SalesLine.SetRange("Special Order Purchase No.", PurchaseLine_vRec."Document No.");
        SalesLine.SetRange("Special Order Purch. Line No.", PurchaseLine_vRec."Line No.");
        if SalesLine.FindSet() then
            repeat
                SalesLine.Validate("Purchasing Code", '');
                SalesLine."Purchase Order No." := '';
                SalesLine."Purch. Order Line No." := 0;
                SalesLine.Validate("Drop Shipment", false);
                SalesLine.Validate("Special Order", false);
                SalesLine.Validate("Special Order Purchase No.", '');
                SalesLine.Validate("Special Order Purch. Line No.", 0);
                SalesLine.Modify();

                ReservationEntry_lRec.Reset();
                ReservationEntry_lRec.SetRange("Source Type", 37);
                ReservationEntry_lRec.SetRange("Source ID", SalesLine."Document No.");
                ReservationEntry_lRec.SetRange("Source Ref. No.", SalesLine."Line No.");
                if ReservationEntry_lRec.FindFirst() then
                    ReservationEntry_lRec.Delete(true);
            until SalesLine.Next() = 0;

        //Header Short Close
        PurchaseLine_lRec.RESET();
        PurchaseLine_lRec.SETRANGE("Document Type", PurchaseHeader_lRec."Document Type");
        PurchaseLine_lRec.SETRANGE("Document No.", PurchaseHeader_lRec."No.");
        PurchaseLine_lRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
        IF Not PurchaseLine_lRec.FindFirst() THEN begin
            PurchaseHeader_lRec.validate("Short Close Reason", SelectedShrtClsReason_lCod);
            PurchaseHeader_lRec."Short Close Boolean" := true;
            PurchaseHeader_lRec.Modify(true);
        end;

    end;


    procedure ForeCLosePurchaseDocument(PurchaseHeader_iRec: Record "Purchase Header")
    var
        PurchaseHeader_lRec: Record "Purchase Header";
        PurchaseLine_lRec: Record "Purchase Line";
        ShortCloseFun_lCdu: Codeunit "Short Close Functionality";
        ShortCloseSetup: Record "Short Close Setup";
        ShortCloseReason_lRpt: Report "Short Close Reason RP";
        IsReportRun_lBln: Boolean;
        SelectedShrtClsReason_lCod: Code[20];
        PLQty_lDec: Decimal;
        PLOutSndQty_lDec: Decimal;
        PLFinalQty_lDec: Decimal;
        BinCode: Code[20];
        UnitPrice: Decimal;
        WarehouseReceiptLine_lRec: Record "Warehouse Receipt Line";
        WarhouActivityLine_lRec: Record "Warehouse Activity Line";
        IsShortClose_lBln: Boolean;
        Text33029350_Lbl: Label 'Do you want to ShortClose Purchase Order %1?', Comment = '%1=SO';
        Text33029351_Lbl: Label 'Purchase Order %1 Short Closed successfully.\Document has been moved to Short Closed Document List.', Comment = '%1=SO';
        Text33029737_Lbl: Label 'There is no "Outstanding Quantity" for Item No. = ''%1''.', Comment = '%1=Item No.';
        Text33029353_Lbl: Label 'There is not any outstanding Qty is available.Purchase Order %1 is not Short Closed.';
        ReservationEntry_lRec: Record "Reservation Entry";
        ReservationEntry2_lRec: Record "Reservation Entry";
        SalesLine: Record "Sales Line";
    begin
        ShortCloseSetup.GET();
        ShortCloseSetup.TESTFIELD("Allow Purchase Short Close", TRUE);

        PurchaseHeader_lRec.GET(PurchaseHeader_iRec."Document Type", PurchaseHeader_iRec."No.");
        PurchaseHeader_lRec.TESTFIELD("Short Close Boolean", FALSE);
        PurchaseHeader_lRec.TESTFIELD(Status, PurchaseHeader_lRec.Status::Open);

        IF CONFIRM(STRSUBSTNO(Text33029350_Lbl, PurchaseHeader_lRec."No."), true) THEN begin

            Clear(ShortCloseReason_lRpt);
            ShortCloseReason_lRpt.RunModal();
            IsReportRun_lBln := ShortCloseReason_lRpt.IsReportRun();

            SelectedShrtClsReason_lCod := ShortCloseReason_lRpt.GetReasonCode_gFnc();
            if SelectedShrtClsReason_lCod = '' then
                Error(SHortClsRsnLabel_gLbl);

            if not IsReportRun_lBln then
                exit;

            PurchaseLine_lRec.RESET();
            PurchaseLine_lRec.SETRANGE("Document Type", PurchaseHeader_lRec."Document Type");
            PurchaseLine_lRec.SETRANGE("Document No.", PurchaseHeader_lRec."No.");
            // PurchaseLine_lRec.SETRANGE(Type, PurchaseLine_lRec.Type::Item); //Hypercare 27022025
            PurchaseLine_lRec.SETFILTER(Type, '<>%1', PurchaseLine_lRec.Type::" "); //Hypercare 27022025
            PurchaseLine_lRec.SETRANGE("Short Close Boolean", FALSE);
            PurchaseLine_lRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
            IF not PurchaseLine_lRec.FINDSET() THEN
                Error(Text33029353_Lbl, PurchaseHeader_lRec."No.");

            PurchaseLine_lRec.RESET();
            PurchaseLine_lRec.SETRANGE("Document Type", PurchaseHeader_lRec."Document Type");
            PurchaseLine_lRec.SETRANGE("Document No.", PurchaseHeader_lRec."No.");
            // PurchaseLine_lRec.SETRANGE(Type, PurchaseLine_lRec.Type::Item);//Hypercare 27022025
            PurchaseLine_lRec.SETFILTER(Type, '<>%1', PurchaseLine_lRec.Type::" "); //Hypercare 27022025
            PurchaseLine_lRec.SETRANGE("Short Close Boolean", FALSE);
            PurchaseLine_lRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
            IF PurchaseLine_lRec.FINDSET(TRUE, TRUE) THEN
                REPEAT
                    BinCode := '';
                    UnitPrice := 0;
                    PLQty_lDec := 0;
                    PLOutSndQty_lDec := 0;
                    PLFinalQty_lDec := 0;

                    BinCode := PurchaseLine_lRec."Bin Code";
                    UnitPrice := PurchaseLine_lRec."Unit Cost";
                    PLQty_lDec := PurchaseLine_lRec.Quantity;
                    PLOutSndQty_lDec := PurchaseLine_lRec."Outstanding Quantity";
                    PLFinalQty_lDec := ABS(PurchaseLine_lRec.Quantity - PLOutSndQty_lDec);
                    PurchaseLine_lRec.Validate("Short Closed Qty", PLOutSndQty_lDec);

                    ReservationEntry_lRec.Reset();
                    ReservationEntry_lRec.SetRange("Source Type", 37);
                    ReservationEntry_lRec.SetRange("Source ID", PurchaseLine_lRec."Document No.");
                    ReservationEntry_lRec.SetRange("Source Ref. No.", PurchaseLine_lRec."Line No.");
                    if ReservationEntry_lRec.FindFirst() then begin
                        ReservationEntry2_lRec.Reset();
                        ReservationEntry2_lRec.SetRange("Entry No.", ReservationEntry_lRec."Entry No.");
                        ReservationEntry2_lRec.SetRange("Reservation Status", ReservationEntry2_lRec."Reservation Status"::Reservation);
                        ReservationEntry2_lRec.SetRange("Item No.", ReservationEntry_lRec."Item No.");
                        if ReservationEntry_lRec.Positive then
                            ReservationEntry2_lRec.SetRange(Positive, false)
                        else
                            ReservationEntry2_lRec.SetRange(Positive, true);
                        if ReservationEntry2_lRec.FindFirst() then
                            ReservationEntry2_lRec.DeleteAll(true);
                        ReservationEntry_lRec.Delete(true);
                    end;

                    //WarehouseReceipt
                    WarehouseReceptNo_gCod := '';
                    WarehouseReceiptLine_lRec.Reset();
                    WarehouseReceiptLine_lRec.SetRange("Source Document", WarehouseReceiptLine_lRec."Source Document"::"Purchase Order");
                    WarehouseReceiptLine_lRec.SetRange("Source Type", 39);
                    WarehouseReceiptLine_lRec.SetRange("Source Subtype", 1);
                    WarehouseReceiptLine_lRec.SetRange("Source No.", PurchaseLine_lRec."Document No.");
                    WarehouseReceiptLine_lRec.SetRange("Source Line No.", PurchaseLine_lRec."Line No.");
                    IF WarehouseReceiptLine_lRec.FindFirst() then begin
                        WarehouseReceptNo_gCod := WarehouseReceiptLine_lRec."No.";
                        //Delete Header If Not any Line Exist
                        WarehouseReceiptLine_lRec.Delete();
                        DeleteWarhReceipt(WarehouseReceptNo_gCod);
                    end;

                    //Inventory Pick
                    WarehouseActivityNo_gCod := '';
                    WarhouActivityLine_lRec.Reset();
                    WarhouActivityLine_lRec.Setfilter("Activity Type", '%1|%2', WarhouActivityLine_lRec."Activity Type"::"Invt. Pick", WarhouActivityLine_lRec."Activity Type"::"Put-away");
                    WarhouActivityLine_lRec.SetRange("Source Document", WarhouActivityLine_lRec."Source Document"::"Purchase Order");
                    WarhouActivityLine_lRec.SetRange("Source Type", 39);
                    WarhouActivityLine_lRec.SetRange("Source Subtype", 1);
                    WarhouActivityLine_lRec.SetRange("Source No.", PurchaseLine_lRec."Document No.");
                    WarhouActivityLine_lRec.SetRange("Source Line No.", PurchaseLine_lRec."Line No.");
                    IF WarhouActivityLine_lRec.FindSet() then
                        repeat
                            ActivityType := WarhouActivityLine_lRec."Activity Type";
                            WarehouseActivityNo_gCod := WarhouActivityLine_lRec."No.";
                            //Delete Header If Not any Line Exist
                            WarhouActivityLine_lRec.Delete();
                            DeleteWarhActivity(ActivityType, WarehouseActivityNo_gCod);
                        until WarhouActivityLine_lRec.Next() = 0;

                    PurchaseLine_lRec.Validate(Quantity, PLFinalQty_lDec);
                    PurchaseLine_lRec.Validate("Completely Received", True);
                    // PurchaseLine_lRec.Validate("Bin Code", BinCode);
                    // PurchaseLine_lRec.Validate("Unit Price", UnitPrice);
                    PurchaseLine_lRec.Validate("Special Order", false);
                    PurchaseLine_lRec.Validate("Special Order Sales No.", '');
                    PurchaseLine_lRec.Validate("Special Order Sales Line No.", 0);

                    PurchaseLine_lRec.Validate("Drop Shipment", false);
                    PurchaseLine_lRec.Validate("Sales Order No.", '');
                    PurchaseLine_lRec.Validate("Sales Order Line No.", 0);

                    PurchaseLine_lRec.validate("Short Close Reason", SelectedShrtClsReason_lCod);
                    PurchaseLine_lRec."Short Close Boolean" := true;
                    PurchaseLine_lRec.Validate("Purchasing Code", '');
                    PurchaseLine_lRec.MODIFY();

                    SalesLine.Reset();
                    SalesLine.SetRange("Purchase Order No.", PurchaseLine_lRec."Document No.");
                    SalesLine.SetRange("Purch. Order Line No.", PurchaseLine_lRec."Line No.");
                    if SalesLine.FindSet() then
                        repeat
                            SalesLine.Validate("Purchasing Code", '');
                            SalesLine."Purchase Order No." := '';
                            SalesLine."Purch. Order Line No." := 0;
                            SalesLine.Validate("Special Order", false);
                            SalesLine.Validate("Special Order Purchase No.", '');
                            SalesLine.Validate("Special Order Purch. Line No.", 0);
                            SalesLine.Modify();

                            ReservationEntry_lRec.Reset();
                            ReservationEntry_lRec.SetRange("Source Type", 37);
                            ReservationEntry_lRec.SetRange("Source ID", SalesLine."Document No.");
                            ReservationEntry_lRec.SetRange("Source Ref. No.", SalesLine."Line No.");
                            if ReservationEntry_lRec.FindFirst() then
                                ReservationEntry_lRec.Delete(true);

                        until SalesLine.Next() = 0;


                    SalesLine.Reset();
                    SalesLine.SetRange("Special Order Purchase No.", PurchaseLine_lRec."Document No.");
                    SalesLine.SetRange("Special Order Purch. Line No.", PurchaseLine_lRec."Line No.");
                    if SalesLine.FindSet() then
                        repeat
                            SalesLine.Validate("Purchasing Code", '');
                            SalesLine."Purchase Order No." := '';
                            SalesLine."Purch. Order Line No." := 0;
                            SalesLine.Validate("Drop Shipment", false);
                            SalesLine.Validate("Special Order", false);
                            SalesLine.Validate("Special Order Purchase No.", '');
                            SalesLine.Validate("Special Order Purch. Line No.", 0);
                            SalesLine.Modify();

                            ReservationEntry_lRec.Reset();
                            ReservationEntry_lRec.SetRange("Source Type", 37);
                            ReservationEntry_lRec.SetRange("Source ID", SalesLine."Document No.");
                            ReservationEntry_lRec.SetRange("Source Ref. No.", SalesLine."Line No.");
                            if ReservationEntry_lRec.FindFirst() then
                                ReservationEntry_lRec.Delete(true);
                        until SalesLine.Next() = 0;


                    IsShortClose_lBln := true;

                UNTIL PurchaseLine_lRec.NEXT() = 0;

            if IsShortClose_lBln then begin
                PurchaseHeader_lRec.validate("Short Close Reason", SelectedShrtClsReason_lCod);
                PurchaseHeader_lRec."Short Close Boolean" := true;
                //   PurchaseHeader_lRec."ShortClose Approval" := true;//T50306
                PurchaseHeader_lRec.Modify(true);
            end;

            if IsShortClose_lBln then
                MESSAGE(Text33029351_Lbl, PurchaseHeader_lRec."No.")
        end;
    end;

    procedure InsertTransferForeCloseLine_gFnc(var TransferLine_vRec: Record "Transfer Line")
    var
        ShortCloseSetup: Record "Short Close Setup";
        TransferHeader_lRec: Record "Transfer Header";
        ShortCloseReason_lRpt: Report "Short Close Reason RP";
        IsReportRun_lBln: Boolean;
        SelectedShrtClsReason_lCod: Code[20];
        TLQty_lDec: Decimal;
        TLOutSndQty_lDec: Decimal;
        TLFinalQty_lDec: Decimal;
        BinCode: Code[20];
        UnitPrice: Decimal;
        WarehouseShipmentLine_lRec: Record "Warehouse Shipment Line";
        WarehouseReceiptLine_lRec: Record "Warehouse Receipt Line";
        WarhouActivityLine_lRec: Record "Warehouse Activity Line";
        TransferLine_lRec: Record "Transfer Line";
        Text33029735_Lbl: Label 'Transfer Line with Type = ''%1'' cannot be Short Closed.', Comment = '%1=Type';
        Text33029736_Lbl: Label 'Do you want to Shortclose Transfer Line for Item No. = ''%1'' Line No. = ''%2'' ?', Comment = '%1=Item No.';
        Text33029737_Lbl: Label 'There is no "Outstanding Quantity" for Item No. = ''%1''.', Comment = '%1=Item No.';
        Text33029738_Lbl: Label '"Quantity Shipped" & "Quantity Received" must be same to Shortclose Transfer Line Item No. = ''%1''.', Comment = '%1=Item No.';
        Text007lLbl: Label 'Qty. Picked = %1 is greater than Qty. Shipped = %2. If you delete the Warehouse Shipment Line, the items will remain in the shipping area until you put them away.\Related Item Tracking information defined during pick will be deleted.\Do you still want to delete the Warehouse Shipment Line?';
        ReservationEntry_lRec: Record "Reservation Entry";
        SkipShortClose: Boolean;
        TransferLineDerLine: Record "Transfer Line";
    begin
        ShortCloseSetup.GET();
        ShortCloseSetup.TESTFIELD("Allow Transfer Short Close", TRUE);


        IF CONFIRM(STRSUBSTNO(Text33029736_Lbl, TransferLine_vRec."Item No.", TransferLine_vRec."Line No."), true) THEN begin


            IF TransferLine_vRec."Quantity Shipped" <> TransferLine_vRec."Quantity Received" THEN
                ERROR(Text33029738_Lbl, TransferLine_vRec."Item No.");

            IF TransferLine_vRec."Outstanding Quantity" = 0 THEN
                ERROR(Text33029737_Lbl, TransferLine_vRec."Item No.");

            TransferHeader_lRec.GET(TransferLine_vRec."Document No.");
            TransferHeader_lRec.TESTFIELD(Status, TransferHeader_lRec.Status::Open);

            TransferLine_vRec.TESTFIELD(TransferLine_vRec."Short Close Boolean", FALSE);

            Clear(ShortCloseReason_lRpt);
            ShortCloseReason_lRpt.RunModal();
            IsReportRun_lBln := ShortCloseReason_lRpt.IsReportRun();

            SelectedShrtClsReason_lCod := ShortCloseReason_lRpt.GetReasonCode_gFnc();
            if SelectedShrtClsReason_lCod = '' then
                Error(SHortClsRsnLabel_gLbl);

            if not IsReportRun_lBln then
                exit;

            WarehouseShipNo_gCod := '';

            SkipShortClose := false;
            WarehouseShipmentLine_lRec.Reset();
            WarehouseShipmentLine_lRec.SetFilter("Source Document", '%1|%2', WarehouseShipmentLine_lRec."Source Document"::"Inbound Transfer", WarehouseShipmentLine_lRec."Source Document"::"Outbound Transfer");
            WarehouseShipmentLine_lRec.SetRange("Source Type", 5741);
            WarehouseShipmentLine_lRec.SetRange("Source Subtype", 0);
            WarehouseShipmentLine_lRec.SetRange("Source No.", TransferLine_vRec."Document No.");
            WarehouseShipmentLine_lRec.SetRange("Source Line No.", TransferLine_vRec."Line No.");
            IF WarehouseShipmentLine_lRec.FindFirst() then
                repeat
                    if not SkipShortClose then
                        if WarehouseShipmentLine_lRec."Qty. Shipped" < WarehouseShipmentLine_lRec."Qty. Picked" then
                            if not Confirm(Text007lLbl, true, WarehouseShipmentLine_lRec."Qty. Picked", WarehouseShipmentLine_lRec."Qty. Shipped") then
                                SkipShortClose := true;
                until WarehouseShipmentLine_lRec.Next() = 0;

            if not SkipShortClose then begin
                //UnitPrice := TransferLine_vRec."Transfer Price";
                TLQty_lDec := TransferLine_vRec.Quantity;
                TLOutSndQty_lDec := TransferLine_vRec."Outstanding Quantity";
                TLFinalQty_lDec := ABS(TransferLine_vRec.Quantity - TLOutSndQty_lDec);
                TransferLine_vRec.Validate("Short Closed Qty", TLOutSndQty_lDec);

                //WarehouseShipment
                WarehouseShipNo_gCod := '';
                WarehouseShipmentLine_lRec.Reset();
                WarehouseShipmentLine_lRec.SetFilter("Source Document", '%1|%2', WarehouseShipmentLine_lRec."Source Document"::"Inbound Transfer", WarehouseShipmentLine_lRec."Source Document"::"Outbound Transfer");
                WarehouseShipmentLine_lRec.SetRange("Source Type", 5741);
                WarehouseShipmentLine_lRec.SetRange("Source Subtype", 0);
                WarehouseShipmentLine_lRec.SetRange("Source No.", TransferLine_vRec."Document No.");
                WarehouseShipmentLine_lRec.SetRange("Source Line No.", TransferLine_vRec."Line No.");
                IF WarehouseShipmentLine_lRec.FindFirst() then begin
                    WarehouseShipNo_gCod := WarehouseShipmentLine_lRec."No.";
                    //Delete Header If Not any Line Exist
                    WarehouseShipmentLine_lRec.Delete();
                    DeleteWarhShip(WarehouseShipNo_gCod);

                end;

                //WarehouseReceipt
                WarehouseReceptNo_gCod := '';
                WarehouseReceiptLine_lRec.Reset();
                WarehouseReceiptLine_lRec.SetFilter("Source Document", '%1|%2', WarehouseReceiptLine_lRec."Source Document"::"Inbound Transfer", WarehouseReceiptLine_lRec."Source Document"::"Outbound Transfer");
                WarehouseReceiptLine_lRec.SetRange("Source Type", 5741);
                WarehouseReceiptLine_lRec.SetRange("Source Subtype", 0);
                WarehouseReceiptLine_lRec.SetRange("Source No.", TransferLine_vRec."Document No.");
                WarehouseReceiptLine_lRec.SetRange("Source Line No.", TransferLine_vRec."Line No.");
                IF WarehouseReceiptLine_lRec.FindFirst() then begin
                    WarehouseReceptNo_gCod := WarehouseReceiptLine_lRec."No.";
                    //Delete Header If Not any Line Exist
                    WarehouseReceiptLine_lRec.Delete();
                    DeleteWarhReceipt(WarehouseReceptNo_gCod);
                end;

                //Inventory Pick
                WarehouseActivityNo_gCod := '';
                WarhouActivityLine_lRec.Reset();
                WarhouActivityLine_lRec.Setfilter("Activity Type", '%1|%2', WarhouActivityLine_lRec."Activity Type"::"Invt. Pick", WarhouActivityLine_lRec."Activity Type"::Pick);
                WarhouActivityLine_lRec.SetFilter("Source Document", '%1|%2', WarhouActivityLine_lRec."Source Document"::"Inbound Transfer", WarhouActivityLine_lRec."Source Document"::"Outbound Transfer");
                WarhouActivityLine_lRec.SetRange("Source Type", 5741);
                WarhouActivityLine_lRec.SetRange("Source Subtype", 0);
                WarhouActivityLine_lRec.SetRange("Source No.", TransferLine_vRec."Document No.");
                WarhouActivityLine_lRec.SetRange("Source Line No.", TransferLine_vRec."Line No.");
                IF WarhouActivityLine_lRec.FindSet() then
                    repeat
                        ActivityType := WarhouActivityLine_lRec."Activity Type";
                        WarehouseActivityNo_gCod := WarhouActivityLine_lRec."No.";
                        //Delete Header If Not any Line Exist
                        WarhouActivityLine_lRec.Delete();
                        DeleteWarhActivity(ActivityType, WarehouseActivityNo_gCod);
                    until WarhouActivityLine_lRec.Next() = 0;


                // RegisteredWhseActivityLine.Reset();
                // RegisteredWhseActivityLine.SetFilter("Activity Type", '%1|%2', RegisteredWhseActivityLine."Activity Type"::"Invt. Pick", RegisteredWhseActivityLine."Activity Type"::Pick);
                // RegisteredWhseActivityLine.SetFilter("Source Document", '%1|%2', RegisteredWhseActivityLine."Source Document"::"Inbound Transfer", RegisteredWhseActivityLine."Source Document"::"Outbound Transfer");
                // RegisteredWhseActivityLine.SetRange("Source Type", 5741);
                // RegisteredWhseActivityLine.SetRange("Source Subtype", 0);
                // RegisteredWhseActivityLine.SetRange("Source No.", TransferLine_vRec."Document No.");
                // RegisteredWhseActivityLine.SetRange("Source Line No.", TransferLine_vRec."Line No.");
                // IF RegisteredWhseActivityLine.FindSet() then
                //     Error('Registered Pick already exist for Document No. %1 Line No. %2', TransferLine_vRec."Document No.", TransferLine_vRec."Line No.");


                TransferLine_vRec.Validate(Quantity, TLFinalQty_lDec);
                TransferLine_vRec.Validate("Completely Shipped", true);
                TransferLine_vRec.Validate("Completely Received", true);
                // TransferLine_vRec.Validate("Unit Price", UnitPrice);
                TransferLine_vRec.validate("Short Close Reason", SelectedShrtClsReason_lCod);
                TransferLine_vRec."Short Close Boolean" := true;
                TransferLine_vRec.MODIFY();


                TransferLineDerLine.Reset();
                TransferLineDerLine.SetRange("Document No.", TransferLine_vRec."Document No.");
                TransferLineDerLine.SetRange("Derived From Line No.", TransferLine_vRec."Line No.");
                if TransferLineDerLine.FindSet() then
                    repeat
                        TransferLineDerLine.Validate(Quantity, TLFinalQty_lDec);
                        TransferLineDerLine.Validate("Completely Shipped", true);
                        TransferLineDerLine.Validate("Completely Received", true);
                        TransferLineDerLine.validate("Short Close Reason", SelectedShrtClsReason_lCod);
                        TransferLineDerLine."Short Close Boolean" := true;
                        TransferLineDerLine.MODIFY();
                    until TransferLineDerLine.Next() = 0;


                ReservationEntry_lRec.Reset();
                ReservationEntry_lRec.SetRange("Source Type", 5741);
                ReservationEntry_lRec.SetRange("Source ID", TransferLine_vRec."Document No.");
                ReservationEntry_lRec.SetRange("Source Ref. No.", TransferLine_vRec."Line No.");
                if ReservationEntry_lRec.FindSet() then
                    ReservationEntry_lRec.DeleteAll();

                //Header Short Close
                TransferLine_lRec.RESET();
                TransferLine_lRec.SETRANGE("Document No.", TransferHeader_lRec."No.");
                TransferLine_lRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
                IF Not TransferLine_lRec.FindFirst() THEN begin
                    TransferHeader_lRec.validate("Short Close Reason", SelectedShrtClsReason_lCod);
                    TransferHeader_lRec."Short Close Boolean" := true;
                    TransferHeader_lRec.Modify(true);
                end;
            end;
        end;
    end;

    procedure ForeCLoseTransferDocument(TransferHeader_iRec: Record "Transfer Header")
    var
        TransferHeader_lRec: Record "Transfer Header";
        TransferLine_lRec: Record "Transfer Line";
        ShortCloseFun_lCdu: Codeunit "Short Close Functionality";
        ShortCloseSetup: Record "Short Close Setup";
        ShortCloseReason_lRpt: Report "Short Close Reason RP";
        IsReportRun_lBln: Boolean;
        SelectedShrtClsReason_lCod: Code[20];
        TLQty_lDec: Decimal;
        TLOutSndQty_lDec: Decimal;
        TLFinalQty_lDec: Decimal;
        BinCode: Code[20];
        UnitPrice: Decimal;
        WarehouseShipmentLine_lRec: Record "Warehouse Shipment Line";
        WarehouseReceiptLine_lRec: Record "Warehouse Receipt Line";
        WarhouActivityLine_lRec: Record "Warehouse Activity Line";
        ReservationEntry_lRec: Record "Reservation Entry";
        Text33029350_Lbl: Label 'Do you want to ShortClose Transfer Order %1?', Comment = '%1=SO';
        Text33029351_Lbl: Label 'Transfer Order %1 Short Closed successfully.\Document has been moved to Short Closed Document List.', Comment = '%1=SO';
        Text33029737_Lbl: Label 'There is no "Outstanding Quantity" for Item No. = ''%1''.', Comment = '%1=Item No.';
        Text33029738_Lbl: Label '"Quantity Shipped" & "Quantity Received" must be same to Shortclose Transfer Line Item No. %1 Line No. %2.', Comment = '%1=Item No.';
        Text33029353_Lbl: Label 'There is not any outstanding Qty is available.Transfer Order %1 is not Short Closed.';
        Text007lLbl: Label 'Qty. Picked = %1 is greater than Qty. Shipped = %2. If you delete the Warehouse Shipment Line, the items will remain in the shipping area until you put them away.\Related Item Tracking information defined during pick will be deleted.\Do you still want to delete the Warehouse Shipment Line?';
        SkipShortClose: Boolean;
        TransferLineDerLine: Record "Transfer Line";
    begin
        ShortCloseSetup.GET();
        ShortCloseSetup.TESTFIELD("Allow Transfer Short Close", TRUE);

        TransferHeader_lRec.GET(TransferHeader_iRec."No.");
        TransferHeader_lRec.TESTFIELD("Short Close Boolean", FALSE);
        TransferHeader_lRec.TESTFIELD(Status, TransferHeader_lRec.Status::Open);

        IF CONFIRM(STRSUBSTNO(Text33029350_Lbl, TransferHeader_lRec."No."), true) THEN begin

            Clear(ShortCloseReason_lRpt);
            ShortCloseReason_lRpt.RunModal();
            IsReportRun_lBln := ShortCloseReason_lRpt.IsReportRun();

            SelectedShrtClsReason_lCod := ShortCloseReason_lRpt.GetReasonCode_gFnc();
            if SelectedShrtClsReason_lCod = '' then
                Error(SHortClsRsnLabel_gLbl);

            if not IsReportRun_lBln then
                exit;

            TransferLine_lRec.RESET();
            TransferLine_lRec.SETRANGE("Document No.", TransferHeader_lRec."No.");
            TransferLine_lRec.SETRANGE("Short Close Boolean", FALSE);
            TransferLine_lRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
            if not TransferLine_lRec.FindFirst() then
                Error(Text33029353_Lbl, TransferHeader_lRec."No.");


            TransferLine_lRec.RESET();
            TransferLine_lRec.SETRANGE("Document No.", TransferHeader_lRec."No.");
            TransferLine_lRec.SETRANGE("Short Close Boolean", FALSE);
            // TransferLine_lRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
            TransferLine_lRec.SetFilter("Derived From Line No.", '%1', 0);
            IF TransferLine_lRec.FINDSET(TRUE, TRUE) THEN
                REPEAT
                    WarehouseShipNo_gCod := '';

                    SkipShortClose := false;
                    WarehouseShipmentLine_lRec.Reset();
                    WarehouseShipmentLine_lRec.SetFilter("Source Document", '%1|%2', WarehouseShipmentLine_lRec."Source Document"::"Inbound Transfer", WarehouseShipmentLine_lRec."Source Document"::"Outbound Transfer");
                    WarehouseShipmentLine_lRec.SetRange("Source Type", 5741);
                    WarehouseShipmentLine_lRec.SetRange("Source Subtype", 0);
                    WarehouseShipmentLine_lRec.SetRange("Source No.", TransferLine_lRec."Document No.");
                    WarehouseShipmentLine_lRec.SetRange("Source Line No.", TransferLine_lRec."Line No.");
                    if WarehouseShipmentLine_lRec.FindSet() then
                        repeat
                            if not SkipShortClose then
                                if WarehouseShipmentLine_lRec."Qty. Shipped" < WarehouseShipmentLine_lRec."Qty. Picked" then
                                    if not Confirm(Text007lLbl, true, WarehouseShipmentLine_lRec."Qty. Picked", WarehouseShipmentLine_lRec."Qty. Shipped") then
                                        SkipShortClose := true;
                        until WarehouseShipmentLine_lRec.Next() = 0;

                    if not SkipShortClose then begin
                        IF TransferLine_lRec."Quantity Shipped" <> TransferLine_lRec."Quantity Received" THEN
                            ERROR(Text33029738_Lbl, TransferLine_lRec."Item No.", TransferLine_lRec."Line No.");

                        IF TransferLine_lRec."Outstanding Quantity" > 0 THEN begin
                            BinCode := '';
                            UnitPrice := 0;
                            TLQty_lDec := 0;
                            TLOutSndQty_lDec := 0;
                            TLFinalQty_lDec := 0;

                            // BinCode := TransferLine_lRec."Bin Code";
                            //UnitPrice := TransferLine_lRec."Transfer Price";
                            TLQty_lDec := TransferLine_lRec.Quantity;
                            TLOutSndQty_lDec := TransferLine_lRec."Outstanding Quantity";
                            TLFinalQty_lDec := ABS(TransferLine_lRec.Quantity - TLOutSndQty_lDec);
                            TransferLine_lRec.Validate("Short Closed Qty", TLOutSndQty_lDec);

                            //WarehouseShipment
                            WarehouseShipNo_gCod := '';
                            WarehouseShipmentLine_lRec.Reset();
                            WarehouseShipmentLine_lRec.SetFilter("Source Document", '%1|%2', WarehouseShipmentLine_lRec."Source Document"::"Inbound Transfer", WarehouseShipmentLine_lRec."Source Document"::"Outbound Transfer");
                            WarehouseShipmentLine_lRec.SetRange("Source Type", 5741);
                            WarehouseShipmentLine_lRec.SetRange("Source Subtype", 0);
                            WarehouseShipmentLine_lRec.SetRange("Source No.", TransferLine_lRec."Document No.");
                            WarehouseShipmentLine_lRec.SetRange("Source Line No.", TransferLine_lRec."Line No.");
                            IF WarehouseShipmentLine_lRec.FindFirst() then begin
                                WarehouseShipNo_gCod := WarehouseShipmentLine_lRec."No.";
                                //Delete Header If Not any Line Exist
                                WarehouseShipmentLine_lRec.Delete();
                                DeleteWarhShip(WarehouseShipNo_gCod);

                            end;

                            //WarehouseReceipt
                            WarehouseReceptNo_gCod := '';
                            WarehouseReceiptLine_lRec.Reset();
                            WarehouseReceiptLine_lRec.SetFilter("Source Document", '%1|%2', WarehouseReceiptLine_lRec."Source Document"::"Inbound Transfer", WarehouseReceiptLine_lRec."Source Document"::"Outbound Transfer");
                            WarehouseReceiptLine_lRec.SetRange("Source Type", 5741);
                            WarehouseReceiptLine_lRec.SetRange("Source Subtype", 0);
                            WarehouseReceiptLine_lRec.SetRange("Source No.", TransferLine_lRec."Document No.");
                            WarehouseReceiptLine_lRec.SetRange("Source Line No.", TransferLine_lRec."Line No.");
                            IF WarehouseReceiptLine_lRec.FindFirst() then begin
                                WarehouseReceptNo_gCod := WarehouseReceiptLine_lRec."No.";
                                //Delete Header If Not any Line Exist
                                WarehouseReceiptLine_lRec.Delete();
                                DeleteWarhReceipt(WarehouseReceptNo_gCod);
                            end;

                            //Inventory Pick
                            WarehouseActivityNo_gCod := '';
                            WarhouActivityLine_lRec.Reset();
                            WarhouActivityLine_lRec.Setfilter("Activity Type", '%1|%2', WarhouActivityLine_lRec."Activity Type"::"Invt. Pick", WarhouActivityLine_lRec."Activity Type"::Pick);
                            WarhouActivityLine_lRec.SetFilter("Source Document", '%1|%2', WarhouActivityLine_lRec."Source Document"::"Inbound Transfer", WarhouActivityLine_lRec."Source Document"::"Outbound Transfer");
                            WarhouActivityLine_lRec.SetRange("Source Type", 5741);
                            WarhouActivityLine_lRec.SetRange("Source Subtype", 0);
                            WarhouActivityLine_lRec.SetRange("Source No.", TransferLine_lRec."Document No.");
                            WarhouActivityLine_lRec.SetRange("Source Line No.", TransferLine_lRec."Line No.");
                            IF WarhouActivityLine_lRec.FindSet() then
                                repeat
                                    ActivityType := WarhouActivityLine_lRec."Activity Type";
                                    WarehouseActivityNo_gCod := WarhouActivityLine_lRec."No.";
                                    //Delete Header If Not any Line Exist
                                    WarhouActivityLine_lRec.Delete();
                                    DeleteWarhActivity(ActivityType, WarehouseActivityNo_gCod);
                                until WarhouActivityLine_lRec.Next() = 0;


                            // RegisteredWhseActivityLine.Reset();
                            // RegisteredWhseActivityLine.SetFilter("Activity Type", '%1|%2', RegisteredWhseActivityLine."Activity Type"::"Invt. Pick", RegisteredWhseActivityLine."Activity Type"::Pick);
                            // RegisteredWhseActivityLine.SetFilter("Source Document", '%1|%2', RegisteredWhseActivityLine."Source Document"::"Inbound Transfer", RegisteredWhseActivityLine."Source Document"::"Outbound Transfer");
                            // RegisteredWhseActivityLine.SetRange("Source Type", 5741);
                            // RegisteredWhseActivityLine.SetRange("Source Subtype", 0);
                            // RegisteredWhseActivityLine.SetRange("Source No.", TransferLine_lRec."Document No.");
                            // RegisteredWhseActivityLine.SetRange("Source Line No.", TransferLine_lRec."Line No.");
                            // IF RegisteredWhseActivityLine.FindSet() then
                            //     Error('Registered Pick already exist for Document %1 Line No. %2', TransferLine_lRec."Document No.", TransferLine_lRec."Line No.");



                            TransferLine_lRec.Validate(Quantity, TLFinalQty_lDec);
                            TransferLine_lRec.Validate("Completely Shipped", true);
                            TransferLine_lRec.Validate("Completely Received", true);
                            // TransferLine_lRec.Validate("Bin Code", BinCode);
                            // TransferLine_lRec.Validate("Unit Price", UnitPrice);
                            TransferLine_lRec.validate("Short Close Reason", SelectedShrtClsReason_lCod);
                            TransferLine_lRec."Short Close Boolean" := true;
                            TransferLine_lRec.MODIFY();


                            TransferLineDerLine.Reset();
                            TransferLineDerLine.SetRange("Document No.", TransferLine_lRec."Document No.");
                            TransferLineDerLine.SetRange("Derived From Line No.", TransferLine_lRec."Line No.");
                            if TransferLineDerLine.FindSet() then
                                repeat
                                    TransferLineDerLine.Validate(Quantity, TLFinalQty_lDec);
                                    TransferLineDerLine.Validate("Completely Shipped", true);
                                    TransferLineDerLine.Validate("Completely Received", true);
                                    TransferLineDerLine.validate("Short Close Reason", SelectedShrtClsReason_lCod);
                                    TransferLineDerLine."Short Close Boolean" := true;
                                    TransferLineDerLine.MODIFY();
                                until TransferLineDerLine.Next() = 0;

                            ReservationEntry_lRec.Reset();
                            ReservationEntry_lRec.SetRange("Source Type", 5741);
                            ReservationEntry_lRec.SetRange("Source ID", TransferLine_lRec."Document No.");
                            ReservationEntry_lRec.SetRange("Source Ref. No.", TransferLine_lRec."Line No.");
                            if ReservationEntry_lRec.FindSet() then
                                ReservationEntry_lRec.DeleteAll();
                        end;
                    end;
                UNTIL TransferLine_lRec.NEXT() = 0;

            if not SkipShortClose then begin
                TransferHeader_lRec.validate("Short Close Reason", SelectedShrtClsReason_lCod);
                TransferHeader_lRec."Short Close Boolean" := true;
                TransferHeader_lRec.Modify(true);
                MESSAGE(Text33029351_Lbl, TransferHeader_lRec."No.");
            end;
        end;
    end;

    local procedure DeleteWarhReceipt(WarhReceiptNo_iCod: Code[20])
    var
        WarehouseRecHeader_lRec: Record "Warehouse Receipt Header";
        WarehouseRecLine_lRec: Record "Warehouse Receipt Line";
    begin
        // WarehouseRecLine_lRec.Reset;
        // WarehouseRecLine_lRec.SetRange("No.", WarhReceiptNo_iCod);
        // if Not WarehouseRecLine_lRec.FindFirst() then begin
        //     WarehouseRecHeader_lRec.Get(WarhReceiptNo_iCod);
        //     WarehouseRecHeader_lRec.Delete();
        // end;
    end;

    local procedure DeleteWarhShip(WarhShipmentNo_iCod: Code[20])
    var
        WarehouseShipHeader_lRec: Record "Warehouse Shipment Header";
        WarehouseShipLine_lRec: Record "Warehouse Shipment Line";
    begin
        // WarehouseShipLine_lRec.Reset;
        // WarehouseShipLine_lRec.SetRange("No.", WarhShipmentNo_iCod);
        // if Not WarehouseShipLine_lRec.FindFirst() then begin
        //     WarehouseShipHeader_lRec.Get(WarhShipmentNo_iCod);
        //     WarehouseShipHeader_lRec.Delete();
        // end;
    end;

    local procedure DeleteWarhActivity(ActivityType: Enum "Warehouse Activity Type"; WarhActivitytNo_iCod: Code[20])
    var
        WarehouseActivityHeader_lRec: Record "Warehouse Activity Header";
        WarehouseActivityLine_lRec: Record "Warehouse Activity Line";
    begin
        WarehouseActivityLine_lRec.Reset;
        WarehouseActivityLine_lRec.SetRange("Activity Type", ActivityType);
        WarehouseActivityLine_lRec.SetRange("No.", WarhActivitytNo_iCod);
        if Not WarehouseActivityLine_lRec.FindFirst() then begin
            if WarehouseActivityHeader_lRec.Get(ActivityType, WarhActivitytNo_iCod) then
                WarehouseActivityHeader_lRec.Delete();
        end;
    end;

    procedure RemoveSalesForeCloseLine_gFnc(var SalesLine_vRec: Record "Sales Line")
    var
        ShortCloseSetup: Record "Short Close Setup";
        SalesHeader_lRec: Record "Sales Header";
        ShortCloseReason_lRpt: Report "Short Close Reason RP";
        IsReportRun_lBln: Boolean;
        SelectedShrtClsReason_lCod: Code[20];
        SLQty_lDec: Decimal;
        SLOutSndQty_lDec: Decimal;
        SLFinalQty_lDec: Decimal;
        BinCode: Code[20];
        UnitPrice: Decimal;
        WarehouseShipmentLine_lRec: Record "Warehouse Shipment Line";
        WarhouActivityLine_lRec: Record "Warehouse Activity Line";
        SalesLine_lRec: Record "Sales Line";
        Text33029735_Lbl: Label 'Sales Line with Type = ''%1'' cannot be Short Closed.', Comment = '%1=Type';
        Text33029736_Lbl: Label 'Do you want to Shortclose Sales Line for Item No. = ''%1'' Line No. = ''%2'' ?', Comment = '%1=Item No.';
        Text33029737_Lbl: Label 'There is no "Outstanding Quantity" for Item No. = ''%1''.', Comment = '%1=Item No.';

    begin


        BinCode := SalesLine_vRec."Bin Code";
        UnitPrice := SalesLine_vRec."Unit Price";
        SLQty_lDec := SalesLine_vRec.Quantity;
        SLOutSndQty_lDec := SalesLine_vRec."Outstanding Quantity";
        SLFinalQty_lDec := SalesLine_vRec."Short Closed Qty";
        SalesLine_vRec.Validate("Short Closed Qty", 0);
        SalesLine_vRec."Short Close Reason" := '';
        SalesLine_vRec."Short Close Boolean" := false;
        SalesLine_vRec."Short Close Approval Required" := false;  //T50307-N
        SalesLine_vRec.MODIFY();

    end;




    procedure UndoPick(Var RegWhseActivityHdr: Record "Registered Whse. Activity Hdr.")
    var
        RegWhseActivityLine: Record "Registered Whse. Activity Line";
        RegWhseActivityLine2: Record "Registered Whse. Activity Line";
        WhseEntry: Record "Warehouse Entry";
        WhseEntry2: Record "Warehouse Entry";
        WhseShipmentLine: Record "Warehouse Shipment Line";
        WhseShipmentHeader: Record "Warehouse Shipment Header";
        ReservationEntry_lRec: Record "Reservation Entry";
        ReservationEntry2_lRec: Record "Reservation Entry";
        WhseItemTrackingLine: Record "Whse. Item Tracking Line";
        PostedWhseShipmentLine: record "Posted Whse. Shipment Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        SkipChecking: Boolean;
        RevQty: Decimal;
        RevQtyBase: Decimal;
        PickedQty: Decimal;
        EntryNo: Integer;
        i: Integer;
        WhseDocNo: Code[20];
        WhseDocLineNo: Integer;
    begin
        if not Confirm('Are you sure you want to Undo Pick?', true) then
            exit;

        WhseEntry2.Reset();
        if WhseEntry2.FindLast() then
            EntryNo := WhseEntry2."Entry No." + 1
        else
            EntryNo := 1;

        RegWhseActivityLine.Reset();
        RegWhseActivityLine.SetRange("Activity Type", RegWhseActivityHdr.Type);
        RegWhseActivityLine.SetRange("No.", RegWhseActivityHdr."No.");
        RegWhseActivityLine.SetRange("Action Type", RegWhseActivityLine."Action Type"::Take);
        if RegWhseActivityLine.FindSet() then begin
            repeat
                if RegWhseActivityLine."Lot No." <> '' then begin
                    Clear(RevQty);
                    Clear(RevQtyBase);
                    Clear(WhseDocNo);
                    Clear(WhseDocLineNo);

                    WhseDocNo := RegWhseActivityLine."Whse. Document No.";
                    WhseDocLineNo := RegWhseActivityLine."Whse. Document Line No.";


                    PostedWhseShipmentLine.Reset();
                    PostedWhseShipmentLine.SetRange("Whse. Shipment No.", RegWhseActivityLine."Whse. Document No.");
                    PostedWhseShipmentLine.SetRange("Whse Shipment Line No.", RegWhseActivityLine."Whse. Document Line No.");
                    PostedWhseShipmentLine.SetRange("Source No.", RegWhseActivityLine."Source No.");
                    PostedWhseShipmentLine.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                    PostedWhseShipmentLine.SetRange("Undo Pick Consideration", false);
                    if PostedWhseShipmentLine.FindSet() then
                        repeat
                            RevQty += PostedWhseShipmentLine.Quantity;
                            RevQtyBase += PostedWhseShipmentLine."Qty. (Base)";
                            PostedWhseShipmentLine."Undo Pick Consideration" := true;
                            PostedWhseShipmentLine.Modify();
                        until PostedWhseShipmentLine.Next() = 0;

                    WhseEntry.Reset();
                    WhseEntry.SetCurrentKey("Entry No.");
                    WhseEntry.Ascending(true);
                    WhseEntry.SetFilter("Entry No.", '<%1', EntryNo);
                    WhseEntry.SetRange("Reference No.", RegWhseActivityLine."No.");
                    WhseEntry.SetRange("Source Type", RegWhseActivityLine."Source Type");
                    WhseEntry.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
                    WhseEntry.SetRange("Source No.", RegWhseActivityLine."Source No.");
                    WhseEntry.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                    WhseEntry.SetRange("Source Document", RegWhseActivityLine."Source Document");
                    if WhseEntry.FindSet() then
                        repeat
                            WhseEntry2.Init();
                            WhseEntry2.TransferFields(WhseEntry);
                            WhseEntry2."Entry No." := EntryNo;

                            if WhseEntry2.Quantity > 0 then begin
                                WhseEntry2.Quantity := (WhseEntry2.Quantity - RevQty) * -1;
                                WhseEntry2."Qty. (Base)" := (WhseEntry2."Qty. (Base)" - RevQtyBase) * -1;
                            end else begin
                                WhseEntry2.Quantity := (WhseEntry2.Quantity + RevQty) * -1;
                                WhseEntry2."Qty. (Base)" := (WhseEntry2."Qty. (Base)" + RevQtyBase) * -1;
                            end;

                            WhseEntry2.Insert(true);
                            EntryNo += 1;
                        until WhseEntry.Next() = 0;

                    ReservationEntry_lRec.Reset();
                    ReservationEntry_lRec.SetRange("Source Type", 37);
                    ReservationEntry_lRec.SetRange("Source Subtype", 1);
                    ReservationEntry_lRec.SetRange("Source ID", RegWhseActivityLine."Source No.");
                    ReservationEntry_lRec.SetRange("Source Ref. No.", RegWhseActivityLine."Source Line No.");
                    if ReservationEntry_lRec.FindFirst() then begin
                        ReservationEntry2_lRec.Reset();
                        ReservationEntry2_lRec.SetRange("Entry No.", ReservationEntry_lRec."Entry No.");
                        ReservationEntry2_lRec.SetRange("Reservation Status", ReservationEntry2_lRec."Reservation Status"::Reservation);
                        ReservationEntry2_lRec.SetRange("Item No.", ReservationEntry_lRec."Item No.");
                        ReservationEntry2_lRec.SetFilter("Source Type", '<>%1', 37);
                        if ReservationEntry_lRec.Positive then
                            ReservationEntry2_lRec.SetRange(Positive, false)
                        else
                            ReservationEntry2_lRec.SetRange(Positive, true);
                        if ReservationEntry2_lRec.FindFirst() then
                            ReservationEntry2_lRec.DeleteAll(true);
                        ReservationEntry_lRec.Delete(true);
                    end;

                    WhseItemTrackingLine.Reset();
                    WhseItemTrackingLine.SetRange("Source ID", RegWhseActivityLine."Whse. Document No.");
                    WhseItemTrackingLine.SetRange("Source Ref. No.", RegWhseActivityLine."Whse. Document Line No.");
                    if WhseItemTrackingLine.FindSet() then
                        WhseItemTrackingLine.DeleteAll();

                    if RegWhseActivityLine.Quantity <> RevQty then begin
                        RegWhseActivityLine.Quantity := RevQty;
                        RegWhseActivityLine."Qty. (Base)" := RevQtyBase;

                        RegWhseActivityLine2.Reset();
                        RegWhseActivityLine2.SetRange("Activity Type", RegWhseActivityLine."Activity Type");
                        RegWhseActivityLine2.SetRange("No.", RegWhseActivityLine."No.");
                        RegWhseActivityLine2.SetRange("Source Type", RegWhseActivityLine."Source Type");
                        RegWhseActivityLine2.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
                        RegWhseActivityLine2.SetRange("Source No.", RegWhseActivityLine."Source No.");
                        RegWhseActivityLine2.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                        RegWhseActivityLine2.SetRange("Whse. Document No.", RegWhseActivityLine."Whse. Document No.");
                        RegWhseActivityLine2.SetRange("Whse. Document Line No.", RegWhseActivityLine."Whse. Document Line No.");
                        RegWhseActivityLine2.SetFilter("Action Type", '<>%1', RegWhseActivityLine."Action Type");
                        if RegWhseActivityLine2.FindSet() then
                            repeat
                                RegWhseActivityLine2.Quantity := RegWhseActivityLine.Quantity;
                                RegWhseActivityLine2."Qty. (Base)" := RegWhseActivityLine."Qty. (Base)";

                                if RegWhseActivityLine2.Quantity <> 0 then begin
                                    RegWhseActivityLine2.Modify();
                                    RegWhseActivityLine.Modify();
                                end else begin
                                    RegWhseActivityLine2.Delete();
                                    RegWhseActivityLine.Delete();
                                end;
                            until RegWhseActivityLine2.Next() = 0;
                    end else begin

                        RegWhseActivityLine2.Reset();
                        RegWhseActivityLine2.SetRange("Activity Type", RegWhseActivityLine."Activity Type");
                        RegWhseActivityLine2.SetRange("No.", RegWhseActivityLine."No.");
                        RegWhseActivityLine2.SetRange("Source Type", RegWhseActivityLine."Source Type");
                        RegWhseActivityLine2.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
                        RegWhseActivityLine2.SetRange("Source No.", RegWhseActivityLine."Source No.");
                        RegWhseActivityLine2.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                        RegWhseActivityLine2.SetRange("Whse. Document No.", RegWhseActivityLine."Whse. Document No.");
                        RegWhseActivityLine2.SetRange("Whse. Document Line No.", RegWhseActivityLine."Whse. Document Line No.");
                        RegWhseActivityLine2.SetFilter("Action Type", '<>%1', RegWhseActivityLine."Action Type");
                        if RegWhseActivityLine2.FindSet() then
                            repeat
                                RegWhseActivityLine2.Delete();
                            until RegWhseActivityLine2.Next() = 0;
                        RegWhseActivityLine.Delete();
                    end;



                    if WhseShipmentLine.GET(WhseDocNo, WhseDocLineNo) then begin
                        Clear(PickedQty);
                        RegWhseActivityLine2.Reset();
                        RegWhseActivityLine2.SetRange("Activity Type", RegWhseActivityLine."Activity Type");
                        RegWhseActivityLine2.SetRange("Source Type", RegWhseActivityLine."Source Type");
                        RegWhseActivityLine2.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
                        RegWhseActivityLine2.SetRange("Source No.", RegWhseActivityLine."Source No.");
                        RegWhseActivityLine2.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                        RegWhseActivityLine2.SetRange("Whse. Document No.", RegWhseActivityLine."Whse. Document No.");
                        RegWhseActivityLine2.SetRange("Whse. Document Line No.", RegWhseActivityLine."Whse. Document Line No.");
                        RegWhseActivityLine2.SetFilter("Action Type", '%1', RegWhseActivityLine."Action Type");
                        if RegWhseActivityLine2.FindSet() then
                            repeat
                                PickedQty += RegWhseActivityLine2.Quantity;
                            until RegWhseActivityLine2.Next() = 0;

                        WhseShipmentLine."Qty. Picked" := PickedQty;
                        WhseShipmentLine."Qty. Picked (Base)" := PickedQty;
                        WhseShipmentLine."Qty. to Ship" := 0;
                        WhseShipmentLine."Qty. to Ship (Base)" := 0;
                        WhseShipmentLine."Completely Picked" :=
                      (WhseShipmentLine."Qty. Picked" = WhseShipmentLine.Quantity) or (WhseShipmentLine."Qty. Picked (Base)" = WhseShipmentLine."Qty. (Base)");
                        WhseShipmentLine.Status := WhseShipmentLine.CalcStatusShptLine();
                        WhseShipmentLine.Modify();

                        if WhseShipmentHeader.GET(WhseShipmentLine."No.") then begin
                            WhseShipmentHeader."Document Status" := WhseShipmentHeader.GetDocumentStatus(0);
                            WhseShipmentHeader.Modify();
                        end;
                    end;
                end else if RegWhseActivityLine."Serial No." <> '' then begin
                    Clear(RevQty);
                    Clear(RevQtyBase);
                    Clear(WhseDocNo);
                    Clear(WhseDocLineNo);

                    WhseDocNo := RegWhseActivityLine."Whse. Document No.";
                    WhseDocLineNo := RegWhseActivityLine."Whse. Document Line No.";

                    SkipChecking := false;
                    PostedWhseShipmentLine.Reset();
                    PostedWhseShipmentLine.SetRange("Whse. Shipment No.", RegWhseActivityLine."Whse. Document No.");
                    PostedWhseShipmentLine.SetRange("Whse Shipment Line No.", RegWhseActivityLine."Whse. Document Line No.");
                    PostedWhseShipmentLine.SetRange("Source No.", RegWhseActivityLine."Source No.");
                    PostedWhseShipmentLine.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                    if PostedWhseShipmentLine.FindSet() then
                        repeat
                            ItemLedgerEntry.Reset();
                            ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                            ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
                            ItemLedgerEntry.SetRange("Document No.", PostedWhseShipmentLine."Posted Source No.");
                            ItemLedgerEntry.SetRange("Document Line No.", PostedWhseShipmentLine."Source Line No.");
                            ItemLedgerEntry.SetRange("Serial No.", RegWhseActivityLine."Serial No.");
                            ItemLedgerEntry.SetRange("Undo Pick Consideration", false);
                            if ItemLedgerEntry.FindSet() then
                                repeat
                                    RevQty += PostedWhseShipmentLine.Quantity;
                                    RevQtyBase += PostedWhseShipmentLine."Qty. (Base)";
                                    ItemLedgerEntry."Undo Pick Consideration" := true;
                                    ItemLedgerEntry.Modify();
                                    SkipChecking := true;
                                until ItemLedgerEntry.Next() = 0;
                        until PostedWhseShipmentLine.Next() = 0;

                    if not SkipChecking then begin


                        WhseEntry.Reset();
                        WhseEntry.SetCurrentKey("Entry No.");
                        WhseEntry.Ascending(true);
                        WhseEntry.SetFilter("Entry No.", '<%1', EntryNo);
                        WhseEntry.SetRange("Reference No.", RegWhseActivityLine."No.");
                        WhseEntry.SetRange("Source Type", RegWhseActivityLine."Source Type");
                        WhseEntry.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
                        WhseEntry.SetRange("Source No.", RegWhseActivityLine."Source No.");
                        WhseEntry.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                        WhseEntry.SetRange("Source Document", RegWhseActivityLine."Source Document");
                        WhseEntry.SetRange("Serial No.", RegWhseActivityLine."Serial No.");
                        if WhseEntry.FindSet() then
                            repeat
                                WhseEntry2.Init();
                                WhseEntry2.TransferFields(WhseEntry);
                                WhseEntry2."Entry No." := EntryNo;

                                if WhseEntry2.Quantity > 0 then begin
                                    WhseEntry2.Quantity := (WhseEntry2.Quantity - RevQty) * -1;
                                    WhseEntry2."Qty. (Base)" := (WhseEntry2."Qty. (Base)" - RevQtyBase) * -1;
                                end else begin
                                    WhseEntry2.Quantity := (WhseEntry2.Quantity + RevQty) * -1;
                                    WhseEntry2."Qty. (Base)" := (WhseEntry2."Qty. (Base)" + RevQtyBase) * -1;
                                end;

                                WhseEntry2.Insert(true);
                                EntryNo += 1;
                            until WhseEntry.Next() = 0;

                        WhseItemTrackingLine.Reset();
                        WhseItemTrackingLine.SetRange("Source ID", RegWhseActivityLine."Whse. Document No.");
                        WhseItemTrackingLine.SetRange("Source Ref. No.", RegWhseActivityLine."Whse. Document Line No.");
                        WhseItemTrackingLine.SetRange("Serial No.", RegWhseActivityLine."Serial No.");
                        if WhseItemTrackingLine.FindSet() then
                            WhseItemTrackingLine.DeleteAll();

                        ReservationEntry_lRec.Reset();
                        ReservationEntry_lRec.SetRange("Source Type", 37);
                        ReservationEntry_lRec.SetRange("Source Subtype", 1);
                        ReservationEntry_lRec.SetRange("Source ID", RegWhseActivityLine."Source No.");
                        ReservationEntry_lRec.SetRange("Source Ref. No.", RegWhseActivityLine."Source Line No.");
                        ReservationEntry_lRec.SetRange("Serial No.", RegWhseActivityLine."Serial No.");
                        if ReservationEntry_lRec.FindFirst() then begin
                            ReservationEntry2_lRec.Reset();
                            ReservationEntry2_lRec.SetRange("Entry No.", ReservationEntry_lRec."Entry No.");
                            ReservationEntry2_lRec.SetRange("Reservation Status", ReservationEntry2_lRec."Reservation Status"::Reservation);
                            ReservationEntry2_lRec.SetRange("Item No.", ReservationEntry_lRec."Item No.");
                            ReservationEntry2_lRec.SetFilter("Source Type", '<>%1', 37);
                            ReservationEntry2_lRec.SetRange("Serial No.", ReservationEntry_lRec."Serial No.");
                            if ReservationEntry_lRec.Positive then
                                ReservationEntry2_lRec.SetRange(Positive, false)
                            else
                                ReservationEntry2_lRec.SetRange(Positive, true);
                            if ReservationEntry2_lRec.FindFirst() then
                                ReservationEntry2_lRec.DeleteAll(true);
                            ReservationEntry_lRec.Delete(true);
                        end;


                        if RegWhseActivityLine.Quantity <> RevQty then begin
                            RegWhseActivityLine.Quantity := RevQty;
                            RegWhseActivityLine."Qty. (Base)" := RevQtyBase;

                            RegWhseActivityLine2.Reset();
                            RegWhseActivityLine2.SetRange("Activity Type", RegWhseActivityLine."Activity Type");
                            RegWhseActivityLine2.SetRange("No.", RegWhseActivityLine."No.");
                            RegWhseActivityLine2.SetRange("Source Type", RegWhseActivityLine."Source Type");
                            RegWhseActivityLine2.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
                            RegWhseActivityLine2.SetRange("Source No.", RegWhseActivityLine."Source No.");
                            RegWhseActivityLine2.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                            RegWhseActivityLine2.SetRange("Whse. Document No.", RegWhseActivityLine."Whse. Document No.");
                            RegWhseActivityLine2.SetRange("Whse. Document Line No.", RegWhseActivityLine."Whse. Document Line No.");
                            RegWhseActivityLine2.SetFilter("Action Type", '<>%1', RegWhseActivityLine."Action Type");
                            RegWhseActivityLine2.SetRange("Serial No.", RegWhseActivityLine."Serial No.");
                            if RegWhseActivityLine2.FindSet() then
                                repeat
                                    RegWhseActivityLine2.Quantity := RegWhseActivityLine.Quantity;
                                    RegWhseActivityLine2."Qty. (Base)" := RegWhseActivityLine."Qty. (Base)";

                                    if RegWhseActivityLine2.Quantity <> 0 then begin
                                        RegWhseActivityLine2.Modify();
                                        RegWhseActivityLine.Modify();
                                    end else begin
                                        RegWhseActivityLine2.Delete();
                                        RegWhseActivityLine.Delete();
                                    end;
                                until RegWhseActivityLine2.Next() = 0;
                        end else begin

                            RegWhseActivityLine2.Reset();
                            RegWhseActivityLine2.SetRange("Activity Type", RegWhseActivityLine."Activity Type");
                            RegWhseActivityLine2.SetRange("No.", RegWhseActivityLine."No.");
                            RegWhseActivityLine2.SetRange("Source Type", RegWhseActivityLine."Source Type");
                            RegWhseActivityLine2.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
                            RegWhseActivityLine2.SetRange("Source No.", RegWhseActivityLine."Source No.");
                            RegWhseActivityLine2.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                            RegWhseActivityLine2.SetRange("Whse. Document No.", RegWhseActivityLine."Whse. Document No.");
                            RegWhseActivityLine2.SetRange("Whse. Document Line No.", RegWhseActivityLine."Whse. Document Line No.");
                            RegWhseActivityLine2.SetFilter("Action Type", '<>%1', RegWhseActivityLine."Action Type");
                            RegWhseActivityLine2.SetRange("Serial No.", RegWhseActivityLine."Serial No.");
                            if RegWhseActivityLine2.FindSet() then
                                repeat
                                    RegWhseActivityLine2.Delete();
                                until RegWhseActivityLine2.Next() = 0;
                            RegWhseActivityLine.Delete();
                        end;

                        if WhseShipmentLine.GET(WhseDocNo, WhseDocLineNo) then begin
                            Clear(PickedQty);
                            RegWhseActivityLine2.Reset();
                            RegWhseActivityLine2.SetRange("Activity Type", RegWhseActivityLine."Activity Type");
                            RegWhseActivityLine2.SetRange("Source Type", RegWhseActivityLine."Source Type");
                            RegWhseActivityLine2.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
                            RegWhseActivityLine2.SetRange("Source No.", RegWhseActivityLine."Source No.");
                            RegWhseActivityLine2.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                            RegWhseActivityLine2.SetRange("Whse. Document No.", RegWhseActivityLine."Whse. Document No.");
                            RegWhseActivityLine2.SetRange("Whse. Document Line No.", RegWhseActivityLine."Whse. Document Line No.");
                            RegWhseActivityLine2.SetFilter("Action Type", '%1', RegWhseActivityLine."Action Type");
                            if RegWhseActivityLine2.FindSet() then
                                repeat
                                    PickedQty += RegWhseActivityLine2.Quantity;
                                until RegWhseActivityLine2.Next() = 0;

                            WhseShipmentLine."Qty. Picked" := PickedQty;
                            WhseShipmentLine."Qty. Picked (Base)" := PickedQty;
                            WhseShipmentLine."Qty. to Ship" := 0;
                            WhseShipmentLine."Qty. to Ship (Base)" := 0;
                            WhseShipmentLine."Completely Picked" :=
                          (WhseShipmentLine."Qty. Picked" = WhseShipmentLine.Quantity) or (WhseShipmentLine."Qty. Picked (Base)" = WhseShipmentLine."Qty. (Base)");
                            WhseShipmentLine.Status := WhseShipmentLine.CalcStatusShptLine();
                            WhseShipmentLine.Modify();

                            if WhseShipmentHeader.GET(WhseShipmentLine."No.") then begin
                                WhseShipmentHeader."Document Status" := WhseShipmentHeader.GetDocumentStatus(0);
                                WhseShipmentHeader.Modify();
                            end;
                        end;
                    end;
                end;
            until RegWhseActivityLine.Next() = 0;


            RegWhseActivityLine.Reset();
            RegWhseActivityLine.SetRange("Activity Type", RegWhseActivityHdr.Type);
            RegWhseActivityLine.SetRange("No.", RegWhseActivityHdr."No.");
            if not RegWhseActivityLine.FindFirst() then
                RegWhseActivityHdr.Delete(true);
        end;
    end;



    procedure UndoPickLine(Var RegWhseActivityLine: Record "Registered Whse. Activity Line")
    var
        RegWhseActivityHdr: Record "Registered Whse. Activity Hdr.";
        RegWhseActivityLine2: Record "Registered Whse. Activity Line";
        WhseEntry: Record "Warehouse Entry";
        WhseEntry2: Record "Warehouse Entry";
        WhseShipmentLine: Record "Warehouse Shipment Line";
        WhseShipmentHeader: Record "Warehouse Shipment Header";
        ReservationEntry_lRec: Record "Reservation Entry";
        ReservationEntry2_lRec: Record "Reservation Entry";
        WhseItemTrackingLine: Record "Whse. Item Tracking Line";
        PostedWhseShipmentLine: record "Posted Whse. Shipment Line";
        ActivityType: Enum "Warehouse Activity Type";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ActivityNo: Code[20];
        RevQty: Decimal;
        RevQtyBase: Decimal;
        PickedQty: Decimal;
        EntryNo: Integer;
        i: Integer;
        WhseDocNo: Code[20];
        WhseDocLineNo: Integer;
    begin
        if not Confirm('Are you sure you want to Undo Pick Line?', true) then
            exit;

        WhseEntry2.Reset();
        if WhseEntry2.FindLast() then
            EntryNo := WhseEntry2."Entry No." + 1
        else
            EntryNo := 1;

        if RegWhseActivityLine."Lot No." <> '' then begin
            Clear(RevQty);
            Clear(RevQtyBase);
            Clear(WhseDocNo);
            Clear(WhseDocLineNo);
            Clear(ActivityType);
            Clear(ActivityNo);

            WhseDocNo := RegWhseActivityLine."Whse. Document No.";
            WhseDocLineNo := RegWhseActivityLine."Whse. Document Line No.";
            ActivityType := RegWhseActivityLine."Activity Type";
            ActivityNo := RegWhseActivityLine."No.";


            PostedWhseShipmentLine.Reset();
            PostedWhseShipmentLine.SetRange("Whse. Shipment No.", RegWhseActivityLine."Whse. Document No.");
            PostedWhseShipmentLine.SetRange("Whse Shipment Line No.", RegWhseActivityLine."Whse. Document Line No.");
            PostedWhseShipmentLine.SetRange("Source No.", RegWhseActivityLine."Source No.");
            PostedWhseShipmentLine.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
            PostedWhseShipmentLine.SetRange("Undo Pick Consideration", false);
            if PostedWhseShipmentLine.FindSet() then
                repeat
                    RevQty += PostedWhseShipmentLine.Quantity;
                    RevQtyBase += PostedWhseShipmentLine."Qty. (Base)";
                    PostedWhseShipmentLine."Undo Pick Consideration" := true;
                    PostedWhseShipmentLine.Modify();
                until PostedWhseShipmentLine.Next() = 0;

            WhseEntry.Reset();
            WhseEntry.SetCurrentKey("Entry No.");
            WhseEntry.Ascending(true);
            WhseEntry.SetFilter("Entry No.", '<%1', EntryNo);
            WhseEntry.SetRange("Reference No.", RegWhseActivityLine."No.");
            WhseEntry.SetRange("Source Type", RegWhseActivityLine."Source Type");
            WhseEntry.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
            WhseEntry.SetRange("Source No.", RegWhseActivityLine."Source No.");
            WhseEntry.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
            WhseEntry.SetRange("Source Document", RegWhseActivityLine."Source Document");
            if WhseEntry.FindSet() then
                repeat
                    WhseEntry2.Init();
                    WhseEntry2.TransferFields(WhseEntry);
                    WhseEntry2."Entry No." := EntryNo;

                    if WhseEntry2.Quantity > 0 then begin
                        WhseEntry2.Quantity := (WhseEntry2.Quantity - RevQty) * -1;
                        WhseEntry2."Qty. (Base)" := (WhseEntry2."Qty. (Base)" - RevQtyBase) * -1;
                    end else begin
                        WhseEntry2.Quantity := (WhseEntry2.Quantity + RevQty) * -1;
                        WhseEntry2."Qty. (Base)" := (WhseEntry2."Qty. (Base)" + RevQtyBase) * -1;
                    end;

                    WhseEntry2.Insert(true);
                    EntryNo += 1;
                until WhseEntry.Next() = 0;

            ReservationEntry_lRec.Reset();
            ReservationEntry_lRec.SetRange("Source Type", 37);
            ReservationEntry_lRec.SetRange("Source Subtype", 1);
            ReservationEntry_lRec.SetRange("Source ID", RegWhseActivityLine."Source No.");
            ReservationEntry_lRec.SetRange("Source Ref. No.", RegWhseActivityLine."Source Line No.");
            if ReservationEntry_lRec.FindFirst() then begin
                ReservationEntry2_lRec.Reset();
                ReservationEntry2_lRec.SetRange("Entry No.", ReservationEntry_lRec."Entry No.");
                ReservationEntry2_lRec.SetRange("Reservation Status", ReservationEntry2_lRec."Reservation Status"::Reservation);
                ReservationEntry2_lRec.SetRange("Item No.", ReservationEntry_lRec."Item No.");
                ReservationEntry2_lRec.SetFilter("Source Type", '<>%1', 37);
                if ReservationEntry_lRec.Positive then
                    ReservationEntry2_lRec.SetRange(Positive, false)
                else
                    ReservationEntry2_lRec.SetRange(Positive, true);
                if ReservationEntry2_lRec.FindFirst() then
                    ReservationEntry2_lRec.DeleteAll(true);
                ReservationEntry_lRec.Delete(true);
            end;

            WhseItemTrackingLine.Reset();
            WhseItemTrackingLine.SetRange("Source ID", RegWhseActivityLine."Whse. Document No.");
            WhseItemTrackingLine.SetRange("Source Ref. No.", RegWhseActivityLine."Whse. Document Line No.");
            if WhseItemTrackingLine.FindSet() then
                WhseItemTrackingLine.DeleteAll();

            if RegWhseActivityLine.Quantity <> RevQty then begin
                RegWhseActivityLine.Quantity := RevQty;
                RegWhseActivityLine."Qty. (Base)" := RevQtyBase;

                RegWhseActivityLine2.Reset();
                RegWhseActivityLine2.SetRange("Activity Type", RegWhseActivityLine."Activity Type");
                RegWhseActivityLine2.SetRange("No.", RegWhseActivityLine."No.");
                RegWhseActivityLine2.SetRange("Source Type", RegWhseActivityLine."Source Type");
                RegWhseActivityLine2.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
                RegWhseActivityLine2.SetRange("Source No.", RegWhseActivityLine."Source No.");
                RegWhseActivityLine2.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                RegWhseActivityLine2.SetRange("Whse. Document No.", RegWhseActivityLine."Whse. Document No.");
                RegWhseActivityLine2.SetRange("Whse. Document Line No.", RegWhseActivityLine."Whse. Document Line No.");
                RegWhseActivityLine2.SetFilter("Action Type", '<>%1', RegWhseActivityLine."Action Type");
                if RegWhseActivityLine2.FindSet() then
                    repeat
                        RegWhseActivityLine2.Quantity := RegWhseActivityLine.Quantity;
                        RegWhseActivityLine2."Qty. (Base)" := RegWhseActivityLine."Qty. (Base)";

                        if RegWhseActivityLine2.Quantity <> 0 then begin
                            RegWhseActivityLine2.Modify();
                            RegWhseActivityLine.Modify();
                        end else begin
                            RegWhseActivityLine2.Delete();
                            RegWhseActivityLine.Delete();
                        end;
                    until RegWhseActivityLine2.Next() = 0;
            end else begin

                RegWhseActivityLine2.Reset();
                RegWhseActivityLine2.SetRange("Activity Type", RegWhseActivityLine."Activity Type");
                RegWhseActivityLine2.SetRange("No.", RegWhseActivityLine."No.");
                RegWhseActivityLine2.SetRange("Source Type", RegWhseActivityLine."Source Type");
                RegWhseActivityLine2.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
                RegWhseActivityLine2.SetRange("Source No.", RegWhseActivityLine."Source No.");
                RegWhseActivityLine2.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                RegWhseActivityLine2.SetRange("Whse. Document No.", RegWhseActivityLine."Whse. Document No.");
                RegWhseActivityLine2.SetRange("Whse. Document Line No.", RegWhseActivityLine."Whse. Document Line No.");
                RegWhseActivityLine2.SetFilter("Action Type", '<>%1', RegWhseActivityLine."Action Type");
                if RegWhseActivityLine2.FindSet() then
                    repeat
                        RegWhseActivityLine2.Delete();
                    until RegWhseActivityLine2.Next() = 0;
                RegWhseActivityLine.Delete();
            end;



            if WhseShipmentLine.GET(WhseDocNo, WhseDocLineNo) then begin
                Clear(PickedQty);
                RegWhseActivityLine2.Reset();
                RegWhseActivityLine2.SetRange("Activity Type", RegWhseActivityLine."Activity Type");
                RegWhseActivityLine2.SetRange("Source Type", RegWhseActivityLine."Source Type");
                RegWhseActivityLine2.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
                RegWhseActivityLine2.SetRange("Source No.", RegWhseActivityLine."Source No.");
                RegWhseActivityLine2.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                RegWhseActivityLine2.SetRange("Whse. Document No.", RegWhseActivityLine."Whse. Document No.");
                RegWhseActivityLine2.SetRange("Whse. Document Line No.", RegWhseActivityLine."Whse. Document Line No.");
                RegWhseActivityLine2.SetFilter("Action Type", '%1', RegWhseActivityLine."Action Type");
                if RegWhseActivityLine2.FindSet() then
                    repeat
                        PickedQty += RegWhseActivityLine2.Quantity;
                    until RegWhseActivityLine2.Next() = 0;

                WhseShipmentLine."Qty. Picked" := PickedQty;
                WhseShipmentLine."Qty. Picked (Base)" := PickedQty;
                WhseShipmentLine."Qty. to Ship" := 0;
                WhseShipmentLine."Qty. to Ship (Base)" := 0;
                WhseShipmentLine."Completely Picked" := (WhseShipmentLine."Qty. Picked" = WhseShipmentLine.Quantity) or (WhseShipmentLine."Qty. Picked (Base)" = WhseShipmentLine."Qty. (Base)");
                WhseShipmentLine.Status := WhseShipmentLine.CalcStatusShptLine();
                WhseShipmentLine.Modify();

                if WhseShipmentHeader.GET(WhseShipmentLine."No.") then begin
                    WhseShipmentHeader."Document Status" := WhseShipmentHeader.GetDocumentStatus(0);
                    WhseShipmentHeader.Modify();
                end;
            end;
        end else if RegWhseActivityLine."Serial No." <> '' then begin
            Clear(RevQty);
            Clear(RevQtyBase);
            Clear(WhseDocNo);
            Clear(WhseDocLineNo);
            Clear(ActivityType);
            Clear(ActivityNo);

            WhseDocNo := RegWhseActivityLine."Whse. Document No.";
            WhseDocLineNo := RegWhseActivityLine."Whse. Document Line No.";
            ActivityType := RegWhseActivityLine."Activity Type";
            ActivityNo := RegWhseActivityLine."No.";


            PostedWhseShipmentLine.Reset();
            PostedWhseShipmentLine.SetRange("Whse. Shipment No.", RegWhseActivityLine."Whse. Document No.");
            PostedWhseShipmentLine.SetRange("Whse Shipment Line No.", RegWhseActivityLine."Whse. Document Line No.");
            PostedWhseShipmentLine.SetRange("Source No.", RegWhseActivityLine."Source No.");
            PostedWhseShipmentLine.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
            if PostedWhseShipmentLine.FindSet() then
                repeat
                    ItemLedgerEntry.Reset();
                    ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                    ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
                    ItemLedgerEntry.SetRange("Document No.", PostedWhseShipmentLine."Posted Source No.");
                    ItemLedgerEntry.SetRange("Document Line No.", PostedWhseShipmentLine."Source Line No.");
                    ItemLedgerEntry.SetRange("Serial No.", RegWhseActivityLine."Serial No.");
                    ItemLedgerEntry.SetRange("Undo Pick Consideration", false);
                    if ItemLedgerEntry.FindSet() then
                        repeat
                            RevQty += PostedWhseShipmentLine.Quantity;
                            RevQtyBase += PostedWhseShipmentLine."Qty. (Base)";
                            ItemLedgerEntry."Undo Pick Consideration" := true;
                            ItemLedgerEntry.Modify();
                        until ItemLedgerEntry.Next() = 0;
                until PostedWhseShipmentLine.Next() = 0;


            WhseEntry.Reset();
            WhseEntry.SetCurrentKey("Entry No.");
            WhseEntry.Ascending(true);
            WhseEntry.SetFilter("Entry No.", '<%1', EntryNo);
            WhseEntry.SetRange("Reference No.", RegWhseActivityLine."No.");
            WhseEntry.SetRange("Source Type", RegWhseActivityLine."Source Type");
            WhseEntry.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
            WhseEntry.SetRange("Source No.", RegWhseActivityLine."Source No.");
            WhseEntry.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
            WhseEntry.SetRange("Source Document", RegWhseActivityLine."Source Document");
            WhseEntry.SetRange("Serial No.", RegWhseActivityLine."Serial No.");
            if WhseEntry.FindSet() then
                repeat
                    WhseEntry2.Init();
                    WhseEntry2.TransferFields(WhseEntry);
                    WhseEntry2."Entry No." := EntryNo;

                    if WhseEntry2.Quantity > 0 then begin
                        WhseEntry2.Quantity := (WhseEntry2.Quantity - RevQty) * -1;
                        WhseEntry2."Qty. (Base)" := (WhseEntry2."Qty. (Base)" - RevQtyBase) * -1;
                    end else begin
                        WhseEntry2.Quantity := (WhseEntry2.Quantity + RevQty) * -1;
                        WhseEntry2."Qty. (Base)" := (WhseEntry2."Qty. (Base)" + RevQtyBase) * -1;
                    end;

                    WhseEntry2.Insert(true);
                    EntryNo += 1;
                until WhseEntry.Next() = 0;

            ReservationEntry_lRec.Reset();
            ReservationEntry_lRec.SetRange("Source Type", 37);
            ReservationEntry_lRec.SetRange("Source Subtype", 1);
            ReservationEntry_lRec.SetRange("Source ID", RegWhseActivityLine."Source No.");
            ReservationEntry_lRec.SetRange("Source Ref. No.", RegWhseActivityLine."Source Line No.");
            ReservationEntry_lRec.SetRange("Serial No.", RegWhseActivityLine."Serial No.");
            if ReservationEntry_lRec.FindFirst() then begin
                ReservationEntry2_lRec.Reset();
                ReservationEntry2_lRec.SetRange("Entry No.", ReservationEntry_lRec."Entry No.");
                ReservationEntry2_lRec.SetRange("Reservation Status", ReservationEntry2_lRec."Reservation Status"::Reservation);
                ReservationEntry2_lRec.SetRange("Item No.", ReservationEntry_lRec."Item No.");
                ReservationEntry2_lRec.SetFilter("Source Type", '<>%1', 37);
                ReservationEntry2_lRec.SetRange("Serial No.", ReservationEntry_lRec."Serial No.");
                if ReservationEntry_lRec.Positive then
                    ReservationEntry2_lRec.SetRange(Positive, false)
                else
                    ReservationEntry2_lRec.SetRange(Positive, true);
                if ReservationEntry2_lRec.FindFirst() then
                    ReservationEntry2_lRec.DeleteAll(true);
                ReservationEntry_lRec.Delete(true);
            end;

            WhseItemTrackingLine.Reset();
            WhseItemTrackingLine.SetRange("Source ID", RegWhseActivityLine."Whse. Document No.");
            WhseItemTrackingLine.SetRange("Source Ref. No.", RegWhseActivityLine."Whse. Document Line No.");
            WhseItemTrackingLine.SetRange("Serial No.", RegWhseActivityLine."Serial No.");
            if WhseItemTrackingLine.FindSet() then
                WhseItemTrackingLine.DeleteAll();

            if RegWhseActivityLine.Quantity <> RevQty then begin
                RegWhseActivityLine.Quantity := RevQty;
                RegWhseActivityLine."Qty. (Base)" := RevQtyBase;

                RegWhseActivityLine2.Reset();
                RegWhseActivityLine2.SetRange("Activity Type", RegWhseActivityLine."Activity Type");
                RegWhseActivityLine2.SetRange("No.", RegWhseActivityLine."No.");
                RegWhseActivityLine2.SetRange("Source Type", RegWhseActivityLine."Source Type");
                RegWhseActivityLine2.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
                RegWhseActivityLine2.SetRange("Source No.", RegWhseActivityLine."Source No.");
                RegWhseActivityLine2.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                RegWhseActivityLine2.SetRange("Whse. Document No.", RegWhseActivityLine."Whse. Document No.");
                RegWhseActivityLine2.SetRange("Whse. Document Line No.", RegWhseActivityLine."Whse. Document Line No.");
                RegWhseActivityLine2.SetFilter("Action Type", '<>%1', RegWhseActivityLine."Action Type");
                RegWhseActivityLine2.SetRange("Serial No.", RegWhseActivityLine."Serial No.");
                if RegWhseActivityLine2.FindSet() then
                    repeat
                        RegWhseActivityLine2.Quantity := RegWhseActivityLine.Quantity;
                        RegWhseActivityLine2."Qty. (Base)" := RegWhseActivityLine."Qty. (Base)";

                        if RegWhseActivityLine2.Quantity <> 0 then begin
                            RegWhseActivityLine2.Modify();
                            RegWhseActivityLine.Modify();
                        end else begin
                            RegWhseActivityLine2.Delete();
                            RegWhseActivityLine.Delete();
                        end;
                    until RegWhseActivityLine2.Next() = 0;
            end else begin

                RegWhseActivityLine2.Reset();
                RegWhseActivityLine2.SetRange("Activity Type", RegWhseActivityLine."Activity Type");
                RegWhseActivityLine2.SetRange("No.", RegWhseActivityLine."No.");
                RegWhseActivityLine2.SetRange("Source Type", RegWhseActivityLine."Source Type");
                RegWhseActivityLine2.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
                RegWhseActivityLine2.SetRange("Source No.", RegWhseActivityLine."Source No.");
                RegWhseActivityLine2.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                RegWhseActivityLine2.SetRange("Whse. Document No.", RegWhseActivityLine."Whse. Document No.");
                RegWhseActivityLine2.SetRange("Whse. Document Line No.", RegWhseActivityLine."Whse. Document Line No.");
                RegWhseActivityLine2.SetFilter("Action Type", '<>%1', RegWhseActivityLine."Action Type");
                RegWhseActivityLine2.SetRange("Serial No.", RegWhseActivityLine."Serial No.");
                if RegWhseActivityLine2.FindSet() then
                    repeat
                        RegWhseActivityLine2.Delete();
                    until RegWhseActivityLine2.Next() = 0;
                RegWhseActivityLine.Delete();
            end;



            if WhseShipmentLine.GET(WhseDocNo, WhseDocLineNo) then begin
                Clear(PickedQty);
                RegWhseActivityLine2.Reset();
                RegWhseActivityLine2.SetRange("Activity Type", RegWhseActivityLine."Activity Type");
                RegWhseActivityLine2.SetRange("Source Type", RegWhseActivityLine."Source Type");
                RegWhseActivityLine2.SetRange("Source Subtype", RegWhseActivityLine."Source Subtype");
                RegWhseActivityLine2.SetRange("Source No.", RegWhseActivityLine."Source No.");
                RegWhseActivityLine2.SetRange("Source Line No.", RegWhseActivityLine."Source Line No.");
                RegWhseActivityLine2.SetRange("Whse. Document No.", RegWhseActivityLine."Whse. Document No.");
                RegWhseActivityLine2.SetRange("Whse. Document Line No.", RegWhseActivityLine."Whse. Document Line No.");
                RegWhseActivityLine2.SetFilter("Action Type", '%1', RegWhseActivityLine."Action Type");
                if RegWhseActivityLine2.FindSet() then
                    repeat
                        PickedQty += RegWhseActivityLine2.Quantity;
                    until RegWhseActivityLine2.Next() = 0;

                WhseShipmentLine."Qty. Picked" := PickedQty;
                WhseShipmentLine."Qty. Picked (Base)" := PickedQty;
                WhseShipmentLine."Qty. to Ship" := 0;
                WhseShipmentLine."Qty. to Ship (Base)" := 0;
                WhseShipmentLine."Completely Picked" := (WhseShipmentLine."Qty. Picked" = WhseShipmentLine.Quantity) or (WhseShipmentLine."Qty. Picked (Base)" = WhseShipmentLine."Qty. (Base)");
                WhseShipmentLine.Status := WhseShipmentLine.CalcStatusShptLine();
                WhseShipmentLine.Modify();

                if WhseShipmentHeader.GET(WhseShipmentLine."No.") then begin
                    WhseShipmentHeader."Document Status" := WhseShipmentHeader.GetDocumentStatus(0);
                    WhseShipmentHeader.Modify();
                end;
            end;
        end;

        RegWhseActivityLine2.Reset();
        RegWhseActivityLine2.SetRange("Activity Type", ActivityType);
        RegWhseActivityLine2.SetRange("No.", ActivityNo);
        if not RegWhseActivityLine2.FindFirst() then begin
            RegWhseActivityHdr.Get(ActivityType, ActivityNo);
            RegWhseActivityHdr.Delete(true);
        end;
    end;


    /*
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
        local procedure CheckSalesPostingRestrictions(var SalesHeader: Record "Sales Header")
        var
            SalesLine_lRec: Record "Sales Line";
            Text33029735Lbl: Label 'You cannot ship Quantity in  Sales Short Closed Line \Document Type = "%1", Document No.="%2", Line No.="%3".', Comment = '%1=Document Type,%2=Document No.,%3=Line No.';
            Text33029736Lbl: Label 'You cannot ship Quantity in  Sales Short Closed Line \Document Type = "%1", Document No.="%2", Line No.="%3".', Comment = '%1=Document Type,%2=Document No.,%3=Line No.';
        begin
            IF SalesHeader.Ship THEN begin
                SalesHeader.TestField("Sales Short Closed", false);

                SalesLine_lRec.RESET();
                SalesLine_lRec.SETRANGE("Document Type", SalesHeader."Document Type");
                SalesLine_lRec.SETRANGE("Document No.", SalesHeader."No.");
                SalesLine_lRec.SETFILTER(Quantity, '<>0');
                IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
                    SalesLine_lRec.SETFILTER("Qty. to Ship", '<>0');
                SalesLine_lRec.SETRANGE("Shipment No.", '');
                IF SalesLine_lRec.FindSet() THEN
                    repeat
                        IF SalesLine_lRec."Applied Sales Short Close" then
                            ERROR(Text33029735Lbl, SalesLine_lRec."Document Type", SalesLine_lRec."Document No.", SalesLine_lRec."Line No.");
                        IF SalesLine_lRec."Sales Short Close Line" then
                            ERROR(Text33029736Lbl, SalesLine_lRec."Document Type", SalesLine_lRec."Document No.", SalesLine_lRec."Line No.");
                    UNTil SalesLine_lRec.Next() = 0;
            end;
        end;
    */


    //T12084-NS 27-06-2024
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateQuantityOnBeforeDropShptCheck', '', false, false)]
    local procedure "Purchase Line_OnValidateQuantityOnBeforeDropShptCheck"(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    begin
        if (PurchaseLine."Drop Shipment") and (PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Invoice) then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reservation Management", 'OnBeforeCheckQuantityIsCompletelyReleased', '', false, false)]
    local procedure "Reservation Management_OnBeforeCheckQuantityIsCompletelyReleased"(ItemTrackingHandling: Option; QtyToRelease: Decimal; DeleteAll: Boolean; CurrentItemTrackingSetup: Record "Item Tracking Setup" temporary; ReservEntry: Record "Reservation Entry"; var IsHandled: Boolean)
    var
        ItemTrackingHandling_lOpt: Option "None","Allow deletion",Match;
    begin
        ItemTrackingHandling_lOpt := ItemTrackingHandling;

        if ItemTrackingHandling_lOpt = ItemTrackingHandling_lOpt::None then
            if not ((ReservEntry."Source Type" = Database::"Item Journal Line") and (ReservEntry."Source Subtype" = 6)) then begin
                if (ReservEntry."Source Type" = 37) and (ReservEntry."Source Subtype" = 1) then
                    IsHandled := true;
                if (ReservEntry."Source Type" = 39) and (ReservEntry."Source Subtype" = 1) then
                    IsHandled := true;
                if (ReservEntry."Source Type" = 5741) and (ReservEntry."Source Subtype" = 0) then
                    IsHandled := true;

                if (ReservEntry."Source Type" = 5741) and (ReservEntry."Source Subtype" = 1) then
                    IsHandled := true;
            end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCheckAssocPurchOrder', '', false, false)]
    local procedure "Sales Line_OnBeforeCheckAssocPurchOrder"(var SalesLine: Record "Sales Line"; TheFieldCaption: Text[250]; var IsHandled: Boolean; xSalesLine: Record "Sales Line")
    begin
        //if SalesLine."Special Order Purch. Line No." <> 0 then
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateQuantityOnBeforeSalesLineVerifyChange', '', false, false)]
    local procedure "Sales Line_OnValidateQuantityOnBeforeSalesLineVerifyChange"(var SalesLine: Record "Sales Line"; StatusCheckSuspended: Boolean; var IsHandled: Boolean)
    begin
        if ShortClose then
            Ishandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Shipment Line", 'OnDeleteOnBeforeConfirmDelete', '', false, false)]
    local procedure "Warehouse Shipment Line_OnDeleteOnBeforeConfirmDelete"(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; var IsHandled: Boolean)
    begin
        Ishandled := true;
    end;



    var
        ActivityType: enum "Warehouse Activity Type";
        ShortClose: Boolean;


    //T12084-NE 27-06-2024


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Validate Source Line", 'OnBeforeVerifyFieldNotChanged', '', false, false)]
    local procedure "Whse. Validate Source Line_OnBeforeVerifyFieldNotChanged"(NewRecRef: RecordRef; OldRecRef: RecordRef; FieldNumber: Integer; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    //T50307-NS
    procedure SetApprovalReqLine_gFnc(var SalesLine_vRec: Record "Sales Line"; ConfMsgReq: Boolean)
    var
        ShortCloseSetup: Record "Short Close Setup";
        SalesHeader_lRec: Record "Sales Header";
        ShortCloseReason_lRpt: Report "Short Close Reason RP";
        IsReportRun_lBln: Boolean;
        SelectedShrtClsReason_lCod: Code[20];
        WarehouseShipmentLine_lRec: Record "Warehouse Shipment Line";
        SalesLine_lRec: Record "Sales Line";
        Text33029735_Lbl: Label 'Sales Line with Type = ''%1'' cannot be Short Closed.', Comment = '%1=Type';
        Text33029736_Lbl: Label 'Do you want to Shortclose Sales Line for Item No. = ''%1'' Line No. = ''%2'' ?', Comment = '%1=Item No.';
        Text33029737_Lbl: Label 'There is no "Outstanding Quantity" for %1 = ''%2''.', Comment = '%1=Item No.';
        Text007lLbl: Label 'Qty. Picked = %1 is greater than Qty. Shipped = %2. If you delete the Warehouse Shipment Line, the items will remain in the shipping area until you put them away.\Related Item Tracking information defined during pick will be deleted.\Do you still want to delete the Warehouse Shipment Line?';
        SkipShortClose: Boolean;
    begin
        ShortCloseSetup.GET();
        ShortCloseSetup.TESTFIELD("Allow Sales Short Close", TRUE);
        //IF NOT (SalesLine_vRec.Type = SalesLine_vRec.Type::Item) THEN //Hypercare 27022025
        if (SalesLine_vRec.Type = SalesLine_vRec.Type::" ") THEN //Hypercare 27022025
            ERROR(Text33029735_Lbl, SalesLine_vRec.Type, SalesLine_vRec.Type);

        IF not CONFIRM(STRSUBSTNO(Text33029736_Lbl, SalesLine_vRec."No.", SalesLine_vRec."Line No."), true) THEN exit;

        IF SalesLine_vRec."Outstanding Quantity" = 0 THEN
            ERROR(Text33029737_Lbl, SalesLine_vRec."No.");

        ShortClose := true;

        SalesHeader_lRec.GET(SalesLine_vRec."Document Type", SalesLine_vRec."Document No.");
        //SalesHeader_lRec.TESTFIELD(Status, SalesHeader_lRec.Status::Open);

        SalesLine_vRec.TESTFIELD(SalesLine_vRec."Short Close Boolean", FALSE);

        Clear(ShortCloseReason_lRpt);
        ShortCloseReason_lRpt.RunModal();
        IsReportRun_lBln := ShortCloseReason_lRpt.IsReportRun();

        SelectedShrtClsReason_lCod := ShortCloseReason_lRpt.GetReasonCode_gFnc();
        if SelectedShrtClsReason_lCod = '' then
            Error(SHortClsRsnLabel_gLbl);

        if not IsReportRun_lBln then
            exit;

        SkipShortClose := false;
        WarehouseShipNo_gCod := '';
        WarehouseShipmentLine_lRec.Reset();
        WarehouseShipmentLine_lRec.SetRange("Source Document", WarehouseShipmentLine_lRec."Source Document"::"Sales Order");
        WarehouseShipmentLine_lRec.SetRange("Source Type", 37);
        WarehouseShipmentLine_lRec.SetRange("Source Subtype", 1);
        WarehouseShipmentLine_lRec.SetRange("Source No.", SalesLine_vRec."Document No.");
        WarehouseShipmentLine_lRec.SetRange("Source Line No.", SalesLine_vRec."Line No.");
        IF WarehouseShipmentLine_lRec.FindFirst() then
            repeat
                if not SkipShortClose then
                    if WarehouseShipmentLine_lRec."Qty. Shipped" < WarehouseShipmentLine_lRec."Qty. Picked" then
                        if not Confirm(Text007lLbl, true, WarehouseShipmentLine_lRec."Qty. Picked", WarehouseShipmentLine_lRec."Qty. Shipped") then
                            SkipShortClose := true;
            until WarehouseShipmentLine_lRec.Next() = 0;

        if not SkipShortClose then begin
            SalesLine_vRec."Short Close Reason" := SelectedShrtClsReason_lCod;
            SalesLine_vRec."Short Close Approval Required" := true;
            SalesLine_vRec.MODIFY();

            //Header Short Close
            SalesLine_lRec.RESET();
            SalesLine_lRec.SETRANGE("Document Type", SalesHeader_lRec."Document Type");
            SalesLine_lRec.SETRANGE("Document No.", SalesHeader_lRec."No.");
            SalesLine_lRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
            IF Not SalesLine_lRec.FindFirst() THEN begin
                SalesHeader_lRec.validate("Short Close Reason", SelectedShrtClsReason_lCod);
                SalesHeader_lRec."Short Close Approval Required" := true;
                SalesHeader_lRec.Modify(true);
            end;
        end;
    end;

    procedure SetApprovalReqSalesDocument_gFnc(SalesHeader_iRec: Record "Sales Header")
    var
        SalesHeader_lRec: Record "Sales Header";
        SalesLine_lRec: Record "Sales Line";
        ShortCloseFun_lCdu: Codeunit "Short Close Functionality";
        ShortCloseSetup: Record "Short Close Setup";
        ShortCloseReason_lRpt: Report "Short Close Reason RP";
        IsReportRun_lBln: Boolean;
        SelectedShrtClsReason_lCod: Code[20];
        SLQty_lDec: Decimal;
        SLOutSndQty_lDec: Decimal;
        SLFinalQty_lDec: Decimal;
        BinCode: Code[20];
        UnitPrice: Decimal;
        ///MBOSOImp_lRec: Record "MBO PO Import";
        SalesLnDelete_lRec: Record "Sales Line";
        WarehouseShipmentLine_lRec: Record "Warehouse Shipment Line";
        WarhouActivityLine_lRec: Record "Warehouse Activity Line";
        Text33029350_Lbl: Label 'Do you want to ShortClose Sales Order %1?', Comment = '%1=SO';
        Text33029351_Lbl: Label 'Sales Order %1 Short Closed successfully.\Document has been moved to Short Closed Document List.', Comment = '%1=SO';
        Text33029737_Lbl: Label 'There is no "Outstanding Quantity" for Item No. = ''%1''.', Comment = '%1=Item No.';
        IsShortClose_lBln: Boolean;
        Text33029353_Lbl: Label 'There is not any outstanding Qty is available.Sales Order %1 is not Short Closed.';
        Text007lLbl: Label 'Qty. Picked = %1 is greater than Qty. Shipped = %2. If you delete the Warehouse Shipment Line, the items will remain in the shipping area until you put them away.\Related Item Tracking information defined during pick will be deleted.\Do you still want to delete the Warehouse Shipment Line?';
        ReservationEntry_lRec: Record "Reservation Entry";
        ReservationEntry2_lRec: Record "Reservation Entry";
        PurchaseLine: Record "Purchase Line";
        SkipShortClose: Boolean;
    begin
        ShortCloseSetup.GET();
        ShortCloseSetup.TESTFIELD("Allow Sales Short Close", TRUE);

        SalesHeader_lRec.GET(SalesHeader_iRec."Document Type", SalesHeader_iRec."No.");
        SalesHeader_lRec.TESTFIELD("Short Close Boolean", FALSE);
        //SalesHeader_lRec.TESTFIELD(Status, SalesHeader_lRec.Status::Open);

        IF CONFIRM(STRSUBSTNO(Text33029350_Lbl, SalesHeader_lRec."No."), true) THEN begin

            ShortClose := true;

            Clear(ShortCloseReason_lRpt);
            ShortCloseReason_lRpt.RunModal();
            IsReportRun_lBln := ShortCloseReason_lRpt.IsReportRun();

            SelectedShrtClsReason_lCod := ShortCloseReason_lRpt.GetReasonCode_gFnc();
            if SelectedShrtClsReason_lCod = '' then
                Error(SHortClsRsnLabel_gLbl);

            if not IsReportRun_lBln then
                exit;

            SalesLine_lRec.RESET();
            SalesLine_lRec.SETRANGE("Document Type", SalesHeader_lRec."Document Type");
            SalesLine_lRec.SETRANGE("Document No.", SalesHeader_lRec."No.");
            // SalesLine_lRec.SETRANGE(Type, SalesLine_lRec.Type::Item);//Hypercare 27022025
            SalesLine_lRec.SETFILTER(Type, '<>%1', SalesLine_lRec.Type::" "); //Hypercare 27022025
            SalesLine_lRec.SETRANGE("Short Close Boolean", FALSE);
            SalesLine_lRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
            IF not SalesLine_lRec.FINDSET() THEN
                Error(Text33029353_Lbl, SalesHeader_lRec."No.");
            // end; ////Hypercare 27022025;

            SalesLine_lRec.RESET();
            SalesLine_lRec.SETRANGE("Document Type", SalesHeader_lRec."Document Type");
            SalesLine_lRec.SETRANGE("Document No.", SalesHeader_lRec."No.");
            // SalesLine_lRec.SETRANGE(Type, SalesLine_lRec.Type::Item);//Hypercare 27022025
            SalesLine_lRec.SETFILTER(Type, '<>%1', SalesLine_lRec.Type::" ");//Hypercare 27022025
            SalesLine_lRec.SETRANGE("Short Close Boolean", FALSE);
            SalesLine_lRec.SETFILTER("Outstanding Quantity", '<>%1', 0);
            IF SalesLine_lRec.FINDSET(TRUE, TRUE) THEN
                REPEAT
                    WarehouseShipNo_gCod := '';
                    WarehouseShipmentLine_lRec.Reset();
                    WarehouseShipmentLine_lRec.SetRange("Source Document", WarehouseShipmentLine_lRec."Source Document"::"Sales Order");
                    WarehouseShipmentLine_lRec.SetRange("Source Type", 37);
                    WarehouseShipmentLine_lRec.SetRange("Source Subtype", 1);
                    WarehouseShipmentLine_lRec.SetRange("Source No.", SalesLine_lRec."Document No.");
                    WarehouseShipmentLine_lRec.SetRange("Source Line No.", SalesLine_lRec."Line No.");
                    if WarehouseShipmentLine_lRec.FindSet() then
                        repeat
                            if not SkipShortClose then
                                if WarehouseShipmentLine_lRec."Qty. Shipped" < WarehouseShipmentLine_lRec."Qty. Picked" then
                                    if not Confirm(Text007lLbl, true, WarehouseShipmentLine_lRec."Qty. Picked", WarehouseShipmentLine_lRec."Qty. Shipped") then
                                        SkipShortClose := true;
                        until WarehouseShipmentLine_lRec.Next() = 0;

                    if not SkipShortClose then begin
                        SalesLine_lRec."Short Close Approval Required" := true;
                        SalesLine_lRec.validate("Short Close Reason", SelectedShrtClsReason_lCod);
                        SalesLine_lRec.Modify(true);
                    end;
                UNTIL SalesLine_lRec.NEXT() = 0;

            if SkipShortClose then
                exit;

            SalesHeader_lRec.GET(SalesHeader_iRec."Document Type", SalesHeader_iRec."No.");
            SalesHeader_lRec.validate("Short Close Reason", SelectedShrtClsReason_lCod);
            SalesHeader_lRec."Short Close Approval Required" := true;
            SalesHeader_lRec.Modify(true);

            MESSAGE(StrSubstNo('Approval will be required for Order %1', SalesHeader_lRec."No."));
        end;
    end;
    //T50307-NE
}
