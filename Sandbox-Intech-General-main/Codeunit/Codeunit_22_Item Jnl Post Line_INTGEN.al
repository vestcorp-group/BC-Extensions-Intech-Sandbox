codeunit 75008 Subscribe_Codeunit_22_INTGEN
{
    trigger OnRun()
    begin

    end;


    //TO_Rcpt_RevaliationError-NS 261222
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeRunWithCheck', '', false, false)]
    local procedure OnBeforeRunWithCheck(var Sender: Codeunit "Item Jnl.-Post Line"; var ItemJournalLine: Record "Item Journal Line"; CalledFromAdjustment: Boolean; CalledFromInvtPutawayPick: Boolean; CalledFromApplicationWorksheet: Boolean; PostponeReservationHandling: Boolean; var IsHandled: Boolean);
    begin
        IF ItemJournalLine."Entry Type" <> ItemJournalLine."Entry Type"::Transfer then
            Exit;

        IF ItemJournalLine."Source Code" <> 'REVALJNL' then
            Exit;

        IF ItemJournalLine.Quantity = 0 then
            Exit;


        Sender.SetPostponeReservationHandling(TRUE);
    end;
    //TO_Rcpt_RevaliationError-NE 261222

    var
        myInt: Integer;
}