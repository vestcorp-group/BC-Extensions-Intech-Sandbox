tableextension 70016 "Sales Cr. Memo Line Ext." extends "Sales Cr.Memo Line"//T12370-Full Comment
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