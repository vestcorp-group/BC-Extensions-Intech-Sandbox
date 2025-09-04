tableextension 58012 ItemUOM extends "Item Unit of Measure"//T12370-Full Comment //T12724
{
    fields
    {
        field(58000; "Decimal Allowed"; Boolean)
        {
            Caption = 'Decimal Allowed';
            FieldClass = FlowField;
            CalcFormula = lookup("Unit of Measure"."Decimal Allowed" where(Code = field(Code)));
        }
        field(58001; "Variant Code"; Code[20])
        {
            Caption = 'Variant Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code WHERE("Item No." = field("Item No."));
        }
    }
    fieldgroups
    {
        addlast(DropDown; "Variant Code")
        { }
    }

}
