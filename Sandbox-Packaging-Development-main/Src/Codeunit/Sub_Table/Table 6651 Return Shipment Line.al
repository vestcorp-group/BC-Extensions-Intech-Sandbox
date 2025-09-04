codeunit 80218 Sub_Table_6651
{
    //Return Shipment Line
    [EventSubscriber(ObjectType::Table, Database::"Return Shipment Line", OnBeforeInsertEvent, '', false, false)]
    local procedure OnBeforeInsertEvent_RtnShptLine(RunTrigger: Boolean; var Rec: Record "Return Shipment Line")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
        UpdateNetGrossWeight_lcdu: Codeunit UpdateNetGrossWeight;
    begin
        if Rec.IsTemporary then
            exit;
        if (Rec."Packaging Code" <> '') and (Rec.Quantity <> 0) and (Rec."Unit of Measure Code" <> '') then BEGIN
            if UpdateNetGrossWeight_lcdu.CalculateNetAndGrossWeight(Abs(Rec."Quantity (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec.Quantity)) then begin
                Rec."Net Weight" := NetweightL;
                Rec."Gross Weight" := GrossWeightL;
            end;
        END;
    end;
}