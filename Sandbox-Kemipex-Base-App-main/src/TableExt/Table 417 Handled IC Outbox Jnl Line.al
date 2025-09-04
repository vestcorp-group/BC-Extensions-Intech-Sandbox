tableextension 50614 "Handled IC Outbox Jnl. Line" extends "Handled IC Outbox Jnl. Line"
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