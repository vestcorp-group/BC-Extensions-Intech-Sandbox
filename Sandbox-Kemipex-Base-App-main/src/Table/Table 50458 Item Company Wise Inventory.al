table 50458 "Item Company Wise Inventory"//T12370-N
{
    DataClassification = ToBeClassified;
    // TableType = Temporary;

    fields
    {
        field(1; "Company Short Name"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Inventory; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Item Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }

    }

    keys
    {
        key(Key1; "Company Short Name")
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