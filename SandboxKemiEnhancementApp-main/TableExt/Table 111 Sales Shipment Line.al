tableextension 80021 "Sales Shipment Line Ext" extends "Sales Shipment Line"//T12370-N
{
    fields
    {
        field(80001; "Item Generic Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = KMP_TblGenericName.Description;

        }
        field(80002; "Line Generic Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = KMP_TblGenericName.Description;

        }
        field(70000; "Customer Requested Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}