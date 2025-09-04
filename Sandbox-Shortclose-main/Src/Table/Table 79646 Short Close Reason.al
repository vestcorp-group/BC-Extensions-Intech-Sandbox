table 79646 "Short Close Reason"
{
    DrillDownPageID = "Short Close Reason";
    LookupPageID = "Short Close Reason";
    Description = 'T12084';

    fields
    {
        field(79646; Code; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(79647; Description; Text[100])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

}