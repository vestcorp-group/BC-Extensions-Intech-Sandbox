page 80224 "INT Pack Param Values"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Parameter Value Dependency Detail';
    DelayedInsert = true;
    PageType = ListPart;
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
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the code of the product.';
                }
                field("Product Assembly Code"; Rec."Product Assembly Code")
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
                field("Parameter 1"; Rec."Parameter 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a parameter for the parameter code.';
                    Visible = "Parameter 1Visible";

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Lookup(P1ParameterCode, 1);
                    end;
                }
                field("Parameter 1 Description"; Rec."Parameter 1 Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a parameter value for parameter.';
                    Visible = "Parameter 1 DescriptionVisible";
                }
                field("Parameter 2"; Rec."Parameter 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a parameter for the parameter code.';
                    Visible = "Parameter 2Visible";

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Lookup(P2ParameterCode, 2);
                    end;
                }
                field("Parameter 2 Description"; Rec."Parameter 2 Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a parameter value for parameter.';
                    Visible = "Parameter 2 DescriptionVisible";
                }
                field("Parameter 3"; Rec."Parameter 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a parameter for the parameter code.';
                    Visible = "Parameter 3Visible";

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Lookup(P3ParameterCode, 3);
                    end;
                }
                field("Parameter 3 Description"; Rec."Parameter 3 Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a parameter value for parameter.';
                    Visible = "Parameter 3 DescriptionVisible";
                }
                field("Parameter 4"; Rec."Parameter 4")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a parameter for the parameter code.';
                    Visible = "Parameter 4Visible";

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Lookup(P4ParameterCode, 4);
                    end;
                }
                field("Parameter 4 Description"; Rec."Parameter 4 Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a parameter value for parameter.';
                    Visible = "Parameter 4 DescriptionVisible";
                }
                field("Parameter 5"; Rec."Parameter 5")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a parameter for the parameter code.';
                    Visible = "Parameter 5Visible";

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Lookup(P5ParameterCode, 5);
                    end;
                }
                field("Parameter 5 Description"; Rec."Parameter 5 Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a parameter value for parameter.';
                    Visible = "Parameter 5 DescriptionVisible";
                }
                field("Parameter 6"; Rec."Parameter 6")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a parameter for the parameter code.';
                    Visible = "Parameter 6Visible";

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Lookup(P6ParameterCode, 6);
                    end;
                }
                field("Parameter 6 Description"; Rec."Parameter 6 Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a parameter value for parameter.';
                    Visible = "Parameter 6 DescriptionVisible";
                }
                field("Parameter Value"; Rec."Parameter Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a parameter value for parameter.';

                    trigger OnValidate();
                    begin
                        //Lookup(ParameterCode,0);
                    end;
                }
                field("Parameter Value Description"; Rec."Parameter Value Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the parameter value.';
                }

                field("Code for Item"; Rec."Code for Item")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for the Item.';
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

    trigger OnInit();
    begin
        //"Parameter 1Visible" := TRUE;
        //"Parameter 2Visible" := TRUE;
        //"Parameter 3Visible" := TRUE;
        //"Parameter 4Visible" := TRUE;
        //"Parameter 5Visible" := TRUE;
        //"Parameter 6Visible" := TRUE;

        //"Parameter 1 DescriptionVisible" := TRUE;
        //"Parameter 2 DescriptionVisible" := TRUE;
        //"Parameter 3 DescriptionVisible" := TRUE;
        //"Parameter 4 DescriptionVisible" := TRUE;
        //"Parameter 5 DescriptionVisible" := TRUE;
        //"Parameter 6 DescriptionVisible" := TRUE;

        //"Parameter 1Visible" := FALSE;
        //"Parameter 2Visible" := FALSE;
        //"Parameter 3Visible" := FALSE;
        //"Parameter 4Visible" := FALSE;
        //"Parameter 5Visible" := FALSE;
        //"Parameter 6Visible" := FALSE;

        //"Parameter 1 DescriptionVisible" := FALSE;
        //"Parameter 2 DescriptionVisible" := FALSE;
        //"Parameter 3 DescriptionVisible" := FALSE;
        //"Parameter 4 DescriptionVisible" := FALSE;
        //"Parameter 5 DescriptionVisible" := FALSE;
        //"Parameter 6 DescriptionVisible" := FALSE;

        //ProductParameterDependency.RESET;
        //ProductParameterDependency.SETRANGE("Product Code",ProductCode);
        //ProductParameterDependency.SETRANGE("Product Code",'1MOTOR');
        //ProductParameterDependency.SETRANGE("Parameter Code",'FRAME');
        //ProductParameterDependency.SETCURRENTKEY("Product Code","Parameter Code","Paremeter Depend On Serial");
        //ShowControls();
    end;

    var
        ProductParameterDependency: Record "INT Packaging Param Dependency";
        SingleInstance: Codeunit "INT Product Config SingleInst.";
        ProductCode: Code[20];
        AssemblyCode: Code[20];
        ParameterCode: Code[20];
        P1ParameterCode: Code[20];
        P2ParameterCode: Code[20];
        P3ParameterCode: Code[20];
        P4ParameterCode: Code[20];
        P5ParameterCode: Code[20];
        P6ParameterCode: Code[20];
        I: Integer;

        "Parameter 1Visible": Boolean;

        "Parameter 2Visible": Boolean;

        "Parameter 3Visible": Boolean;

        "Parameter 4Visible": Boolean;

        "Parameter 5Visible": Boolean;

        "Parameter 6Visible": Boolean;

        "Parameter 1 DescriptionVisible": Boolean;

        "Parameter 2 DescriptionVisible": Boolean;

        "Parameter 3 DescriptionVisible": Boolean;

        "Parameter 4 DescriptionVisible": Boolean;

        "Parameter 5 DescriptionVisible": Boolean;

        "Parameter 6 DescriptionVisible": Boolean;

    procedure SetValues(NewProductCode: Code[20]; NewAssemblyCode: Code[20]; NewParameterCode: Code[20]);
    begin
        ProductCode := '';
        AssemblyCode := '';
        ParameterCode := '';

        ProductCode := NewProductCode;
        AssemblyCode := NewAssemblyCode;
        ParameterCode := NewParameterCode;
    end;

    procedure SetParameterValues(NewP1ParameterCode: Code[10]; NewP2ParameterCode: Code[20]; NewP3ParameterCode: Code[20]; NewP4ParameterCode: Code[20]; NewP5ParameterCode: Code[20]; NewP6ParameterCode: Code[20]);
    begin
        P1ParameterCode := '';
        P2ParameterCode := '';
        P3ParameterCode := '';
        P4ParameterCode := '';
        P5ParameterCode := '';
        P6ParameterCode := '';

        P1ParameterCode := NewP1ParameterCode;
        P2ParameterCode := NewP2ParameterCode;
        P3ParameterCode := NewP3ParameterCode;
        P4ParameterCode := NewP4ParameterCode;
        P5ParameterCode := NewP5ParameterCode;
        P6ParameterCode := NewP6ParameterCode;
    end;

    local procedure OnBeforePutRecord();
    begin
        ShowControls();
    end;

    procedure ShowControls();
    begin
        ProductCode := SingleInstance.GetProductCode();
        AssemblyCode := SingleInstance.GetAssemblyCode();
        ParameterCode := SingleInstance.GetParameterCode();
        ProductParameterDependency.RESET();
        ProductParameterDependency.SETRANGE("Product Code", ProductCode);
        ProductParameterDependency.SETRANGE("Parameter Code", ParameterCode);

        //ProductParameterDependency.SETRANGE("Product Code",'1MOTOR');
        //ProductParameterDependency.SETRANGE("Parameter Code",'FRAME');
        //ProductParameterDependency.SETCURRENTKEY("Product Code","Parameter Code","Paremeter Depend On Serial");
        //ProductParameterDependency.SETRANGE("Product Code","Product Code");
        //ProductParameterDependency.SETRANGE("Parameter Code","Parameter Code");

        IF ProductParameterDependency.FINDSET() THEN;

        //"Parameter 1Visible" := FALSE;
        //"Parameter 2Visible" := FALSE;
        //"Parameter 3Visible" := FALSE;
        //"Parameter 4Visible" := FALSE;
        //"Parameter 5Visible" := FALSE;
        //"Parameter 6Visible" := FALSE;
        //"Parameter 1 DescriptionVisible" := FALSE;
        //"Parameter 2 DescriptionVisible" := FALSE;
        //"Parameter 3 DescriptionVisible" := FALSE;
        //"Parameter 4 DescriptionVisible" := FALSE;
        //"Parameter 5 DescriptionVisible" := FALSE;
        //"Parameter 6 DescriptionVisible" := FALSE;

        CASE ProductParameterDependency.COUNT() OF
            1:
                BEGIN
                    "Parameter 1Visible" := TRUE;
                    "Parameter 1 DescriptionVisible" := TRUE;
                END;
            2:
                BEGIN
                    "Parameter 1Visible" := TRUE;
                    "Parameter 1 DescriptionVisible" := TRUE;
                    "Parameter 2Visible" := TRUE;
                    "Parameter 2 DescriptionVisible" := TRUE;
                END;
            3:
                BEGIN
                    "Parameter 1Visible" := TRUE;
                    "Parameter 1 DescriptionVisible" := TRUE;
                    "Parameter 2Visible" := TRUE;
                    "Parameter 2 DescriptionVisible" := TRUE;
                    "Parameter 3Visible" := TRUE;
                    "Parameter 3 DescriptionVisible" := TRUE;
                END;
            4:
                BEGIN
                    "Parameter 1Visible" := TRUE;
                    "Parameter 1 DescriptionVisible" := TRUE;
                    "Parameter 2Visible" := TRUE;
                    "Parameter 2 DescriptionVisible" := TRUE;
                    "Parameter 3Visible" := TRUE;
                    "Parameter 3 DescriptionVisible" := TRUE;
                    "Parameter 4Visible" := TRUE;
                    "Parameter 4 DescriptionVisible" := TRUE;
                END;
            5:
                BEGIN
                    "Parameter 1Visible" := TRUE;
                    "Parameter 1 DescriptionVisible" := TRUE;
                    "Parameter 2Visible" := TRUE;
                    "Parameter 2 DescriptionVisible" := TRUE;
                    "Parameter 3Visible" := TRUE;
                    "Parameter 3 DescriptionVisible" := TRUE;
                    "Parameter 4Visible" := TRUE;
                    "Parameter 4 DescriptionVisible" := TRUE;
                    "Parameter 5Visible" := TRUE;
                    "Parameter 5 DescriptionVisible" := TRUE;
                END;
            6:
                BEGIN
                    "Parameter 1Visible" := TRUE;
                    "Parameter 1 DescriptionVisible" := TRUE;
                    "Parameter 2Visible" := TRUE;
                    "Parameter 2 DescriptionVisible" := TRUE;
                    "Parameter 3Visible" := TRUE;
                    "Parameter 3 DescriptionVisible" := TRUE;
                    "Parameter 4Visible" := TRUE;
                    "Parameter 4 DescriptionVisible" := TRUE;
                    "Parameter 5Visible" := TRUE;
                    "Parameter 5 DescriptionVisible" := TRUE;
                    "Parameter 6Visible" := TRUE;
                    "Parameter 6 DescriptionVisible" := TRUE;
                END;
        END;
    end;

    procedure AssignParameterCode();
    begin
        //FOR I := 1 TO ProductParameterDependency.COUNT DO BEGIN
        //  CASE I OF
        //    1:
        //      P1ParameterCode := ProductParameterDependency."Parameter Depend On";
        //    2:
        //      P2ParameterCode := ProductParameterDependency."Parameter Depend On";
        //    3:
        //      P3ParameterCode := ProductParameterDependency."Parameter Depend On";
        //    4:
        //      P4ParameterCode := ProductParameterDependency."Parameter Depend On";
        //    5:
        //      P5ParameterCode := ProductParameterDependency."Parameter Depend On";
        //    6:
        //      P6ParameterCode := ProductParameterDependency."Parameter Depend On";
        //  END;
        //END;
    end;

    procedure Lookup(NewParameterCode: Code[20]; NewParameterNo: Integer);
    var
        ProductParameterDetails: Record "INT Packaging Parameter Values";
        ParametersValueList: Page "INT Parameters Value List";
    begin
        ProductParameterDetails.RESET();
        ProductParameterDetails.SETRANGE("Packaging Parameter Code", NewParameterCode);
        IF ProductParameterDetails.FINDSET() THEN;

        //DimSelection.LOOKUPMODE := TRUE;
        //IF DimSelection.RUNMODAL = ACTION::LookupOK THEN
        //  EXIT(DimSelection.GetDimSelCode);
        //EXIT(OldDimSelCode);
        CLEAR(ParametersValueList);
        ParametersValueList.LOOKUPMODE := TRUE;
        ParametersValueList.SETTABLEVIEW(ProductParameterDetails);

        //CLEAR(ParamValue_gCod);
        //IF PAGE.RUNMODAL(0,ProductParameterDetails) = ACTION::LookupOK THEN BEGIN
        IF ParametersValueList.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            ParametersValueList.GETRECORD(ProductParameterDetails);
            CASE NewParameterNo OF
                0:
                    BEGIN
                        Rec."Parameter Value" := ProductParameterDetails."Packaging Parameter Value";
                        Rec."Parameter Value Description" := ProductParameterDetails."Packaging Parameter Value Description";
                        //ParamValue_gCod := ProductParameterDetails."Parameter Value";
                    END;
                1:
                    BEGIN
                        Rec."Parameter 1" := ProductParameterDetails."Packaging Parameter Value";
                        Rec."Parameter 1 Description" := ProductParameterDetails."Packaging Parameter Value Description";
                        //Param_gCod := ProductParameterDetails."Parameter Value";
                    END;
                2:
                    BEGIN
                        Rec."Parameter 2" := ProductParameterDetails."Packaging Parameter Value";
                        Rec."Parameter 2 Description" := ProductParameterDetails."Packaging Parameter Value Description";
                    END;
                3:
                    BEGIN
                        Rec."Parameter 3" := ProductParameterDetails."Packaging Parameter Value";
                        Rec."Parameter 3 Description" := ProductParameterDetails."Packaging Parameter Value Description";
                    END;
                4:
                    BEGIN
                        Rec."Parameter 4" := ProductParameterDetails."Packaging Parameter Value";
                        Rec."Parameter 4 Description" := ProductParameterDetails."Packaging Parameter Value Description";
                    END;
                5:
                    BEGIN
                        Rec."Parameter 5" := ProductParameterDetails."Packaging Parameter Value";
                        Rec."Parameter 5 Description" := ProductParameterDetails."Packaging Parameter Value Description";
                    END;
                6:
                    BEGIN
                        Rec."Parameter 6" := ProductParameterDetails."Packaging Parameter Value";
                        Rec."Parameter 6 Description" := ProductParameterDetails."Packaging Parameter Value Description";
                    END;
            END;
        END;
        //EXIT(Param_gCod);
    end;
}

