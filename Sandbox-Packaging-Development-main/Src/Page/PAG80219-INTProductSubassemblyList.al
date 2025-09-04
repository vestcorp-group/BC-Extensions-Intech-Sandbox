page 80219 "INT Packaging Subassembly List"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Subassembly List';
    Editable = false;
    PageType = List;
    SourceTable = "INT Packaging Assembly";
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Assembly Code"; Rec."Assembly Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Assembly code for the product.';
                }
                field("Assembly Description"; Rec."Assembly Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the Assembly Code.';
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

