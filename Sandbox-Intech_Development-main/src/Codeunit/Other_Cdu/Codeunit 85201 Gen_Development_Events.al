#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 85201 "Gen_Development_Events"
{
    //T13767-NS 170225 Nilesh Gajjar
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Adjustment", OnPostItemJnlLineOnAfterSetPostingDate, '', false, false)]
    local procedure "Inventory Adjustment_OnPostItemJnlLineOnAfterSetPostingDate"(var ItemJournalLine: Record "Item Journal Line"; ValueEntry: Record "Value Entry"; PostingDateForClosedPeriod: Date; var Item: Record Item)
    var
        FindInvPeriod_lRec: Record "Inventory Period";
    begin
        ItemJournalLine."Posting Date" := ValueEntry."Posting Date";

        FindInvPeriod_lRec.RESET;
        FindInvPeriod_lRec.SetFilter("Ending Date", '>=%1', ItemJournalLine."Posting Date");
        FindInvPeriod_lRec.SetRange(Closed, true);
        IF FindInvPeriod_lRec.FindLast() then
            ItemJournalLine."Posting Date" := FindInvPeriod_lRec."Ending Date" + 1;  //next day
        //Error('Invetory Period is closed till Ending Date %1, You can not post Inventory Adjustment in Date %2', FindInvPeriod_lRec."Ending Date", ItemJournalLine."Posting Date");
    end;
    //T13767-NE

}

