page 80212 "INT Pack Param Depend. Detail"
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
                    ToolTip = 'Specifies the code of the product.';
                }
                field("Product Assembly Code"; Rec."Product Assembly Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Assembly code for the product.';
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = All;
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

                    trigger OnValidate()
                    begin
                        ValidateValue(P1ParameterCode, 1, Rec."Parameter 1");
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


                    trigger OnValidate()
                    begin
                        ValidateValue(P2ParameterCode, 2, Rec."Parameter 2");
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

                    trigger OnValidate()
                    begin
                        ValidateValue(P3ParameterCode, 3, Rec."Parameter 3");
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

                    trigger OnValidate()
                    begin
                        ValidateValue(P4ParameterCode, 4, Rec."Parameter 4");
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

                    trigger OnValidate()
                    begin
                        ValidateValue(P5ParameterCode, 5, Rec."Parameter 5");
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

                    trigger OnValidate()
                    begin
                        ValidateValue(P6ParameterCode, 6, Rec."Parameter 6");
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
                        //Lookup(ParameterCode,0); //I-C0020-01-N
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
                    ToolTip = 'Specifies the code for the item.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord();
    begin
        ShowControls();
    end;

    trigger OnAfterGetRecord()
    begin
        ShowControls();
    end;

    trigger OnOpenPage()
    var
        INTKeyValidationMgt: Codeunit "INT Key Validation Mgt- PC";
        ProDepINT_lCud: Codeunit ParaDep_INT;
    begin
        CLEAR(INTKeyValidationMgt);
        INTKeyValidationMgt.onOpenPageKeyValidation();

        IF GlobView_ProdCode = '' THen begin
            ProDepINT_lCud.GetValue(GlobView_ProdCode, GlobView_ParaCode);
        end;

        SetShowControls(GlobView_ProdCode, GlobView_ParaCode);
    end;

    var
        ProductDependent: Record "INT Packaging Param Dependency";
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

        GlobView_ProdCode: Code[20];
        GlobView_ParaCode: Code[20];

    procedure SetParameterValues(NewP1ParameterCode: Code[20]; NewP2ParameterCode: Code[20]; NewP3ParameterCode: Code[20]; NewP4ParameterCode: Code[20]; NewP5ParameterCode: Code[20]; NewP6ParameterCode: Code[20]; View_ProdCode: Code[20]; View_ParaCode: Code[20]);
    begin
        P1ParameterCode := NewP1ParameterCode;
        P2ParameterCode := NewP2ParameterCode;
        P3ParameterCode := NewP3ParameterCode;
        P4ParameterCode := NewP4ParameterCode;
        P5ParameterCode := NewP5ParameterCode;
        P6ParameterCode := NewP6ParameterCode;

        GlobView_ProdCode := View_ProdCode;
        GlobView_ParaCode := View_ParaCode;


        SetShowControls(View_ProdCode, View_ParaCode);
    end;

    procedure ShowControls();
    begin
        ProductDependent.RESET();
        ProductDependent.SETRANGE("Product Code", Rec."Product Code");
        ProductDependent.SETRANGE("Parameter Code", Rec."Parameter Code");
        IF NOT ProductDependent.ISEMPTY() THEN
            CASE ProductDependent.COUNT() OF
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
    END;

    procedure SetShowControls(ProdCode: Code[20]; ParaCode: Code[20]);
    begin
        ProductDependent.RESET();
        ProductDependent.SETRANGE("Product Code", ProdCode);
        ProductDependent.SETRANGE("Parameter Code", ParaCode);
        IF NOT ProductDependent.ISEMPTY() THEN
            CASE ProductDependent.COUNT() OF
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
    END;
    //end;




    procedure Lookup(NewParameterCode: Code[20]; NewParameterNo: Integer);
    var
        ProductParameterDetails: Record "INT Packaging Parameter Values";
    begin
        ProductParameterDetails.FILTERGROUP(2);
        ProductParameterDetails.SETRANGE("Packaging Parameter Code", NewParameterCode);
        ProductParameterDetails.FILTERGROUP(0);
        IF PAGE.RUNMODAL(PAGE::"INT Parameters Value List", ProductParameterDetails) = ACTION::LookupOK THEN
            CASE NewParameterNo OF
                0:
                    BEGIN
                        Rec."Parameter Value" := ProductParameterDetails."Packaging Parameter Value";
                        Rec."Parameter Value Description" := ProductParameterDetails."Packaging Parameter Value Description";
                    END;
                1:
                    BEGIN
                        Rec."Parameter 1" := ProductParameterDetails."Packaging Parameter Value";
                        Rec."Parameter 1 Description" := ProductParameterDetails."Packaging Parameter Value Description";
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
    //end;

    procedure ValidateValue(NewParameterCode: Code[20]; NewParameterNo: Integer; EnteredValue_lCod: Code[20]);
    var
        ProductParameterDetails: Record "INT Packaging Parameter Values";
    begin
        ProductParameterDetails.FILTERGROUP(2);
        ProductParameterDetails.SETRANGE("Packaging Parameter Code", NewParameterCode);
        ProductParameterDetails.SetRange("Packaging Parameter Value", EnteredValue_lCod);
        ProductParameterDetails.FILTERGROUP(0);
        IF ProductParameterDetails.FindFirst() THEN
            CASE NewParameterNo OF
                0:
                    BEGIN
                        Rec."Parameter Value" := ProductParameterDetails."Packaging Parameter Value";
                        Rec."Parameter Value Description" := ProductParameterDetails."Packaging Parameter Value Description";
                    END;
                1:
                    BEGIN
                        Rec."Parameter 1" := ProductParameterDetails."Packaging Parameter Value";
                        Rec."Parameter 1 Description" := ProductParameterDetails."Packaging Parameter Value Description";
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
}

