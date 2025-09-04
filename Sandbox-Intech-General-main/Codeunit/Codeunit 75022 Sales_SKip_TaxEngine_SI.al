Codeunit 75022 "Sales_SKip_TaxEngine_SI"
{    //T35424-N New Obect
    SingleInstance = true;

    procedure SetSkipCal_gFnc(SetSkipCal_iBln: Boolean)
    begin
        SalesSetup_gRec.GET;
        IF NOT SalesSetup_gRec."Skip TE on Sales Entry" then
            Exit;

        SetSkipCal_gBln := SetSkipCal_iBln;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Use Case Event Handling", 'OnBeforeSalesUseCaseHandleEvent', '', false, false)]
    local procedure OnBeforeSalesUseCaseHandleEvent(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; var IsHandled: Boolean);
    begin
        IF SetSkipCal_gBln then
            IsHandled := TRUE;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Tax", 'OnBeforeCallTaxEngineForSalesLine', '', false, false)]
    local procedure OnBeforeCallTaxEngineForSalesLine(var SalesLine: Record "Sales Line"; var IsHandled: Boolean);
    begin
        IF SetSkipCal_gBln then
            IsHandled := TRUE;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeOpenDocumentStatistics', '', false, false)]
    local procedure OnBeforeOpenDocumentStatistics(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean);
    begin
        SetSkipCal_gBln := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var Sender: Codeunit "Sales-Post"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean);
    begin
        SetSkipCal_gBln := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; SkipCheckReleaseRestrictions: Boolean);
    begin
        SetSkipCal_gBln := false;
    end;

    var
        SetSkipCal_gBln: Boolean;
        SalesSetup_gRec: Record "Sales & Receivables Setup";
}

