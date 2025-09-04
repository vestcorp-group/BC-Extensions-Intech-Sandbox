table 70100 TaxType
{
    Caption = 'Tax Type';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Tax Type Code"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Tax Type Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Tax Country"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
    }

    keys
    {
        key(PK; "Tax Type Code")
        {
            Clustered = true;
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