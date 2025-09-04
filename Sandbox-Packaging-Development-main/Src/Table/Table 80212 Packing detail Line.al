table 80212 "Packaging detail Line"
{
    Caption = 'Packaging detail Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Packaging Code"; Code[250])
        {
            Caption = 'Packaging Code';
            Editable = false;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(30; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(31; "Packaging Level"; Integer)
        {
            Caption = 'Packaging Level';
            Editable = false;
        }
        field(32; "Packaging Matrics"; Integer)
        {
            Caption = 'Packaging Matrics';
            trigger OnValidate()
            begin
                if Rec."Packaging Weight" = 0 then begin
                    Rec."Gross Weight" := 0;
                    Rec.Modify();
                end else begin
                    CalculateGrossWeight_gFnc;
                end;
                CalculateGrossWeightForOtherLevel_gFnc();
            end;
        }
        field(33; "Packaging Weight"; Decimal)
        {
            Caption = 'Packaging Weight';
            trigger OnValidate()
            var
                PackingdetailLine_lRec: Record "Packaging detail Line";
            begin
                if Rec."Packaging Weight" = 0 then begin
                    Rec."Gross Weight" := 0;
                    Rec.Modify();
                end else begin
                    CalculateGrossWeight_gFnc;
                    // CalculateGrossWeightForOtherLevel_gFnc();
                end;
                CalculateGrossWeightForOtherLevel_gFnc();
            end;
        }
        field(34; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            trigger OnValidate()
            begin
                if Rec."Packaging Weight" = 0 then begin
                    Rec."Gross Weight" := 0;
                    Rec.Modify();
                end else begin
                    CalculateGrossWeight_gFnc;
                end;
                CalculateGrossWeightForOtherLevel_gFnc();
            end;
        }
        field(35; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            Editable = false;
        }
        field(36; Length; Decimal)
        {
            Caption = 'Length';
        }
        field(37; Width; Decimal)
        {
            Caption = 'Width';
        }
        field(38; Height; Decimal)
        {
            Caption = 'Height';
        }
    }
    keys
    {
        key(PK; "Packaging Code", "Unit of Measure")
        {
            Clustered = true;
        }
    }

    trigger OnInsert();
    begin
        PackingdetailLine_gRec.RESET();
        PackingdetailLine_gRec.SETCURRENTKEY("Packaging Level");
        PackingdetailLine_gRec.SETRANGE("Packaging Code", Rec."Packaging Code");
        IF PackingdetailLine_gRec.FINDLAST() THEN begin
            "Packaging Level" := PackingdetailLine_gRec."Packaging Level" + 1;
            "Line No." := PackingdetailLine_gRec."Line No." + 10000;
        end ELSE begin
            "Packaging Level" := 0;
            "Line No." := 10000;
        end;
    end;

    trigger OnDelete()
    var
        PackingdetailLine_lRec: Record "Packaging detail Line";
    begin
        PackingdetailLine_lRec.Reset();
        PackingdetailLine_lRec.SetRange("Packaging Code", Rec."Packaging Code");
        PackingdetailLine_lRec.SetFilter("Packaging Level", '>%1', Rec."Packaging Level");
        PackingdetailLine_lRec.SetCurrentKey("Packaging Level");
        PackingdetailLine_lRec.SetAscending("Packaging Level", true);
        if PackingdetailLine_lRec.FindFirst() then
            Error('Please delete Packaging Detail Line with UOM:%1 and Packaging Level:%2 so that all calculations are correct', PackingdetailLine_lRec."Unit of Measure", PackingdetailLine_lRec."Packaging Level");
    end;

    procedure CalculateGrossWeight_gFnc()
    var
        PackingdetailLine_lRec: Record "Packaging detail Line";
    begin
        if "Packaging Level" <> 0 then begin
            if ("Packaging Weight" <> 0) and ("Packaging Matrics" <> 0) and ("Net Weight" <> 0) and ("Packaging Level" = 1) then
                "Gross Weight" := ("Packaging Weight" * "Packaging Matrics") + ("Net Weight" * "Packaging Matrics")
            else begin
                PackingdetailLine_lRec.Reset();
                PackingdetailLine_lRec.SetRange("Packaging Code", Rec."Packaging Code");
                PackingdetailLine_lRec.SetFilter("Packaging Level", '<%1&<>%2', Rec."Packaging Level", 0);
                PackingdetailLine_lRec.SetCurrentKey("Packaging Level");
                PackingdetailLine_lRec.SetAscending("Packaging Level", false);
                if PackingdetailLine_lRec.FindFirst() then begin
                    if ("Packaging Weight" <> 0) and ("Packaging Matrics" <> 0) and (PackingdetailLine_lRec."Gross Weight" <> 0) then
                        "Gross Weight" := ("Packaging Weight" * "Packaging Matrics") + PackingdetailLine_lRec."Gross Weight";
                end;
            end;
            Rec.Modify();
        end;
    end;

    local procedure CalculateGrossWeightForOtherLevel_gFnc()
    var
        PackingdetailLine_lRec: Record "Packaging detail Line";
        PackingdetailLine1_lRec: Record "Packaging detail Line";
    begin
        PackingdetailLine_lRec.Reset();
        PackingdetailLine_lRec.SetRange("Packaging Code", Rec."Packaging Code");
        PackingdetailLine_lRec.SetFilter("Packaging Level", '>%1', Rec."Packaging Level");
        PackingdetailLine_lRec.SetCurrentKey("Packaging Level");
        PackingdetailLine_lRec.SetAscending("Packaging Level", true);
        if PackingdetailLine_lRec.FindSet() then begin
            repeat
                if PackingdetailLine_lRec."Packaging Level" <> 0 then begin
                    if (PackingdetailLine_lRec."Packaging Weight" <> 0) and (PackingdetailLine_lRec."Packaging Matrics" <> 0) and (PackingdetailLine_lRec."Net Weight" <> 0) and (PackingdetailLine_lRec."Packaging Level" = 1) then
                        PackingdetailLine_lRec."Gross Weight" := (PackingdetailLine_lRec."Packaging Weight" * "Packaging Matrics") + (PackingdetailLine_lRec."Net Weight" * PackingdetailLine_lRec."Packaging Matrics")
                    else begin
                        PackingdetailLine1_lRec.Reset();
                        PackingdetailLine1_lRec.SetRange("Packaging Code", PackingdetailLine_lRec."Packaging Code");
                        PackingdetailLine1_lRec.SetFilter("Packaging Level", '<%1&<>%2', PackingdetailLine_lRec."Packaging Level", 0);
                        PackingdetailLine1_lRec.SetCurrentKey("Packaging Level");
                        PackingdetailLine1_lRec.SetAscending("Packaging Level", false);
                        if PackingdetailLine1_lRec.FindFirst() then begin
                            if (PackingdetailLine_lRec."Packaging Weight" <> 0) and (PackingdetailLine_lRec."Packaging Matrics" <> 0) and (PackingdetailLine1_lRec."Gross Weight" <> 0) then
                                PackingdetailLine_lRec."Gross Weight" := (PackingdetailLine_lRec."Packaging Weight" * PackingdetailLine_lRec."Packaging Matrics") + PackingdetailLine1_lRec."Gross Weight"
                            else
                                PackingdetailLine_lRec."Gross Weight" := 0;
                        end;
                    end;
                end;
                // if (PackingdetailLine_lRec."Packaging Level" <> 0) AND ((PackingdetailLine_lRec."Packaging Matrics") or ()) 
                PackingdetailLine_lRec.Modify();
            until PackingdetailLine_lRec.Next() = 0;
        end;
    end;

    var
        PackingdetailLine_gRec: Record "Packaging detail Line";

}
