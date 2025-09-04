Table 50101 "ILE Origin Detail"
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
            Editable = false;
        }
        field(30; "Applied Document No."; Code[20])
        {
            Editable = false;
        }
        field(40; "Applied Entry Type"; Option)
        {
            Caption = 'Entry Type';
            Editable = false;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(50; "Applied Posting Date"; Date)
        {
            Editable = false;
        }
        field(60; "Applied Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(70; "Orignal Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(80; "Orignal Entry Type"; Option)
        {
            Caption = 'Entry Type';
            Editable = false;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(90; "Orignal Posting Date"; Date)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "ILE No.", "Applied ILE No.")
        {
            Clustered = true;
        }
        key(Key2; "Applied ILE No.")
        {
        }
    }

    fieldgroups
    {
    }
}

