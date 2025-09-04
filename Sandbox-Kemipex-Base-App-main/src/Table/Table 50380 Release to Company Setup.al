table 50380 "Release to Company Setup"//T12370-N
{
    //DataPerCompany = No;

    fields
    {
        field(1; "Company Name"; Text[30])
        {

            TableRelation = Company;
        }
        field(50000; "Transfer Gl Account"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Transfer Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Transfer Customer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Transfer Vendor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Transfer Attribute"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Transfer Others"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Transfer Exchange Rate"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Company Name")
        {
        }
    }

    fieldgroups
    {
    }
}

