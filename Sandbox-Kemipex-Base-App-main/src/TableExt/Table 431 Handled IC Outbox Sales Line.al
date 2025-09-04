tableextension 50606 "Handled IC Outbox Sales Line" extends "Handled IC Outbox Sales Line"
{
    fields
    {
        // Add changes to table fields here       
        field(50600; "Profit % IC"; Decimal)
        {
            Caption = 'Profit % (IC)';
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