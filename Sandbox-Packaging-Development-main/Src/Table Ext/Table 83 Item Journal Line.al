tableextension 80204 ItemJnlLineExt extends "Item Journal Line"
{
    fields
    {
        field(80201; "Packaging Code"; Code[250])
        {
            Caption = 'Packaging Code';
            TableRelation = "Packaging Detail Header";
            DataClassification = ToBeClassified;
        }
    }
}
