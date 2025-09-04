codeunit 75004 Subscribe_Codeunit_1373
{

    //PostedVoucherPrint-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Batch Posting Print Mgt.", 'OnBeforeGLRegPostingReportPrint', '', false, false)]
    local procedure OnBeforeGLRegPostingReportPrint(var ReportID: Integer; ReqWindow: Boolean; SystemPrinter: Boolean; var GLRegister: Record "G/L Register"; var Handled: Boolean);
    var
        DocumentFilter_lTxt: Text[1024];
        GLEntryGet_lRec: Record "G/L Entry";
        GLEntry_lRec: Record "G/L Entry";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        GeneralLedgerSetup.GET;
        if NOT GeneralLedgerSetup."Post & Print with Job Queue" then begin

            Handled := true;

            DocumentFilter_lTxt := '';
            GLEntryGet_lRec.RESET;
            GLEntryGet_lRec.SETRANGE("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
            IF GLEntryGet_lRec.FINDSET THEN BEGIN
                REPEAT
                    IF STRPOS(DocumentFilter_lTxt, GLEntryGet_lRec."Document No.") = 0 THEN BEGIN
                        IF DocumentFilter_lTxt = '' THEN
                            DocumentFilter_lTxt := GLEntryGet_lRec."Document No."
                        ELSE
                            DocumentFilter_lTxt += '|' + GLEntryGet_lRec."Document No.";
                    END;

                UNTIL GLEntryGet_lRec.NEXT = 0;

                GLEntry_lRec.SETCURRENTKEY("Document No.", "Posting Date");
                GLEntry_lRec.SETFILTER("Document No.", DocumentFilter_lTxt);
                IF GLEntry_lRec.FINDFIRST THEN
                    REPORT.Run(ReportID, false, false, GLRegister);  //    REPORT.RUNMODAL(REPORT::"Posted Voucher", FALSE, FALSE, GLEntry_lRec)//16-11-2022
            END ELSE BEGIN
                REPORT.Run(ReportID, false, false, GLRegister);
            END;
        end;
    End;
    //PostedVoucherPrint-NE
}