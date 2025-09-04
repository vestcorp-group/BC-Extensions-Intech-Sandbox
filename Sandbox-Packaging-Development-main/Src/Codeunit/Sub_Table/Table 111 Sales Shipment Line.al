codeunit 80213 Sub_Table_111
{
    //Sales Shipment Line
    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", OnBeforeInsertEvent, '', false, false)]
    local procedure OnBeforeInsertEvent_SalShptLine(RunTrigger: Boolean; var Rec: Record "Sales Shipment Line")
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