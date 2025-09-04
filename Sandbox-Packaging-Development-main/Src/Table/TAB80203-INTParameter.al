table 80203 "INT Packaging Parameter"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Parameter';
    DrillDownPageID = "INT Packaging Parameter List";
    LookupPageID = "INT Packaging Parameter List";

    fields
    {
        field(70144421; "Packaging Parameter Code"; Code[20])
        {
            Caption = 'Packaging Parameter Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(70144441; "Packaging Parameter Description"; Text[50])
        {
            Caption = 'Packaging Parameter Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Packaging Parameter Code")
        {
        }
        key(Key2; "Packaging Parameter Description")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Packaging Parameter Code", "Packaging Parameter Description")
        {
        }
    }

    trigger OnDelete();
    begin
        ParameterValues.RESET();
        ParameterValues.SETRANGE("Packaging Parameter Code", "Packaging Parameter Code");
        IF ParameterValues.FINDSET() THEN
            ParameterValues.DELETEALL(TRUE);
    end;

    var
        ParameterValues: Record "INT Packaging Parameter Values";
}

