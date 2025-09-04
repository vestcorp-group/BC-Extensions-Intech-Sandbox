page 80220 "INT Prod Param. Depend. List"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Parameter Dependency List';
    CardPageID = "INT Pack. Parameter Dependency";
    DataCaptionFields = "Product Code";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "INT Packaging Parameters";
    SourceTableView = SORTING("Product Code", "Serial No.");

    layout
    {
        area(content)
        {
            repeater("")
            {
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the code of the product.';
                }
                field("Assembly Code"; Rec."Assembly Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the Assembly code for the product.';
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the code of the parameter.';
                }
                field("Parameter Description"; Rec."Parameter Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the parameter.';
                }
                field("Mandatory Parameter"; Rec."Mandatory Parameter")
                {
                    ApplicationArea = All;
                    ToolTip = '"Specifies wether a parameter is mandatory or not. "';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a serial number.';
                }
                field("Parameter Depend On"; Rec."Parameter Depend On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if a parameter is dependent on other parameter.';
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

