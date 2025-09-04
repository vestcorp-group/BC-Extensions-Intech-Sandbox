tableextension 50254 "Item Unit of Measure Ext." extends "Item Unit of Measure"
{
    fields
    {
        field(50100; "Net Weight"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Weight (kg)';
            DecimalPlaces = 0 : 5;
        }
        field(50101; "Packing Weight"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Packing Weight (kg)';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                "Gross weight" := Weight + "Packing Weight"; //T12540-N
            end;
        }
        field(50102; Default; Boolean)
        {
            Caption = 'Default Selection';
            DataClassification = ToBeClassified;
        }
        field(77802; "Gross weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Gross weight';
            Description = '//T12540-N';
        }
        modify(Weight)//T12540-NS
        {
            trigger OnAfterValidate()
            begin
                "Gross weight" := Weight + "Packing Weight";
            end;
        }//T12540-NE

    }
    fieldgroups
    {
        addlast(DropDown; "Net Weight", "Packing Weight", Default)
        { }
    }

    var
        myInt: Integer;
}