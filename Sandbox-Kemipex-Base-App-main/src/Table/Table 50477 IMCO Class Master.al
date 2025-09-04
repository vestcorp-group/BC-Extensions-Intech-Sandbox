table 50477 "IMCO Class Master"//T12370-N
{
    DataClassification = ToBeClassified;
    LookupPageId = "IMCO Class Master";
    Caption = 'UN Numbers';

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Description"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Class; Text[30])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(dropdown; Code, Description)
        {

        }
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