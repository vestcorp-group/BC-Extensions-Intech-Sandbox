table 80201 "INT Packaging"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Packaging';
    DrillDownPageID = "INT Packaging List";
    LinkedObject = false;
    LookupPageID = "INT Packaging List";

    fields
    {
        field(170144421; "Product Code"; Code[20])
        {
            Caption = 'Product Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(70144441; "Product Description"; Text[50])
        {
            Caption = 'Product Description';
            DataClassification = CustomerContent;
        }
        field(70144444; Approved; Boolean)
        {
            Caption = 'Approved';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin

                IF Approved THEN BEGIN
                    "Approved By" := copystr(USERID(), 1, 50);
                    "Approved DateTime" := CURRENTDATETIME();
                END ELSE BEGIN
                    "Approved By" := '';
                    "Approved DateTime" := 0DT;
                END;
            end;
        }
        field(70144445; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(70144446; "Approved DateTime"; DateTime)
        {
            Caption = 'Approved DateTime';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144447; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Product Code")
        {
        }
        key(Key2; "Product Description")
        {
        }
    }

    fieldgroups
    {
        // fieldgroup(DropDown; "Product Code", "Product Description", "Item Category Code", "Product Group Code")
        // {
        // }
        fieldgroup(DropDown; "Product Code", "Product Description")
        {
        }
    }

    trigger OnDelete();
    begin
        ProductAssembly.RESET();
        ProductAssembly.SETRANGE("Product Code", "Product Code");
        IF ProductAssembly.FINDSET() THEN
            ProductAssembly.DELETEALL(TRUE);
    end;

    var
        ProductAssembly: Record "INT Packaging Assembly";
        Text000Err: Label 'No. Series cannot be edited for Approved Product = ''%1''.';
}

