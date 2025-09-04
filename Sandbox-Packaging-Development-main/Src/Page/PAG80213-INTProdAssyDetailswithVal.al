page 80213 "INT Pack Assy.Details with Val"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Assy.Details with Val';
    PageType = List;
    SourceTable = "INT Pack Assy.Details with Val";
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the product.';
                }
                field("Assembly Code"; Rec."Assembly Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Assembly code for the product. It can also be called the top level BOM for the product.';
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the parameter.';
                }
                field("Parameter Value"; Rec."Parameter Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value for the parameter code.';
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

