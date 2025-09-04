page 80210 "INT Pack Param Dependency List"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Param Dependency List';
    DataCaptionFields = "Product Code", "Parameter Code";
    DelayedInsert = true;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "INT Packaging Param Dependency";
    SourceTableView = SORTING("Product Code", "Parameter Code", "Parameter Depend On Serial");

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Parameter Depend On"; Rec."Parameter Depend On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code of the dependent parameter.';
                }
                field("Parameter Depend On Serial"; Rec."Parameter Depend On Serial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a serial number of the parameter depend code.';
                }
                field("Parameter Serial"; Rec."Parameter Serial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the serial number of the parameter code.';
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

