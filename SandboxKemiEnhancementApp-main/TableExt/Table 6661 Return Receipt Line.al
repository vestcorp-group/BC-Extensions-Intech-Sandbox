tableextension 70017 "Return Receipt Line Ext." extends "Return Receipt Line"//T12370-Full Comment
{
    fields
    {
        // Add changes to table fields here
        field(70000; "Customer Requested Unit Price"; Decimal)//T13395-N
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}