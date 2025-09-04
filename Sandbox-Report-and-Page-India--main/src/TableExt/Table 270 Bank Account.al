tableextension 50109 BankAcc extends "Bank Account"//T12370-Full Comment
{
    fields
    {
        // Add changes to table fields here
        /* // hide by B, MS update
        field(50000; "IFSC CODE"; Code[50])
        {
            DataClassification = ToBeClassified;

        } */
        field(50001; "Branch Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}