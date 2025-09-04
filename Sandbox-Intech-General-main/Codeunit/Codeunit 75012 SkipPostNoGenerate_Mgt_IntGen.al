codeunit 75012 SkipPostNoGenerate_Mgt_IntGen
{
    //SkipPostingNoGenerate-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure C_80_OnBeforePostSalesDoc(var Sender: Codeunit "Sales-Post"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean)
    begin
        IF NOT PreviewMode Then
            Sender.SetSuppressCommit(true);
    End;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure C_90_OnBeforePostPurchaseDoc(var Sender: Codeunit "Purch.-Post"; var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean)
    begin
        IF NOT PreviewMode Then
            Sender.SetSuppressCommit(true);
    end;
    //SkipPostingNoGenerate-NE
}