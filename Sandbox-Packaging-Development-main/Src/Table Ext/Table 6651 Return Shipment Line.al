tableextension 80208 RtnShptLineExt extends "Return Shipment Line"
{
    fields
    {
        field(80201; "Packaging Code"; Code[250])
        {
            Caption = 'Packaging Code';
            TableRelation = "Packaging Detail Header";
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}
