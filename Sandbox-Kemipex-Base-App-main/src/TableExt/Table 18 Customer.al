tableextension 50255 TabExtCustomer extends Customer//T12370-Full Comment //T12574-N
{
    fields
    {
        field(50005; "E-Mirsal Code"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Hide in Reports"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "Insurance Limit (LCY) 2"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Customer Group Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Group";
        }
        field(50103; "Customer Group Code 2"; Code[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Group";
        }
        field(50104; "Customer Incentive Ratio (CIR)"; Option)
        {
            OptionMembers = "","1","2","3","4","5";
            InitValue = 5;
        }
        field(50105; "Trade License Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'T52098';
        }
    }

    var
        myInt: Integer;
}