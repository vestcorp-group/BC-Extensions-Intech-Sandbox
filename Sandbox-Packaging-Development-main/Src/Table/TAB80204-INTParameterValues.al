table 80204 "INT Packaging Parameter Values"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Parameter Values';
    DataCaptionFields = "Packaging Parameter Code";
    DrillDownPageID = "INT Packaging Parameter Values";
    LookupPageID = "INT Packaging Parameter Values";

    fields
    {
        field(70144421; "Packaging Parameter Code"; Code[20])
        {
            Caption = 'Packaging Parameter Code';
            Editable = false;
            NotBlank = true;
            TableRelation = "INT Packaging Parameter"."Packaging Parameter Code";
            DataClassification = CustomerContent;
        }
        field(70144422; "Packaging Parameter Value"; Code[5])
        {
            Caption = 'Packaging Parameter Value';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(70144423; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(70144441; "Packaging Parameter Value Description"; Text[50])
        {
            Caption = 'Packaging Parameter Value Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Packaging Parameter Code", "Packaging Parameter Value", "Line No.")
        {
        }
        key(Key2; "Packaging Parameter Value")
        {
        }
        key(Key3; "Line No.")
        {
        }
        key(Key4; "Packaging Parameter Value Description")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Packaging Parameter Code", "Packaging Parameter Value", "Packaging Parameter Value Description")
        {
        }
    }
}

