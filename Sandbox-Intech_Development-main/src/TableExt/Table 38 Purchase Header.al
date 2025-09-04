tableextension 50100 PurHdrExt extends "Purchase Header"
{
    fields
    {
        //T48125-NS
        field(50705; "Est Payment Date 1"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50706; "Est Payment Date 2"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50707; "Est Payment Date 3"; Date)
        {
            DataClassification = ToBeClassified;
        }
        //T48125-NE
        field(50709; "Consumable Exist"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T51983';
        }
    }

}