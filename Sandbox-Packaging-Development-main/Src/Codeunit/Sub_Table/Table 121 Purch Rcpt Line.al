codeunit 80210 Sub_Table_121
{
    //Purch. Rcpt. Line
    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", OnBeforeInsertEvent, '', false, false)]
    local procedure OnBeforeInsertEvent_PurRcptLine(RunTrigger: Boolean; var Rec: Record "Purch. Rcpt. Line")
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