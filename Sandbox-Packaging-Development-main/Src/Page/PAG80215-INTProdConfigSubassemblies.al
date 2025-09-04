page 80215 "INT Pack. Config Subassemblies"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Configurator Subassemblies';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "INT Pack. Configurator Detail";
    SourceTableView = SORTING("Assembly Line No.")
                      ORDER(Ascending)
                      WHERE(Type = FILTER(Assembly));

    layout
    {
        area(content)
        {
            repeater("")
            {
                field("Assembly Code"; Rec."Assembly Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies a code of the Subassembly.';
                }
                field("Assembly Description"; Rec."Assembly Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the assembly description.';
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

