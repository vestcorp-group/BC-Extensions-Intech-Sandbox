tableextension 50476 VatpostingSetupext extends "VAT Posting Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "Out of scope"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "Sales OTV Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            Description = 'T13730';
        }
        field(50110; "Purchase OTV Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            Description = 'T13730';
        }

    }

    var
        myInt: Integer;
}