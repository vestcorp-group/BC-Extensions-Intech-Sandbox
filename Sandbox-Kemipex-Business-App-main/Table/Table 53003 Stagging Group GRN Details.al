//T13919-NS
table 53003 "Stagging Group GRN Details" //T14049
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(17; "From Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "To Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "From Group GRN Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "To Group GRN Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "From Company"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "To Company"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "GRN No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Shipment No"; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Item No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Lot No"; code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
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
//T13919-NE