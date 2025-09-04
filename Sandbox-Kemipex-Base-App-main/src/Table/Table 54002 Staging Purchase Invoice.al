/// <summary>
/// Table Staging Purchase Header (ID 50100).
/// </summary>
table 54002 "Staging Purchase Invoice"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Vendor No."; Code[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Vendor;

        }
        field(2; "Vendor Refrence"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

        field(4; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;

        }

        field(5; "Currency Code"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Header Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Your Reference/PO Refernce"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Receipt No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; Type; Enum "Purchase Invoice Item Type")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;

        }
        field(10; "Item No."; Code[50])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            // TableRelation = IF (Type = CONST("Comment")) "Standard Text"
            // ELSE
            // IF (Type = CONST("G/L Account")) "G/L Account" WHERE("Direct Posting" = CONST(true))
            // ELSE
            // IF (Type = CONST("G/L Account")) "G/L Account"
            // ELSE
            // IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            // ELSE
            // IF (Type = CONST("Charge (Item)")) "Item Charge"
            // ELSE
            // IF (Type = CONST(Item)) Item WHERE(Blocked = CONST(false))
            // else
            // if (Type = const(Resource)) Resource;
        }
        field(11; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(12; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Direct Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Charge Item Types"; Option)
        {
            OptionMembers = " ",TR,RS,SS,RR,PR;
            DataClassification = ToBeClassified;

        }
        field(15; "Charge Item Doc1"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(16; "Charge Item Doc2"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(17; "Alloction"; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(18; "Status"; Option)
        {
            OptionMembers = Open,Created,Closed,Error,Deleted;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if (Status <> Status::Open) then
                    Error('You cannot change the Status')


            end;
        }
        field(19; "Error Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Location Code"; Code[20])
        {
            //TableRelation = Location;
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
        field(24; "Purch. Inv. No."; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Posted Purch. Inv. No."; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26; "Modify By"; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(27; "Modify On"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "Retry Count"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(Key1; "Vendor Refrence", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Upload Batch No.")//30-04-2022-added key as this field is being used in table relation and sorting
        {

        }
    }

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