tableextension 80212 TrackingSpecExt extends "Tracking Specification"
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
        field(80202; "Unit of Measure Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
            Editable = false;
        }
    }
}
