table 80015 "Customer Registration"//T12370-N
{

    DataClassification = ToBeClassified;
    fields
    {

        field(1; Code; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Customer Registration Type"; Text[20])
        {
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
        fieldgroup(DropDown; Code, "Customer Registration Type")
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