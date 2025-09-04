report 80201 "INT Activate App-PC"
{
    // version NAVW111.00
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------    

    ProcessingOnly = true;
    Caption = 'Activate App';
    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Enter Activation Key")
                {
                    Caption = 'Enter Activation Key';
                    field("Key"; EnteredKey)
                    {
                        ApplicationArea = all;
                        Caption = 'Key';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        EnteredKey: Code[250];

    trigger OnPreReport()
    var
        INTSetup: Record "INT Packaging Config Setup";
        INTKeyValidationMgt: Codeunit "INT Key Validation Mgt- PC";
        EndDate: Date;
    begin
        IF EnteredKey = '' then
            Error('Enter the Key first');
        CLEAR(INTKeyValidationMgt);
        EndDate := INTKeyValidationMgt.ValidateKey(EnteredKey);
        INTSetup.Get();
        INTSetup."Activation Key" := EnteredKey;
        INTSetup.Modify(true);
        MESSAGE('Your App has been Activated till Date %1.', EndDate);
    end;
}

