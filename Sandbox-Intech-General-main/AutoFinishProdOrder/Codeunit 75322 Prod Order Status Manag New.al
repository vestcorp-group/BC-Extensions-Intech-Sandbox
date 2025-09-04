Codeunit 75322 "Prod. Order Status Manag New"
{
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Intech-Systems - info@intech-systems.com
    // ------------------------------------------------------------------------------------------------------------------------------------
    // ID                  Date        Author
    // ------------------------------------------------------------------------------------------------------------------------------------
    // I-C0046-1006182-01  18/05/12    Nilesh Gajjar
    //                     C0046-Prod Plan Material Availibilty
    // I-C0046-1006182-03  16/03/13    Nilesh Gajjar / Dipak Patel
    //                     Upload to live database after tested in test db
    // I-A010_A-63000044-01 21/07/14     RaviShah
    //                      Transfer Order to Production Order Functionality
    //                      Added Code to flow fields from one Status to another status
    // ------------------------------------------------------------------------------------------------------------------------------------
    //AutoFinishProdOrder
    Permissions = TableData "Source Code Setup" = r,
                  TableData "Production Order" = rimd,
                  TableData "Prod. Order Capacity Need" = rid,
                  TableData "Inventory Adjmt. Entry (Order)" = rim;
    TableNo = "Production Order";

    trigger OnRun()
    var
        ChangeStatusForm: Page "Change Status on Prod. Order";
    begin
        ChangeStatusForm.Set(Rec);
        if ChangeStatusForm.RunModal = Action::Yes then begin
#pragma warning disable
            ChangeStatusForm.ReturnPostingInfo(NewStatus, NewPostingDate, NewUpdateUnitCost);
#pragma warning disable
            ChangeStatusOnProdOrder(Rec, NewStatus, NewPostingDate, NewUpdateUnitCost);
            Commit;
            Message(Text000, Rec.Status, Rec.TableCaption, Rec."No.", ToProdOrder.Status, ToProdOrder.TableCaption, ToProdOrder."No.")
        end;
    end;

    var
        Text000: label '%2 %3  with status %1 has been changed to %5 %6 with status %4.';
        Text002: label 'Posting Automatic consumption...\\';
        Text003: label 'Posting lines         #1###### @2@@@@@@@@@@@@@';
        Text004: label '%1 %2 has not been finished. Some output is still missing. Do you still want to finish the order?';
        Text005: label 'The update has been interrupted to respect the warning.';
        Text006: label '%1 %2 has not been finished. Some consumption is still missing. Do you still want to finish the order?';
        ToProdOrder: Record "Production Order";
        SourceCodeSetup: Record "Source Code Setup";
        Item: Record Item;
        InvtSetup: Record "Inventory Setup";
        DimMgt: Codeunit DimensionManagement;
        ReserveProdOrderLine: Codeunit "Prod. Order Line-Reserve";
        ReserveProdOrderComp: Codeunit "Prod. Order Comp.-Reserve";
        ReservMgt: Codeunit "Reservation Management";
        CalendarMgt: Codeunit "Shop Calendar Management";
        UpdateProdOrderCost: Codeunit "Update Prod. Order Cost";
        ACYMgt: Codeunit "Additional-Currency Management";
        WhseProdRelease: Codeunit "Whse.-Production Release";
        WhseOutputProdRelease: Codeunit "Whse.-Output Prod. Release";
        InvtAdjmt: Codeunit "Inventory Adjustment";
        NewStatus: Option Quote,Planned,"Firm Planned",Released,Finished;
        NewPostingDate: Date;
        NewUpdateUnitCost: Boolean;
        SourceCodeSetupRead: Boolean;
        Text008: label '%1 %2 cannot be finished as the associated subcontract order %3 has not been fully delivered.';
        Text009: label 'You cannot finish line %1 on %2 %3. It has consumption or capacity posted with no output.';
        Text010: label 'You must specify a %1 in %2 %3 %4.';
        Text16321: label 'Associated subcontract order has not been fully delivered. Do you wish to continue?';
        Text16322: label 'Operation Stoped.';
        SubcontractErr: label 'The subcontracting production order includes an item or a work center where the flushing method is backward. If you finish the production order, it can result in double consumption of items. Change the flushing method, and then finish the production order';
        PlanningRefresh_gBln: Boolean;
        RemainingQuantity_gDec: Decimal;
        ProductionPlanNo_gCde: Code[20];
        ProdOrderNo_gCod: Code[20];
        ProductionOrder_gRec: Record "Production Order";
        ProductionOrderLine_gRec: Record "Prod. Order Line";
        ProductionOrderLine2_gRec: Record "Prod. Order Line";
        AutoFinishBatch_gBln: Boolean;


    procedure ChangeStatusOnProdOrder(ProdOrder: Record "Production Order"; NewStatus: Option Quote,Planned,"Firm Planned",Released,Finished; NewPostingDate: Date; NewUpdateUnitCost: Boolean)
    var
        DynaEquipSetup_lRec: Record "Manufacturing Setup";
    begin
        SetPostingInfo(NewStatus, NewPostingDate, NewUpdateUnitCost);
        if NewStatus = Newstatus::Finished then begin
            CheckBeforeFinishProdOrder(ProdOrder);
            FlushProdOrder(ProdOrder, NewStatus, NewPostingDate);
            ProdOrder.HandleItemTrackingDeletion;
            ErrorIfUnableToClearWIP(ProdOrder);
            ProdOrderNo_gCod := ''; //C0046.01
            TransProdOrder(ProdOrder);

            //ManuChk-NS
            // DynaEquipSetup_lRec.Get;
            //  if DynaEquipSetup_lRec."Check Consumption Booked" then
            CheckConsumptionBooked_lFnc(ProdOrder);
            //ManuChk-NE



            InvtSetup.Get;
            if InvtSetup."Automatic Cost Adjustment" <>
               InvtSetup."automatic cost adjustment"::Never
            then begin
                InvtAdjmt.SetProperties(true, InvtSetup."Automatic Cost Posting");
                InvtAdjmt.MakeMultiLevelAdjmt;
            end;

            WhseProdRelease.FinishedDelete(ProdOrder);
            WhseOutputProdRelease.FinishedDelete(ProdOrder);
        end else begin
            TransProdOrder(ProdOrder);
            FlushProdOrder(ProdOrder, NewStatus, NewPostingDate);
            WhseProdRelease.Release(ProdOrder);
        end;
        Commit;

        Clear(InvtAdjmt);
    end;

    local procedure TransProdOrder(var FromProdOrder: Record "Production Order")
    var
        ToProdOrderLine: Record "Prod. Order Line";
    begin
        ToProdOrderLine.LockTable;

        ToProdOrder := FromProdOrder;
#pragma warning disable
        ToProdOrder.Status := NewStatus;
#pragma warning disable

        case FromProdOrder.Status of
            FromProdOrder.Status::Simulated:
                ToProdOrder."Simulated Order No." := FromProdOrder."No.";
            FromProdOrder.Status::Planned:
                ToProdOrder."Planned Order No." := FromProdOrder."No.";
            FromProdOrder.Status::"Firm Planned":
                ToProdOrder."Firm Planned Order No." := FromProdOrder."No.";
            FromProdOrder.Status::Released:
                ToProdOrder."Finished Date" := NewPostingDate;
        end;

        ToProdOrder.TestNoSeries;
        if (ToProdOrder.GetNoSeriesCode <> FromProdOrder.GetNoSeriesCode) and
           (ToProdOrder.Status <> ToProdOrder.Status::Finished)
        then begin
            ToProdOrder."No." := '';
            ToProdOrder."Due Date" := 0D;
        end;

        ToProdOrder.Insert(true);
        ToProdOrder."Starting Time" := FromProdOrder."Starting Time";
        ToProdOrder."Starting Date" := FromProdOrder."Starting Date";
        ToProdOrder."Ending Time" := FromProdOrder."Ending Time";
        ToProdOrder."Ending Date" := FromProdOrder."Ending Date";
        ToProdOrder."Due Date" := FromProdOrder."Due Date";
        ToProdOrder."Shortcut Dimension 1 Code" := FromProdOrder."Shortcut Dimension 1 Code";
        ToProdOrder."Shortcut Dimension 2 Code" := FromProdOrder."Shortcut Dimension 2 Code";
        ToProdOrder."Dimension Set ID" := FromProdOrder."Dimension Set ID";

        //AutoFinishProduction-NS //T5415-NS
        if AutoFinishBatch_gBln then begin
            ToProdOrder."Finished from batch job" := true;
            ToProdOrder."Finished Date from batch job" := Today;
            ToProdOrder."Finished By from batch job" := UserId;
        end;
        //AutoFinishProduction-NE //T5415-NE
        ToProdOrder.Modify;

        ProdOrderNo_gCod := ToProdOrder."No."; //C0046.01

        TransProdOrderLine(FromProdOrder);
        TransProdOrderRtngLine(FromProdOrder);
        TransProdOrderComp(FromProdOrder);
        TransProdOrderRtngTool(FromProdOrder);
        TransProdOrderRtngPersnl(FromProdOrder);
        TransProdOrdRtngQltyMeas(FromProdOrder);
        TransProdOrderCmtLine(FromProdOrder);
        TransProdOrderRtngCmtLn(FromProdOrder);
        TransProdOrderBOMCmtLine(FromProdOrder);
        TransProdOrderCapNeed(FromProdOrder);
        //C0046.01 >>
        if (not PlanningRefresh_gBln) or (RemainingQuantity_gDec = 0) then
            FromProdOrder.Delete;
        //C0046.01 <<
        //DELETE;   //C0046.01
        FromProdOrder := ToProdOrder;
    end;

    local procedure TransProdOrderLine(FromProdOrder: Record "Production Order")
    var
        FromProdOrderLine: Record "Prod. Order Line";
        ToProdOrderLine: Record "Prod. Order Line";
        InvtAdjmtEntryOrder: Record "Inventory Adjmt. Entry (Order)";
    begin
        FromProdOrderLine.SetRange(Status, FromProdOrder.Status);
        FromProdOrderLine.SetRange("Prod. Order No.", FromProdOrder."No.");
        FromProdOrderLine.LockTable;
        if FromProdOrderLine.FindSet then begin
            repeat
                ToProdOrderLine := FromProdOrderLine;
                ToProdOrderLine.Status := ToProdOrder.Status;
                ToProdOrderLine."Prod. Order No." := ToProdOrder."No.";
                ToProdOrderLine.Insert;
                if NewStatus = Newstatus::Finished then begin
                    if InvtAdjmtEntryOrder.Get(InvtAdjmtEntryOrder."order type"::Production, FromProdOrderLine."Prod. Order No.", FromProdOrderLine."Line No.") then begin
                        InvtAdjmtEntryOrder."Routing No." := ToProdOrderLine."Routing No.";
                        InvtAdjmtEntryOrder.Modify;
                    end else
                        InvtAdjmtEntryOrder.SetProdOrderLine(FromProdOrderLine);
                    InvtAdjmtEntryOrder."Cost is Adjusted" := false;
                    InvtAdjmtEntryOrder."Is Finished" := true;

                    InvtAdjmtEntryOrder.Modify;

                    if NewUpdateUnitCost then
                        UpdateProdOrderCost.UpdateUnitCostOnProdOrder(FromProdOrderLine, true, true);
                    ToProdOrderLine."Unit Cost (ACY)" :=
                      ACYMgt.CalcACYAmt(ToProdOrderLine."Unit Cost", NewPostingDate, true);
                    ToProdOrderLine."Cost Amount (ACY)" :=
                      ACYMgt.CalcACYAmt(ToProdOrderLine."Cost Amount", NewPostingDate, false);
                    //  ReservMgt.SetProdOrderLine(FromProdOrderLine);  //NG-Pending
                    // SetProdOrderLine(FromProdOrderLine);
                    // //intech-today


                    ReservMgt.DeleteReservEntries(true, 0);
                end else begin
                    if Item.Get(FromProdOrderLine."Item No.") then begin
                        if (Item."Costing Method" <> Item."costing method"::Standard) and NewUpdateUnitCost then
                            UpdateProdOrderCost.UpdateUnitCostOnProdOrder(FromProdOrderLine, false, true);
                    end;
                    ToProdOrderLine.BlockDynamicTracking(true);
                    ToProdOrderLine.Validate(Quantity);
                    ReserveProdOrderLine.TransferPOLineToPOLine(FromProdOrderLine, ToProdOrderLine, 0, true);
                end;
                ToProdOrderLine.Validate("Unit Cost", FromProdOrderLine."Unit Cost");
                ToProdOrderLine.Modify;
            until FromProdOrderLine.Next = 0;
            //C0046.01 >>
            if (not PlanningRefresh_gBln) or (RemainingQuantity_gDec = 0) then
                FromProdOrderLine.DeleteAll;
            //C0046.01 <<
            //DELETEALL;   //C0046.01
        end;
    end;

    local procedure TransProdOrderRtngLine(FromProdOrder: Record "Production Order")
    var
        FromProdOrderRtngLine: Record "Prod. Order Routing Line";
        ToProdOrderRtngLine: Record "Prod. Order Routing Line";
        ProdOrderCapNeed: Record "Prod. Order Capacity Need";
    begin
        FromProdOrderRtngLine.SetRange(Status, FromProdOrder.Status);
        FromProdOrderRtngLine.SetRange("Prod. Order No.", FromProdOrder."No.");
        FromProdOrderRtngLine.LockTable;
        if FromProdOrderRtngLine.FindSet then begin
            repeat
                ToProdOrderRtngLine := FromProdOrderRtngLine;
                ToProdOrderRtngLine.Status := ToProdOrder.Status;
                ToProdOrderRtngLine."Prod. Order No." := ToProdOrder."No.";
                if ToProdOrder.Status = ToProdOrder.Status::Released then
                    ToProdOrderRtngLine."Routing Status" := FromProdOrderRtngLine."routing status"::Planned;

                if ToProdOrder.Status in [ToProdOrder.Status::"Firm Planned", ToProdOrder.Status::Released] then begin
                    ProdOrderCapNeed.SetRange("Prod. Order No.", FromProdOrder."No.");
                    ProdOrderCapNeed.SetRange(Status, FromProdOrder.Status);
                    ProdOrderCapNeed.SetRange("Routing Reference No.", FromProdOrderRtngLine."Routing Reference No.");
                    ProdOrderCapNeed.SetRange("Operation No.", FromProdOrderRtngLine."Operation No.");
                    ProdOrderCapNeed.SetRange("Requested Only", false);
                    ProdOrderCapNeed.CalcSums("Needed Time (ms)");
                    ToProdOrderRtngLine."Expected Capacity Need" := ProdOrderCapNeed."Needed Time (ms)";
                end;
                ToProdOrderRtngLine.Insert;
            until FromProdOrderRtngLine.Next = 0;
            //C0046.01 >>
            if (not PlanningRefresh_gBln) or (RemainingQuantity_gDec = 0) then
                FromProdOrderRtngLine.DeleteAll;
            //C0046.01 <<
            //DELETEALL;    //C0046.01
        end;
    end;

    local procedure TransProdOrderComp(FromProdOrder: Record "Production Order")
    var
        FromProdOrderComp: Record "Prod. Order Component";
        ToProdOrderComp: Record "Prod. Order Component";
        Location: Record Location;
    begin
        FromProdOrderComp.SetRange(Status, FromProdOrder.Status);
        FromProdOrderComp.SetRange("Prod. Order No.", FromProdOrder."No.");
        FromProdOrderComp.LockTable;
        if FromProdOrderComp.FindSet then begin
            repeat
                if Location.Get(FromProdOrderComp."Location Code") and
                   Location."Bin Mandatory" and
                   not Location."Directed Put-away and Pick" and
                   (FromProdOrderComp.Status = FromProdOrderComp.Status::"Firm Planned") and
                   (ToProdOrder.Status = ToProdOrder.Status::Released) and
                   (FromProdOrderComp."Flushing Method" in [FromProdOrderComp."flushing method"::Forward, FromProdOrderComp."flushing method"::"Pick + Forward"]) and
                   (FromProdOrderComp."Routing Link Code" = '') and
                   (FromProdOrderComp."Bin Code" = '')
                then
                    Error(
                      Text010,
                      FromProdOrderComp.FieldCaption("Bin Code"),
                      FromProdOrderComp.TableCaption,
                      FromProdOrderComp.FieldCaption("Line No."),
                      FromProdOrderComp."Line No.");
                ToProdOrderComp := FromProdOrderComp;
                ToProdOrderComp.Status := ToProdOrder.Status;
                ToProdOrderComp."Prod. Order No." := ToProdOrder."No.";
                ToProdOrderComp.Insert;
                if NewStatus = Newstatus::Finished then begin
                    // ReservMgt.SetProdOrderComponent(FromProdOrderComp);  //NG-Pending
                    ReservMgt.DeleteReservEntries(true, 0);
                end else begin
                    ToProdOrderComp.BlockDynamicTracking(true);
                    ToProdOrderComp.Validate("Expected Quantity");
                    ReserveProdOrderComp.TransferPOCompToPOComp(FromProdOrderComp, ToProdOrderComp, 0, true);
                    if ToProdOrderComp.Status in [ToProdOrderComp.Status::"Firm Planned", ToProdOrderComp.Status::Released] then
                        ToProdOrderComp.AutoReserve;
                end;
                ToProdOrderComp.Modify;
            until FromProdOrderComp.Next = 0;
            //C0046.01 >>
            if (not PlanningRefresh_gBln) or (RemainingQuantity_gDec = 0) then
                FromProdOrderComp.DeleteAll;
            //C0046.01 <<
            //DELETEALL;    //C0046.01
        end;
    end;

    local procedure TransProdOrderRtngTool(FromProdOrder: Record "Production Order")
    var
        FromProdOrderRtngTool: Record "Prod. Order Routing Tool";
        ToProdOrderRoutTool: Record "Prod. Order Routing Tool";
    begin
        FromProdOrderRtngTool.SetRange(Status, FromProdOrder.Status);
        FromProdOrderRtngTool.SetRange("Prod. Order No.", FromProdOrder."No.");
        FromProdOrderRtngTool.LockTable;
        if FromProdOrderRtngTool.FindSet then begin
            repeat
                ToProdOrderRoutTool := FromProdOrderRtngTool;
                ToProdOrderRoutTool.Status := ToProdOrder.Status;
                ToProdOrderRoutTool."Prod. Order No." := ToProdOrder."No.";
                ToProdOrderRoutTool.Insert;
            until FromProdOrderRtngTool.Next = 0;
            FromProdOrderRtngTool.DeleteAll;
        end;
    end;

    local procedure TransProdOrderRtngPersnl(FromProdOrder: Record "Production Order")
    var
        FromProdOrderRtngPersonnel: Record "Prod. Order Routing Personnel";
        ToProdOrderRtngPersonnel: Record "Prod. Order Routing Personnel";
    begin
        FromProdOrderRtngPersonnel.SetRange(Status, FromProdOrder.Status);
        FromProdOrderRtngPersonnel.SetRange("Prod. Order No.", FromProdOrder."No.");
        FromProdOrderRtngPersonnel.LockTable;
        if FromProdOrderRtngPersonnel.FindSet then begin
            repeat
                ToProdOrderRtngPersonnel := FromProdOrderRtngPersonnel;
                ToProdOrderRtngPersonnel.Status := ToProdOrder.Status;
                ToProdOrderRtngPersonnel."Prod. Order No." := ToProdOrder."No.";
                ToProdOrderRtngPersonnel.Insert;
            until FromProdOrderRtngPersonnel.Next = 0;
            FromProdOrderRtngPersonnel.DeleteAll;
        end;
    end;

    local procedure TransProdOrdRtngQltyMeas(FromProdOrder: Record "Production Order")
    var
        FromProdOrderRtngQltyMeas: Record "Prod. Order Rtng Qlty Meas.";
        ToProdOrderRtngQltyMeas: Record "Prod. Order Rtng Qlty Meas.";
    begin
        FromProdOrderRtngQltyMeas.SetRange(Status, FromProdOrder.Status);
        FromProdOrderRtngQltyMeas.SetRange("Prod. Order No.", FromProdOrder."No.");
        FromProdOrderRtngQltyMeas.LockTable;
        if FromProdOrderRtngQltyMeas.FindSet then begin
            repeat
                ToProdOrderRtngQltyMeas := FromProdOrderRtngQltyMeas;
                ToProdOrderRtngQltyMeas.Status := ToProdOrder.Status;
                ToProdOrderRtngQltyMeas."Prod. Order No." := ToProdOrder."No.";
                ToProdOrderRtngQltyMeas.Insert;
            until FromProdOrderRtngQltyMeas.Next = 0;
            FromProdOrderRtngQltyMeas.DeleteAll;
        end;
    end;

    local procedure TransProdOrderCmtLine(FromProdOrder: Record "Production Order")
    var
        FromProdOrderCommentLine: Record "Prod. Order Comment Line";
        ToProdOrderCommentLine: Record "Prod. Order Comment Line";
        RecordLinkManagement: Codeunit "Record Link Management";
    begin
        FromProdOrderCommentLine.SetRange(Status, FromProdOrder.Status);
        FromProdOrderCommentLine.SetRange("Prod. Order No.", FromProdOrder."No.");
        FromProdOrderCommentLine.LockTable;
        if FromProdOrderCommentLine.FindSet then begin
            repeat
                ToProdOrderCommentLine := FromProdOrderCommentLine;
                ToProdOrderCommentLine.Status := ToProdOrder.Status;
                ToProdOrderCommentLine."Prod. Order No." := ToProdOrder."No.";
                ToProdOrderCommentLine.Insert;
            until FromProdOrderCommentLine.Next = 0;
            FromProdOrderCommentLine.DeleteAll;
        end;
        RecordLinkManagement.CopyLinks(FromProdOrder, ToProdOrder);
    end;

    local procedure TransProdOrderRtngCmtLn(FromProdOrder: Record "Production Order")
    var
        FromProdOrderRtngComment: Record "Prod. Order Rtng Comment Line";
        ToProdOrderRtngComment: Record "Prod. Order Rtng Comment Line";
    begin
        FromProdOrderRtngComment.SetRange(Status, FromProdOrder.Status);
        FromProdOrderRtngComment.SetRange("Prod. Order No.", FromProdOrder."No.");
        FromProdOrderRtngComment.LockTable;
        if FromProdOrderRtngComment.FindSet then begin
            repeat
                ToProdOrderRtngComment := FromProdOrderRtngComment;
                ToProdOrderRtngComment.Status := ToProdOrder.Status;
                ToProdOrderRtngComment."Prod. Order No." := ToProdOrder."No.";
                ToProdOrderRtngComment.Insert;
            until FromProdOrderRtngComment.Next = 0;
            FromProdOrderRtngComment.DeleteAll;
        end;
    end;

    local procedure TransProdOrderBOMCmtLine(FromProdOrder: Record "Production Order")
    var
        FromProdOrderBOMComment: Record "Prod. Order Comp. Cmt Line";
        ToProdOrderBOMComment: Record "Prod. Order Comp. Cmt Line";
    begin
        FromProdOrderBOMComment.SetRange(Status, FromProdOrder.Status);
        FromProdOrderBOMComment.SetRange("Prod. Order No.", FromProdOrder."No.");
        FromProdOrderBOMComment.LockTable;
        if FromProdOrderBOMComment.FindSet then begin
            repeat
                ToProdOrderBOMComment := FromProdOrderBOMComment;
                ToProdOrderBOMComment.Status := ToProdOrder.Status;
                ToProdOrderBOMComment."Prod. Order No." := ToProdOrder."No.";
                ToProdOrderBOMComment.Insert;
            until FromProdOrderBOMComment.Next = 0;
            FromProdOrderBOMComment.DeleteAll;
        end;
    end;

    local procedure TransProdOrderCapNeed(FromProdOrder: Record "Production Order")
    var
        FromProdOrderCapNeed: Record "Prod. Order Capacity Need";
        ToProdOrderCapNeed: Record "Prod. Order Capacity Need";
    begin
        FromProdOrderCapNeed.SetRange(Status, FromProdOrder.Status);
        FromProdOrderCapNeed.SetRange("Prod. Order No.", FromProdOrder."No.");
        FromProdOrderCapNeed.SetRange("Requested Only", false);
        if NewStatus = Newstatus::Finished then
            FromProdOrderCapNeed.DeleteAll
        else begin
            FromProdOrderCapNeed.LockTable;
            if FromProdOrderCapNeed.FindSet then begin
                repeat
                    ToProdOrderCapNeed := FromProdOrderCapNeed;
                    ToProdOrderCapNeed.Status := ToProdOrder.Status;
                    ToProdOrderCapNeed."Prod. Order No." := ToProdOrder."No.";
                    ToProdOrderCapNeed."Allocated Time" := ToProdOrderCapNeed."Needed Time";
                    ToProdOrderCapNeed.Insert;
                until FromProdOrderCapNeed.Next = 0;
                //C0046.01 >>
                if (not PlanningRefresh_gBln) or (RemainingQuantity_gDec = 0) then
                    FromProdOrderCapNeed.DeleteAll;
                //C0046.01 <<
                //DELETEALL; //C0046.01
            end;
        end;
    end;


    procedure FlushProdOrder(ProdOrder: Record "Production Order"; NewStatus: Option Simulated,Planned,"Firm Planned",Released,Finished; PostingDate: Date)
    var
        Item: Record Item;
        ItemJnlLine: Record "Item Journal Line";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        ProdOrderComp: Record "Prod. Order Component";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        CostCalcMgt: Codeunit "Cost Calculation Management";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        Window: Dialog;
        QtyToPost: Decimal;
        NoOfRecords: Integer;
        LineCount: Integer;
        OutputQty: Decimal;
        OutputQtyBase: Decimal;
        ActualOutputAndScrapQty: Decimal;
        ActualOutputAndScrapQtyBase: Decimal;
    begin
        if NewStatus < Newstatus::Released then
            exit;

        GetSourceCodeSetup;

        ProdOrderLine.LockTable;
        ProdOrderLine.Reset;
        ProdOrderLine.SetRange(Status, ProdOrder.Status);
        ProdOrderLine.SetRange("Prod. Order No.", ProdOrder."No.");
        if ProdOrderLine.FindSet then
            repeat
                ProdOrderRtngLine.SetCurrentkey("Prod. Order No.", Status, "Flushing Method");
                if NewStatus = Newstatus::Released then
                    ProdOrderRtngLine.SetRange("Flushing Method", ProdOrderRtngLine."flushing method"::Forward)
                else begin
                    ProdOrderRtngLine.Ascending(false); // In case of backward flushing on the last operation
                    ProdOrderRtngLine.SetRange("Flushing Method", ProdOrderRtngLine."flushing method"::Backward);
                end;
                ProdOrderRtngLine.SetRange(Status, ProdOrderLine.Status);
                ProdOrderRtngLine.SetRange("Prod. Order No.", ProdOrder."No.");
                ProdOrderRtngLine.SetRange("Routing No.", ProdOrderLine."Routing No.");
                ProdOrderRtngLine.SetRange("Routing Reference No.", ProdOrderLine."Routing Reference No.");
                ProdOrderRtngLine.LockTable;
                if ProdOrderRtngLine.Find('-') then begin
                    // First found operation
                    if ProdOrderRtngLine."Flushing Method" = ProdOrderRtngLine."flushing method"::Backward then begin
                        ActualOutputAndScrapQtyBase :=
                          CostCalcMgt.CalcActOperOutputAndScrap(ProdOrderLine, ProdOrderRtngLine);
                        ActualOutputAndScrapQty := ActualOutputAndScrapQtyBase / ProdOrderLine."Qty. per Unit of Measure";
                    end;

                    if (ProdOrderRtngLine."Flushing Method" = ProdOrderRtngLine."flushing method"::Forward) or
                       (ProdOrderRtngLine."Next Operation No." = '')
                    then begin
                        OutputQty := ProdOrderLine."Remaining Quantity";
                        OutputQtyBase := ProdOrderLine."Remaining Qty. (Base)";
                    end else
                        if ProdOrderRtngLine."Next Operation No." <> '' then begin // Not Last Operation
                            OutputQty := ActualOutputAndScrapQty;
                            OutputQtyBase := ActualOutputAndScrapQtyBase;
                        end;

                    repeat
                        ItemJnlLine.Init;
                        ItemJnlLine.Validate("Entry Type", ItemJnlLine."entry type"::Output);
                        ItemJnlLine.Validate("Posting Date", PostingDate);
                        ItemJnlLine."Document No." := ProdOrder."No.";
                        ItemJnlLine.Validate("Order Type", ItemJnlLine."order type"::Production);
                        ItemJnlLine.Validate("Order No.", ProdOrder."No.");
                        ItemJnlLine.Validate("Order Line No.", ProdOrderLine."Line No.");
                        ItemJnlLine.Validate("Item No.", ProdOrderLine."Item No.");
                        ItemJnlLine.Validate("Routing Reference No.", ProdOrderRtngLine."Routing Reference No.");
                        ItemJnlLine.Validate("Routing No.", ProdOrderRtngLine."Routing No.");
                        ItemJnlLine.Validate("Variant Code", ProdOrderLine."Variant Code");
                        ItemJnlLine."Location Code" := ProdOrderLine."Location Code";
                        ItemJnlLine.Validate("Bin Code", ProdOrderLine."Bin Code");
                        if ItemJnlLine."Unit of Measure Code" <> ProdOrderLine."Unit of Measure Code" then
                            ItemJnlLine.Validate("Unit of Measure Code", ProdOrderLine."Unit of Measure Code");
                        ItemJnlLine.Validate("Operation No.", ProdOrderRtngLine."Operation No.");
                        if ProdOrderRtngLine."Concurrent Capacities" = 0 then
                            ProdOrderRtngLine."Concurrent Capacities" := 1;
                        SetTimeAndQuantityOmItemJnlLine(ItemJnlLine, ProdOrderRtngLine, OutputQtyBase, OutputQty);
                        ItemJnlLine."Source Code" := SourceCodeSetup.Flushing;
                        if not (ItemJnlLine.TimeIsEmpty and (ItemJnlLine."Output Quantity" = 0)) then begin
                            DimMgt.UpdateGlobalDimFromDimSetID(ItemJnlLine."Dimension Set ID", ItemJnlLine."Shortcut Dimension 1 Code",
                              ItemJnlLine."Shortcut Dimension 2 Code");
                            if ProdOrderRtngLine."Next Operation No." = '' then
                                ReserveProdOrderLine.TransferPOLineToItemJnlLine(ProdOrderLine, ItemJnlLine, ItemJnlLine."Output Quantity (Base)");
                            ItemJnlPostLine.RunWithCheck(ItemJnlLine);
                        end;

                        if (ProdOrderRtngLine."Flushing Method" = ProdOrderRtngLine."flushing method"::Backward) and
                           (ProdOrderRtngLine."Next Operation No." = '')
                        then begin
                            OutputQty += ActualOutputAndScrapQty;
                            OutputQtyBase += ActualOutputAndScrapQtyBase;
                        end;
                    until ProdOrderRtngLine.Next = 0;
                end;
            until ProdOrderLine.Next = 0;

        ProdOrderComp.SetCurrentkey(Status, "Prod. Order No.", "Routing Link Code", "Flushing Method");
        if NewStatus = Newstatus::Released then
            ProdOrderComp.SetFilter(
              "Flushing Method",
              '%1|%2',
              ProdOrderComp."flushing method"::Forward,
              ProdOrderComp."flushing method"::"Pick + Forward")
        else
            ProdOrderComp.SetFilter(
              "Flushing Method",
              '%1|%2',
              ProdOrderComp."flushing method"::Backward,
              ProdOrderComp."flushing method"::"Pick + Backward");
        ProdOrderComp.SetRange("Routing Link Code", '');
        ProdOrderComp.SetRange(Status, ProdOrderComp.Status::Released);
        ProdOrderComp.SetRange("Prod. Order No.", ProdOrder."No.");
        ProdOrderComp.SetFilter("Item No.", '<>%1', '');
        ProdOrderComp.LockTable;
        if ProdOrderComp.FindSet then begin
            NoOfRecords := ProdOrderComp.Count;
            Window.Open(
              Text002 +
              Text003);
            LineCount := 0;

            repeat
                LineCount := LineCount + 1;
                Item.Get(ProdOrderComp."Item No.");
                Item.TestField("Rounding Precision");
                Window.Update(1, LineCount);
                Window.Update(2, ROUND(LineCount / NoOfRecords * 10000, 1));
                ProdOrderLine.Get(ProdOrderComp.Status, ProdOrder."No.", ProdOrderComp."Prod. Order Line No.");
                if NewStatus = Newstatus::Released then
                    QtyToPost := ProdOrderComp.GetNeededQty(1, false)
                else
                    QtyToPost := ProdOrderComp.GetNeededQty(0, false);
                QtyToPost := ROUND(QtyToPost, Item."Rounding Precision", '>');

                if QtyToPost <> 0 then begin
                    if ProdOrderLine.IsSubcontractingOrder(ProdOrderComp) then
                        Error(SubcontractErr);
                    ItemJnlLine.Init;
                    ItemJnlLine.Validate("Entry Type", ItemJnlLine."entry type"::Consumption);
                    ItemJnlLine.Validate("Posting Date", PostingDate);
                    ItemJnlLine."Order Type" := ItemJnlLine."order type"::Production;
                    ItemJnlLine."Order No." := ProdOrder."No.";
                    ItemJnlLine."Source No." := ProdOrderLine."Item No.";
                    ItemJnlLine."Source Type" := ItemJnlLine."source type"::Item;
                    ItemJnlLine."Order Line No." := ProdOrderLine."Line No.";
                    ItemJnlLine."Document No." := ProdOrder."No.";
                    ItemJnlLine.Validate("Item No.", ProdOrderComp."Item No.");
                    ItemJnlLine.Validate("Prod. Order Comp. Line No.", ProdOrderComp."Line No.");
                    if ItemJnlLine."Unit of Measure Code" <> ProdOrderComp."Unit of Measure Code" then
                        ItemJnlLine.Validate("Unit of Measure Code", ProdOrderComp."Unit of Measure Code");
                    ItemJnlLine."Qty. per Unit of Measure" := ProdOrderComp."Qty. per Unit of Measure";
                    ItemJnlLine.Description := ProdOrderComp.Description;
                    ItemJnlLine.Validate(Quantity, QtyToPost);
                    ItemJnlLine.Validate("Unit Cost", ProdOrderComp."Unit Cost");
                    ItemJnlLine."Location Code" := ProdOrderComp."Location Code";
                    ItemJnlLine."Bin Code" := ProdOrderComp."Bin Code";
                    ItemJnlLine."Variant Code" := ProdOrderComp."Variant Code";
                    ItemJnlLine."Source Code" := SourceCodeSetup.Flushing;
                    ItemJnlLine."Gen. Bus. Posting Group" := ProdOrder."Gen. Bus. Posting Group";
                    ItemJnlLine."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                    if Item."Item Tracking Code" <> '' then
                        ItemTrackingMgt.CopyItemTracking(ProdOrderComp.RowID1, ItemJnlLine.RowID1, false);
                    ItemJnlPostLine.Run(ItemJnlLine);
                end;
            until ProdOrderComp.Next = 0;
            Window.Close;
        end;
    end;

    local procedure CheckBeforeFinishProdOrder(ProdOrder: Record "Production Order")
    var
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderComp: Record "Prod. Order Component";
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        PurchLine: Record "Purchase Line";
        ShowWarning: Boolean;
        SubOrdCompListVend: Record "Sub Order Comp. List Vend";
    begin
        PurchLine.SetCurrentkey("Document Type", Type, "Prod. Order No.", "Prod. Order Line No.", "Routing No.", "Operation No.");
        PurchLine.SetRange("Document Type", PurchLine."document type"::Order);
        PurchLine.SetRange(Type, PurchLine.Type::Item);
        PurchLine.SetRange("Prod. Order No.", ProdOrder."No.");
        PurchLine.SetFilter("Outstanding Quantity", '<>%1', 0);
        if PurchLine.FindFirst then begin
            SubOrdCompListVend.Reset;
            SubOrdCompListVend.SetRange("Document No.", PurchLine."Document No.");
            SubOrdCompListVend.SetRange("Document Line No.", PurchLine."Line No.");
            SubOrdCompListVend.SetRange("Production Order No.", PurchLine."Prod. Order No.");
            SubOrdCompListVend.SetRange("Production Order Line No.", PurchLine."Prod. Order Line No.");
            SubOrdCompListVend.SetRange("Parent Item No.", PurchLine."No.");
            if SubOrdCompListVend.FindFirst then begin
                SubOrdCompListVend.CalcFields("Quantity at Vendor Location");
                if SubOrdCompListVend."Quantity at Vendor Location" <> 0 then
                    Error(Text008, ProdOrder.TableCaption, ProdOrder."No.", PurchLine."Document No.");
            end;
        end;

        ProdOrderLine.SetRange(Status, ProdOrder.Status);
        ProdOrderLine.SetRange("Prod. Order No.", ProdOrder."No.");
        ProdOrderLine.SetFilter("Remaining Quantity", '<>0');
        if not ProdOrderLine.IsEmpty then begin
            ProdOrderRtngLine.SetRange(Status, ProdOrder.Status);
            ProdOrderRtngLine.SetRange("Prod. Order No.", ProdOrder."No.");
            ProdOrderRtngLine.SetRange("Next Operation No.", '');
            if not ProdOrderRtngLine.IsEmpty then begin
                ProdOrderRtngLine.SetFilter("Flushing Method", '<>%1', ProdOrderRtngLine."flushing method"::Backward);
                ShowWarning := not ProdOrderRtngLine.IsEmpty;
            end else
                ShowWarning := true;

            if not AutoFinishBatch_gBln then begin  //AutoFinishProduction-N
                if ShowWarning then begin
                    ;
                    if Confirm(StrSubstNo(Text004, ProdOrder.TableCaption, ProdOrder."No.")) then
                        exit;
                    Error(Text005);
                end;
            end;  //AutoFinishProduction-N
        end;

        ProdOrderComp.SetAutocalcFields("Pick Qty. (Base)");
        ProdOrderComp.SetRange(Status, ProdOrder.Status);
        ProdOrderComp.SetRange("Prod. Order No.", ProdOrder."No.");
        ProdOrderComp.SetFilter("Remaining Quantity", '<>0');
        if ProdOrderComp.FindSet then
            repeat
                ProdOrderComp.TestField("Pick Qty. (Base)", 0);
                if not AutoFinishBatch_gBln then begin  //AutoFinishProduction-N
                    if ((ProdOrderComp."Flushing Method" <> ProdOrderComp."flushing method"::Backward) and
                        (ProdOrderComp."Flushing Method" <> ProdOrderComp."flushing method"::"Pick + Backward") and
                        (ProdOrderComp."Routing Link Code" = '')) or
                       ((ProdOrderComp."Routing Link Code" <> '') and not RtngWillFlushComp(ProdOrderComp))
                    then begin
                        if Confirm(StrSubstNo(Text006, ProdOrder.TableCaption, ProdOrder."No.")) then
                            exit;
                        Error(Text005);
                    end;
                end;  //AutoFinishProduction-N
            until ProdOrderComp.Next = 0;
    end;

    local procedure RtngWillFlushComp(ProdOrderComp: Record "Prod. Order Component"): Boolean
    var
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        ProdOrderLine: Record "Prod. Order Line";
    begin
        if ProdOrderComp."Routing Link Code" = '' then
            exit;

        ProdOrderLine.Get(ProdOrderComp.Status, ProdOrderComp."Prod. Order No.", ProdOrderComp."Prod. Order Line No.");

        ProdOrderRtngLine.SetCurrentkey("Prod. Order No.", Status, "Flushing Method");
        ProdOrderRtngLine.SetRange("Flushing Method", ProdOrderRtngLine."flushing method"::Backward);
        ProdOrderRtngLine.SetRange(Status, ProdOrderRtngLine.Status::Released);
        ProdOrderRtngLine.SetRange("Prod. Order No.", ProdOrderComp."Prod. Order No.");
        ProdOrderRtngLine.SetRange("Routing Link Code", ProdOrderComp."Routing Link Code");
        ProdOrderRtngLine.SetRange("Routing No.", ProdOrderLine."Routing No.");
        ProdOrderRtngLine.SetRange("Routing Reference No.", ProdOrderLine."Routing Reference No.");
        exit(ProdOrderRtngLine.FindFirst);
    end;

    local procedure GetSourceCodeSetup()
    begin
        if not SourceCodeSetupRead then
            SourceCodeSetup.Get;
        SourceCodeSetupRead := true;
    end;


    procedure SetPostingInfo(Status: Option Quote,Planned,"Firm Planned",Released,Finished; PostingDate: Date; UpdateUnitCost: Boolean)
    begin
        NewStatus := Status;
        NewPostingDate := PostingDate;
        NewUpdateUnitCost := UpdateUnitCost;
    end;

    local procedure ErrorIfUnableToClearWIP(ProdOrder: Record "Production Order")
    var
        ProdOrderLine: Record "Prod. Order Line";
    begin
        ProdOrderLine.SetRange(Status, ProdOrder.Status);
        ProdOrderLine.SetRange("Prod. Order No.", ProdOrder."No.");
        if ProdOrderLine.FindSet then
            repeat
                if not OutputExists(ProdOrderLine) then
                    if MatrOrCapConsumpExists(ProdOrderLine) then
                        Error(Text009, ProdOrderLine."Line No.", ToProdOrder.TableCaption, ProdOrderLine."Prod. Order No.");
            until ProdOrderLine.Next = 0;
    end;

    local procedure OutputExists(ProdOrderLine: Record "Prod. Order Line"): Boolean
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemLedgEntry.SetCurrentkey("Order Type", "Order No.", "Order Line No.");
        ItemLedgEntry.SetRange("Order Type", ItemLedgEntry."order type"::Production);
        ItemLedgEntry.SetRange("Order No.", ProdOrderLine."Prod. Order No.");
        ItemLedgEntry.SetRange("Order Line No.", ProdOrderLine."Line No.");
        ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."entry type"::Output);
        if ItemLedgEntry.FindFirst then begin
            ItemLedgEntry.CalcSums(Quantity);
            if ItemLedgEntry.Quantity <> 0 then
                exit(true)
        end;
        exit(false);
    end;

    local procedure MatrOrCapConsumpExists(ProdOrderLine: Record "Prod. Order Line"): Boolean
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        CapLedgEntry: Record "Capacity Ledger Entry";
    begin
        ItemLedgEntry.SetCurrentkey("Order Type", "Order No.", "Order Line No.");
        ItemLedgEntry.SetRange("Order Type", ItemLedgEntry."order type"::Production);
        ItemLedgEntry.SetRange("Order No.", ProdOrderLine."Prod. Order No.");
        ItemLedgEntry.SetRange("Order Line No.", ProdOrderLine."Line No.");
        ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."entry type"::Consumption);
        if ItemLedgEntry.FindFirst then
            exit(true);

        CapLedgEntry.SetCurrentkey("Order Type", "Order No.", "Order Line No.", "Routing No.", "Routing Reference No.");
        CapLedgEntry.SetRange("Order Type", CapLedgEntry."order type"::Production);
        CapLedgEntry.SetRange("Order No.", ProdOrderLine."Prod. Order No.");
        CapLedgEntry.SetRange("Routing No.", ProdOrderLine."Routing No.");
        CapLedgEntry.SetRange("Routing Reference No.", ProdOrderLine."Routing Reference No.");
        exit(CapLedgEntry.FindFirst);
    end;

    local procedure SetTimeAndQuantityOmItemJnlLine(var ItemJnlLine: Record "Item Journal Line"; ProdOrderRtngLine: Record "Prod. Order Routing Line"; OutputQtyBase: Decimal; OutputQty: Decimal)
    var
        CostCalculationManagement: Codeunit "Cost Calculation Management";
        PutawayQtyBaseToCalc: Decimal;
    begin
        if ItemJnlLine.SubcontractingWorkCenterUsed then begin
            ItemJnlLine.Validate("Output Quantity", 0);
            ItemJnlLine.Validate("Run Time", 0);
            ItemJnlLine.Validate("Setup Time", 0)
        end else begin
            ItemJnlLine.Validate(
              "Setup Time",
              ROUND(
                ProdOrderRtngLine."Setup Time" *
                ProdOrderRtngLine."Concurrent Capacities" *
                CalendarMgt.QtyperTimeUnitofMeasure(
                  ProdOrderRtngLine."Work Center No.",
                  ProdOrderRtngLine."Setup Time Unit of Meas. Code"),
                0.00001));
            ItemJnlLine.Validate(
              "Run Time",
             CostCalculationManagement.CalculateCostTime(
                OutputQtyBase + PutawayQtyBaseToCalc,
                ProdOrderRtngLine."Setup Time", ProdOrderRtngLine."Setup Time Unit of Meas. Code",
                ProdOrderRtngLine."Run Time", ProdOrderRtngLine."Run Time Unit of Meas. Code",
                ProdOrderRtngLine."Lot Size",
                ProdOrderRtngLine."Scrap Factor % (Accumulated)", ProdOrderRtngLine."Fixed Scrap Qty. (Accum.)",
                ProdOrderRtngLine."Work Center No.", Enum::"Unit Cost Calculation Type"::Time, false, 0));  //BC26-U 250325
            ItemJnlLine.Validate("Output Quantity", OutputQty);
        end;
    end;


    procedure SetPlanningFlag_gFnc(PlanningRefresh_iBln: Boolean)
    begin
        PlanningRefresh_gBln := PlanningRefresh_iBln; //C0046.01
    end;


    procedure SetRemainingQuantity_gFnc(RemainingQuantity_iDec: Decimal)
    begin
        RemainingQuantity_gDec := RemainingQuantity_iDec; //C0046.01
        ProdOrderNo_gCod := '';
    end;


    procedure SetProdPlanNo_gFnc(ProductionPlanNo_iCde: Code[20])
    begin
        ProductionPlanNo_gCde := ProductionPlanNo_iCde; //C0046.01
    end;


    procedure GetProdOrderNo_gFnc(var ProdOrderNo_vCod: Code[20])
    begin
        ProdOrderNo_vCod := ProdOrderNo_gCod; //C0046.01
    end;


    procedure AutoFinishProdOrder_gFnc(ProdOrderNo_iCod: Code[20]; PostingDate_iDat: Date)
    var
        PostingDate_lDat: Date;
        UpdateUnitCost_lBln: Boolean;
        NewProdOrderNo_lCod: Code[20];
        Status_lOpt: Option Simulated,Planned,"Firm Planned",Released,Finished;
        ProductionOrder_lRec: Record "Production Order";
        NoOfRecs1_lInt: Integer;
        NoOfRecs2_lInt: Integer;
    begin
        //I-A012_A-1000580-01-NS
        ProductionOrder_gRec.Reset;
        if ProductionOrder_gRec.Get(ProductionOrder_gRec.Status::Released, ProdOrderNo_iCod) then begin
            PostingDate_lDat := PostingDate_iDat;
            UpdateUnitCost_lBln := true;
            NewProdOrderNo_lCod := '';
            Status_lOpt := Status_lopt::Finished;
            ChangeStatusProdAuto_gFnc(ProductionOrder_gRec, Status_lOpt, PostingDate_lDat, UpdateUnitCost_lBln, NewProdOrderNo_lCod);
        end;
        //I-A012_A-1000580-01-NE
    end;


    procedure ChangeStatusProdAuto_gFnc(ProdOrder: Record "Production Order"; NewStatus: Option Quote,Planned,"Firm Planned",Released,Finished; NewPostingDate: Date; NewUpdateUnitCost: Boolean; NewProdOrderNo: Code[20])
    begin
        //I-A012_A-1000580-01-NS
        SetPostingInfo(NewStatus, NewPostingDate, NewUpdateUnitCost);
        if NewStatus = Newstatus::Finished then begin
            AutoFinishBatch_gBln := true;
            CheckBeforeFinishProdOrder(ProdOrder);
            FlushProdOrder(ProdOrder, NewStatus, NewPostingDate);
            ProdOrder.HandleItemTrackingDeletion;
            ErrorIfUnableToClearWIP(ProdOrder);
            ProdOrderNo_gCod := '';
            TransProdOrder(ProdOrder);

            InvtSetup.Get;
            if InvtSetup."Automatic Cost Adjustment" <>
               InvtSetup."automatic cost adjustment"::Never
            then begin
                InvtAdjmt.SetProperties(true, InvtSetup."Automatic Cost Posting");
                InvtAdjmt.MakeMultiLevelAdjmt;
            end;
            WhseProdRelease.FinishedDelete(ProdOrder);
            WhseOutputProdRelease.FinishedDelete(ProdOrder);
        end else begin
            TransProdOrder(ProdOrder);
            FlushProdOrder(ProdOrder, NewStatus, NewPostingDate);
            WhseProdRelease.Release(ProdOrder);
        end;

        Clear(InvtAdjmt);
        //I-A012_A-1000580-01-NS
    end;

    local procedure CheckConsumptionBooked_lFnc(ProductionOrder_iRec: Record "Production Order")
    var
        ProdOrderComp_lRec: Record "Prod. Order Component";
        ProdOrderLine_lRec: Record "Prod. Order Line";
        ExpectedConsumption_lDec: Decimal;
    begin
        //ManuChk-NS
        ProdOrderComp_lRec.Reset;
        ProdOrderComp_lRec.SetCurrentkey(Status, "Prod. Order No.", "Prod. Order Line No.", "Item No.", "Line No.");
        ProdOrderComp_lRec.SetRange(Status, ProductionOrder_iRec.Status);
        ProdOrderComp_lRec.SetRange("Prod. Order No.", ProductionOrder_iRec."No.");
        if ProdOrderComp_lRec.FindSet(false, false) then begin
            repeat
                ProdOrderLine_lRec.Get(ProdOrderComp_lRec.Status, ProdOrderComp_lRec."Prod. Order No.", ProdOrderComp_lRec."Prod. Order Line No.");
                ProdOrderComp_lRec.CalcFields(ProdOrderComp_lRec."Act. Consumption (Qty)");
                ExpectedConsumption_lDec := (ProdOrderLine_lRec."Finished Quantity") * ProdOrderComp_lRec."Quantity per";
                if ExpectedConsumption_lDec > ProdOrderComp_lRec."Act. Consumption (Qty)" then
                    Error('Production Order %1 cannot been finished. Consumption is pending for Item No. %2', ProdOrderComp_lRec."Prod. Order No.", ProdOrderComp_lRec."Item No.");
            until ProdOrderComp_lRec.Next = 0;
        end;
        //ManuChk-NE
    end;



    // procedure SetProdOrderComponent(NewProdOrderComp: Record "Prod. Order Component")

    // begin
    //     CLEARALL;
    //     TempTrackingSpecification.DELETEALL;

    //     ForProdOrderComp := NewProdOrderComp;

    //     CalcReservEntry."Source Type" := DATABASE::"Prod. Order Component";
    //     CalcReservEntry."Source Subtype" := NewProdOrderComp.Status;
    //     CalcReservEntry."Source ID" := NewProdOrderComp."Prod. Order No.";
    //     CalcReservEntry."Source Prod. Order Line" := NewProdOrderComp."Prod. Order Line No.";
    //     CalcReservEntry."Source Ref. No." := NewProdOrderComp."Line No.";

    //     CalcReservEntry."Item No." := NewProdOrderComp."Item No.";
    //     CalcReservEntry."Variant Code" := NewProdOrderComp."Variant Code";
    //     CalcReservEntry."Location Code" := NewProdOrderComp."Location Code";
    //     CalcReservEntry."Serial No." := '';
    //     CalcReservEntry."Lot No." := '';
    //     CalcReservEntry."Qty. per Unit of Measure" := NewProdOrderComp."Qty. per Unit of Measure";
    //     CalcReservEntry."Expected Receipt Date" := NewProdOrderComp."Due Date";
    //     CalcReservEntry."Shipment Date" := NewProdOrderComp."Due Date";
    //     CalcReservEntry.Description := NewProdOrderComp.Description;

    //     CalcReservEntry2 := CalcReservEntry;

    //     GetItemSetup(CalcReservEntry);

    //     Positive := ForProdOrderComp."Remaining Qty. (Base)" > 0;

    //     SetPointerFilter(CalcReservEntry2);

    //     CallCalcReservedQtyOnPick;
    // end;


    // procedure SetProdOrderLine(NewProdOrderLine: Record "Prod. Order Line")
    // begin
    //     CLEARALL;
    //     TempTrackingSpecification.DELETEALL;

    //     ForProdOrderLine := NewProdOrderLine;

    //     CalcReservEntry."Source Type" := DATABASE::"Prod. Order Line";
    //     CalcReservEntry."Source Subtype" := ForProdOrderLine.Status;
    //     CalcReservEntry."Source ID" := ForProdOrderLine."Prod. Order No.";
    //     CalcReservEntry."Source Prod. Order Line" := NewProdOrderLine."Line No.";

    //     CalcReservEntry."Item No." := NewProdOrderLine."Item No.";
    //     CalcReservEntry."Variant Code" := NewProdOrderLine."Variant Code";
    //     CalcReservEntry."Location Code" := NewProdOrderLine."Location Code";
    //     CalcReservEntry."Serial No." := '';
    //     CalcReservEntry."Lot No." := '';
    //     CalcReservEntry."Qty. per Unit of Measure" := NewProdOrderLine."Qty. per Unit of Measure";
    //     CalcReservEntry."Expected Receipt Date" := NewProdOrderLine."Due Date";
    //     CalcReservEntry."Shipment Date" := NewProdOrderLine."Due Date";
    //     CalcReservEntry."Planning Flexibility" := NewProdOrderLine."Planning Flexibility";
    //     CalcReservEntry.Description := NewProdOrderLine.Description;

    //     CalcReservEntry2 := CalcReservEntry;

    //     GetItemSetup(CalcReservEntry);

    //     Positive := ForProdOrderLine."Remaining Qty. (Base)" < 0;

    //     SetPointerFilter(CalcReservEntry2);

    //     CallCalcReservedQtyOnPick;
    // end;

    // procedure GetItemSetup(VAR ReservEntry: Record "Reservation Entry")
    // begin
    //     IF ReservEntry."Item No." <> Item."No." THEN BEGIN
    //         Item.GET(ReservEntry."Item No.");
    //         IF Item."Item Tracking Code" <> '' THEN
    //             ItemTrackingCode.GET(Item."Item Tracking Code")
    //         ELSE
    //             ItemTrackingCode.INIT;
    //         GetPlanningParameters.AtSKU(SKU, ReservEntry."Item No.",
    //           ReservEntry."Variant Code", ReservEntry."Location Code");
    //         MfgSetup.GET;
    //     END;

    // end;

    // procedure SetPointerFilter(VAR ReservEntry: Record "Reservation Entry")
    // begin
    //     ReservEntry.SETCURRENTKEY(
    //       "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
    //       "Source Batch Name", "Source Prod. Order Line", "Reservation Status",
    //       "Shipment Date", "Expected Receipt Date");
    //     ReservEntry.SETRANGE("Source ID", ReservEntry."Source ID");
    //     ReservEntry.SETRANGE("Source Ref. No.", ReservEntry."Source Ref. No.");
    //     ReservEntry.SETRANGE("Source Type", ReservEntry."Source Type");
    //     ReservEntry.SETRANGE("Source Subtype", ReservEntry."Source Subtype");
    //     ReservEntry.SETRANGE("Source Batch Name", ReservEntry."Source Batch Name");
    //     ReservEntry.SETRANGE("Source Prod. Order Line", ReservEntry."Source Prod. Order Line");
    // End;

    // procedure CallCalcReservedQtyOnPick()
    // begin
    //     IF Positive AND
    //        (CalcReservEntry."Location Code" <> '') AND
    //        Location.GET(CalcReservEntry."Location Code") AND
    //        (Location."Bin Mandatory" OR Location."Require Pick")
    //     THEN
    //         CalcReservedQtyOnPick(TotalAvailQty, QtyAllocInWhse);
    // end;

    // procedure CalcReservedQtyOnPick(VAR AvailQty: Decimal; VAR AllocQty: Decimal)
    // var
    //     WhseActivLine: Record "Warehouse Activity Line";
    //     TempWhseActivLine2: Record "Warehouse Activity Line";
    //     WhseAvailMgt: Codeunit "Warehouse Availability Mgt.";
    //     PickQty: Decimal;
    //     QtyOnOutboundBins: Decimal;
    //     QtyOnInvtMovement: Decimal;
    //     QtyOnAssemblyBin: Decimal;
    // begin
    //     GetItemSetup(CalcReservEntry);
    //     Item.SETRANGE("Location Filter", CalcReservEntry."Location Code");
    //     Item.SETRANGE("Variant Filter", CalcReservEntry."Variant Code");
    //     IF CalcReservEntry."Lot No." <> '' THEN
    //         Item.SETRANGE("Lot No. Filter", CalcReservEntry."Lot No.");
    //     IF CalcReservEntry."Serial No." <> '' THEN
    //         Item.SETRANGE("Serial No. Filter", CalcReservEntry."Serial No.");
    //     Item.CALCFIELDS(
    //       Inventory, "Reserved Qty. on Inventory");

    //     WhseActivLine.SETCURRENTKEY(
    //       "Item No.", "Bin Code", "Location Code", "Action Type", "Variant Code",
    //       "Unit of Measure Code", "Breakbulk No.", "Activity Type", "Lot No.", "Serial No.");

    //     WhseActivLine.SETRANGE("Item No.", CalcReservEntry."Item No.");
    //     IF Location."Bin Mandatory" THEN
    //         WhseActivLine.SETFILTER("Bin Code", '<>%1', '');
    //     WhseActivLine.SETRANGE("Location Code", CalcReservEntry."Location Code");
    //     WhseActivLine.SETFILTER(
    //       "Action Type", '%1|%2', WhseActivLine."Action Type"::" ", WhseActivLine."Action Type"::Take);
    //     WhseActivLine.SETRANGE("Variant Code", CalcReservEntry."Variant Code");
    //     WhseActivLine.SETRANGE("Breakbulk No.", 0);
    //     WhseActivLine.SETFILTER(
    //       "Activity Type", '%1|%2', WhseActivLine."Activity Type"::Pick, WhseActivLine."Activity Type"::"Invt. Pick");
    //     IF CalcReservEntry."Lot No." <> '' THEN
    //         WhseActivLine.SETRANGE("Lot No.", CalcReservEntry."Lot No.");
    //     IF CalcReservEntry."Serial No." <> '' THEN
    //         WhseActivLine.SETRANGE("Serial No.", CalcReservEntry."Serial No.");
    //     WhseActivLine.CALCSUMS("Qty. Outstanding (Base)");
    //     //     IF Location."Require Pick" THEN BEGIN
    //     //         QtyOnOutboundBins :=
    //     //           CreatePick.CalcQtyOnOutboundBins(
    //     //             "Location Code", "Item No.", "Variant Code", "Lot No.", "Serial No.", TRUE);
    //     //         QtyReservedOnPickShip :=
    //     //           WhseAvailMgt.CalcReservQtyOnPicksShips(
    //     //             "Location Code", "Item No.", "Variant Code", TempWhseActivLine2);
    //     //         QtyOnInvtMovement := CalcQtyOnInvtMovement(WhseActivLine);
    //     //         QtyOnAssemblyBin :=
    //     //           WhseAvailMgt.CalcQtyOnAssemblyBin("Location Code", "Item No.", "Variant Code", "Lot No.", "Serial No.");
    //     //     END;
    //     //     AllocQty :=
    //     //       WhseActivLine."Qty. Outstanding (Base)" + QtyOnInvtMovement + QtyOnOutboundBins + QtyOnAssemblyBin;
    //     //     PickQty := WhseActivLine."Qty. Outstanding (Base)" + QtyOnInvtMovement;
    //     //     AvailQty :=
    //     //       Item.Inventory - PickQty - QtyOnOutboundBins - QtyOnAssemblyBin -
    //     //       Item."Reserved Qty. on Inventory" + QtyReservedOnPickShip;
    // END;

    // procedure CalcQtyOnOutboundBins(LocationCode: Code[10]; ItemNo: Code[20]; VariantCode: Code[10]; LotNo: Code[20]; SerialNo: Code[20]; ExcludeDedicatedBinContent: Boolean) QtyOnOutboundBins: Decimal
    // // Directed put-away and pick
    // var
    //     WhseEntry: Record "Warehouse Entry";
    //     WhseShptLine: Record "Warehouse Shipment Line";
    // Begin
    //     GetLocation(LocationCode);

    //     IF Location."Directed Put-away and Pick" THEN
    //         WITH WhseEntry DO BEGIN
    //             FilterWhseEntry(
    //               WhseEntry, ItemNo, LocationCode, VariantCode, TRUE, LotNo, TRUE, SerialNo, ExcludeDedicatedBinContent);
    //             SETFILTER("Bin Type Code", GetBinTypeFilter(1)); // Shipping area
    //             CALCSUMS("Qty. (Base)");
    //             QtyOnOutboundBins := "Qty. (Base)";
    //             IF Location."Adjustment Bin Code" <> '' THEN BEGIN
    //                 SETRANGE("Bin Type Code");
    //                 SETRANGE("Bin Code", Location."Adjustment Bin Code");
    //                 CALCSUMS("Qty. (Base)");
    //                 QtyOnOutboundBins += "Qty. (Base)";
    //             END
    //         END
    //     ELSE
    //         IF Location."Require Pick" THEN
    //             IF Location."Bin Mandatory" AND ((LotNo <> '') OR (SerialNo <> '')) THEN BEGIN
    //                 FilterWhseEntry(WhseEntry, ItemNo, LocationCode, VariantCode, TRUE, LotNo, TRUE, SerialNo, FALSE);
    //                 WITH WhseEntry DO BEGIN
    //                     SETRANGE("Whse. Document Type", "Whse. Document Type"::Shipment);
    //                     SETRANGE("Reference Document", "Reference Document"::Pick);
    //                     SETFILTER("Qty. (Base)", '>%1', 0);
    //                     QtyOnOutboundBins := CalcResidualPickedQty(WhseEntry);
    //                 END
    //             END ELSE
    //                 WITH WhseShptLine DO BEGIN
    //                     SETRANGE("Item No.", ItemNo);
    //                     SETRANGE("Location Code", LocationCode);
    //                     SETRANGE("Variant Code", VariantCode);
    //                     CALCSUMS("Qty. Picked (Base)", "Qty. Shipped (Base)");
    //                     QtyOnOutboundBins := "Qty. Picked (Base)" - "Qty. Shipped (Base)";
    //                 END;
    // end;

    procedure GetLocation(LocationCode: Code[10])
    Begin
        IF LocationCode = '' THEN
            Location := WhseSetupLocation
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
    End;

    var
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        SKU: Record "Stockkeeping Unit";
        CreatePick: Codeunit "Create Pick";
        WhseSetupLocation: Record Location;
        Location: Record Location;
        ItemTrackingCode: Record "Item Tracking Code";
        MfgSetup: Record "Manufacturing Setup";
        GetPlanningParameters: Codeunit "Planning-Get Parameters";


        ForProdOrderComp: Record "Prod. Order Component";
        CalcReservEntry: Record "Reservation Entry";
        Positive: Boolean;
        TotalAvailQty: Decimal;
        QtyAllocInWhse: Decimal;
        CalcReservEntry2: Record "Reservation Entry";
        ForProdOrderLine: Record "Prod. Order Line";
}

