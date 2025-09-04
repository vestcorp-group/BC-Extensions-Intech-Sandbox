table 50147 "Intercompany Profit Margin"//T12370-N
{
    DataClassification = CustomerContent;
    Caption = 'Intercompany Profit Margin';
    DataPerCompany = false;
    ReplicateData = false;

    fields
    {
        field(1; "From Company"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell From';
            TableRelation = Company;
            NotBlank = true;
        }
        field(2; "To Company"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell To';
            TableRelation = Company;
            NotBlank = true;
        }
        field(21; "Profit Margin %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'To Company Profit Margin %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
        }
    }

    keys
    {
        key(PK; "From Company", "To Company")
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