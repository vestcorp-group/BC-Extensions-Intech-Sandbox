page 80214 "INT Packaging Configurator"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Configurator';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "INT Pack. Configurator Detail";
    SourceTableView = SORTING("Configurator No.", "Line No.")
                      WHERE("Line No." = FILTER(0),
                            Type = FILTER(Product));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Configurator No."; Rec."Configurator No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a Configurator Number.';

                    trigger OnAssistEdit();
                    begin
                        Rec.AssistEdit();
                    end;
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
                field("Suggested Code"; Rec."Suggested Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a suggested code.';
                }
                field("Suggested Description"; Rec."Suggested Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Suggested Description field.', Comment = '%';
                }
                field("Packaging Code Created"; Rec."Packaging Code Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Packaging Code Created field.', Comment = '%';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the product configurator card was last modified.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the product configurator card was created.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the product configurator is new or certified.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user name through which the product configurator was created.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the product configurator is of type product, assembly, or parameter.';
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the line number.';
                    Visible = false;
                }
            }
            part("Product Assy. Line"; "INT Pack. Config Subassemblies")
            {
                ApplicationArea = All;
                SubPageLink = "Configurator No." = FIELD("Configurator No.");
                SubPageView = WHERE("Line No." = FILTER(<> 0));
                Visible = ShowAssembleyPartPage;
            }
            part("Product Parameter"; "INT Packaging Config Para")
            {
                ApplicationArea = All;
                SubPageLink = "Configurator No." = FIELD("Configurator No.");
                SubPageView = WHERE("Line No." = FILTER(<> 0));
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action68>")
            {
                Caption = 'F&unctions';
                action("Get Subassembly & Parameter")
                {
                    ApplicationArea = All;
                    Caption = 'Get Subassembly & Parameter';
                    Image = AssemblyBOM;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Get the Subassemblies and Parameter.';

                    trigger OnAction();
                    begin
                        Rec.GetParameterandAssembly();
                    end;
                }
                action("Suggest Packaging Code")
                {
                    ApplicationArea = All;
                    Caption = 'Suggest Packaging Code';
                    Image = SuggestItemPrice;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'View the system generated suggested Packaging code.';

                    trigger OnAction();
                    var
                    begin
                        rec.SuggestPackagingCode_gFnc();
                    end;
                }
                action("Accept Configurator")
                {
                    ApplicationArea = All;
                    Caption = 'Accept Configurator';
                    Image = ApprovalSetup;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'View the details nand finalize them by accepting the configurator.';

                    trigger OnAction();
                    var

                    begin

                        rec.GeneratePackagingCode_gfnc();

                    end;
                }
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

    var
        ShowAssembleyPartPage: Boolean;
}

