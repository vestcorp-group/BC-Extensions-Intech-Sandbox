table 80202 "INT Packaging Assembly"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Product Assembly';
    DrillDownPageID = "INT Packaging Assembly";
    LookupPageID = "INT Packaging Assembly";

    fields
    {
        field(70144421; "Product Code"; Code[20])
        {
            Caption = 'Product Code';
            Editable = false;
            TableRelation = "INT Packaging"."Product Code";
            DataClassification = CustomerContent;
        }
        field(70144422; "Assembly Code"; Code[20])
        {
            Caption = 'Assembly Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(70144441; "Assembly Description"; Text[50])
        {
            Caption = 'Assembly Description';
            DataClassification = CustomerContent;
        }
        field(70144442; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Product Code", "Assembly Code")
        {
        }
        key(Key2; "Assembly Code")
        {
        }
        key(Key3; "Assembly Description")
        {
        }
        key(Key4; "Line No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Assembly Code", "Assembly Description")
        {
        }
    }

    trigger OnInsert();
    var
        ProductAssembly: Record "INT Packaging Assembly";
        Products: Record "INT Packaging";
    begin
        Products.GET("Product Code");
        Products.TESTFIELD(Blocked, FALSE);
        ProductAssembly.RESET();
        ProductAssembly.SETRANGE("Product Code", "Product Code");
        ProductAssembly.SETCURRENTKEY("Line No.");
        IF ProductAssembly.FINDLAST() THEN
            "Line No." := ProductAssembly."Line No." + 10000
        ELSE
            "Line No." := 10000
    end;

    var
        Text000Err: Label 'Item Category Code & Product Group Code for Product = ''%1'' must be blank.';

}

