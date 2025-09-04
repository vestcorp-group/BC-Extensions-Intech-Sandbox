table 58245 ItemVarCompanywise//T12370-Full Comment     //T13413-Full UnComment
{
    DataClassification = ToBeClassified;
    Caption = 'Item Var wise';

    fields
    {
        field(1; CompanyName; Text[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Company;
            NotBlank = true;
        }
        field(2; "Item No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Variant Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "QC Blocked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Sales Reserved"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Production Reserved"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Available Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; BlockedQty; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; CompanyName, "Item No.", "Variant Code")
        {
            Clustered = true;
        }
    }
}