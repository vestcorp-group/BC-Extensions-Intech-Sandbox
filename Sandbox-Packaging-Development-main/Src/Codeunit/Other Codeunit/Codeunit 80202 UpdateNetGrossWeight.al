codeunit 80202 UpdateNetGrossWeight
{

    //SALES-BEGIN
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', true, true)]
    local procedure SalesLine_OnBeforeQtyValidate(var Rec: Record "Sales Line"; CurrFieldNo: Integer; var xRec: Record "Sales Line")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
    begin
        if (CurrFieldNo = Rec.FieldNo(Quantity)) and (Rec."Packaging Code" <> '') and (Rec.Quantity <> 0) and (Rec."Unit of Measure Code" <> '') then BEGIN
            if CalculateNetAndGrossWeight(Abs(Rec."Quantity (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec.Quantity)) then begin
                Rec."Net Weight" := NetweightL;
                Rec."Gross Weight" := GrossWeightL;
            end;
        END else begin
            if (Rec.Quantity = 0) then begin
                Rec."Net Weight" := 0;
                Rec."Gross Weight" := 0;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', "Packaging Code", true, true)]
    local procedure SalesLine_OnBeforePackingValidate(var Rec: Record "Sales Line"; CurrFieldNo: Integer; var xRec: Record "Sales Line")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
    begin
        if (Rec.Quantity <> 0) and (Rec."Packaging Code" <> '') and (Rec."Unit of Measure Code" <> '') then BEGIN
            if Rec."Document Type" = Rec."Document Type"::Order then
                Rec.TestField("Qty. Shipped (Base)", 0);
            if CalculateNetAndGrossWeight(Abs(Rec."Quantity (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec.Quantity)) then begin
                Rec."Net Weight" := NetweightL;
                Rec."Gross Weight" := GrossWeightL;
            end;
        END;
        if Rec."Packaging Code" = '' then begin
            if Rec."Document Type" = Rec."Document Type"::Order then
                Rec.TestField("Qty. Shipped (Base)", 0);
            Rec."Net Weight" := 0;
            Rec."Gross Weight" := 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', "Unit of Measure Code", true, true)]
    local procedure SalesLine_OnBeforeUOMValidate(var Rec: Record "Sales Line"; CurrFieldNo: Integer; var xRec: Record "Sales Line")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
    begin
        if (Rec.Quantity <> 0) and (Rec."Packaging Code" <> '') and (Rec."Unit of Measure Code" <> '') then BEGIN
            if Rec."Document Type" = Rec."Document Type"::Order then
                Rec.TestField("Qty. Shipped (Base)", 0);
            if CalculateNetAndGrossWeight(Abs(Rec."Quantity (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec.Quantity)) then begin
                Rec."Net Weight" := NetweightL;
                Rec."Gross Weight" := GrossWeightL;
            end;
        END;
        if Rec."Unit of Measure Code" = '' then begin
            Rec."Net Weight" := 0;
            Rec."Gross Weight" := 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, "Variant Code", false, false)]
    local procedure OnAfterValidateEvent_VariantCode_SalesLine(CurrFieldNo: Integer; var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        ItemVariant_lRec: Record "Item Variant";
    begin
        Clear(ItemVariant_lRec);
        if ItemVariant_lRec.Get(Rec."No.", Rec."Variant Code") and (CurrFieldNo = 5402) then begin
            Rec."Packaging Code" := ItemVariant_lRec."Packaging Code";
        end;
    end;
    //SALES-END

    //PURCHASE-BEGIN
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Quantity', true, true)]
    local procedure PurchaseLine_OnBeforeQtyValidate(CurrFieldNo: Integer; var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
    begin
        if (CurrFieldNo = Rec.FieldNo(Quantity)) and (Rec."Packaging Code" <> '') and (Rec.Quantity <> 0) and (Rec."Unit of Measure Code" <> '') then BEGIN
            if CalculateNetAndGrossWeight(Abs(Rec."Quantity (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec.Quantity)) then begin
                Rec."Net Weight" := NetweightL;
                Rec."Gross Weight" := GrossWeightL;
            end;
        END else begin
            if (Rec.Quantity = 0) then begin
                Rec."Net Weight" := 0;
                Rec."Gross Weight" := 0;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', "Packaging Code", true, true)]
    local procedure PurchaseLine_OnBeforePackingValidate(CurrFieldNo: Integer; var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
    begin
        if (Rec.Quantity <> 0) and (Rec."Packaging Code" <> '') and (Rec."Unit of Measure Code" <> '') then BEGIN
            if Rec."Document Type" = Rec."Document Type"::Order then
                Rec.TestField("Qty. Received (Base)", 0);
            if CalculateNetAndGrossWeight(Abs(Rec."Quantity (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec.Quantity)) then begin
                Rec."Net Weight" := NetweightL;
                Rec."Gross Weight" := GrossWeightL;
            end;
        END;
        if Rec."Packaging Code" = '' then begin
            if Rec."Document Type" = Rec."Document Type"::Order then
                Rec.TestField("Qty. Received (Base)", 0);
            Rec."Net Weight" := 0;
            Rec."Gross Weight" := 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', "Unit of Measure Code", true, true)]
    local procedure PurchaseLine_OnBeforeUOMValidate(CurrFieldNo: Integer; var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
    begin
        if (Rec.Quantity <> 0) and (Rec."Packaging Code" <> '') and (Rec."Unit of Measure Code" <> '') then BEGIN
            if Rec."Document Type" = Rec."Document Type"::Order then
                Rec.TestField("Qty. Received (Base)", 0);
            if CalculateNetAndGrossWeight(Abs(Rec."Quantity (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec.Quantity)) then begin
                Rec."Net Weight" := NetweightL;
                Rec."Gross Weight" := GrossWeightL;
            end;
        END;
        if Rec."Unit of Measure Code" = '' then begin
            Rec."Net Weight" := 0;
            Rec."Gross Weight" := 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterValidateEvent, "Variant Code", false, false)]
    local procedure OnAfterValidateEvent_VariantCode_PurchaseLine(CurrFieldNo: Integer; var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line")
    var
        ItemVariant_lRec: Record "Item Variant";
    begin
        Clear(ItemVariant_lRec);
        if ItemVariant_lRec.Get(Rec."No.", Rec."Variant Code") and (CurrFieldNo = 5402) then begin
            Rec."Packaging Code" := ItemVariant_lRec."Packaging Code";
        end;
    end;
    //PURCHASE-END

    //TRANSFER-BEGIN
    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", 'OnAfterValidateEvent', 'Quantity', true, true)]
    local procedure TransferLine_OnBeforeQtyValidate(CurrFieldNo: Integer; var Rec: Record "Transfer Line"; var xRec: Record "Transfer Line")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
    begin
        if (CurrFieldNo = Rec.FieldNo(Quantity)) and (Rec."Packaging Code" <> '') and (Rec.Quantity <> 0) and (Rec."Unit of Measure Code" <> '') then BEGIN
            if CalculateNetAndGrossWeight(Abs(Rec."Quantity (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec.Quantity)) then begin
                Rec."Net Weight" := NetweightL;
                Rec."Gross Weight" := GrossWeightL;
            end;
        END else begin
            if (Rec.Quantity = 0) then begin
                Rec."Net Weight" := 0;
                Rec."Gross Weight" := 0;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", 'OnAfterValidateEvent', "Packaging Code", true, true)]
    local procedure TransferLine_OnBeforePackingValidate(CurrFieldNo: Integer; var Rec: Record "Transfer Line"; var xRec: Record "Transfer Line")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
    begin
        if (Rec.Quantity <> 0) and (Rec."Packaging Code" <> '') and (Rec."Unit of Measure Code" <> '') then BEGIN
            Rec.TestField("Qty. Shipped (Base)", 0);
            if CalculateNetAndGrossWeight(Abs(Rec."Quantity (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec.Quantity)) then begin
                Rec."Net Weight" := NetweightL;
                Rec."Gross Weight" := GrossWeightL;
            end;
        END;
        if Rec."Packaging Code" = '' then begin
            Rec."Net Weight" := 0;
            Rec."Gross Weight" := 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", 'OnAfterValidateEvent', "Unit of Measure Code", true, true)]
    local procedure TransferLine_OnBeforeUOMValidate(CurrFieldNo: Integer; var Rec: Record "Transfer Line"; var xRec: Record "Transfer Line")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
    begin
        if (Rec.Quantity <> 0) and (Rec."Packaging Code" <> '') and (Rec."Unit of Measure Code" <> '') then BEGIN
            if CalculateNetAndGrossWeight(Abs(Rec."Quantity (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec.Quantity)) then begin
                Rec."Net Weight" := NetweightL;
                Rec."Gross Weight" := GrossWeightL;
            end;
        END;
        if Rec."Unit of Measure Code" = '' then begin
            Rec."Net Weight" := 0;
            Rec."Gross Weight" := 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Line", OnAfterValidateEvent, "Variant Code", false, false)]
    local procedure OnAfterValidateEvent_VariantCode_TransferLine(CurrFieldNo: Integer; var Rec: Record "Transfer Line"; var xRec: Record "Transfer Line")
    var
        ItemVariant_lRec: Record "Item Variant";
    begin
        Clear(ItemVariant_lRec);
        if ItemVariant_lRec.Get(Rec."Item No.", Rec."Variant Code") and (CurrFieldNo = 30) then begin
            Rec."Packaging Code" := ItemVariant_lRec."Packaging Code";
        end;
    end;
    //TRANSFER-END

    procedure CalculateNetAndGrossWeight(QuantityBase: Decimal; PackingCode: code[250]; UOM: Code[10]; var NetWeight: Decimal; var GrossWeight: Decimal; Quantity: Decimal): Boolean
    var
        PackingdetailLine_lRec: Record "Packaging detail Line";
        CalcNetWeight_lDec: Decimal;
        CalcGrossWeight_lDec: Decimal;
        PackingLevel_lInt: Integer;
    begin
        PackingdetailLine_lRec.Reset();
        PackingdetailLine_lRec.SetRange("Packaging Code", PackingCode);
        PackingdetailLine_lRec.SetFilter("Packaging Level", '%1', 0);
        if PackingdetailLine_lRec.FindFirst() then begin
            PackingdetailLine_lRec.TestField("Net Weight");
            NetWeight := PackingdetailLine_lRec."Net Weight" * QuantityBase;
        end;

        if PackingdetailLine_lRec."Unit of Measure" = UOM then begin
            NetWeight := QuantityBase;
            GrossWeight := QuantityBase;
        end;

        if (GrossWeight <> 0) and (NetWeight <> 0) then
            exit(true);

        PackingdetailLine_lRec.Reset();
        PackingdetailLine_lRec.SetRange("Packaging Code", PackingCode);
        PackingdetailLine_lRec.SetCurrentKey("Packaging Level");
        PackingdetailLine_lRec.SetAscending("Packaging Level", false);
        // PackingdetailLine_lRec.SetRange("Unit of Measure", UOM); 
        if PackingdetailLine_lRec.FindFirst() then begin
            if PackingdetailLine_lRec."Unit of Measure" = UOM then
                PackingLevel_lInt := PackingdetailLine_lRec."Packaging Level"
            else
                Error('Packaging Detail Line does not have the UOM : %1 in Packaging Code: %2', UOM, PackingdetailLine_lRec."Packaging Code");
        end;

        PackingdetailLine_lRec.Reset();
        PackingdetailLine_lRec.SetRange("Packaging Code", PackingCode);
        PackingdetailLine_lRec.SetFilter("Packaging Level", '<=%1&<>%2', PackingLevel_lInt, 0);
        PackingdetailLine_lRec.SetCurrentKey("Packaging Level");
        PackingdetailLine_lRec.SetAscending("Packaging Level", false);
        if PackingdetailLine_lRec.FindSet() then begin
            repeat
                PackingdetailLine_lRec.TestField("Packaging Weight");
                PackingdetailLine_lRec.TestField("Packaging Matrics");
            until PackingdetailLine_lRec.Next() = 0;
        end;
        PackingdetailLine_lRec.Reset();
        PackingdetailLine_lRec.SetRange("Packaging Code", PackingCode);
        PackingdetailLine_lRec.SetFilter("Packaging Level", '<=%1&<>%2', PackingLevel_lInt, 0);
        PackingdetailLine_lRec.SetCurrentKey("Packaging Level");
        PackingdetailLine_lRec.SetAscending("Packaging Level", false);
        if PackingdetailLine_lRec.FindSet() then begin
            repeat
                if PackingdetailLine_lRec."Unit of Measure" = UOM then
                    GrossWeight += (NetWeight + (Quantity * PackingdetailLine_lRec."Packaging Weight"))
                else
                    GrossWeight += (Quantity * (PackingdetailLine_lRec."Packaging Weight" * PackingdetailLine_lRec."Packaging Matrics"));
            until PackingdetailLine_lRec.Next() = 0;
        end else begin
            GrossWeight := PackingdetailLine_lRec."Gross Weight";
        end;

        if (GrossWeight <> 0) and (NetWeight <> 0) then
            exit(true)
        else
            exit(false);
    end;
}