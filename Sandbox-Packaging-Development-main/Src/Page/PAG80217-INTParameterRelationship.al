page 80217 "INT Parameter Relationship"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Parameter Relationship';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "INT Pack Param Relationship";
    SourceTableView = SORTING("Line No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater("")
            {
                field("Parameter Value"; Rec."Parameter Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value for the parameter code.';
                }
                field("Parameter Value Description"; Rec."Parameter Value Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies a description of the parameter value.';
                }
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the product.';
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the parameter.';
                }
                field("Parameter 1"; Rec."Parameter 1")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies a parameter for the parameter code.';
                    Visible = false;
                }
                field("Parameter 2"; Rec."Parameter 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies a parameter for the parameter code.';
                    Visible = false;
                }
                field("Parameter 3"; Rec."Parameter 3")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies a parameter for the parameter code.';
                    Visible = false;
                }
                field("Parameter 4"; Rec."Parameter 4")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies a parameter for the parameter code.';
                    Visible = false;
                }
                field("Parameter 5"; Rec."Parameter 5")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies a parameter for the parameter code.';
                    Visible = false;
                }
                field("Parameter 6"; Rec."Parameter 6")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies a parameter for the parameter code.';
                    Visible = false;
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

    procedure GetSelectedLine(var ProdParameterRelationTemp: Record "INT Pack Param Relationship" temporary);
    begin
    end;
}

