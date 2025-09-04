codeunit 74995 "Preview Posting SingleIns"
{
    //PreviewPost
    SingleInstance = true;

    procedure SetSalesPreviewPost_gFnc(SH_iRec: Record "Sales Header")
    begin
        SalesRecSetup.GET;
        IF NOT SalesRecSetup."Enable Sales Preview Post" THEN
            EXIT;
        IF NOT (SH_iRec."Document Type" IN [SH_iRec."Document Type"::Order, SH_iRec."Document Type"::"Return Order", SH_iRec."Document Type"::Invoice, SH_iRec."Document Type"::"Credit Memo"]) THEN
            EXIT;
        LastPreviewDocNo_gCod := '';
        StartPreviewPostingDocNo_gCod := SH_iRec."No.";
    end;

    procedure SetPurchPreviewPost_gFnc(PH_iRec: Record "Purchase Header")
    var
        PurchRecSetup: Record "Purchases & Payables Setup";
    begin
        PurchRecSetup.GET;
        IF NOT PurchRecSetup."Enable Purchase Preview Post" THEN
            EXIT;
        IF NOT (PH_iRec."Document Type" IN [PH_iRec."Document Type"::Order, PH_iRec."Document Type"::"Return Order", PH_iRec."Document Type"::Invoice, PH_iRec."Document Type"::"Credit Memo"]) THEN
            EXIT;
        LastPreviewDocNo_gCod := '';
        StartPreviewPostingDocNo_gCod := PH_iRec."No.";
    end;

    procedure IsDocNoSet_gFnc(): Boolean
    begin
        IF StartPreviewPostingDocNo_gCod <> '' THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;

    procedure VerifyPreiviewDocNo_gFnc()
    begin
        LastPreviewDocNo_gCod := StartPreviewPostingDocNo_gCod;
        PreviewUserID_gCod := USERID;
        PreviewDateTime_gDT := CURRENTDATETIME;
    end;

    procedure GetLasVerifytPreviewDocNo_gFnc(): Code[20]
    begin
        EXIT(LastPreviewDocNo_gCod);
    end;

    procedure CheckSalesPreviewPost_gFnc(SH_iRec: Record "Sales Header"): Boolean
    begin
        SalesRecSetup.GET;
        IF NOT SalesRecSetup."Enable Sales Preview Post" THEN
            EXIT(FALSE);

        IF SH_iRec."Document Type" IN [SH_iRec."Document Type"::Order, SH_iRec."Document Type"::"Return Order"] THEN BEGIN
            IF NOT SH_iRec.Invoice THEN
                EXIT(FALSE);
        END ELSE BEGIN
            IF NOT (SH_iRec."Document Type" IN [SH_iRec."Document Type"::Invoice, SH_iRec."Document Type"::"Credit Memo"]) THEN
                EXIT(FALSE);
        END;

        EXIT(TRUE);
    end;

    procedure CheckPurchPreviewPost_gFnc(PH_iRec: Record "Purchase Header"): Boolean
    begin
        PurchRecSetup.GET;
        IF NOT PurchRecSetup."Enable Purchase Preview Post" THEN
            EXIT;

        IF PH_iRec."Document Type" IN [PH_iRec."Document Type"::Order, PH_iRec."Document Type"::"Return Order"] THEN BEGIN
            IF NOT PH_iRec.Invoice THEN
                EXIT(FALSE);
        END ELSE BEGIN
            IF NOT (PH_iRec."Document Type" IN [PH_iRec."Document Type"::Invoice, PH_iRec."Document Type"::"Credit Memo"]) THEN
                EXIT(FALSE);
        END;

        EXIT(TRUE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Preview", 'OnBeforeShowAllEntries', '', true, true)]
    local procedure OnBeforeShowAllEntries(var TempDocumentEntry: Record "Document Entry" temporary; var IsHandled: Boolean; var PostingPreviewEventHandler: Codeunit "Posting Preview Event Handler")
    begin
        Clear(gCPostingPreviewEventHandler);
        gCPostingPreviewEventHandler := PostingPreviewEventHandler;
    end;

    procedure ShowEntries()
    begin
        gCPostingPreviewEventHandler.ShowEntries(17);
    end;

    var
        LastPreviewDocNo_gCod: Code[20];
        StartPreviewPostingDocNo_gCod: Code[20];
        PreviewUserID_gCod: Code[20];
        PreviewDateTime_gDT: DateTime;
        PurchRecSetup: Record "Purchases & Payables Setup";
        SalesRecSetup: Record "Sales & Receivables Setup";
        TempGLEntry: Record "G/L Entry" temporary;
        gCPostingPreviewEventHandler: Codeunit "Posting Preview Event Handler";



}
