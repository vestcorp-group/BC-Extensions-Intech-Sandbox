Table 74986 "Update Posting Date Batch"
{
    //UpdatePostingDateBatch
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "New Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "New Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; Updated; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50020; "Last Modify By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50030; "Last Modify DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Updated, false);
    end;

    trigger OnInsert()
    begin
        "Last Modify By" := UserId;
        "Last Modify DateTime" := CurrentDatetime;
    end;

    trigger OnModify()
    begin
        TestField(Updated, false);

        "Last Modify By" := UserId;
        "Last Modify DateTime" := CurrentDatetime;
    end;
}
