page 80208 "INT Packaging Parameter Values"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    AutoSplitKey = true;
    Caption = 'Packaging Parameter Values';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "INT Packaging Parameter Values";
    SourceTableView = SORTING("Line No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Packaging Parameter Code"; Rec."Packaging Parameter Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the Packaging parameter.';
                }
                field("Packaging Parameter Value"; Rec."Packaging Parameter Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value for the Packaging parameter code.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the line number.';
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

