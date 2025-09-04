codeunit 75024 ChargeGrpCodeSales_Subc_SI
{
    //ChargeGroupCode
    SingleInstance = true;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnRunPreviewOnAfterSetPostingFlags', '', false, false)]
    local procedure OnRunPreviewOnAfterSetPostingFlags(var SalesHeader: Record "Sales Header");
    begin
        IF SalesHeader."Charge Group Code" <> '' Then begin
            SaveItemChargeGrpCode_gCod := SalesHeader."Charge Group Code";
            SalesHeader."Charge Group Code" := '';
        End;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeRunSalesPost', '', false, false)]
    local procedure OnBeforeRunSalesPost(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var SuppressCommit: Boolean);
    begin
        IF SalesHeader."Charge Group Code" <> '' Then begin
            SaveItemChargeGrpCode_gCod := SalesHeader."Charge Group Code";
            SalesHeader."Charge Group Code" := '';
        End;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforeRunSalesPost', '', false, false)]
    local procedure OnBeforeRunSalesPostPrint(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean);
    begin
        IF SalesHeader."Charge Group Code" <> '' Then begin
            SaveItemChargeGrpCode_gCod := SalesHeader."Charge Group Code";
            SalesHeader."Charge Group Code" := '';
        End;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnPostSourceDocumentOnBeforePostSalesHeader', '', false, false)]
    local procedure OnPostSourceDocumentOnBeforePostSalesHeader(var SalesPost: Codeunit "Sales-Post"; var SalesHeader: Record "Sales Header"; WhseShptHeader: Record "Warehouse Shipment Header"; var CounterSourceDocOK: Integer; SuppressCommit: Boolean; var IsHandled: Boolean; var Invoice: Boolean);
    begin
        IF SalesHeader."Charge Group Code" <> '' Then begin
            SaveItemChargeGrpCode_gCod := SalesHeader."Charge Group Code";
            SalesHeader."Charge Group Code" := '';
        End;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeValidatePostingAndDocumentDate', '', false, false)]
    local procedure OnBeforeValidatePostingAndDocumentDate(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean);
    begin
        IF SaveItemChargeGrpCode_gCod <> '' Then begin
            IF SalesHeader."Charge Group Code" = '' then
                SalesHeader."Charge Group Code" := SaveItemChargeGrpCode_gCod;
        end;
    end;


    var
        SaveItemChargeGrpCode_gCod: Code[20];

}