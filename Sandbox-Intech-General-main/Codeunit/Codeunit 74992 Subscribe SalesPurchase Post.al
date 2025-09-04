codeunit 74992 "Subscribe Sales Purchase Post"
{
    //PostOption-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPostProcedure', '', true, true)]
    local procedure OnBeforeConfirmPurchPost(var PurchaseHeader: Record "Purchase Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        PurchRecSetup: Record "Purchases & Payables Setup";
        Selection: Integer;
        ShipQst: Label '&Ship';
        ReceiveQst: Label '&Receive';
    begin
        PurchRecSetup.Get();
        IF Not PurchRecSetup."Enable Ship-Recieve Purchase" then
            exit;
        IF NOT (PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::"Return Order"]) then
            exit;
        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Order:
                begin
                    Selection := StrMenu(ReceiveQst, 1);
                    IF Selection <> 1 then begin
                        Result := false;
                        IsHandled := true;
                        exit;
                    end else begin
                        PurchaseHeader.Receive := true;
                        PurchaseHeader."Print Posted Documents" := false;
                    end;
                end;
            PurchaseHeader."Document Type"::"Return Order":
                begin
                    Selection := StrMenu(ShipQst, 1);
                    IF Selection <> 1 then begin
                        Result := false;
                        IsHandled := true;
                        exit;
                    end else begin
                        PurchaseHeader.Ship := true;
                        PurchaseHeader."Print Posted Documents" := false;
                    end;

                end

        end;
        IsHandled := true;
        Result := true;
        PurchaseHeader."Print Posted Documents" := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmPost', '', true, true)]
    local procedure OnBeforeConfirmSalesPost(var SalesHeader: Record "Sales Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        SalesRecSetup: Record "Sales & Receivables Setup";
        Selection: Integer;
        ShipQst: Label '&Ship';
        ReceiveQst: Label '&Receive';
    begin
        SalesRecSetup.Get();
        IF Not SalesRecSetup."Enable only Ship-Receive Sales" then
            exit;
        IF NOT (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::"Return Order"]) then
            exit;
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Order:
                begin
                    Selection := StrMenu(ShipQst, 1);
                    IF Selection <> 1 then begin
                        Result := false;
                        IsHandled := true;
                        exit;
                    end else begin
                        SalesHeader.ship := true;
                        SalesHeader."Print Posted Documents" := false;
                    end;
                end;
            SalesHeader."Document Type"::"Return Order":
                begin
                    Selection := StrMenu(ReceiveQst, 1);
                    IF Selection <> 1 then begin
                        Result := false;
                        IsHandled := true;
                        exit;
                    end else begin
                        SalesHeader.Receive := true;
                        SalesHeader."Print Posted Documents" := false;
                    end
                end

        end;
        IsHandled := true;
        Result := true;
        SalesHeader."Print Posted Documents" := false;
    end;
    //PostOption-NE

    //StopDelete-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeFinalizePosting', '', true, true)]
    local procedure OnBeforePurchaseFinalizePosting(var PurchaseHeader: Record "Purchase Header"; var TempPurchLineGlobal: Record "Purchase Line" temporary; var EverythingInvoiced: Boolean; CommitIsSupressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        PurchRecSetup: Record "Purchases & Payables Setup";
    begin
        PurchRecSetup.Get();
        IF PurchRecSetup."Stop Delete Order on Post" then
            EverythingInvoiced := false;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeFinalizePosting', '', true, true)]
    local procedure OnBeforeSalesFinalizePosting(var SalesHeader: Record "Sales Header"; var TempSalesLineGlobal: Record "Sales Line" temporary; var EverythingInvoiced: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        SalesRecSetup: Record "Sales & Receivables Setup";
    begin
        SalesRecSetup.Get();
        IF SalesRecSetup."Stop Delete Order on Post" then
            EverythingInvoiced := false;

    end;
    //StopDelete-NE


    //SkipLocErrorHdrLine-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"GST Sales Validation", 'OnBeforeCheckHeaderLocation', '', false, false)]
    local procedure OnBeforeCheckHeaderLocation_Sales(SalesLine: Record "Sales Line"; var IsHandled: Boolean);
    begin
        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"GST Purchase Subscribers", 'OnBeforeCheckHeaderLocation', '', false, false)]
    local procedure OnBeforeCheckHeaderLocation_Purcahse(PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean);
    begin
        IsHandled := true;
    end;
    //SkipLocErrorHdrLine-NE
}



