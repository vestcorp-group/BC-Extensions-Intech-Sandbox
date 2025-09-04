tableextension 50619 ICPartner extends "IC Partner"
{
    fields
    {
        // Add changes to table fields here
        field(50600; "Default Profit %"; Decimal)
        {
            Caption = 'Default Profit %';
            Editable = false;
        }
    }

    var
        myInt: Integer;
}