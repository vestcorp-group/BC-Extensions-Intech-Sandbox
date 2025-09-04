table 50176 KMP_TblGenericName//T12370-N
{
    DataClassification = ToBeClassified;
    Caption = 'Generic Name';
    LookupPageId = KMP_PageGenericName;
    DrillDownPageId = KMP_PageGenericName;

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
                    ItemL.SetRange(GenericName, Code);
                    ItemL.ModifyAll("Generic Description", Description);
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