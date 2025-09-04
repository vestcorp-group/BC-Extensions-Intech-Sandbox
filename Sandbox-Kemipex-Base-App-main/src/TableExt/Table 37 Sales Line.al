tableextension 50306 "KMP_TabExtSalesLine" extends "Sales Line"//T12370-N
{
    fields
    {
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';
        }
        field(50101; HSNCode; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'HSN Code';
            TableRelation = "Tariff Number";
        }
        field(50102; CountryOfOrigin; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Country Of Origin';
            TableRelation = "Country/Region";
        }
        field(50103; BillOfExit; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill Of Exit';
        }
        field(50104; LineHSNCode; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Line HSN Code';
            TableRelation = "Tariff Number";

        }
        field(50105; LineCountryOfOrigin; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Line Country Of Origin';
            TableRelation = "Country/Region";
        }
        field(50106; "IC Customer"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'IC Customer';
        }
        field(50107; "IC Related SO"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'IC Related SO';
        }
        field(50108; "Allow Loose Qty."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Loose Qty.';
            trigger OnValidate()
            var
                ItemL: Record Item;
                ItemUoML: Record "Item Unit of Measure";
                UnitofMeasureL: Record "Unit of Measure";
                BaseUOMQtyL: Decimal;
            begin
                //T12370-Full Comment
                if not ItemL.Get("No.") then
                    exit;
                ItemL.TestField("Allow Loose Qty.", true);
                if not UnitofMeasureL.Get("Unit of Measure Code") then
                    exit;
                if UnitofMeasureL."Decimal Allowed" then
                    exit;
                ItemUoML.Get("No.", "Unit of Measure Code");
                //Hypercare-12-03-2025-OS-NetWtGrossWt
                // "Net Weight" := Quantity * ItemUoML."Net Weight";
                // "Gross Weight" := "Net Weight";
                //Hypercare-12-03-2025-OE-NetWtGrossWt
                BaseUOMQtyL := Quantity * ItemUoML."Qty. per Unit of Measure";
                ItemUoML.Reset();
                ItemUoML.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
                ItemUoML.Ascending(true);
                ItemUoML.SetRange("Item No.", "No.");
                if "Allow Loose Qty." then begin
                    if ItemUoML.FindFirst() then
                        "Gross Weight" += Round(BaseUOMQtyL / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";
                end else begin
                    if ItemUoML.FindSet() then
                        repeat
                            UnitofMeasureL.Get(ItemUoML.Code);
                            if not UnitofMeasureL."Decimal Allowed" then
                                "Gross Weight" += Round(BaseUOMQtyL / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";
                        until ItemUoML.Next() = 0;
                end;
                //Hypercare-12-03-2025-OS-NetWtGrossWt
                // "Gross Weight" := Round("Gross Weight", 1, '=');
                // "Net Weight" := Round("Net Weight", 1, '=');
                //Hypercare-12-03-2025-OE-NetWtGrossWt
            end;
        }
        field(50109; "IC Copy"; Boolean)
        {
            DataClassification = ToBeClassified;
            // linked to Sales unit of measure validation. do not use for any other purpose.
            Description = 'linked to Sales unit of measure validation. do not use for any other purpose.';
        }
        field(50110; "Base UOM 2"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = IF (Type = CONST(Item), "No." = FILTER(<> '')) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(50111; "Unit Price Base UOM 2"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                Validate("Unit Price", "Unit Price Base UOM 2" * rec."Qty. per Unit of Measure");
            end;
        }

        //Moved from PDCnothers Extension
        field(50112; "Container No. 2"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "IMCO Class"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "IMCO Class Master";
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                ItemRec: Record item;
            begin
                if rec.Type = rec.Type::Item then begin
                    ItemRec.Get("No.");
                    Rec."Base UOM 2" := ItemRec."Base Unit of Measure";
                    "IMCO Class" := ItemRec."IMCO Class";
                end;
            end;
        }

        field(50600; "Profit % IC"; Decimal)
        {
            Caption = 'Profit % (IC)';
            Editable = false;
        }
    }
}