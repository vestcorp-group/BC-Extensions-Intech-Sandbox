table 80211 "Packaging Detail Header"
{
    Caption = 'Packaging Detail Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Packaging Code"; Code[250])
        {
            Caption = 'Code';
            NotBlank = true;
            // Editable = false;
        }
        field(30; Description; Text[1024])
        {
            Caption = 'Description';
            // Editable = false;
        }
        field(40; "Product Code"; Code[20])
        {
            Caption = 'Product Code';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Packaging Code")
        {
            Clustered = true;
        }
    }
}
