table 80210 "INT Packaging Config Setup"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Configurator Setup';

    fields
    {
        field(70144421; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(70144441; "Configurator Nos."; Code[20])
        {
            Caption = 'Configurator Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(70144446; "Activation Key"; Code[250])
        {
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                INTKeyValidationMgt: Codeunit "INT Key Validation Mgt- PC";
                EndDate: Date;
            begin
                IF "Activation Key" <> '' THEN BEGIN
                    CLEAR(INTKeyValidationMgt);
                    EndDate := INTKeyValidationMgt.ValidateKey("Activation Key");
                    MESSAGE('Your App has been Activated, Last Date is %1', EndDate);
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

