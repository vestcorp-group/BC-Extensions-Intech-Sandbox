codeunit 75028 ChargeGrpCodePurch_Subc_SI
{
    //ChargeGroupCode
    SingleInstance = true;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", OnRunPreviewOnBeforePurchPostRun, '', false, false)]
    local procedure OnRunPreviewOnBeforePurchPostRun(var PurchaseHeader: Record "Purchase Header");
    begin
        IF PurchaseHeader."Charge Group Code" <> '' Then begin
            SaveItemChargeGrpCode_gCod := PurchaseHeader."Charge Group Code";
            PurchaseHeader."Charge Group Code" := '';
        End;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", OnBeforeRunPurchPost, '', false, false)]
    local procedure OnBeforeRunPurchPost(var PurchaseHeader: Record "Purchase Header");
    begin
        IF PurchaseHeader."Charge Group Code" <> '' Then begin
            SaveItemChargeGrpCode_gCod := PurchaseHeader."Charge Group Code";
            PurchaseHeader."Charge Group Code" := '';
        End;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", OnBeforeRunPurchPost, '', false, false)]
    local procedure OnBeforeRunPurchPost_Print(var PurchHeader: Record "Purchase Header"; var IsHandled: Boolean);
    begin
        IF PurchHeader."Charge Group Code" <> '' Then begin
            SaveItemChargeGrpCode_gCod := PurchHeader."Charge Group Code";
            PurchHeader."Charge Group Code" := '';
        End;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnBeforePostSourcePurchDocument, '', false, false)]
    local procedure OnBeforePostSourcePurchDocument(var PurchPost: Codeunit "Purch.-Post"; var PurchHeader: Record "Purchase Header"; var CounterSourceDocOK: Integer; var IsHandled: Boolean);
    begin
        IF PurchHeader."Charge Group Code" <> '' Then begin
            SaveItemChargeGrpCode_gCod := PurchHeader."Charge Group Code";
            PurchHeader."Charge Group Code" := '';
        End;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforeValidatePostingAndDocumentDate, '', false, false)]
    local procedure OnBeforeValidatePostingAndDocumentDate(var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean);
    begin
        IF SaveItemChargeGrpCode_gCod <> '' Then begin
            IF PurchaseHeader."Charge Group Code" = '' then
                PurchaseHeader."Charge Group Code" := SaveItemChargeGrpCode_gCod;
        end;
    end;

    var
        SaveItemChargeGrpCode_gCod: Code[20];

}