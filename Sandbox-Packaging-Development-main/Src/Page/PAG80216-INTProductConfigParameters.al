page 80216 "INT Packaging Config Para"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Configurator Parameters';
    InsertAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "INT Pack. Configurator Detail";
    SourceTableView = SORTING("Serial No")
                      ORDER(Ascending)
                      WHERE(Type = FILTER(Parameter),
                            "Set Visible on Page" = FILTER(true));

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
                    ToolTip = 'Specifies the assembly description.';
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the parameter.';
                }
                field("Parameter Description"; Rec."Parameter Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the parameter.';
                }
                field("Parameter Value"; Rec."Parameter Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value for the parameter code.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Rec.LookupParameter();
                        CurrPage.UPDATE();
                        Rec.UpdateVisibleParameterLine();
                        CurrPage.UPDATE();
                    end;

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE();
                        Rec.UpdateVisibleParameterLine();
                    end;
                }
                field("Parameter Value Description"; Rec."Parameter Value Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the parameter value.';
                }
                field("Serial No"; Rec."Serial No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a serial number.';
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                    ToolTip = '"Specifies wether a parameter is mandatory or not. "';
                }

                field("Code for Item"; Rec."Code for Item")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for the item.';
                }
                field("Allow Multiple Selection"; Rec."Allow Multiple Selection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether multiple selection is allowed or not.';
                }
                field("Text Parameter"; Rec."Text Parameter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the text value of parameter.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    var
        ProductParameterDependency: Record "INT Packaging Param Dependency";
        ProductConfiDetail: Record "INT Pack. Configurator Detail";
    begin
        //For Set Visible Boolean - Start
        ShowParameterLine := TRUE;

        ProductParameterDependency.RESET();
        ProductParameterDependency.SETCURRENTKEY("Product Code", "Parameter Code", "Parameter Depend On Serial");
        ProductParameterDependency.SETRANGE("Product Code", Rec."Product Code");
        ProductParameterDependency.SETRANGE("Parameter Code", Rec."Parameter Code");
        IF ProductParameterDependency.FINDSET() THEN
            REPEAT
                ProductConfiDetail.RESET();
                ProductConfiDetail.SETRANGE("Configurator No.", Rec."Configurator No.");
                ProductConfiDetail.SETRANGE("Product Code", ProductParameterDependency."Product Code");
                ProductConfiDetail.SETRANGE("Parameter Code", ProductParameterDependency."Parameter Depend On");
                ProductConfiDetail.SETFILTER("Parameter Value", '<>%1', '');
                IF NOT ProductConfiDetail.FINDFIRST() THEN
                    ShowParameterLine := FALSE;
            UNTIL ProductParameterDependency.NEXT() = 0;
        //END;
        //For Set Visible Boolean - End
    end;

    trigger OnOpenPage();
    var
        INTKeyValidationMgt: Codeunit "INT Key Validation Mgt- PC";
    begin
        ShowParameterLine := TRUE;
        CLEAR(INTKeyValidationMgt);
        INTKeyValidationMgt.onOpenPageKeyValidation();
    end;

    var
        ShowParameterLine: Boolean;
}

