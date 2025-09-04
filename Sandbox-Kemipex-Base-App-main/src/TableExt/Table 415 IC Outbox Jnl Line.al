tableextension 50609 "IC Outbox Jnl. Line" extends "IC Outbox Jnl. Line"
{
    fields
    {
        // Add changes to table fields here
        field(50600; "Profit % IC"; Decimal)
        {
            Caption = 'Profit % (IC)';
        }
    }

    var
        myInt: Integer;
}