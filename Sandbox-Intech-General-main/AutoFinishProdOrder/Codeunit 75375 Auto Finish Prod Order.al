Codeunit 75375 "Auto Finish Prod Order"
{
    TableNo = "Production Order";
    //AutoFinishProdOrder

    trigger OnRun()
    var
        PurchLine_lRec: Record "Purchase Line";
        ProdOrderLine_lRec: Record "Prod. Order Line";
        ProdOrderStatusMgmt_lCdu: Codeunit "Prod. Order Status Manag New";
        ItemLedgerEntry_lRec: Record "Item Ledger Entry";
        LastOutputDate_lDat: Date;
    begin
        //NG-NS
        if Rec.Status <> Rec.Status::Released then
            exit;

        PurchLine_lRec.Reset;
        PurchLine_lRec.SetRange("Document Type", PurchLine_lRec."document type"::Order);
        PurchLine_lRec.SetRange("Prod. Order No.", Rec."No.");
        if PurchLine_lRec.FindFirst then
            exit;

        // ProdOrderLine_lRec.RESET;
        // ProdOrderLine_lRec.SETRANGE(Status,Status);
        // ProdOrderLine_lRec.SETRANGE("Prod. Order No.","No.");
        // ProdOrderLine_lRec.SETFILTER("Remaining Quantity",'<>%1',0);
        // IF ProdOrderLine_lRec.FINDFIRST THEN
        //  EXIT;


        ProdOrderLine_lRec.Reset;
        ProdOrderLine_lRec.SetRange(Status, Rec.Status);
        ProdOrderLine_lRec.SetRange("Prod. Order No.", Rec."No.");
        ProdOrderLine_lRec.SetFilter("Finished Quantity", '<>%1', 0);
        if not ProdOrderLine_lRec.FindFirst then
            exit;

        LastOutputDate_lDat := 0D;
        ItemLedgerEntry_lRec.Reset;
        ItemLedgerEntry_lRec.SetRange("Entry Type", ItemLedgerEntry_lRec."entry type"::Output);
        ItemLedgerEntry_lRec.SetRange("Order Type", ItemLedgerEntry_lRec."order type"::Production);
        ItemLedgerEntry_lRec.SetRange("Order No.", Rec."No.");
        ItemLedgerEntry_lRec.SetRange("Order Line No.", 10000);
        if ItemLedgerEntry_lRec.FindLast then begin
            LastOutputDate_lDat := ItemLedgerEntry_lRec."Posting Date";
        end;

        if LastOutputDate_lDat = 0D then
            exit;

        Clear(ProdOrderStatusMgmt_lCdu);
        ProdOrderStatusMgmt_lCdu.AutoFinishProdOrder_gFnc(Rec."No.", LastOutputDate_lDat);
        //NG-NE
    end;


    procedure IsOrderToFinish_gFnc(ProductionOrder_iRec: Record "Production Order"): Boolean
    var
        PurchLine_lRec: Record "Purchase Line";
        ProdOrderLine_lRec: Record "Prod. Order Line";
    begin
        //NG-NS
        if ProductionOrder_iRec.Status <> ProductionOrder_iRec.Status::Released then
            exit(false);

        PurchLine_lRec.Reset;
        PurchLine_lRec.SetRange("Document Type", PurchLine_lRec."document type"::Order);
        PurchLine_lRec.SetRange("Prod. Order No.", ProductionOrder_iRec."No.");
        if PurchLine_lRec.FindFirst then
            exit(false);

        ProdOrderLine_lRec.Reset;
        ProdOrderLine_lRec.SetRange(Status, ProductionOrder_iRec.Status);
        ProdOrderLine_lRec.SetRange("Prod. Order No.", ProductionOrder_iRec."No.");
        ProdOrderLine_lRec.SetRange("Line No.", 10000);
        ProdOrderLine_lRec.SetFilter("Finished Quantity", '<>%1', 0);
        if not ProdOrderLine_lRec.FindFirst then
            exit(false);

        exit(true);
        //NG-NE
    end;
}

