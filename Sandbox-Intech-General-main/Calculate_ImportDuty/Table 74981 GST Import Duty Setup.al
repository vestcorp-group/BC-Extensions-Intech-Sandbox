Table 74981 "GST Import Duty Setup"
{
    DrillDownPageID = "GST Import Duty Setup";
    LookupPageID = "GST Import Duty Setup";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(11; "Landing Cost %"; Integer)
        {
            MaxValue = 100;
            MinValue = 0;
        }
        field(12; "BCD %"; Decimal)
        {
            MaxValue = 100;
            MinValue = 0;
        }
        field(13; "Custom eCess %"; Decimal)
        {
            MaxValue = 100;
            MinValue = 0;
        }
        field(14; "Custom SHE Cess %"; Decimal)
        {
            MaxValue = 100;
            MinValue = 0;
        }
        field(15; "Against Advance License"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

