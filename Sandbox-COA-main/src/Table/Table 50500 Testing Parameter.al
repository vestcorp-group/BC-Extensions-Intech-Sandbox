table 50500 "Testing Parameter"//T12370-N
{
    DataClassification = CustomerContent;
    Caption = 'Testing Parameter';

    fields
    {
        field(1; Code; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            NotBlank = true;
        }
        field(21; "Testing Parameter"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Testing Parameter';
            NotBlank = true;
        }
        field(22; "Testing Parameter Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Testing Parameter Code';
        }
        field(23; "Data Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Data Type';
            OptionMembers = Alphanumeric,Decimal,Integer;
            OptionCaption = 'Alphanumeric,Decimal,Integer';
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
        //fieldgroup(DropDown; Code, "Testing Parameter") { }////T45727-O
        fieldgroup(DropDown; Code, "Testing Parameter", "Testing Parameter Code", "Data Type") { }//T45727-N
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}