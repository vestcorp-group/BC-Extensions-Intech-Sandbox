table 80014 "Sales Order Remarks"//T12370-N
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order",Shipment;
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(4; Comments; Text[500])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Type"; Option)
        {
            OptionMembers = ,Unposted,Posted;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Document Type", "Document No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

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