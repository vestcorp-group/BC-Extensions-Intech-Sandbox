codeunit 80203 Table_83_Sub
{
    //Item Journal Line
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterCopyItemJnlLineFromPurchLine, '', false, false)]
    local procedure "Item Journal Line_OnAfterCopyItemJnlLineFromPurchLine"(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")
    begin
        ItemJnlLine."Packaging Code" := PurchLine."Packaging Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterCopyItemJnlLineFromSalesLine, '', false, false)]
    local procedure "Item Journal Line_OnAfterCopyItemJnlLineFromSalesLine"(var ItemJnlLine: Record "Item Journal Line"; SalesLine: Record "Sales Line")
    begin
        ItemJnlLine."Packaging Code" := SalesLine."Packaging Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterValidateEvent', 'Quantity', true, true)]
    local procedure ItemJnlLine_OnBeforeQtyValidate(CurrFieldNo: Integer; var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
        UpdateNetGrossWeight_lcdu: Codeunit UpdateNetGrossWeight;
    begin
        if (CurrFieldNo = Rec.FieldNo(Quantity)) and (Rec."Packaging Code" <> '') and (Rec.Quantity <> 0) and (Rec."Unit of Measure Code" <> '') then BEGIN
            if UpdateNetGrossWeight_lcdu.CalculateNetAndGrossWeight(Abs(Rec."Quantity (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec.Quantity)) then begin
                Rec."Net Weight 2" := NetweightL;
                Rec."Gross Weight 2" := GrossWeightL;
            end;
        END else begin
            if (Rec.Quantity = 0) then begin
                Rec."Net Weight 2" := 0;
                Rec."Gross Weight 2" := 0;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterValidateEvent', "Packaging Code", true, true)]
    local procedure ItemJnlLine_OnBeforePackingValidate(CurrFieldNo: Integer; var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
        UpdateNetGrossWeight_lcdu: Codeunit UpdateNetGrossWeight;
    begin
        if (Rec.Quantity <> 0) and (Rec."Packaging Code" <> '') and (Rec."Unit of Measure Code" <> '') then BEGIN
            if UpdateNetGrossWeight_lcdu.CalculateNetAndGrossWeight(Abs(Rec."Quantity (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec.Quantity)) then begin
                Rec."Net Weight 2" := NetweightL;
                Rec."Gross Weight 2" := GrossWeightL;
            end;
        END;
        if Rec."Packaging Code" = '' then begin
            Rec."Net Weight 2" := 0;
            Rec."Gross Weight 2" := 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterValidateEvent', "Unit of Measure Code", true, true)]
    local procedure ItemJnlLine_OnBeforeUOMValidate(CurrFieldNo: Integer; var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
        UpdateNetGrossWeight_lcdu: Codeunit UpdateNetGrossWeight;
    begin
        if (Rec.Quantity <> 0) and (Rec."Packaging Code" <> '') and (Rec."Unit of Measure Code" <> '') then BEGIN
            if UpdateNetGrossWeight_lcdu.CalculateNetAndGrossWeight(Abs(Rec."Quantity (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec.Quantity)) then begin
                Rec."Net Weight 2" := NetweightL;
                Rec."Gross Weight 2" := GrossWeightL;
            end;
        END;
        if Rec."Unit of Measure Code" = '' then begin
            Rec."Net Weight 2" := 0;
            Rec."Gross Weight 2" := 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnBeforeInsertEvent, '', false, false)]
    local procedure OnBeforeInsertEvent_ItemJnlLine(RunTrigger: Boolean; var Rec: Record "Item Journal Line")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
        UpdateNetGrossWeight_lcdu: Codeunit UpdateNetGrossWeight;
    begin
        if Rec.IsTemporary then
            exit;
        if (Rec."Packaging Code" <> '') and (Rec.Quantity <> 0) and (Rec."Unit of Measure Code" <> '') then BEGIN
            if UpdateNetGrossWeight_lcdu.CalculateNetAndGrossWeight(Abs(Rec."Quantity (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec.Quantity)) then begin
                Rec."Net Weight 2" := NetweightL;
                Rec."Gross Weight 2" := GrossWeightL;
            end;
        END else begin
            if (Rec.Quantity = 0) then begin
                Rec."Net Weight 2" := 0;
                Rec."Gross Weight 2" := 0;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterValidateEvent, "Variant Code", false, false)]
    local procedure OnAfterValidateEvent_VariantCode_ItemJournalLine(CurrFieldNo: Integer; var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line")
    var
        ItemVariant_lRec: Record "Item Variant";
    begin
        Clear(ItemVariant_lRec);
        if ItemVariant_lRec.Get(Rec."Item No.", Rec."Variant Code") and (CurrFieldNo = 5402) then begin
            Rec."Packaging Code" := ItemVariant_lRec."Packaging Code";
        end;
    end;
}
