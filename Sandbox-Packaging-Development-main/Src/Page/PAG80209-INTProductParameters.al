page 80209 "INT Packaging Parameters"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Parameters';
    DelayedInsert = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "INT Packaging Parameters";
    SourceTableView = SORTING("Product Code", "Serial No.");
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
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
                    ToolTip = 'Specifies the Assembly code for the product. It can also be called the top level BOM for the product.';
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the parameter.';
                }
                field("Parameter Description"; Rec."Parameter Description")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Allow Multiple Selection"; Rec."Allow Multiple Selection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if a multiple selection is allowed.';
                }
                field("Text Parameter"; Rec."Text Parameter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the parameter is a text parameter.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Dependency")
            {
                ApplicationArea = All;
                Caption = '&Dependency';
                Image = Relationship;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "INT Pack Param Dependency List";
                RunPageLink = "Product Code" = FIELD("Product Code"),
                              "Parameter Code" = FIELD("Parameter Code"),
                              "Parameter Serial" = FIELD("Serial No.");
                ToolTip = 'View the Parameter Depenency.';
            }
            action("Dependency &Value")
            {
                ApplicationArea = All;
                Caption = 'Dependency &Value';
                Image = ValueLedger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // RunObject = Page "INT Prod. Parameter Dependency";
                // RunPageLink = "Product Code" = FIELD("Product Code"),
                //               "Parameter Code" = FIELD("Parameter Code"),
                //               "Assembly Code" = FIELD("Assembly Code");
                ToolTip = 'View and configure the Product Parameter Dependency value.';

                trigger OnAction()
                var
                    ProdPaaDep_lPge: Page "INT Pack. Parameter Dependency";
                    ParaDepRec_lRec: Record "INT Packaging Parameters";
                    ParaDep_INT: Codeunit ParaDep_INT;
                begin
                    Clear(ParaDepRec_lRec);
                    ParaDepRec_lRec.SetRange("Product Code", Rec."Product Code");
                    ParaDepRec_lRec.SetRange("Parameter Code", Rec."Parameter Code");
                    ParaDepRec_lRec.SetRange("Assembly Code", Rec."Assembly Code");

                    ParaDep_INT.SetValue(Rec."Product Code", Rec."Parameter Code");

                    Clear(ProdPaaDep_lPge);
                    ProdPaaDep_lPge.SetTableView(ParaDepRec_lRec);
                    ProdPaaDep_lPge.RunModal();
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        INTKeyValidationMgt: Codeunit "INT Key Validation Mgt- PC";
    begin
        CLEAR(INTKeyValidationMgt);
        INTKeyValidationMgt.onOpenPageKeyValidation();
    end;
}

