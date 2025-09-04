table 80208 "INT Pack Assy.Details with Val"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Assy.Details with Val';

    fields
    {
        field(70144421; "Product Code"; Code[20])
        {
            Caption = 'Product Code';
            TableRelation = "INT Packaging"."Product Code";
            DataClassification = CustomerContent;
        }
        field(70144422; "Parameter Code"; Code[20])
        {
            Caption = 'Parameter Code';
            DataClassification = CustomerContent;
        }
        field(70144441; "Assembly Code"; Code[20])
        {
            Caption = 'Assembly Code';
            TableRelation = "INT Packaging Assembly"."Assembly Code" WHERE("Product Code" = FIELD("Product Code"));
            DataClassification = CustomerContent;
        }
        field(70144442; "Parameter Value"; Decimal)
        {
            Caption = 'Parameter Value';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Product Code", "Parameter Code")
        {
        }
    }

    fieldgroups
    {
    }
}

