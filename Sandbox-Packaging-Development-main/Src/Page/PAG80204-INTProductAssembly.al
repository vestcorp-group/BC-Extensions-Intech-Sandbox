page 80204 "INT Packaging Assembly"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Assembly';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "INT Packaging Assembly";
    SourceTableView = SORTING("Line No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater("")
            {
                field("Assembly Code"; Rec."Assembly Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Assembly code for the product. It can also be called the top level BOM for the product.';
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

