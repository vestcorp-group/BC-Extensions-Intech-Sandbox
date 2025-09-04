table 50486 "Product Family"//T12370-N
{
    Caption = 'Product Family';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Product Family";
    LookupPageId = "Product Family";

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Product Family Name"; Text[100])
        {
            Caption = 'Product Family Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Minimum Stock Quantity"; Decimal)
        {
            Caption = 'Minimum Stock Quantity';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, "Product Family Name")
        {

        }
    }
}
