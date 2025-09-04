pageextension 75050 GL_Entries_Preview_75050 extends "G/L Entries Preview"
{
    actions

    {
        //PreviewPost-NS
        addafter(Dimensions)
        {

            action(Verify)
            {
                Caption = 'Verify';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ShortcutKey = 'F9';
                trigger OnAction()
                begin
                    PreviewPostingSingleIns_gCdu.VerifyPreiviewDocNo_gFnc;
                    PrePostOK_gBln := TRUE;
                    CurrPage.CLOSE;
                end;
            }
            action(PreviewVoucher)
            {
                Caption = 'Preview Voucher';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ShortcutKey = 'F10';
                trigger OnAction()
                var
                    rePostedVoucher_lRpt: Report "Pre Posted Voucher";
                begin
                    //T7223-NS  05-02-18
                    rePostedVoucher_lRpt.CopyTmpTable_gFnc(Rec);
                    rePostedVoucher_lRpt.RunModal();
                    //T7223-NE  05-02-18
                end;
            }

        }

    }
    trigger OnOpenPage()
    begin
        VerifyRequire_gBln := PreviewPostingSingleIns_gCdu.IsDocNoSet_gFnc;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        IF (VerifyRequire_gBln) AND (NOT PrePostOK_gBln) THEN BEGIN
            IF CONFIRM('Do you want to verify the entries?', FALSE) THEN
                PreviewPostingSingleIns_gCdu.VerifyPreiviewDocNo_gFnc;
        END;

    end;

    var
        VerifyRequire_gBln: Boolean;
        PreviewPostingSingleIns_gCdu: Codeunit "Preview Posting SingleIns";
        PrePostOK_gBln: Boolean;
    //PreviewPost-NE
}
