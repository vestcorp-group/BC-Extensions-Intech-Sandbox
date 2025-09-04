tableextension 70012 "Transaction Specification Ext." extends "Transaction Specification"//T12370-N
{
    fields
    {
        // Add changes to table fields here
        field(70000; "Insurance By"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,"Seller","Buyer";
        }
    }
    fieldgroups
    {
        addlast(DropDown; "Insurance By")
        {
        }
    }

    var
        myInt: Integer;
}