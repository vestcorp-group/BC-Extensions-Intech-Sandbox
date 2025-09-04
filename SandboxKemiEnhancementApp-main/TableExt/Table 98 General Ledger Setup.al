tableextension 70300 "My GL Setup" extends "General Ledger Setup"//T12370-Full Comment T12946-Code Uncommented
{
    fields
    {
        field(70350; "GP G/L Accounts"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    var
        myInt: Integer;
}