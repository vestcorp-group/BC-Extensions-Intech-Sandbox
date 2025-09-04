page 80211 "INT Pack. Parameter Dependency"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Parameter Dependency1';
    DeleteAllowed = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "INT Packaging Parameters";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
                    ToolTip = 'Specifies the Assembly code for the product. It can also be called the top level BOM for the product.';
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the code of the parameter.';
                }
            }
            group("Parameter Dependency Detail")
            {
                Caption = 'Parameter Dependency Detail';
                field(P1ParameterCode; P1ParameterCode)
                {
                    ApplicationArea = All;
                    Caption = 'Parameter 1';
                    Editable = false;
                    ToolTip = 'Specifies the code of the parameter.';
                }
                field(P2ParameterCode; P2ParameterCode)
                {
                    ApplicationArea = All;
                    Caption = 'Parameter 2';
                    Editable = false;
                    ToolTip = 'Specifies the code of the parameter.';
                }
                field(P3ParameterCode; P3ParameterCode)
                {
                    ApplicationArea = All;
                    Caption = 'Parameter 3';
                    Editable = false;
                    ToolTip = 'Specifies the code of the parameter.';
                }
                field(P4ParameterCode; P4ParameterCode)
                {
                    ApplicationArea = All;
                    Caption = 'Parameter 4';
                    Editable = false;
                    ToolTip = 'Specifies the code of the parameter.';
                }
                field(P5ParameterCode; P5ParameterCode)
                {
                    ApplicationArea = All;
                    Caption = 'Parameter 5';
                    Editable = false;
                    ToolTip = 'Specifies the code of the parameter.';
                }
                field(P6ParameterCode; P6ParameterCode)
                {
                    ApplicationArea = All;
                    Caption = 'Parameter 6';
                    Editable = false;
                    ToolTip = 'Specifies the code of the parameter.';
                }
            }
            part(DependencyDetail; "INT Pack Param Depend. Detail")
            {
                ApplicationArea = All;
                SubPageLink = "Product Code" = FIELD("Product Code"),
                              "Product Assembly Code" = FIELD("Assembly Code"),
                              "Parameter Code" = FIELD("Parameter Code");
            }
        }
    }

    actions
    {
    }


    trigger OnAfterGetRecord();
    begin
        AssignParameterCode();
        CurrPage.DependencyDetail.PAGE.SetParameterValues(P1ParameterCode, P2ParameterCode, P3ParameterCode,
                                                               P4ParameterCode, P5ParameterCode, P6ParameterCode, Rec."Product Code", Rec."Parameter Code");
    end;

    trigger OnOpenPage();
    var
        INTKeyValidationMgt: Codeunit "INT Key Validation Mgt- PC";
    begin
        CLEAR(INTKeyValidationMgt);
        INTKeyValidationMgt.onOpenPageKeyValidation();

        ProductCode := Rec."Product Code";
        AssemblyCode := Rec."Assembly Code";
        ParameterCode := Rec."Parameter Code";

    end;

    var
        ProductDependenct: Record "INT Packaging Param Dependency";
        P1ParameterCode: Code[20];
        P2ParameterCode: Code[20];
        P3ParameterCode: Code[20];
        P4ParameterCode: Code[20];
        P5ParameterCode: Code[20];
        P6ParameterCode: Code[20];
        ProductCode: Code[20];
        AssemblyCode: Code[20];
        ParameterCode: Code[20];
        i: Integer;

    procedure AssignParameterCode();
    begin
        P1ParameterCode := '';
        P2ParameterCode := '';
        P3ParameterCode := '';
        P4ParameterCode := '';
        P5ParameterCode := '';
        P6ParameterCode := '';

        ProductDependenct.RESET();
        ProductDependenct.SETCURRENTKEY("Product Code", "Parameter Code", "Parameter Depend On Serial");
        ProductDependenct.SETRANGE("Product Code", Rec."Product Code");
        ProductDependenct.SETRANGE("Parameter Code", Rec."Parameter Code");
        IF ProductDependenct.FINDFIRST() THEN;
        FOR i := 1 TO ProductDependenct.COUNT() DO BEGIN
            CASE i OF
                1:
                    P1ParameterCode := ProductDependenct."Parameter Depend On";
                2:
                    P2ParameterCode := ProductDependenct."Parameter Depend On";
                3:
                    P3ParameterCode := ProductDependenct."Parameter Depend On";
                4:
                    P4ParameterCode := ProductDependenct."Parameter Depend On";
                5:
                    P5ParameterCode := ProductDependenct."Parameter Depend On";
                6:
                    P6ParameterCode := ProductDependenct."Parameter Depend On";
            END;
            ProductDependenct.NEXT();
        END;
    end;
}

