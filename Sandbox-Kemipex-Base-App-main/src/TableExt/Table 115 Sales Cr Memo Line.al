tableextension 50398 SalesCrMemLineTblExt extends "Sales Cr.Memo Line"
{
    // version NAVW113.00

    fields
    {
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

        field(50600; "Profit % IC"; Decimal)
        {
            Caption = 'Profit % (IC)';
        }
    }
}

// field(50101; "Shipment Method 2"; Code[10])
// {
//     DataClassification = ToBeClassified;
//     TableRelation = "Shipment Method";
// }
// field(50102; "Shipment Packing 2"; Code[20])
// {
//     DataClassification = ToBeClassified;
//     TableRelation = "Shipment Packings"."Packing Container" where("Item No." = field("No."));
// }
// field(50103; "Packing Qty 2"; Decimal)
// {
//     DataClassification = ToBeClassified;
//     DecimalPlaces = 0 : 5;
// }
// field(50104; "No. of Load 2"; decimal)
// {
//     DataClassification = ToBeClassified;
//     DecimalPlaces = 0 : 5;
// }
// field(50105; "Packing Net Weight 2"; Decimal)
// {
//     DataClassification = ToBeClassified;
//     DecimalPlaces = 0 : 5;
// }
// field(50106; "Packing Gross Weight 2"; Decimal)
// {
//     DataClassification = ToBeClassified;
//     DecimalPlaces = 0 : 5;
// }