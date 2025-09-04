table 50504 "Item Variant Testing Parameter"
{
    DataClassification = CustomerContent;
    Caption = 'Item Variant Testing Parameter';
    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
            TableRelation = Item;
            NotBlank = true;
        }
        field(2; "Variant Code"; Code[10]) //AJAY
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }
        field(3; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            TableRelation = "Testing Parameter";
            NotBlank = true;
            trigger OnValidate()
            var
                TestingParameterL: Record "Testing Parameter";
            //ItemVariantTestingParameter: Record "Item Variant Testing Parameter";
            begin
                If Code > '' then begin
                    TestingParameterL.Get(Code);
                    "Testing Parameter" := TestingParameterL."Testing Parameter";
                    "Data Type" := TestingParameterL."Data Type";
                end else begin
                    "Testing Parameter" := '';
                    "Data Type" := "Data Type"::Alphanumeric;
                end;
            end;
        }
        field(21; "Testing Parameter"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Testing Parameter';
        }
        field(22; Minimum; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum';
            DecimalPlaces = 0 : 5; // B
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CheckDataType(Minimum);
            end;
        }
        field(23; Maximum; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum';
            DecimalPlaces = 0 : 5; // B
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CheckDataType(Maximum);
            end;
        }
        field(24; Value; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Alternate';
            ObsoleteState = Pending;
            ObsoleteReason = 'length is not sufficent';
            trigger OnValidate()
            var
                myInt: Integer;
            begin


            end;
        }
        field(25; Priority; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Priority';
            MinValue = 0;
            trigger OnValidate()
            var
                //ItemTestingParameterL: Record "Item Testing Parameter";
                ItemVariantTestingParameter: Record "Item Variant Testing Parameter";
                PriorityDuplicateErr: Label 'Priority can''t be duplicated.';
            begin
                ItemVariantTestingParameter.RESET;
                ItemVariantTestingParameter.SetRange("Item No.", "Item No.");
                ItemVariantTestingParameter.SetRange("Variant Code", "Variant Code");
                ItemVariantTestingParameter.SetFilter(Code, '<>%1', Code);
                ItemVariantTestingParameter.SetRange(Priority, Priority);
                if not ItemVariantTestingParameter.IsEmpty then
                    Error(PriorityDuplicateErr);
            end;
        }
        field(26; "Show in COA"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Show in COA';
        }
        field(27; "Data Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Data Type';
            OptionMembers = Alphanumeric,Decimal,Integer;
            OptionCaption = 'Alphanumeric,Decimal,Integer';
        }
        field(28; "Symbol"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Symbol';
            OptionMembers = " ",">","<";
        }
        field(30; Value2; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Alternate';
        }
        field(31; "Default Value"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Item No.", "Variant Code", Code)
        {
            Clustered = true;
        }

    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, "Testing Parameter") { }
    }


    var
        DecimalNotAllowedErr: Label 'The data type is %1, you can''t enter decimal values';

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    local procedure CheckDataType(ValueP: Decimal)
    begin
        case "Data Type" of
            "Data Type"::Integer:
                if (ValueP mod 1) <> 0 then
                    Error(DecimalNotAllowedErr, "Data Type");
        end;
    end;

}