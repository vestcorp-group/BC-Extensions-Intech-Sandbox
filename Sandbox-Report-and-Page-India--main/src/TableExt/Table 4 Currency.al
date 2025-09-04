tableextension 50054 CurrencyEXT extends Currency//T12370-N 
{
    fields
    {
        field(50000; "Subsidiary Currency"; Code[20])
        {
            Caption = 'Subsidiary Currency';
            DataClassification = ToBeClassified;
        }
    }
}
