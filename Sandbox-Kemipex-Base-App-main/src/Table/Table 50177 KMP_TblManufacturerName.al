//KMP_TblCountryOfOrigin//T12370-N
table 50177 KMP_TblManufacturerName
{
    DataClassification = ToBeClassified;
    Caption = 'Manufacturer Name';
    LookupPageId = KMP_PageManufacurer;
    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ItemL: Record Item;
            begin
                if xRec.Description <> Description then begin
                    ItemL.SetRange(ManufacturerName, Code);
                    ItemL.ModifyAll("Manufacturer Description", Description);
                end;
            end;
        }
    }

    keys
    {
        key(PK; Code)
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
        Error('You can''t rename the record');
    end;

}