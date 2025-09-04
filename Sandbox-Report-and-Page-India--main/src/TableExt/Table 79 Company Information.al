tableextension 50108 ComInfo extends "Company Information"//T12370-N
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Registration No New"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Registration No';
        }
        field(50001; "LUT ARN No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}