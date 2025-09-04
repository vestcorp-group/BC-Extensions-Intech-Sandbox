tableextension 80210 PurRcptLineExt extends "Purch. Rcpt. Line"
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
