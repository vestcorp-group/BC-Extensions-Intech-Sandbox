tableextension 74998 Vendor_74998 extends "Vendor"
{
    fields
    {
        // Add changes to table fields here
        field(74981; "Check Vendor Invoice No. FY"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'VendInvNoChk';
        }
    }

    var
        myInt: Integer;
}