codeunit 74996 "Check Preview Post"
{ //PreviewPost-NS
    procedure CheckSalesPost_gFnc(SalesHeader_iRec: Record "Sales Header")
    begin
        IF NOT PreviewPostingSingleIns_gCdu.CheckSalesPreviewPost_gFnc(SalesHeader_iRec) THEN
            EXIT;

        IF SalesHeader_iRec."No." <> PreviewPostingSingleIns_gCdu.GetLasVerifytPreviewDocNo_gFnc THEN
            ERROR('Please check the preview posting for Document No. = %1', SalesHeader_iRec."No.");
    end;

    procedure CheckPurchasePost_gFnc(PurchHeader_iRec: Record "Purchase Header")
    begin
        IF NOT PreviewPostingSingleIns_gCdu.CheckPurchPreviewPost_gFnc(PurchHeader_iRec) THEN
            EXIT;

        IF PurchHeader_iRec."No." <> PreviewPostingSingleIns_gCdu.GetLasVerifytPreviewDocNo_gFnc THEN
            ERROR('Please check the preview posting for Document No. = %1', PurchHeader_iRec."No.");
    end;

    var
        PreviewPostingSingleIns_gCdu: Codeunit "Preview Posting SingleIns";
    //PreviewPost-NE


}
