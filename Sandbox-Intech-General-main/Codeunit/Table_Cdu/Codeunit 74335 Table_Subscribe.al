//T07350-NS
codeunit 74998 Table_Subscribe_74998
{

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Location_gRec: Record Location;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", 'OnBeforeCheckTransferFromAndToCodesNotTheSame', '', false, false)]
    local procedure OnBeforeCheckTransferFromAndToCodesNotTheSame(TransferHeader: Record "Transfer Header"; var IsHandled: Boolean);
    var
        Location_lRec: Record Location;
    begin
        IF TransferHeader."In-Transit Code" = '' then
            Exit;

        Location_lRec.get(TransferHeader."In-Transit Code");
        if Location_lRec.Returnable then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", 'OnBeforeValidateEvent', 'In-Transit Code', false, false)]
    local procedure "Table_5740_In-TransitCode"(var Rec: Record "Transfer Header"; var xRec: Record "Transfer Header"; CurrFieldNo: Integer)
    begin
        //ReturnTO-NS
        Location_gRec.Reset;
        if Location_gRec.Get(Rec."In-Transit Code") then begin
            if Location_gRec.Returnable then begin
                if Rec."In-Transit Code" <> xRec."In-Transit Code" then
                    Rec.CheckExistingLines_gFnc;
                Rec."Transfer-to Code" := Rec."Transfer-from Code";
            end;
        end;
        //ReturnTO-NE
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", 'OnBeforeValidateEvent', 'Transfer-from Code', false, false)]
    local procedure Table_5740_TransferfromCode_OnValidate(var Rec: Record "Transfer Header"; var xRec: Record "Transfer Header"; CurrFieldNo: Integer)
    var
        NoSeries_lRec: Record "No. Series";
        Text001: label '%1 and %2 cannot be the same in %3 %4.';
        Location_lRec: Record Location;
    begin
        if Rec.IsTemporary then
            exit;

        //ReturnTO-NS
        if Rec."In-Transit Code" <> '' then begin
            Location_gRec.Reset;
            Location_gRec.Get(Rec."In-Transit Code");
            if not Location_gRec.Returnable then begin
                if (Rec."Transfer-from Code" = Rec."Transfer-to Code") and (Rec."Transfer-from Code" <> '') then
                    Error(Text001, Rec.FieldCaption("Transfer-from Code"), Rec.FieldCaption("Transfer-to Code"), Rec.TableCaption, Rec."No.");
            end;
        end else begin
            if (Rec."Transfer-from Code" = Rec."Transfer-to Code") and (Rec."Transfer-from Code" <> '') then
                Error(Text001, Rec.FieldCaption("Transfer-from Code"), Rec.FieldCaption("Transfer-to Code"), Rec.TableCaption, Rec."No.");
        end;
        //ReturnTO-NE
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", 'OnBeforeValidateEvent', 'Transfer-to Code', false, false)]
    local procedure Table_5740_TransfertoCode(var Rec: Record "Transfer Header"; var xRec: Record "Transfer Header"; CurrFieldNo: Integer)
    var
        NoSeries_lRec: Record "No. Series";
        Text001: label '%1 and %2 cannot be the same in %3 %4.';
    begin
        if Rec.IsTemporary then
            exit;

        //ReturnTO-NS
        if Rec."In-Transit Code" <> '' then begin
            Location_gRec.Reset;
            Location_gRec.Get(Rec."In-Transit Code");
            if not Location_gRec.Returnable then begin
                if (Rec."Transfer-from Code" = Rec."Transfer-to Code") and (Rec."Transfer-from Code" <> '') then
                    Error(Text001, Rec.FieldCaption("Transfer-from Code"), Rec.FieldCaption("Transfer-to Code"), Rec.TableCaption, Rec."No.");
            end;
        end else begin
            if (Rec."Transfer-from Code" = Rec."Transfer-to Code") and (Rec."Transfer-to Code" <> '') then
                Error(Text001, Rec.FieldCaption("Transfer-from Code"), Rec.FieldCaption("Transfer-to Code"), Rec.TableCaption, Rec."No.");
        end;
        //ReturnTO-NE
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Transfer Document", OnBeforeCheckTransferCode, '', false, false)]
    local procedure OnBeforeCheckTransferCode(var TransferHeader: Record "Transfer Header"; var IsHandled: Boolean);
    begin
        //ReturnTO-NS
        if TransferHeader."In-Transit Code" <> '' then begin
            Location_gRec.Reset;
            Location_gRec.Get(TransferHeader."In-Transit Code");
            if Location_gRec.Returnable then begin
                if (TransferHeader."Transfer-from Code" = TransferHeader."Transfer-to Code") Then
                    IsHandled := TRUE;
            end;
        End;
        //ReturnTO-NE
    end;

}
//T07350-NE