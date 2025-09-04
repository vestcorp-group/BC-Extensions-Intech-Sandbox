report 79647 "Auto Short Close SO_PO"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Description = 'T12084';
    Caption = 'Auto Short Close Sales/Purchase Order';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {

            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order), "Short Close Boolean" = const(false), Status = filter(Open | Released));
            RequestFilterHeading = 'Sales Order';
            RequestFilterFields = "No.", "Sell-to Customer No.";
            trigger OnPreDataItem()
            begin
                if Not SalesOrders_gBln then
                    CurrReport.Break();

                TotalSortClose_gInt := 0;

                if DateCalc_gDate <> 0D then begin
                    "Sales Header".SetRange("Order Date", 0D, DateCalc_gDate);
                    // "Sales Header".SetRange("Order Date", DateCalc_gDate, Today);
                end;

                SOCnt_gInt := 0;

                if GuiAllowed then begin
                    Windows_gDlg.Open(Text000 + Text001 + Text002);
                    Windows_gDlg.Update(1, Count);
                end;
            end;

            trigger OnAfterGetRecord()
            var
                ReleaseSalesDoc: Codeunit "Release Sales Document";
            begin
                SOCnt_gInt += 1;
                if GuiAllowed then begin
                    Windows_gDlg.Update(2, SOCnt_gInt);
                end;

                if "Sales Header".Status = "Sales Header".Status::Released then begin
                    Clear(SalesHeader_gRec);
                    SalesHeader_gRec.get("Sales Header"."Document Type", "Sales Header"."No.");
                    ReleaseSalesDoc.PerformManualReopen(SalesHeader_gRec);
                    Commit();
                end;


                ForeCLoseSalesDocument("Sales Header");

            end;

            trigger OnPostDataItem()
            begin
                if GuiAllowed then begin
                    if SalesOrders_gBln then begin
                        Windows_gDlg.Close();
                        // Message('Total %1 Sales Orders Short closed.', TotalSortClose_gInt);
                    end;
                end;
            end;
        }
        dataitem("Purchase Header"; "Purchase Header")
        {

            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order), "Short Close Boolean" = const(false), Status = filter(Open | Released));
            RequestFilterHeading = 'Purchase Order';
            RequestFilterFields = "No.", "Buy-from Vendor No.";

            trigger OnPreDataItem()
            begin
                if Not PurchaseOrders_gBln then
                    CurrReport.Break();

                TotalSortClose_gInt := 0;

                if DateCalc_gDate <> 0D then begin
                    "Purchase Header".SetRange("Order Date", 0D, DateCalc_gDate);
                    // "Purchase Header".SetRange("Order Date", DateCalc_gDate, Today);
                end;

                POCnt_gInt := 0;

                if GuiAllowed then begin
                    Windows_gDlg.Open(Text000 + Text001 + Text002);
                    Windows_gDlg.Update(1, Count);
                end;
            end;

            trigger OnAfterGetRecord()
            var
                ReleasePurchDoc: Codeunit "Release Purchase Document";
            begin
                POCnt_gInt += 1;
                if GuiAllowed then begin
                    Windows_gDlg.Update(2, POCnt_gInt);
                end;

                if "Purchase Header".Status = "Purchase Header".Status::Released then begin
                    Clear(PurchaseHeader_gRec);
                    PurchaseHeader_gRec.get("Purchase Header"."Document Type", "Purchase Header"."No.");
                    ReleasePurchDoc.PerformManualReopen(PurchaseHeader_gRec);
                    Commit();
                end;

                ForeCLosePurchaseDocument("Purchase Header");

            end;

            trigger OnPostDataItem()
            begin
                if GuiAllowed then begin
                    if PurchaseOrders_gBln then begin
                        Windows_gDlg.Close();
                        // Message('Total %1 Purchase Orders Short closed.', TotalSortClose_gInt);
                    end;
                end;
            end;
        }



    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {

                    ShowCaption = true;
                    field(LastNoofDays_gDF; LastNoofDays_gDF)
                    {
                        ApplicationArea = All;
                        Caption = 'Short Close Before No. of Days';

                    }
                    field(ShortCloseReason_gCod; ShortCloseReason_gCod)
                    {
                        ApplicationArea = All;
                        Caption = 'Short Close Reason';
                        TableRelation = "Short Close Reason".Code;

                    }
                    field(SalesOrders_gBln; SalesOrders_gBln)
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Orders';

                    }
                    field(PurchaseOrders_gBln; PurchaseOrders_gBln)
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase Orders';

                    }


                }
            }
        }
    }
    // actions
    // {
    //     area(processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;

    //         }
    //     }
    // }

    trigger OnPreReport()
    begin

        if ShortCloseReason_gCod = '' then
            Error(SHortClsRsnLabel_gLbl);

        if (Not SalesOrders_gBln) and (Not PurchaseOrders_gBln) then
            Error(FilterError_gLbl);

        if Format(LastNoofDays_gDF) <> '' then begin
            if StrPos(format(LastNoofDays_gDF), '-') = 0 then
                Evaluate(LastNoofDays_gDF, '-' + format(LastNoofDays_gDF));

            DateCalc_gDate := CalcDate(LastNoofDays_gDF, Today);

        end;
    end;


    var
        LastNoofDays_gDF: DateFormula;
        ShortCloseReason_gCod: Code[20];
        SalesOrders_gBln: Boolean;
        PurchaseOrders_gBln: Boolean;
        DateCalc_gDate: date;
        Windows_gDlg: Dialog;
        SOCnt_gInt: Integer;
        POCnt_gInt: Integer;
        Text000: label 'Processing.....\';
        Text001: label 'Total Recerd #1###################\';
        Text002: label 'Curr Record #2####################\';
        SHortClsRsnLabel_gLbl: Label 'Short Close Reason cannot be blank. Please select Short Close Reason.';
        FilterError_gLbl: Label 'Either Sales order or Purchase Order filter is mandatory.';
        WarehouseShipNo_gCod: Code[20];
        WarehouseReceptNo_gCod: Code[20];
        WarehouseActivityNo_gCod: Code[20];
        TotalSortClose_gInt: Integer;
        SalesHeader_gRec: Record "Sales Header";
        PurchaseHeader_gRec: Record "Purchase Header";

    procedure ForeCLoseSalesDocument(SalesHeader_iRec: Record "Sales Header");
    var
        SalesHeader_lRec: Record "Sales Header";
        SalesLine_lRec: Record "Sales Line";
        ShortCloseFun_lCdu: Codeunit "Short Close Functionality";
        ShortCloseSetup: Record "Short Close Setup";
        SLQty_lDec: Decimal;
        SLOutSndQty_lDec: Decimal;
        SLFinalQty_lDec: Decimal;
        BinCode: Code[20];
        UnitPrice: Decimal;
        SalesLnDelete_lRec: Record "Sales Line";
        //MBOSOImp_lRec: Record "MBO PO Import";
        WarehouseShipmentLine_lRec: Record "Warehouse Shipment Line";
        WarhouActivityLine_lRec: Record "Warehouse Activity Line";
        IsShortClose_lBln: Boolean;
        Text33029350_Lbl: Label 'Do you want to ShortClose Sales Order %1?', Comment = '%1=SO';
        Text33029351_Lbl: Label 'Sales Order %1 Short Closed successfully.\Document has been moved to Short Closed Document List.', Comment = '%1=SO';
        Text33029737_Lbl: Label 'There is no "Outstanding Quantity" for Item No. = ''%1''.', Comment = '%1=Item No.';
        Text007lLbl: Label 'Qty. Picked = %1 is greater than Qty. Shipped = %2. If you delete the Warehouse Shipment Line, the items will remain in the shipping area until you put them away.\Related Item Tracking information defined during pick will be deleted.\Do you still want to delete the Warehouse Shipment Line?';
        ReservationEntry_lRec: Record "Reservation Entry";
        ReservationEntry2_lRec: Record "Reservation Entry";
        PurchaseLine: Record "Purchase Line";
        RegisteredWhseActivityLine: Record "Registered Whse. Activity Line";
        SkipShortClose: Boolean;
    begin
        ShortCloseSetup.GET();
        ShortCloseSetup.TESTFIELD("Allow Sales Short Close", TRUE);

        SalesHeader_lRec.GET(SalesHeader_iRec."Document Type", SalesHeader_iRec."No.");
        SalesHeader_lRec.TESTFIELD("Short Close Boolean", FALSE);
        SalesHeader_lRec.TESTFIELD(Status, SalesHeader_lRec.Status::Open);

        IsShortClose_lBln := false;

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

                ///Inventory Pick
                WarehouseActivityNo_gCod := '';
                WarhouActivityLine_lRec.Reset();
                WarhouActivityLine_lRec.Setfilter("Activity Type", '%1|%2', WarhouActivityLine_lRec."Activity Type"::"Invt. Pick", WarhouActivityLine_lRec."Activity Type"::Pick);
                WarhouActivityLine_lRec.SetRange("Source Document", WarhouActivityLine_lRec."Source Document"::"Sales Order");
                WarhouActivityLine_lRec.SetRange("Source Type", 37);
                WarhouActivityLine_lRec.SetRange("Source Subtype", 1);
                WarhouActivityLine_lRec.SetRange("Source No.", SalesLine_lRec."Document No.");
                WarhouActivityLine_lRec.SetRange("Source Line No.", SalesLine_lRec."Line No.");
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
                // RegisteredWhseActivityLine.Setrange("Source Document", RegisteredWhseActivityLine."Source Document"::"Sales Order");
                // RegisteredWhseActivityLine.SetRange("Source Type", 37);
                // RegisteredWhseActivityLine.SetRange("Source Subtype", 1);
                // RegisteredWhseActivityLine.SetRange("Source No.", SalesLine_lRec."Document No.");
                // RegisteredWhseActivityLine.SetRange("Source Line No.", SalesLine_lRec."Line No.");
                // IF RegisteredWhseActivityLine.FindSet() then
                //     Error('Registered Pick already exist for Document %1 Line No. %2', SalesLine_lRec."Document No.", SalesLine_lRec."Line No.");

                SalesLine_lRec.Validate(Quantity, SLFinalQty_lDec);
                SalesLine_lRec.Validate("Completely Shipped", True);

                SalesLine_lRec.Validate("Special Order", false);
                SalesLine_lRec.Validate("Special Order Purchase No.", '');
                SalesLine_lRec.Validate("Special Order Purch. Line No.", 0);
                SalesLine_lRec.Validate("Purchasing Code", '');
                SalesLine_lRec.Validate("Purchase Order No.", '');
                SalesLine_lRec.Validate("Purch. Order Line No.", 0);
                SalesLine_lRec."Drop Shipment" := false;
                SalesLine_lRec.Validate("Special Order", false);

                // SalesLine_lRec.Validate("Bin Code", BinCode);
                // SalesLine_lRec.Validate("Unit Price", UnitPrice);

                SalesLine_lRec.validate("Short Close Reason", ShortCloseReason_gCod);
                SalesLine_lRec."Short Close Boolean" := true;
                SalesLine_lRec.MODIFY();

                IsShortClose_lBln := true;

                PurchaseLine.Reset();
                PurchaseLine.SetRange("Sales Order No.", SalesLine_lRec."Document No.");
                PurchaseLine.SetRange("Sales Order Line No.", SalesLine_lRec."Line No.");
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
            UNTIL SalesLine_lRec.NEXT() = 0;

        if IsShortClose_lBln then begin
            SalesHeader_lRec.validate("Short Close Reason", ShortCloseReason_gCod);
            SalesHeader_lRec."Short Close Boolean" := true;

            SalesHeader_lRec.Modify(true);

            // //Delete MBO PO
            // SalesLnDelete_lRec.Reset();
            // SalesLnDelete_lRec.SetRange("Document Type", SalesHeader_lRec."Document Type");
            // SalesLnDelete_lRec.SetRange("Document No.", SalesHeader_lRec."No.");
            // SalesLnDelete_lRec.SetFilter("Import PO Line No.", '<>%1', 0);
            // if SalesLnDelete_lRec.FindSet() then begin
            //     repeat
            //         Clear(MBOSOImp_lRec);
            //         MBOSOImp_lRec.Get(SalesLnDelete_lRec."Import PO Line No.");
            //         MBOSOImp_lRec.Delete();
            //     until SalesLnDelete_lRec.Next() = 0;
            // end;

            TotalSortClose_gInt += 1;
        end;
    end;

    procedure ForeCLosePurchaseDocument(PurchaseHeader_iRec: Record "Purchase Header");
    var
        PurchaseHeader_lRec: Record "Purchase Header";
        PurchaseLine_lRec: Record "Purchase Line";
        ShortCloseFun_lCdu: Codeunit "Short Close Functionality";
        ShortCloseSetup: Record "Short Close Setup";
        PLQty_lDec: Decimal;
        PLOutSndQty_lDec: Decimal;
        PLFinalQty_lDec: Decimal;
        BinCode: Code[20];
        UnitPrice: Decimal;
        IsShortClose_lBln: Boolean;
        WarehouseReceiptLine_lRec: Record "Warehouse Receipt Line";
        WarhouActivityLine_lRec: Record "Warehouse Activity Line";
        Text33029350_Lbl: Label 'Do you want to ShortClose Purchase Order %1?', Comment = '%1=SO';
        Text33029351_Lbl: Label 'Purchase Order %1 Short Closed successfully.\Document has been moved to Short Closed Document List.', Comment = '%1=SO';
        Text33029737_Lbl: Label 'There is no "Outstanding Quantity" for Item No. = ''%1''.', Comment = '%1=Item No.';
        ReservationEntry_lRec: Record "Reservation Entry";
        ReservationEntry2_lRec: Record "Reservation Entry";
        SalesLine: Record "Sales Line";
        RegisteredWhseActivityLine: Record "Registered Whse. Activity Line";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
    begin
        ShortCloseSetup.GET();
        ShortCloseSetup.TESTFIELD("Allow Purchase Short Close", TRUE);

        PurchaseHeader_lRec.GET(PurchaseHeader_iRec."Document Type", PurchaseHeader_iRec."No.");
        PurchaseHeader_lRec.TESTFIELD("Short Close Boolean", FALSE);
        PurchaseHeader_lRec.TESTFIELD(Status, PurchaseHeader_lRec.Status::Open);

        IsShortClose_lBln := false;

        PurchaseLine_lRec.RESET();
        PurchaseLine_lRec.SETRANGE("Document Type", PurchaseHeader_lRec."Document Type");
        PurchaseLine_lRec.SETRANGE("Document No.", PurchaseHeader_lRec."No.");
        PurchaseLine_lRec.SETRANGE(Type, PurchaseLine_lRec.Type::Item);//Hypercare 27022025
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
                WarhouActivityLine_lRec.SetFilter("Activity Type", '%1|%2', WarhouActivityLine_lRec."Activity Type"::"Invt. Pick", WarhouActivityLine_lRec."Activity Type"::"Put-away");
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


                // RegisteredWhseActivityLine.Reset();
                // RegisteredWhseActivityLine.SetFilter("Activity Type", '%1|%2', RegisteredWhseActivityLine."Activity Type"::"Invt. Pick", RegisteredWhseActivityLine."Activity Type"::Pick);
                // RegisteredWhseActivityLine.Setrange("Source Document", RegisteredWhseActivityLine."Source Document"::"Purchase Order");
                // RegisteredWhseActivityLine.SetRange("Source Type", 39);
                // RegisteredWhseActivityLine.SetRange("Source Subtype", 1);
                // RegisteredWhseActivityLine.SetRange("Source No.", PurchaseLine_lRec."Document No.");
                // RegisteredWhseActivityLine.SetRange("Source Line No.", PurchaseLine_lRec."Line No.");
                // IF RegisteredWhseActivityLine.FindSet() then
                //     Error('Registered Pick already exist for Document %1 Line No. %2', PurchaseLine_lRec."Document No.", PurchaseLine_lRec."Line No.");

                PurchaseLine_lRec.Validate(Quantity, PLFinalQty_lDec);
                PurchaseLine_lRec.Validate("Completely Received", True);

                PurchaseLine_lRec.Validate("Special Order", false);
                PurchaseLine_lRec.Validate("Special Order Sales No.", '');
                PurchaseLine_lRec.Validate("Special Order Sales Line No.", 0);

                PurchaseLine_lRec.Validate("Purchasing Code", '');
                PurchaseLine_lRec.Validate("Sales Order No.", '');
                PurchaseLine_lRec.Validate("Sales Order Line No.", 0);
                // PurchaseLine_lRec.Validate("Bin Code", BinCode);
                // PurchaseLine_lRec.Validate("Unit Price", UnitPrice);
                PurchaseLine_lRec.Validate("Drop Shipment", false);
                PurchaseLine_lRec.validate("Short Close Reason", ShortCloseReason_gCod);
                PurchaseLine_lRec."Short Close Boolean" := true;
                PurchaseLine_lRec.MODIFY();


                SalesLine.Reset();
                SalesLine.SetRange("Purchase Order No.", PurchaseLine_lRec."Document No.");
                SalesLine.SetRange("Purch. Order Line No.", PurchaseLine_lRec."Line No.");
                if SalesLine.FindSet() then
                    repeat
                        SalesLine.Validate("Purchasing Code", '');
                        SalesLine."Purchase Order No." := '';
                        SalesLine."Purch. Order Line No." := 0;
                        SalesLine."Drop Shipment" := false;
                        SalesLine."Special Order" := false;
                        SalesLine."Special Order Purchase No." := '';
                        SalesLine."Special Order Purch. Line No." := 0;
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
                        SalesLine."Drop Shipment" := false;
                        SalesLine."Special Order" := false;
                        SalesLine."Special Order Purchase No." := '';
                        SalesLine."Special Order Purch. Line No." := 0;
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
            PurchaseHeader_lRec.validate("Short Close Reason", ShortCloseReason_gCod);
            PurchaseHeader_lRec."Short Close Boolean" := true;
            PurchaseHeader_lRec.Modify(true);
            TotalSortClose_gInt += 1;
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



    var
        ActivityType: enum "Warehouse Activity Type";


}