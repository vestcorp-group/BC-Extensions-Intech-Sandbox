Codeunit 75011 INTGEN_Sub_Codeunit_12_SI
{

    SingleInstance = true;

    var
        GenJnlLine_gRec: Record "Gen. Journal Line";
        TDSReceivableAmount_gDec: Decimal;

    trigger OnRun()
    begin

    end;


    Procedure InitTDSReceableAmt_gFnc(Type: Option DetailedCVLedgEntryBuff,TDSEntryGen; VAR GenJnlLine: Record "Gen. Journal Line"; var Sender: Codeunit "Gen. Jnl.-Post Line")
    var
        //TDSReceivableAccount_lCod: Record "Tax Accounting Period";       
        TDSReceivableAccount_lCod: Code[50];
        GLEntry: Record "G/L Entry";
    begin
        //I-C0059-1001707-01-NS
        CASE Type OF
            Type::DetailedCVLedgEntryBuff:
                IF GenJnlLine."TDS Receivable Amount" <> 0 THEN
                    TDSReceivableAmount_gDec := GenJnlLine."TDS Receivable Amount";
            Type::TDSEntryGen:
                BEGIN
                    IF TDSReceivableAmount_gDec <> 0 THEN BEGIN
                        //TDSReceivableAmount_gDec := GenJnlLine."TDS Receivable Amount";
                        TDSReceivableAccount_lCod := CheckAccountPeriod_gFnc(GenJnlLine."Posting Date");
                        IF TDSReceivableAccount_lCod = '' THEN
                            ERROR('Income Tax Accounting Period is not defined of Posting Date %1', GenJnlLine."Posting Date");
                        Sender.InitGLEntry(GenJnlLine, GLEntry, TDSReceivableAccount_lCod, TDSReceivableAmount_gDec, TDSReceivableAmount_gDec, TRUE, TRUE);
                        Sender.InsertGLEntry(GenJnlLine, GLEntry, TRUE);
                    END;
                END;
        END;
        //I-C0059-1001707-01-NE
    end;

    procedure CheckAccountPeriod_gFnc(PostingDate: Date): Code[20]
    var
        ITAccountingPeriod_lRec: Record "Tax Accounting Period";
    begin
        //I-C0059-1001707-01-NS
        ITAccountingPeriod_lRec.RESET;
        ITAccountingPeriod_lRec.ASCENDING(FALSE);
        ITAccountingPeriod_lRec.SetRange("Tax Type Code", 'TDS/TCS');
        ITAccountingPeriod_lRec.SetFilter("Starting Date", '<=%1', PostingDate);
        ITAccountingPeriod_lRec.SetFilter("Ending Date", '>=%1', PostingDate);
        IF ITAccountingPeriod_lRec.FINDFIRST THEN
            REPEAT
                ITAccountingPeriod_lRec.TESTFIELD("TDS Receivable Account");
                EXIT(ITAccountingPeriod_lRec."TDS Receivable Account");
            UNTIL ITAccountingPeriod_lRec.NEXT = 0;
        EXIT('');
        //I-C0059-1001707-01-NE
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostCustOnAfterAssignReceivablesAccount', '', false, false)]
    local procedure OnPostCustOnAfterAssignReceivablesAccount(GenJnlLine: Record "Gen. Journal Line"; CustomerPostingGroup: Record "Customer Posting Group"; var ReceivablesAccount: Code[20]);
    var
        Dummy_lCdu: Codeunit "Gen. Jnl.-Post Line";
    begin
        //I-C0059-1001707-01-NS
        TDSReceivableAmount_gDec := 0;
        InitTDSReceableAmt_gFnc(0, GenJnlLine, Dummy_lCdu);
        //I-C0059-1001707-01-NE
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostCust', '', false, false)]
    local procedure OnAfterPostCust(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextEntryNo: Integer; var NextTransactionNo: Integer);
    begin
        //I-C0059-1001707-01-NS
        InitTDSReceableAmt_gFnc(1, GenJournalLine, Sender);
        TDSReceivableAmount_gDec := 0;
        //I-C0059-1001707-01-NE
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostCustOnAfterTempDtldCVLedgEntryBufCopyFromGenJnlLine', '', false, false)]
    local procedure OnPostCustOnAfterTempDtldCVLedgEntryBufCopyFromGenJnlLine(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary);
    begin
        //I-C0059-1001707-01-NS
        IF TDSReceivableAmount_gDec <> 0 Then begin
            TempDtldCVLedgEntryBuf.Amount := GenJournalLine.Amount - TDSReceivableAmount_gDec;
            TempDtldCVLedgEntryBuf."Amount (LCY)" := GenJournalLine."Amount (LCY)" - TDSReceivableAmount_gDec;
            TempDtldCVLedgEntryBuf."Additional-Currency Amount" := GenJournalLine.Amount - TDSReceivableAmount_gDec;
        End;
        //I-C0059-1001707-01-NE
    end;

}

