page 80206 "INT Packaging Parameter List"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Parameter List';
    CardPageID = "INT Parameter";
    Editable = false;
    PageType = List;
    SourceTable = "INT Packaging Parameter";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Packaging Parameter Code"; Rec."Packaging Parameter Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the parameter.';
                }
                field("Packaging Parameter Description"; Rec."Packaging Parameter Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the parameter.';
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

