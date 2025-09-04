table 50175 KMP_TblMarketIndustry//T12370-N
{
    DataClassification = ToBeClassified;
    Caption = 'Market Industry';
    LookupPageId = KMP_PageMarketIndustry;

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
                    ItemL.SetRange(MarketIndustry, Code);
                    ItemL.ModifyAll("Market Industry Desc.", Description);
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