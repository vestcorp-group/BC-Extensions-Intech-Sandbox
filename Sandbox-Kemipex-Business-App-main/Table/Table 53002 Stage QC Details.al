//T13919-NS
table 53002 "Stage QC Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "No."; Code[20])
        {
            NotBlank = true;
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = false;
            Editable = true;
        }
        field(4; "Quality Parameter Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Vendor COA Value Result"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(6; "Vendor COA Text Result"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Actual Value"; Decimal)
        {
            Caption = 'QC Value';
            DecimalPlaces = 3 : 3;
        }
        field(8; "Actual Text"; Text[30])
        {
            caption = 'QC Text Value';
        }
        field(9; "Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Purchase Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "ILE Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "ILE Lot No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Sample Collector ID"; Code[50])
        {
            Caption = 'Sample Collector ID';
            Description = 'T12541';
            DataClassification = ToBeClassified;
        }
        field(14; "Date of Sample Collection"; Date)
        {
            Caption = 'Date of Sample Collection';
            Description = 'T12541';
            DataClassification = ToBeClassified;
        }
        field(15; "Sample Provider ID"; Code[50])
        {
            Caption = 'Sample Provider ID';
            Description = 'T12541';
            DataClassification = ToBeClassified;
        }
        field(16; Result; Option)
        {
            Description = 'QCV2';
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        //14-04-2025-NS
        field(30; Required; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //14-04-2025-NE
        field(50001; "Sample Date and Time"; DateTime)
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