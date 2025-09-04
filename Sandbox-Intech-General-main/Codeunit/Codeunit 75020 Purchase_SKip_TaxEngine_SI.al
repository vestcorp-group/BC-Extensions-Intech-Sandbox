Codeunit 75020 "Purchase_SKip_TaxEngine_SI"
{    //TaxEngine-Optimization
    SingleInstance = true;

    procedure SetSkipCal_gFnc(SetSkipCal_iBln: Boolean)
    begin
        PurchaseSetup_gRec.GET;
        IF NOT PurchaseSetup_gRec."Skip TE on Purchase Entry" then
            Exit;

        SetSkipCal_gBln := SetSkipCal_iBln;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Use Case Event Handling", 'OnBeforePurchaseUseCaseHandleEvent', '', false, false)]
    local procedure OnBeforePurchaseUseCaseHandleEvent(var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; var IsHandled: Boolean);
    begin
        IF SetSkipCal_gBln then
            IsHandled := TRUE;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Tax", 'OnBeforeCallTaxEngineForPurchaseLine', '', false, false)]
    local procedure OnBeforeCallTaxEngineForPurchaseLine(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean);
    begin
        IF SetSkipCal_gBln then
            IsHandled := TRUE;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeOpenDocumentStatistics', '', false, false)]
    local procedure OnBeforeOpenDocumentStatistics(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean);
    begin
        SetSkipCal_gBln := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure OnBeforePostPurchaseDoc(var Sender: Codeunit "Purch.-Post"; var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var IsHandled: Boolean);
    begin
        SetSkipCal_gBln := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeReleasePurchaseDoc', '', false, false)]
    local procedure OnBeforeReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var SkipCheckReleaseRestrictions: Boolean; var IsHandled: Boolean);
    begin
        SetSkipCal_gBln := false;
    end;

    var
        SetSkipCal_gBln: Boolean;
        PurchaseSetup_gRec: Record "Purchases & Payables Setup";
}

