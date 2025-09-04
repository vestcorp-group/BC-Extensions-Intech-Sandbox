Codeunit 74991 "Allow Posting Date Sub"
{
    //Subscribing Codeunit 11 "Gen. Jnl.-Check Line"
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnBeforeDateNotAllowed', '', true, true)]
    // local procedure "Gen. Jnl.-Check Line_OnBeforeDateNotAllowed"
    // (
    //     GenJnlLine: Record "Gen. Journal Line";
    //     var DateCheckDone: Boolean
    // )
    // var
    //     GenJnlCheckLine_lCodeunit: Codeunit "Gen. Jnl.-Check Line";
    //     PostingDateErr_gCtx: Label 'is not within your range of allowed posting dates\User ID = %1\Document Posting Date = %2\User Setup Allow Posting Date %3..%4\\GL Setup Allow Posting Date %5..%6';
    //     UserSetup: Record "User Setup";
    //     GLSetup: Record "General Ledger Setup";
    // begin
    //     UserSetup.Reset();
    //     UserSetup.Get(UserId);
    //     GLSetup.Reset();
    //     GLSetup.GET();

    //     if GenJnlCheckLine_lCodeunit.DateNotAllowed(GenJnlLine."Posting Date", GenJnlLine."Journal Template Name") then
    //         GenJnlLine.FIELDERROR("Posting Date", STRSUBSTNO(PostingDateErr_gCtx, USERID, GenJnlLine."Posting Date", UserSetup."Allow Posting From", UserSetup."Allow Posting To", GLSetup."Allow Posting From", GLSetup."Allow Posting To"));
    // end;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", 'OnBeforeDateNotAllowed', '', true, true)]
    // local procedure "Item Jnl.-Check Line_OnBeforeDateNotAllowed"
    // (
    //     ItemJnlLine: Record "Item Journal Line";
    //     var DateCheckDone: Boolean
    // )
    // var
    //     ItemJnlCheckLine_lCodeunit: Codeunit "Item Jnl.-Check Line";
    //     PostingDateErr_gCtx: Label 'is not within your range of allowed posting dates\User ID = %1\Document Posting Date = %2\User Setup Allow Posting Date %3..%4\\GL Setup Allow Posting Date %5..%6';
    //     UserSetup: Record "User Setup";
    //     GLSetup: Record "General Ledger Setup";
    //     UserSetupManagement: Codeunit "User Setup Management";
    // begin
    //     UserSetup.Reset();
    //     UserSetup.Get(UserId);
    //     GLSetup.Reset();
    //     GLSetup.GET();

    //     if not UserSetupManagement.IsPostingDateValid(ItemJnlLine."Posting Date") then
    //         ItemJnlLine.FIELDERROR("Posting Date", STRSUBSTNO(PostingDateErr_gCtx, USERID, ItemJnlLine."Posting Date", UserSetup."Allow Posting From", UserSetup."Allow Posting To", GLSetup."Allow Posting From", GLSetup."Allow Posting To"));
    // end;
}
