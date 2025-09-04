tableextension 50308 KMP_TabExtSalesShipmentLine extends "Sales Shipment Line"//T12370-N
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
        }
        field(50300; "Stencil"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50301; "Relabel"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(50302; "Inspection"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
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

    }

    var
        myInt: Integer;
}