/// <summary>
/// Table Staging Gen. Journal Line (ID 50102).
/// </summary>
table 54000 "Staging Gen. Journal Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "External Document No."; code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;

        }
        field(6; "Account No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Account Type" = CONST(Employee)) Employee;

        }
        field(7; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Currency Code"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(9; Amount; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(10; "IC Partner G/L Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "IC G/L Account";

        }
        field(11; "Status"; Option)
        {
            OptionMembers = Open,Created,Closed,Error,Deleted;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if (Status <> Status::Open) then
                    Error('You cannot change the Status');
            end;
        }
        field(12; "Error Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
            Editable = false;
        }
        field(14; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
            Editable = false;
        }
        field(15; IC; Boolean)
        {
            Editable = false;
        }
        field(16; "Gen. Doc"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "Uploaded By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Uploaded Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Upload Batch No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Modify By"; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Modify On"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Upload Batch No.")//30-04-2022-added key as this field is being used in table relation and sorting
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
        if Status <> Status::Created then begin
            "Modify By" := UserId;
            "Modify On" := CurrentDateTime;
        end;

    end;

    trigger OnDelete()
    begin
        if Status = Status::Created then
            Error('You cannot delete Line No. %1 as status is created', Rec."Line No.");
    end;

    trigger OnRename()
    begin

    end;

}