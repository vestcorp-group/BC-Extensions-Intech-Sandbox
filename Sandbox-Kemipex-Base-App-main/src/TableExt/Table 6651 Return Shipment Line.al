tableextension 50302 KMP_TblExtReturnShipmentLine extends "Return Shipment Line"
{
    fields
    {
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';
        }
        field(50110; "Base UOM 2"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = IF (Type = CONST(Item), "No." = FILTER(<> '')) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        //Moved from PDCnothers Extension
        field(50112; "Container No. 2"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }
}