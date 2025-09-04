tableextension 53001 VendorTExt extends Vendor
{
    fields
    {
        field(60000; "IC Company Code"; Text[30])
        {
            Caption = 'IC Company Code';
            DataClassification = ToBeClassified;
        }
        field(53001; "Blocked Reason"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
    }
}
