table 80206 "INT Packaging Param Dependency"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Parameter Dependency';
    DataCaptionFields = "Product Code", "Parameter Code";

    fields
    {
        field(70144421; "Product Code"; Code[20])
        {
            Caption = 'Product Code';
            Editable = false;
            TableRelation = "INT Packaging"."Product Code";
            DataClassification = CustomerContent;
        }
        field(70144422; "Parameter Code"; Code[20])
        {
            Caption = 'Parameter Code';
            Editable = false;
            TableRelation = "INT Packaging Parameter";
            DataClassification = CustomerContent;
        }
        field(70144423; "Parameter Depend On"; Code[20])
        {
            Caption = 'Parameter Depend On';
            TableRelation = "INT Packaging Parameter";
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                ProductParameters.RESET();
                ProductParameters.FILTERGROUP(2);
                ProductParameters.SETRANGE("Product Code", "Product Code");
                ProductParameters.SETFILTER("Serial No.", '<%1', "Parameter Serial");
                ProductParameters.FILTERGROUP(0);
                IF PAGE.RUNMODAL(PAGE::"INT Prod Param. Depend. List", ProductParameters) = ACTION::LookupOK THEN BEGIN
                    "Parameter Depend On" := ProductParameters."Parameter Code";
                    "Parameter Depend On Serial" := ProductParameters."Serial No.";
                END;
            end;
        }
        field(70144424; "Parameter Serial"; Integer)
        {
            Caption = 'Parameter Serial';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144441; "Parameter Depend On Serial"; Integer)
        {
            Caption = 'Parameter Depend On Serial';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144442; "Parameter Description"; Text[50])
        {
            Caption = 'Parameter Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Product Code", "Parameter Code", "Parameter Depend On", "Parameter Serial")
        {
        }
        key(Key2; "Product Code", "Parameter Code", "Parameter Depend On Serial")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ProductParameters: Record "INT Packaging Parameters";
}

