codeunit 80209 Sub_Table_5747
{
    //Transfer Receipt Line
    [EventSubscriber(ObjectType::Table, Database::"Transfer Receipt Line", OnAfterCopyFromTransferLine, '', false, false)]
    local procedure "Transfer Receipt Line_OnAfterCopyFromTransferLine"(var TransferReceiptLine: Record "Transfer Receipt Line"; TransferLine: Record "Transfer Line")
    begin
        TransferReceiptLine."Packaging Code" := TransferLine."Packaging Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Receipt Line", OnBeforeInsertEvent, '', false, false)]
    local procedure OnBeforeInsertEvent_TransRcptLine(RunTrigger: Boolean; var Rec: Record "Transfer Receipt Line")
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