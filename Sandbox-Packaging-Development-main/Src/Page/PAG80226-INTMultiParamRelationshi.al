page 80226 "INT Multi. Param. Relationshi"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Multiple Parameter Relationship';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
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
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                    Caption = 'Select';
                    ToolTip = 'Specifies if parameter relation is to be selected or not.';

                    trigger OnValidate();
                    begin
                        IF NOT TempPrdRel.GET(Rec."Product Code", Rec."Product Assembly Code", Rec."Parameter Code", Rec."Parameter 1", Rec."Parameter 2", Rec."Parameter 3", Rec."Parameter 4", Rec."Parameter 5", Rec."Parameter 6", Rec."Parameter Value") THEN BEGIN
                            TempPrdRel.INIT();
                            TempPrdRel := Rec;
                            TempPrdRel.INSERT();
                        END;

                        TempPrdRel.Select := Rec.Select;
                        TempPrdRel.MODIFY();
                    end;
                }
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

    trigger OnAfterGetRecord();
    begin
        Rec.Select := FALSE;
        IF TempPrdRel.GET(Rec."Product Code", Rec."Product Assembly Code", Rec."Parameter Code", Rec."Parameter 1", Rec."Parameter 2", Rec."Parameter 3", Rec."Parameter 4", Rec."Parameter 5", Rec."Parameter 6", Rec."Parameter Value") THEN
            IF TempPrdRel.Select THEN
                Rec.Select := TRUE;

    end;

    var
        TempPrdRel: Record "INT Pack Param Relationship" temporary;
        Select: Boolean;

    procedure GetSelectedLine(var ProdParameterRelationTemp: Record "INT Pack Param Relationship" temporary);
    begin
        TempPrdRel.RESET();
        TempPrdRel.SETRANGE(Select, TRUE);
        ProdParameterRelationTemp.COPY(TempPrdRel, TRUE);
    end;
}

