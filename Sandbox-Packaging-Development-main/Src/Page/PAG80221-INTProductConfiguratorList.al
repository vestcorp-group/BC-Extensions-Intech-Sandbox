page 80221 "INT Packaging Config List"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Configurator List';
    CardPageID = "INT Packaging Configurator";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "INT Pack. Configurator Detail";
    SourceTableView = SORTING("Configurator No.", "Line No.")
                      WHERE(Type = FILTER(Product),
                            "Line No." = FILTER(0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Configurator No."; Rec."Configurator No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a Configurator Number.';
                }
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the product.';
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the product.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the product configurator is new or certified.';
                }
                field("Suggested Code"; Rec."Suggested Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a suggested code.';
                }
                field("Suggested Description"; Rec."Suggested Description")
                {
                    ToolTip = 'Specifies the value of the Suggested Description field.', Comment = '%';
                }
                field("Packaging Code Created"; Rec."Packaging Code Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Packaging Code Created field.', Comment = '%';
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

