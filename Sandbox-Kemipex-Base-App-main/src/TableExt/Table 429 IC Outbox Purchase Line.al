tableextension 50611 "IC Outbox Purchase Line" extends "IC Outbox Purchase Line"
{
    fields
    {
        // Add changes to table fields here
        field(50600; "Profit % IC"; Decimal)
        {
            Caption = 'Profit % (IC)';
        }
        field(50601; "Variant Code"; Code[50])
        {
            Caption = 'Variant Code';
            DataClassification = CustomerContent;
        }
        //T52505 08-04-2025-NS
        field(60110; "IC Base UOM"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(60111; "IC Unit Price Base UOM"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        //T52505 08-04-2025-NE
    }

    var
        myInt: Integer;
}