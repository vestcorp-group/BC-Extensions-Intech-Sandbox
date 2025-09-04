codeunit 80214 Sub_Codeunit_6500
{
    //Item Tracking Management
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Management", 'OnBeforeTempHandlingSpecificationInsert', '', false, false)]
    local procedure OnBeforeTempHandlingSpecificationInsert(var TempTrackingSpecification: Record "Tracking Specification"; ReservationEntry: Record "Reservation Entry"; var ItemTrackingCode: Record "Item Tracking Code"; var EntriesExist: Boolean);
    begin
        TempTrackingSpecification."Packaging Code" := ReservationEntry."Packaging Code";
        TempTrackingSpecification."Unit of Measure Code" := ReservationEntry."Unit of Measure Code";
        TempTrackingSpecification."Gross Weight 2" := ReservationEntry."Gross Weight 2";
        TempTrackingSpecification."Net Weight 2" := ReservationEntry."Net Weight 2";
    end;
}