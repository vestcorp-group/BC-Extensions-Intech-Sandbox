table 80205 "INT Packaging Parameters"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Parameters';
    DataCaptionFields = "Product Code";
    DrillDownPageID = "INT Packaging Parameters";
    LookupPageID = "INT Packaging Parameters";

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
            TableRelation = "INT Packaging Parameter";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Parameter: Record "INT Packaging Parameter";
            begin
                TESTFIELD("Product Code");
                TESTFIELD("Assembly Code");
                IF "Parameter Code" <> '' THEN BEGIN
                    Parameter.GET("Parameter Code");
                    "Parameter Description" := Parameter."Packaging Parameter Description";
                END ELSE
                    "Parameter Description" := '';
            end;
        }
        field(70144441; "Assembly Code"; Code[20])
        {
            Caption = 'Assembly Code';
            TableRelation = "INT Packaging Assembly"."Assembly Code" WHERE("Product Code" = FIELD("Product Code"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ProductParameterRelationship: Record "INT Pack Param Relationship";
                ProductParameterRelationship2: Record "INT Pack Param Relationship";
            begin
                TESTFIELD("Product Code");
                IF xRec."Assembly Code" <> "Assembly Code" THEN BEGIN
                    ProductParameterRelationship.RESET();
                    ProductParameterRelationship.SETRANGE("Product Code", "Product Code");
                    ProductParameterRelationship.SETRANGE("Parameter Code", "Parameter Code");
                    IF ProductParameterRelationship.FINDSET(TRUE, TRUE) THEN
                        REPEAT
                            CLEAR(ProductParameterRelationship2);
                            ProductParameterRelationship2.COPY(ProductParameterRelationship);
                            ProductParameterRelationship2.RENAME(ProductParameterRelationship2."Product Code",
                            "Assembly Code",
                            ProductParameterRelationship2."Parameter Code",
                            ProductParameterRelationship2."Parameter 1",
                            ProductParameterRelationship2."Parameter 2",
                            ProductParameterRelationship2."Parameter 3",
                            ProductParameterRelationship2."Parameter 4",
                            ProductParameterRelationship2."Parameter 5",
                            ProductParameterRelationship2."Parameter 6",
                            ProductParameterRelationship2."Parameter Value");
                        UNTIL ProductParameterRelationship.NEXT() = 0;
                END;
            end;
        }
        field(70144442; "Parameter Description"; Text[50])
        {
            Caption = 'Parameter Description';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144443; "Parameter Depend On"; Boolean)
        {
            CalcFormula = Exist("INT Packaging Param Dependency" WHERE("Product Code" = FIELD("Product Code"),
                                                                       "Parameter Code" = FIELD("Parameter Code")));
            Caption = 'Parameter Depend On';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70144444; "Mandatory Parameter"; Boolean)
        {
            Caption = 'Mandatory Parameter';
            DataClassification = CustomerContent;
        }
        field(70144445; "Serial No."; Integer)
        {
            Caption = 'Serial No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144446; "Allow Multiple Selection"; Boolean)
        {
            Caption = 'Allow Multiple Selection';
            DataClassification = CustomerContent;
        }
        field(70144447; "Text Parameter"; Boolean)
        {
            Caption = 'Text Parameter';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Product Code", "Parameter Code")
        {
        }
        key(Key2; "Serial No.")
        {
        }
        key(Key3; "Product Code", "Serial No.")
        {
        }
        key(Key4; "Parameter Code")
        {
        }
        key(Key5; "Parameter Description")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Product Code", "Parameter Code", "Serial No.")
        {
        }
    }

    trigger OnDelete();
    begin
        CALCFIELDS("Parameter Depend On");
        IF "Parameter Depend On" THEN
            ERROR(Text000Err);
    end;

    trigger OnInsert();
    begin
        ProductParameters.RESET();
        ProductParameters.SETCURRENTKEY("Serial No.");
        ProductParameters.SETRANGE("Product Code", "Product Code");
        IF ProductParameters.FINDLAST() THEN
            "Serial No." := ProductParameters."Serial No." + 1
        ELSE
            "Serial No." := 1;
    end;

    var
        ProductParameters: Record "INT Packaging Parameters";
        Text000Err: Label 'You cannot remove Product Parameter without removing Product Parameter Dependency.';
}

