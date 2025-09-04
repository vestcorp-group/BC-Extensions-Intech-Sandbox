codeunit 80204 Sub_Table_336
{
    //Tracking Specification
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", OnAfterValidateEvent, "Qty. to Handle (Base)", false, false)]
    local procedure OnBeforeValidateEvent_QtytoHandle_TrackingSpecification(CurrFieldNo: Integer; var Rec: Record "Tracking Specification"; var xRec: Record "Tracking Specification")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
        UpdateNetGrossWeight_lcdu: Codeunit UpdateNetGrossWeight;
    begin
        if (Rec."Qty. to Handle (Base)" <> 0) and (Rec."Packaging Code" <> '') and (Rec."Unit of Measure Code" <> '') then BEGIN
            if UpdateNetGrossWeight_lcdu.CalculateNetAndGrossWeight(Abs(Rec."Qty. to Handle (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec."Qty. to Handle")) then begin
                Rec."Net Weight 2" := NetweightL;
                Rec."Gross Weight 2" := GrossWeightL;
            end;
        END;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", OnAfterValidateEvent, "Quantity (Base)", false, false)]
    local procedure OnBeforeValidateEvent_Qty_TrackingSpecification(CurrFieldNo: Integer; var Rec: Record "Tracking Specification"; var xRec: Record "Tracking Specification")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
        UpdateNetGrossWeight_lcdu: Codeunit UpdateNetGrossWeight;
    begin
        if (Rec."Qty. to Handle (Base)" <> 0) and (Rec."Packaging Code" <> '') and (Rec."Unit of Measure Code" <> '') then BEGIN
            if UpdateNetGrossWeight_lcdu.CalculateNetAndGrossWeight(Abs(Rec."Qty. to Handle (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec."Qty. to Handle")) then begin
                Rec."Net Weight 2" := NetweightL;
                Rec."Gross Weight 2" := GrossWeightL;
            end;
        END;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", OnAfterValidateEvent, "Lot No.", false, false)]
    local procedure OnBeforeValidateEvent_LotNo_TrackingSpecification(CurrFieldNo: Integer; var Rec: Record "Tracking Specification"; var xRec: Record "Tracking Specification")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
        UpdateNetGrossWeight_lcdu: Codeunit UpdateNetGrossWeight;
    begin
        if (Rec."Qty. to Handle (Base)" <> 0) and (Rec."Packaging Code" <> '') and (Rec."Unit of Measure Code" <> '') and (Rec."Lot No." <> '') then BEGIN
            if UpdateNetGrossWeight_lcdu.CalculateNetAndGrossWeight(Abs(Rec."Qty. to Handle (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec."Qty. to Handle")) then begin
                Rec."Net Weight 2" := NetweightL;
                Rec."Gross Weight 2" := GrossWeightL;
            end;
        END;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", OnAfterValidateEvent, "Serial No.", false, false)]
    local procedure OnBeforeValidateEvent_SerialNo_TrackingSpecification(CurrFieldNo: Integer; var Rec: Record "Tracking Specification"; var xRec: Record "Tracking Specification")
    var
        NetweightL: Decimal;
        GrossWeightL: Decimal;
        UpdateNetGrossWeight_lcdu: Codeunit UpdateNetGrossWeight;
    begin
        if (Rec."Qty. to Handle (Base)" <> 0) and (Rec."Packaging Code" <> '') and (Rec."Unit of Measure Code" <> '') and (Rec."Serial No." <> '') then BEGIN
            if UpdateNetGrossWeight_lcdu.CalculateNetAndGrossWeight(Abs(Rec."Qty. to Handle (Base)"), Rec."Packaging Code", Rec."Unit of Measure Code", NetweightL, GrossWeightL, Abs(Rec."Qty. to Handle")) then begin
                Rec."Net Weight 2" := NetweightL;
                Rec."Gross Weight 2" := GrossWeightL;
            end;
        END;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", OnAfterInitFromItemJnlLine, '', false, false)]
    local procedure "Tracking Specification_OnAfterInitFromItemJnlLine"(var TrackingSpecification: Record "Tracking Specification"; ItemJournalLine: Record "Item Journal Line")
    begin
        TrackingSpecification."Packaging Code" := ItemJournalLine."Packaging Code";
        TrackingSpecification."Unit of Measure Code" := ItemJournalLine."Unit of Measure Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", OnBeforeInsertEvent, '', false, false)]
    local procedure "Tracking Specification_OnBeforeInsertEvent"(var Rec: Record "Tracking Specification"; RunTrigger: Boolean)
    var
        PL_lRec: Record "Purchase Line";
        SL_lRec: Record "Sales Line";
        ItemJnl_lRec: Record "Item Journal Line";
        TL_lRec: Record "Transfer Line";
    begin
        if Rec.IsTemporary then begin
            Case Rec."Source Type" of
                39:
                    begin
                        IF PL_lRec.GET(Rec."Source Subtype", Rec."Source ID", Rec."Source Ref. No.") Then begin
                            Rec."Packaging Code" := PL_lRec."Packaging Code";
                            Rec."Unit of Measure Code" := PL_lRec."Unit of Measure Code";
                        end;
                    end;

                37:
                    begin
                        IF SL_lRec.GET(Rec."Source Subtype", Rec."Source ID", Rec."Source Ref. No.") Then begin
                            Rec."Packaging Code" := SL_lRec."Packaging Code";
                            Rec."Unit of Measure Code" := SL_lRec."Unit of Measure Code";
                        end;
                    end;
                83:
                    begin
                        IF StrLen(Rec."Source ID") <= 10 Then begin
                            IF ItemJnl_lRec.GET(Rec."Source ID", Rec."Source Batch Name", Rec."Source Ref. No.") Then begin
                                Rec."Packaging Code" := ItemJnl_lRec."Packaging Code";
                                Rec."Unit of Measure Code" := ItemJnl_lRec."Unit of Measure Code";
                            end;
                        End;
                    end;
                5741:
                    begin
                        IF TL_lRec.GET(Rec."Source ID", Rec."Source Ref. No.") Then begin
                            Rec."Packaging Code" := TL_lRec."Packaging Code";
                            Rec."Unit of Measure Code" := TL_lRec."Unit of Measure Code";
                        end;
                    end;
            End;
        End;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", OnAfterSetSourceFromPurchLine, '', false, false)]
    local procedure "Tracking Specification_OnAfterSetSourceFromPurchLine"(var TrackingSpecification: Record "Tracking Specification"; PurchLine: Record "Purchase Line")
    begin
        TrackingSpecification."Packaging Code" := PurchLine."Packaging Code";
        TrackingSpecification."Unit of Measure Code" := PurchLine."Unit of Measure Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", OnAfterSetSourceFromSalesLine, '', false, false)]
    local procedure "Tracking Specification_OnAfterSetSourceFromSalesLine"(var TrackingSpecification: Record "Tracking Specification"; SalesLine: Record "Sales Line")
    begin
        TrackingSpecification."Packaging Code" := SalesLine."Packaging Code";
        TrackingSpecification."Unit of Measure Code" := SalesLine."Unit of Measure Code";
    end;
}