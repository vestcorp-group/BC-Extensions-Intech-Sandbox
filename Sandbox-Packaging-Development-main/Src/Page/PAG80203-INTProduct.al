page 80203 "INT Packaging"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging';
    PageType = Card;
    SourceTable = "INT Packaging";
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
                    ToolTip = 'Specifies the code of the product.';
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    ToolTip = 'Specifies a description of the product.';
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the product configurator can be now used.';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the Approver.';
                }
                field("Approved DateTime"; Rec."Approved DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date and time of the approval.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that transactions with the product code cannot be used, for example, because the product is in quarantine.';
                }
            }
            part("Product Assy. Line"; "INT Packaging Assembly")
            {
                ApplicationArea = All;
                SubPageLink = "Product Code" = FIELD("Product Code");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Packaging Parameter")
            {
                ApplicationArea = All;
                Caption = 'Packaging Parameter';
                Image = Production;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "INT Packaging Parameters";
                RunPageLink = "Product Code" = FIELD("Product Code");
                ToolTip = 'View and configure the Product Parameters.';
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

