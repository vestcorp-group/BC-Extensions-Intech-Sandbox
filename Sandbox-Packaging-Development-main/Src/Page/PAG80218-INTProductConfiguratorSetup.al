page 80218 "INT Packaging Config Setup"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Configurator Setup';
    PageType = Card;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = "INT Packaging Config Setup";
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Configurator Nos."; Rec."Configurator Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the number series that will be used to assign numbers to product configurator.';
                }
                group("App Activation")
                {
                    Caption = 'App Activation';
                    field("Activation Key"; Rec."Activation Key")
                    {
                        ApplicationArea = all;
                    }
                    field("Expiration Date"; ExpirationDate)
                    {
                        Editable = false;
                        ApplicationArea = all;
                    }
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Activate App")
            {
                Image = Lock;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = report "INT Activate App-PC";
                ApplicationArea = all;
            }
            action("Insert Demo Data")
            {
                Image = Insert;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = report "INT Insert Pack. Config Demo";
                ApplicationArea = all;
            }
        }
    }

    var
        ExpirationDate: Date;

    trigger OnOpenPage();
    var
        INTKeyValidationMgt: Codeunit "INT Key Validation Mgt- PC";
    begin
        Rec.RESET();
        IF NOT Rec.GET() THEN BEGIN
            Rec.INIT();
            Rec.INSERT();
        END;

        IF Rec."Activation Key" <> '' THEN
            ExpirationDate := INTKeyValidationMgt.ValidateEndDateFunction(Rec."Activation Key");

    end;
}

