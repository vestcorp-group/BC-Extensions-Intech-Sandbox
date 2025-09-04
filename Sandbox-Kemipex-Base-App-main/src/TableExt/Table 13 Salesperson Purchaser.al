tableextension 50253 "KMP_Salesperson/Purchaser" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50100; "Short Name"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Short Name';
        }
    }

    var
        myInt: Integer;
}