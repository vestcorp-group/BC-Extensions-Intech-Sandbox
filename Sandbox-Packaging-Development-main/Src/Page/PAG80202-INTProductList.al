page 80202 "INT Packaging List"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging List';
    CardPageID = "INT Packaging";
    Editable = false;
    PageType = List;
    SourceTable = "INT Packaging";
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
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

                field("Approved DateTime"; FORMAT(Rec."Approved DateTime"))
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

