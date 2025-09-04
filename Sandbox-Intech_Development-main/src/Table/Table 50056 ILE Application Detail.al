Table 50102 "ILE Application Detail"
{
    Description = 'T47866';

    fields
    {
        field(1; "ILE No."; Integer)
        {
            Editable = false;
        }
        field(2; "Applied ILE No."; Integer)
        {
            Caption = 'Applied ILE No.';
            Editable = false;
        }
        field(30; "Applied Document No."; Code[20])
        {
            Caption = 'Applied Document No.';
            Editable = false;
        }
        field(40; "Applied Entry Type"; Option)
        {
            Caption = 'Applied Entry Type';
            Editable = false;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(50; "Applied Posting Date"; Date)
        {
            Caption = 'Applied Posting Date';
            Editable = false;
        }
        field(60; "Applied Quantity"; Decimal)
        {
            Caption = 'Applied Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(70; "Orignal Quantity"; Decimal)
        {
            Caption = 'Orignal Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(80; "Orignal Entry Type"; Option)
        {
            Caption = 'Orignal Entry Type';
            Editable = false;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(90; "Orignal Posting Date"; Date)
        {
            Caption = 'Orignal Posting Date';
            Editable = false;
        }
        field(50010; "Create By Item Application Ent"; Boolean)
        {
            Caption = 'Create By Item Application Entry';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "ILE No.", "Applied ILE No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

