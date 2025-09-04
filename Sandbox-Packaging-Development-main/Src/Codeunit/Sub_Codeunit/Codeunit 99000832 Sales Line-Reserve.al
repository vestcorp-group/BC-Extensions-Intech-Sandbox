codeunit 80216 Sub_Codeunit_99000832
{
    //Sales Line-Reserve
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Line-Reserve", OnAfterInitFromSalesLine, '', false, false)]
    local procedure "Sales Line-Reserve_OnAfterInitFromSalesLine"(var TrackingSpecification: Record "Tracking Specification"; SalesLine: Record "Sales Line")
    begin
        TrackingSpecification."Packaging Code" := SalesLine."Packaging Code";
        TrackingSpecification."Unit of Measure Code" := SalesLine."Unit of Measure Code";
    end;
}