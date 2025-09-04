page 80205 "INT Packaging Parameter2"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Parameter';
    PageType = CardPart;
    SourceTable = "INT Packaging Parameter";
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Parameter Code"; Rec."Packaging Parameter Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the parameter.';
                }
                field("Parameter Description"; Rec."Packaging Parameter Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the parameter.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1000000011>")
            {
                ApplicationArea = All;
                Caption = 'Parameter Values';
                Image = CostEntries;
                RunObject = Page "INT Parameter";
                RunPageLink = "Packaging Parameter Code" = FIELD("Packaging Parameter Code");
                ToolTip = 'View and configure the parameter values.';
            }
        }
    }
    trigger OnOpenPage()
    var
        INTKeyValidationMgt: Codeunit "INT Key Validation Mgt- PC";
    begin
        CLEAR(INTKeyValidationMgt);
        INTKeyValidationMgt.onOpenPageKeyValidation();
    end;
}

