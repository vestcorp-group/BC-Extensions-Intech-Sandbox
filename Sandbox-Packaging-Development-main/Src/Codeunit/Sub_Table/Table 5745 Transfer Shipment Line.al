codeunit 80207 Sub_Table_5745
{
    //Transfer Shipment Line
    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Line", OnAfterCopyFromTransferLine, '', false, false)]
    local procedure "Transfer Shipment Line_OnAfterCopyFromTransferLine"(var TransferShipmentLine: Record "Transfer Shipment Line"; TransferLine: Record "Transfer Line")
    begin
        TransferShipmentLine."Packaging Code" := TransferLine."Packaging Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Line", OnBeforeInsertEvent, '', false, false)]
    local procedure OnBeforeInsertEvent_TransShptLine(RunTrigger: Boolean; var Rec: Record "Transfer Shipment Line")
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