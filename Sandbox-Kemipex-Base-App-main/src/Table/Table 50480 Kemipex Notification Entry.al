table 50480 "Kemipex Notification Entry"
{
    DataClassification = ToBeClassified;
    // ReplicateData = false;

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
            Caption = 'ID';
        }
        // field(3; Type; Enum "Notification Entry Type")
        // {
        //     Caption = 'Type';
        // }
        field(4; "Recipient User ID"; Code[50])
        {
            Caption = 'Recipient User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup"."User ID";
            ValidateTableRelation = false;
        }
        field(5; "Triggered By Record"; RecordID)
        {
            Caption = 'Triggered By Record';
            DataClassification = SystemMetadata;
        }
        // field(6; "Link Target Page"; Integer)
        // {
        //     Caption = 'Link Target Page';
        //     TableRelation = "Page Metadata".ID;
        // }
        // field(7; "Custom Link"; Text[250])
        // {
        //     Caption = 'Custom Link';
        //     ExtendedDatatype = URL;
        // }
        // field(8; "Error Message"; Text[2048])
        // {
        //     Caption = 'Error Message';
        //     Editable = false;
        // }
        // field(9; "Created Date-Time"; DateTime)
        // {
        //     Caption = 'Created Date-Time';
        //     Editable = false;
        // }
        // field(10; "Created By"; Code[50])
        // {
        //     Caption = 'Created By';
        //     DataClassification = EndUserIdentifiableInformation;
        //     Editable = false;
        //     TableRelation = User."User Name";
        // }
        // field(15; "Error Message 2"; Text[250])
        // {
        //     Caption = 'Error Message 2';
        //     ObsoleteReason = 'Error Message field size has been increased ';
        //     ObsoleteState = Removed;
        //     ObsoleteTag = '18.0';
        // }
        // field(16; "Error Message 3"; Text[250])
        // {
        //     Caption = 'Error Message 3';
        //     ObsoleteReason = 'Error Message field size has been increased ';
        //     ObsoleteState = Removed;
        //     ObsoleteTag = '18.0';
        // }
        // field(17; "Error Message 4"; Text[250])
        // {
        //     Caption = 'Error Message 4';
        //     ObsoleteReason = 'Error Message field size has been increased ';
        //     ObsoleteState = Removed;
        //     ObsoleteTag = '18.0';
        // }
        field(18; "Sender User ID"; Code[50])
        {
            Caption = 'Sender User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup"."User ID";
        }
        field(19; Handled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Approval Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; ID)
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
        NotificationDispatcher: Codeunit "Notification Entry Dispatcher";
        approval: Record "Approval Entry";
        N2: Record "Notification Entry";

        w: Codeunit "Workflow Management";

        N: Codeunit "Notification Management";

}