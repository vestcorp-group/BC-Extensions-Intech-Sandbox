table 70050 "Sales Archive Remarks"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Quote","Order","Invoice","Credit Memo","Blanket Order","Return Order","Receipt","Posted Invoice","Posted Credit Memo","Posted Return Receipt";

        }
        field(50010; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50040; Remarks; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Doc. No. Occurance"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50070; "Version No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Document Type", "No.", "Doc. No. Occurance", "Version No.", "Line No.")
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