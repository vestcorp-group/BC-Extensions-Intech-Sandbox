page 80207 "INT Parameter"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Parameter';
    PageType = Card;
    SourceTable = "INT Packaging Parameter";
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
            part("Parameter Values"; "INT Packaging Parameter Values")
            {
                ApplicationArea = All;
                SubPageLink = "Packaging Parameter Code" = FIELD("Packaging Parameter Code");
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

