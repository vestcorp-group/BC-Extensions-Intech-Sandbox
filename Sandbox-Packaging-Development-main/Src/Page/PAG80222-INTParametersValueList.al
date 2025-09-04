page 80222 "INT Parameters Value List"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Parameter Values';
    DataCaptionFields = "Packaging Parameter Code";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "INT Packaging Parameter Values";
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Packaging Parameter Value"; Rec."Packaging Parameter Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value for the Packaging parameter code.';
                }
                field("Packaging Parameter Value Description"; Rec."Packaging Parameter Value Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the Packaging parameter value.';
                }
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    var
        INTKeyValidationMgt: Codeunit "INT Key Validation Mgt- PC";
    begin
        CLEAR(INTKeyValidationMgt);
        INTKeyValidationMgt.onOpenPageKeyValidation();
    end;
}

