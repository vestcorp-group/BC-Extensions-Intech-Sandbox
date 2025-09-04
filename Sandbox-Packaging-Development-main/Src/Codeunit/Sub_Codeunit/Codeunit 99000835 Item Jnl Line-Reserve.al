codeunit 80217 Sub_Codeunit_99000835
{
    //Item Jnl. Line-Reserve
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl. Line-Reserve", OnAfterInitFromItemJnlLine, '', false, false)]
    local procedure "Item Jnl. Line-Reserve_OnAfterInitFromItemJnlLine"(var TrackingSpecification: Record "Tracking Specification"; ItemJournalLine: Record "Item Journal Line")
    begin
        TrackingSpecification."Packaging Code" := ItemJournalLine."Packaging Code";
        TrackingSpecification."Unit of Measure Code" := ItemJournalLine."Unit of Measure Code";
    end;
}