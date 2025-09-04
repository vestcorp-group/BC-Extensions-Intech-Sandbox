table 50148 "Company Short Name"//T12370-N
{
    DataClassification = CustomerContent;
    Caption = 'Company Short Name';
    DataPerCompany = false;
    ReplicateData = false;

    fields
    {
        field(1; Name; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
            TableRelation = Company;
            NotBlank = true;
        }
        field(21; "Short Name"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Short Name';
        }
        field(2; "Block in Reports"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Block in Reports';
        }
        field(3; "Block in PowerBI"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Name)
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