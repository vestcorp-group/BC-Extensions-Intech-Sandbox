codeunit 75373 CopySalesPurchaseDocument
{
    SingleInstance = true;

    procedure SetSkipLines_gFnc(InputSetSkip_iBln: Boolean)

    begin
        SkipLines_gBln := InputSetSkip_iBln;
    end;

    //Hypercare-21-03-25-OS
    // [EventSubscriber(ObjectType::Report, Report::"Copy Sales Document", 'OnAfterValidateIncludeHeaderProcedure', '', true, false)]
    // local procedure OnAfterValidateIncludeHeaderProcedure(var IncludeHeader: Boolean; var RecalculateLines: Boolean; SalesHeader: Record "Sales Header"; FromDocType: Enum "Sales Document Type From")
    // begin
    //     SkipLines_gBln := NOT RecalculateLines;  //I-C0059-1005710-01-N
    // end;
    //Hypercare-21-03-25-OE

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocOnBeforeCopyLines', '', false, false)]

    local procedure OnCopySalesDocOnBeforeCopyLines(FromSalesHeader: Record "Sales Header"; var ToSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IF SkipLines_gBln then
            IsHandled := True;
    end;


    //Hypercare-21-03-25-OS
    // [EventSubscriber(ObjectType::Report, Report::"Copy Purchase Document", 'OnAfterValidateIncludeHeader', '', true, false)]
    // local procedure OnAfterValidateIncludeHeader(var RecalculateLines: Boolean; IncludeHeader: Boolean)
    // begin
    //     SkipLines_gBln := NOT RecalculateLines;  //I-C0059-1005710-01-N
    // end;
    //Hypercare-21-03-25-OE


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopyPurchDocLineOnBeforeCopyThisLine', '', false, false)]

    local procedure OnCopyPurchDocLineOnBeforeCopyThisLine(var ToPurchLine: Record "Purchase Line"; var FromPurchLine: Record "Purchase Line"; MoveNegLines: Boolean; FromPurchDocType: Enum "Purchase Document Type From"; var LinesNotCopied: Integer; var CopyThisLine: Boolean; var Result: Boolean; var IsHandled: Boolean; ToPurchaseHeader: Record "Purchase Header")
    begin
        IF SkipLines_gBln then
            IsHandled := True;
    end;

    var
        SkipLines_gBln: Boolean;
}