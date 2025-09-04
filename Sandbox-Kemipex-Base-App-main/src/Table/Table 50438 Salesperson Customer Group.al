table 50438 "Salesperson Customer Group"//T12370-N
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Group";
            NotBlank = true;
            trigger OnValidate()
            var
                CustRegionRec: Record "Customer Group";
            begin
                if CustRegionRec.Get("Customer group Code") then
                    "Region Description" := CustRegionRec."Description/Name";
            end;
        }
        field(2; "Region Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Salesperson code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
            NotBlank = true;
            trigger OnValidate()
            var
                SPrec: Record "Salesperson/Purchaser";
            begin
                if SPrec.get("Salesperson code") then "Salesperson Name" := SPrec.Name;
            end;
        }
        field(4; "Salesperson Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Customer Group Code", "Salesperson code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

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

}