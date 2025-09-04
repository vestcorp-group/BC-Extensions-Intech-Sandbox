tableextension 75003 ProductionOrders extends "Production Order"
{
    //AutoFinishProdOrder
    fields
    {
        field(60001; "Error on Finish PO"; Text[250])
        {
            Description = 'AutoFinishProdOrder';
            Editable = false;
        }
        field(60002; "Finished from batch job"; Boolean)
        {
            Description = 'T5415';
            Editable = false;
        }
        field(60003; "Finished Date from batch job"; Date)
        {
            Description = 'T5415';
            Editable = false;
        }
        field(60004; "Finished By from batch job"; Code[50])
        {
            Description = 'T5415';
            Editable = false;
        }

    }



    PROCEDURE HandleItemTrackingDeletion();
    VAR
        ReservEntry: Record "Reservation Entry";
        ReservEntry2: Record "Reservation Entry";
        Confirmed: Boolean;
    BEGIN
        ProdOrder := Rec;
        ReservEntry.RESET;
        ReservEntry.SETCURRENTKEY(
          "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
          "Source Batch Name", "Source Prod. Order Line", "Reservation Status");
        ReservEntry.SETFILTER("Source Type", '%1|%2', DATABASE::"Prod. Order Line", DATABASE::"Prod. Order Component");
        ReservEntry.SETRANGE("Source Subtype", ProdOrder.Status);
        ReservEntry.SETRANGE("Source ID", ProdOrder."No.");
        ReservEntry.SETRANGE("Source Batch Name", '');
        ReservEntry.SETFILTER("Item Tracking", '> %1', ReservEntry."Item Tracking"::None);
        IF ReservEntry.ISEMPTY THEN
            EXIT;

        IF HideValidationDialog OR NOT GUIALLOWED THEN
            Confirmed := TRUE
        ELSE
            Confirmed := CONFIRM(Text009, FALSE, ProdOrder.Status, ProdOrder.TABLECAPTION, ProdOrder."No.");

        IF NOT Confirmed THEN
            ERROR('');

        IF ReservEntry.FINDSET THEN
            REPEAT
                ReservEntry2 := ReservEntry;
                ReservEntry2.ClearItemTrackingFields;
                ReservEntry2.MODIFY;
            UNTIL ReservEntry.NEXT = 0;
    END;

    var
        Text009: label 'The %1 %2 %3 has item tracking. Do you want to delete it anyway?';
        ProdOrder: Record "Production Order";
}