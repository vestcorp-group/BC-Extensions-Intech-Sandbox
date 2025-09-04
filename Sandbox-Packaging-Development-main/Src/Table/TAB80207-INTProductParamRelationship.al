table 80207 "INT Pack Param Relationship"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging Parameter Relationship';
    DrillDownPageID = "INT Parameter Relationship";
    LookupPageID = "INT Parameter Relationship";

    fields
    {
        field(70144421; "Product Code"; Code[20])
        {
            Caption = 'Product Code';
            Editable = false;
            TableRelation = "INT Packaging"."Product Code";
            DataClassification = CustomerContent;
        }
        field(70144422; "Product Assembly Code"; Code[20])
        {
            Caption = 'Product Assembly Code';
            Editable = false;
            TableRelation = "INT Packaging Assembly"."Assembly Code" WHERE("Product Code" = FIELD("Product Code"));
            DataClassification = CustomerContent;
        }
        field(70144423; "Parameter Code"; Code[20])
        {
            Caption = 'Parameter Code';
            Editable = false;
            TableRelation = "INT Packaging Parameter"."Packaging Parameter Code";
            DataClassification = CustomerContent;
        }
        field(70144424; "Parameter 1"; Code[20])
        {
            Caption = 'Parameter 1';
            DataClassification = CustomerContent;
        }
        field(70144425; "Parameter 2"; Code[20])
        {
            Caption = 'Parameter 2';
            DataClassification = CustomerContent;
        }
        field(70144426; "Parameter 3"; Code[20])
        {
            Caption = 'Parameter 3';
            DataClassification = CustomerContent;
        }
        field(70144427; "Parameter 4"; Code[20])
        {
            Caption = 'Parameter 4';
            DataClassification = CustomerContent;
        }
        field(70144428; "Parameter 5"; Code[20])
        {
            Caption = 'Parameter 5';
            DataClassification = CustomerContent;
        }
        field(70144429; "Parameter 6"; Code[20])
        {
            Caption = 'Parameter 6';
            DataClassification = CustomerContent;
        }
        field(70144430; "Parameter Value"; Code[5])
        {
            Caption = 'Parameter Value';
            TableRelation = "INT Packaging Parameter Values"."Packaging Parameter Value" WHERE("Packaging Parameter Code" = FIELD("Parameter Code"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Parameter Code");
                IF "Parameter Value" <> '' THEN BEGIN
                    ParameterValues.RESET();
                    ParameterValues.SETRANGE("Packaging Parameter Code", "Parameter Code");
                    ParameterValues.SETRANGE("Packaging Parameter Value", "Parameter Value");
                    IF ParameterValues.FINDFIRST() THEN begin
                        "Parameter Value Description" := ParameterValues."Packaging Parameter Value Description";
                        Rec."Code for Item" := Rec."Parameter Value"; //10032025
                    End;
                END ELSE begin
                    "Parameter Value Description" := '';
                    Rec."Code for Item" := '';

                End;

            end;
        }
        field(70144441; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(70144442; "Parameter Value Description"; Text[50])
        {
            Caption = 'Parameter Value Description';
            DataClassification = CustomerContent;
        }
        field(70144443; "Parameter 1 Description"; Text[50])
        {
            Caption = 'Parameter 1 Description';
            DataClassification = CustomerContent;
        }
        field(70144444; "Parameter 2 Description"; Text[50])
        {
            Caption = 'Parameter 2 Description';
            DataClassification = CustomerContent;
        }
        field(70144445; "Parameter 3 Description"; Text[50])
        {
            Caption = 'Parameter 3 Description';
            DataClassification = CustomerContent;
        }
        field(70144446; "Parameter 4 Description"; Text[50])
        {
            Caption = 'Parameter 4 Description';
            DataClassification = CustomerContent;
        }
        field(70144447; "Parameter 5 Description"; Text[50])
        {
            Caption = 'Parameter 5 Description';
            DataClassification = CustomerContent;
        }
        field(70144448; "Parameter 6 Description"; Text[50])
        {
            Caption = 'Parameter 6 Description';
            DataClassification = CustomerContent;
        }

        field(70144449; "Code for Item"; Code[5])
        {
            Caption = 'Code for Item';
            DataClassification = CustomerContent;
        }

        field(70144450; Select; Boolean)
        {
            Caption = 'Select';
            DataClassification = CustomerContent;
        }
        field(70144461; "Dep_Parameter 1"; Code[20])
        {
            Caption = 'Parameter 1';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Product Code", "Product Assembly Code", "Parameter Code", "Parameter 1", "Parameter 2", "Parameter 3", "Parameter 4", "Parameter 5", "Parameter 6", "Parameter Value")
        {
        }
        key(Key2; "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        ProductParameterRelationship.RESET();
        ProductParameterRelationship.SETRANGE("Product Code", "Product Code");
        ProductParameterRelationship.SETRANGE("Product Assembly Code", "Product Assembly Code");
        ProductParameterRelationship.SETRANGE("Parameter Code", "Parameter Code");
        ProductParameterRelationship.SETCURRENTKEY("Line No.");
        IF ProductParameterRelationship.FINDLAST() THEN
            "Line No." := ProductParameterRelationship."Line No." + 10000;
    end;

    var
        ParameterValues: Record "INT Packaging Parameter Values";
        ProductParameterRelationship: Record "INT Pack Param Relationship";
}

