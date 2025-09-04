table 50437 "Customer Group"//T12370-N
{
    LookupPageId = "Customer Group Lookup";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Description/Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Customer Group Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Customer Group Code", "Description/Name")
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