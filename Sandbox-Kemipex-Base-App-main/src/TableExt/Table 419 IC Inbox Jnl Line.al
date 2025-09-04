tableextension 50608 "IC Inbox Jnl. Line" extends "IC Inbox Jnl. Line"
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