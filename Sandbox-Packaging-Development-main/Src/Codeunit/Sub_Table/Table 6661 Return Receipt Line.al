codeunit 80219 Sub_Table_6661
{
    //Return Receipt Line
    [EventSubscriber(ObjectType::Table, Database::"Return Receipt Line", OnBeforeInsertEvent, '', false, false)]
    local procedure OnBeforeInsertEvent_RtnRcptLine(RunTrigger: Boolean; var Rec: Record "Return Receipt Line")
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