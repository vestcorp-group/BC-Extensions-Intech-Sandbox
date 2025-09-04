table 50366 "Warehouse Instruction Setup"//T12370-Full Comment
{
    DataClassification = ToBeClassified;
    Caption = 'Warehouse Instruction Setup';
    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Whse Delivery Ins No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(3; "CC Email Address"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Ex-Works Incoterm"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Transaction Specification";
            TableRelation = "Shipment Method";
        }
        field(5; "Agent No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; MyField)
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