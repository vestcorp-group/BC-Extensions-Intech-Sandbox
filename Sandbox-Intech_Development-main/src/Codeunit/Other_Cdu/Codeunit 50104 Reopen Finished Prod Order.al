#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50104 "Re-Open Production Order"
{
    //ReOpenPrOrd - new codeunit

    Permissions = tabledata 5896 = m;
    // ************************************ SQL Store Procedure ******************************************************************
    // /****** Object:  StoredProcedure [dbo].[Hirel_OpenPordOrder]    Script Date: 03-02-2017 11:58:15 ******/
    // SET ANSI_NULLS ON
    // GO
    // SET QUOTED_IDENTIFIER ON
    // GO
    // Create PROC [dbo].[Hirel_OpenPordOrder]
    // @ProdOrder varchar(20)
    // AS
    // BEGIN
    // SET NOCOUNT ON
    // SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    // 
    // 
    // 
    // Update  [PASL Windtech Pvt_ Ltd_ - LIVE$Production Order] set [Status] = 3  WHERE No_ = @ProdOrder
    // update  [PASL Windtech Pvt_ Ltd_ - LIVE$Prod_ Order Line] set [Status] = 3 WHERE  [Prod_ Order No_] = @ProdOrder
    // update [PASL Windtech Pvt_ Ltd_ - LIVE$Prod_ Order Comment Line]  set [Status] = 3 WHERE [Prod_ Order No_] = @ProdOrder
    // update [PASL Windtech Pvt_ Ltd_ - LIVE$Inventory Adjmt_ Entry (Order)] set [Cost is Adjusted] = 0 , [Is Finished] = 0 WHERE [Order No_] = @ProdOrder
    // update [PASL Windtech Pvt_ Ltd_ - LIVE$Prod_ Order Component] set Status = 3 where [Prod_ Order No_] = @ProdOrder
    // Update  [PASL Windtech Pvt_ Ltd_ - LIVE$Prod_ Order Routing Line] set [Status] = 3  WHERE [Prod_ Order No_] = @ProdOrder
    // 
    // END
    // ************************************************************************************************************************************************


    trigger OnRun()
    begin
    end;

    var
        Text50000: label 'Getting Detail...\';
        Text50001: label 'Connecting Database  #1##################\';
        Text50002: label 'Row Received          #2##################';


    procedure LoopProdOrder_gFnc(ProdOrder_iRec: Record "Production Order")
    var
        userSetup_lRec: Record "User Setup";
    begin
        userSetup_lRec.Get(UserId);
        userSetup_lRec.TestField(userSetup_lRec."Allow to Re-Open Prod Order.", true);

        ProdOrder_iRec.TestField(Status, ProdOrder_iRec.Status::Finished);


        if not Confirm(StrSubstNo('Production Order %1 will Re-Open.\Do you want to continue?', ProdOrder_iRec."No."), false) then
            exit;

        GetData_lFnc(ProdOrder_iRec."No.");

        Message('Production Order %1 Re-Open Successfully', ProdOrder_iRec."No.");
    end;


    procedure SQLLoopProdOrder_gFnc(ProdOrder_iRec: Record "Production Order")
    var
        userSetup_lRec: Record "User Setup";
    begin
        userSetup_lRec.GET(USERID);
        userSetup_lRec.TESTFIELD(userSetup_lRec."Allow to Re-Open Prod Order.", TRUE);

        ProdOrder_iRec.TESTFIELD(Status, ProdOrder_iRec.Status::Finished);


        IF NOT CONFIRM(STRSUBSTNO('Production Order %1 will Re-Open.\Do you want to continue?', ProdOrder_iRec."No."), FALSE) THEN
            EXIT;

        GetData_lFnc(ProdOrder_iRec."No.");

        MESSAGE('Production Order %1 Re-Open Successfully', ProdOrder_iRec."No.");
    end;

    local procedure GetData_lFnc(FinishProOrder_iCod: Code[20])
    var
        ProductionOrder_lRec: Record "Production Order";
        ModProductionOrder_lRec: Record "Production Order";
        ProdOrderLine_lRec: Record "Prod. Order Line";
        ModProdOrderLine_lRec: Record "Prod. Order Line";
        ProdOrderCommentLine_lRec: Record "Prod. Order Comment Line";
        ModProdOrderCommentLine_lRec: Record "Prod. Order Comment Line";
        InventoryAdjEntry_lRec: Record "Inventory Adjmt. Entry (Order)";
        ModInventoryAdjEntry_lRec: Record "Inventory Adjmt. Entry (Order)";
        ProdOrderComp_lRec: Record "Prod. Order Component";
        ModProdOrderComp_lRec: Record "Prod. Order Component";
        ProdOrderRoutingLine_lRec: Record "Prod. Order Routing Line";
        ModProdOrderRoutingLine_lRec: Record "Prod. Order Routing Line";

    begin
        ProductionOrder_lRec.RESET;
        ProductionOrder_lRec.SETRANGE("No.", FinishProOrder_iCod);
        IF ProductionOrder_lRec.FINDFIRST THEN BEGIN
            ModProductionOrder_lRec.GET(ProductionOrder_lRec.Status, ProductionOrder_lRec."No.");
            ModProductionOrder_lRec.RENAME(ModProductionOrder_lRec.Status::Released, ProductionOrder_lRec."No.");
        END;

        ProdOrderLine_lRec.RESET;
        ProdOrderLine_lRec.SETRANGE("Prod. Order No.", FinishProOrder_iCod);
        IF ProdOrderLine_lRec.FINDSET THEN BEGIN
            REPEAT
                ProdOrderLine_lRec.Delete();
                ModProdOrderLine_lRec := ProdOrderLine_lRec;
                ModProdOrderLine_lRec.Status := ProdOrderLine_lRec.Status::Released;
                ModProdOrderLine_lRec.Insert();
            UNTIL ProdOrderLine_lRec.NEXT = 0;
        END;

        ProdOrderCommentLine_lRec.Reset;
        ProdOrderCommentLine_lRec.SetRange("Prod. Order No.", FinishProOrder_iCod);
        IF ProdOrderCommentLine_lRec.FINDSET THEN BEGIN
            REPEAT
                ModProdOrderCommentLine_lRec.GET(ProdOrderCommentLine_lRec.Status, ProdOrderCommentLine_lRec."Prod. Order No.", ProdOrderCommentLine_lRec."Line No.");
                ModProdOrderCommentLine_lRec.RENAME(ProdOrderCommentLine_lRec.Status::Released, ProdOrderCommentLine_lRec."Prod. Order No.", ProdOrderCommentLine_lRec."Line No.");
            UNTIL ProdOrderCommentLine_lRec.NEXT = 0;
        END;

        InventoryAdjEntry_lRec.Reset;
        InventoryAdjEntry_lRec.SetRange("Order No.", FinishProOrder_iCod);
        IF InventoryAdjEntry_lRec.FINDSET THEN BEGIN
            REPEAT
                ModInventoryAdjEntry_lRec.GET(InventoryAdjEntry_lRec."Order Type", InventoryAdjEntry_lRec."Order No.", InventoryAdjEntry_lRec."Order Line No.");
                ModInventoryAdjEntry_lRec."Cost is Adjusted" := false;
                ModInventoryAdjEntry_lRec."Is Finished" := false;
                ModInventoryAdjEntry_lRec.Modify();
            UNTIL InventoryAdjEntry_lRec.NEXT = 0;
        END;

        ProdOrderComp_lRec.RESET;
        ProdOrderComp_lRec.SETRANGE("Prod. Order No.", FinishProOrder_iCod);
        IF ProdOrderComp_lRec.FINDSET THEN BEGIN
            REPEAT
                ProdOrderComp_lRec.Delete();
                ModProdOrderComp_lRec := ProdOrderComp_lRec;
                ModProdOrderComp_lRec.Status := ProdOrderComp_lRec.Status::Released;
                ModProdOrderComp_lRec.Insert();
            UNTIL ProdOrderComp_lRec.NEXT = 0;
        END;

        ProdOrderRoutingLine_lRec.Reset;
        ProdOrderRoutingLine_lRec.SetRange("Prod. Order No.", FinishProOrder_iCod);
        IF ProdOrderRoutingLine_lRec.FINDSET THEN BEGIN
            REPEAT

                ModProdOrderRoutingLine_lRec.GET(ProdOrderRoutingLine_lRec.Status, ProdOrderRoutingLine_lRec."Prod. Order No.", ProdOrderRoutingLine_lRec."Routing Reference No.", ProdOrderRoutingLine_lRec."Routing No.", ProdOrderRoutingLine_lRec."Operation No.");
                ProdOrderRoutingLine_lRec.Delete();
                ModProdOrderRoutingLine_lRec.Status := ModProdOrderRoutingLine_lRec.Status::Released;
                ModProdOrderRoutingLine_lRec."Routing Status" := ModProdOrderRoutingLine_lRec."Routing Status"::" ";//Hypercare-11-03-2025
                ModProdOrderRoutingLine_lRec.Insert();
            UNTIL ProdOrderRoutingLine_lRec.NEXT = 0;
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeShowErrorOnRename', '', false, false)]
    local procedure OnBeforeShowErrorOnRename(var IsHandled: Boolean; var ProductionOrder: Record "Production Order");
    var
        userSetup_lRec: Record "User Setup";
    begin
        userSetup_lRec.GET(USERID);
        IF userSetup_lRec."Allow to Re-Open Prod Order." Then
            IsHandled := true;
    end;
}

