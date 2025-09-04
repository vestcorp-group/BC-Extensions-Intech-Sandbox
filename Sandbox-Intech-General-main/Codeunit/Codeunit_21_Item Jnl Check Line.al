codeunit 75377 Subscribe_Codeunit_21
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", 'OnBeforeCheckLocation', '', false, false)]
    local procedure OnBeforeCheckLocation(var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        InventorySetup_lRec: Record "Inventory Setup";
        InvtPeriod: Record "Inventory Period";
    begin
        //InvOpnChk-NS
        InventorySetup_lRec.GET;
        IF InventorySetup_lRec."Check Inventory Period Open" THEN BEGIN
            IF InvtPeriod.InvtPeriodEntryExists_gfun(CALCDATE('CM', ItemJournalLine."Posting Date")) THEN
                ERROR('Please Open Inventory Period for Period End Date %1', CALCDATE('CM', ItemJournalLine."Posting Date"));
        END;
        //InvOpnChk-NE

    end;

}