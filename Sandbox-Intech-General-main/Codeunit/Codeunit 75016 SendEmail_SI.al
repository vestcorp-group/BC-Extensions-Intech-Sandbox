Codeunit 75016 SendEmail_Subscribe_SI
{
    //SendEmail - Event to find before and after send email popup for enable boolean flag on report attachment & add CC in default sending email
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        SalesQuoteEmailSending_gBln: Boolean;
        SH_gRec: Record "Sales Header";


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforeDoPrintSalesHeader', '', false, false)]
    local procedure OnBeforeDoPrintSalesHeader(var SalesHeader: Record "Sales Header"; ReportUsage: Integer; SendAsEmail: Boolean; var IsPrinted: Boolean);
    begin
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then begin
            SalesQuoteEmailSending_gBln := true;
            SH_gRec := SalesHeader;
        End;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnAfterDoPrintSalesHeader', '', false, false)]
    local procedure OnAfterDoPrintSalesHeader(var SalesHeader: Record "Sales Header"; SendAsEmail: Boolean);
    begin
        Clear(SH_gRec);
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
            SalesQuoteEmailSending_gBln := False;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeSendEmail', '', false, false)]
    local procedure OnBeforeSendEmail(var TempEmailItem: Record "Email Item" temporary; var IsFromPostedDoc: Boolean; var PostedDocNo: Code[20]; var HideDialog: Boolean; var ReportUsage: Integer; var EmailSentSuccesfully: Boolean; var IsHandled: Boolean; EmailDocName: Text[250]; SenderUserID: Code[50]; EmailScenario: Enum "Email Scenario");
    var
        SP_lRec: Record "Salesperson/Purchaser";
    begin
        //NG-NS 160523
        IF TempEmailItem."Send CC" = '' Then begin
            IF SH_gRec."Salesperson Code" <> '' Then begin
                SP_lRec.GET(SH_gRec."Salesperson Code");
                SP_lRec.TESTfield("E-Mail");
                TempEmailItem."Send CC" := SP_lRec."E-Mail";
            End;
        end;
        //NG-NE 160523
    end;


    procedure GetSalesQuoteSendEmail_gFnc(): Boolean
    begin
        Exit(SalesQuoteEmailSending_gBln);
    end;

    procedure SetSalesQuoteSendEmailFalse_gFnc()
    begin
        SalesQuoteEmailSending_gBln := false;
    end;


}

