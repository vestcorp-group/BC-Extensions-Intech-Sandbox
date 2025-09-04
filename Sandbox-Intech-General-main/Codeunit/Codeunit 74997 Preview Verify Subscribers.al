codeunit 74997 "Preview Verify Subscribers"
{
    //PreviewPost-NS

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean)
    begin

        IF NOT PreviewMode THEN BEGIN
            CheckPreviewPost_lCdu.CheckSalesPost_gFnc(SalesHeader);
        END;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', true, true)]
    local procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean)
    begin

        IF NOT PreviewMode THEN BEGIN
            CheckPreviewPost_lCdu.CheckPurchasePost_gFnc(PurchaseHeader);
        END;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnRunPreviewOnAfterSetPostingFlags', '', true, true)]
    local procedure OnRunPreviewOnAfterSetPostingFlags(var SalesHeader: Record "Sales Header")
    begin
        PreviewPostingSingleIns_lCdu.SetSalesPreviewPost_gFnc(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnRunPreviewOnBeforePurchPostRun', '', true, true)]
    local procedure OnRunPreviewOnBeforePurchPostRun(var PurchaseHeader: Record "Purchase Header")
    begin
        PreviewPostingSingleIns_lCdu.SetPurchPreviewPost_gFnc(PurchaseHeader);
    end;

    var
        CheckPreviewPost_lCdu: Codeunit "Check Preview Post";
        PreviewPostingSingleIns_lCdu: Codeunit "Preview Posting SingleIns";
    //PreviewPost-NE

}
