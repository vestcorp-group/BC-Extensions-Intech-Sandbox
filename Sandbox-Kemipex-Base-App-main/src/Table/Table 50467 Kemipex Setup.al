table 50467 "Kemipex Setup"//T12370-N
{
    DataClassification = ToBeClassified;
    Caption = 'Kemipex Setup';
    DataPerCompany = false;
    ReplicateData = false;

    fields
    {
        field(1; "Company Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Company;
        }
        field(2; "Sales Order Reopen Approver"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Sales Doc. Reopen User Type" = const(User)) User."User Name" else
            if ("Sales Doc. Reopen User Type" = const("User Group")) "Workflow User Group";
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;
        }
        field(3; "Sales Doc. Reopen User Type"; Option)
        {
            OptionMembers = ,"User Group","User";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Sales Order Reopen Approver" := '';
            end;
        }
    }

    keys
    {
        key(Key1; "Company Name")
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

    var
        notes: Record "Record Link";
        WOrkflow: Record "Workflow User Group";


}