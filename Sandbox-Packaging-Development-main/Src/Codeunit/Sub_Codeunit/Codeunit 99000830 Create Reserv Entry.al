codeunit 80211 Sub_Codeunit_99000830
{
    //Create Reserv. Entry
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", OnBeforeCreateRemainingReservEntry, '', false, false)]
    local procedure "Create Reserv. Entry_OnBeforeCreateRemainingReservEntry"(var ReservationEntry: Record "Reservation Entry"; FromReservationEntry: Record "Reservation Entry")
    begin
        ReservationEntry."Packaging Code" := FromReservationEntry."Packaging Code";
        ReservationEntry."Unit of Measure Code" := FromReservationEntry."Unit of Measure Code";
        ReservationEntry."Gross Weight 2" := FromReservationEntry."Gross Weight 2";
        ReservationEntry."Net Weight 2" := FromReservationEntry."Net Weight 2";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", OnBeforeCreateRemainingNonSurplusReservEntry, '', false, false)]
    local procedure "Create Reserv. Entry_OnBeforeCreateRemainingNonSurplusReservEntry"(var ReservationEntry: Record "Reservation Entry"; FromReservationEntry: Record "Reservation Entry")
    begin
        ReservationEntry."Packaging Code" := FromReservationEntry."Packaging Code";
        ReservationEntry."Unit of Measure Code" := FromReservationEntry."Unit of Measure Code";
        ReservationEntry."Gross Weight 2" := FromReservationEntry."Gross Weight 2";
        ReservationEntry."Net Weight 2" := FromReservationEntry."Net Weight 2";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnCreateReservEntryExtraFields', '', false, false)]
    local procedure OnCreateReservEntryExtraFields(var InsertReservEntry: Record "Reservation Entry"; OldTrackingSpecification: Record "Tracking Specification"; NewTrackingSpecification: Record "Tracking Specification");
    begin
        InsertReservEntry."Packaging Code" := NewTrackingSpecification."Packaging Code";
        InsertReservEntry."Unit of Measure Code" := NewTrackingSpecification."Unit of Measure Code";
        InsertReservEntry."Gross Weight 2" := NewTrackingSpecification."Gross Weight 2";
        InsertReservEntry."Net Weight 2" := NewTrackingSpecification."Net Weight 2";
    end;
}