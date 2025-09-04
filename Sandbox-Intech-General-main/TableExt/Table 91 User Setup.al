tableextension 74983 User_Setup_74983 extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        field(74981; Administrator; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T18908';
            Editable = false;
        }
        //ReOpenPrOrd-NS
        //T13754-NS already in Intech Dev
        // field(74982; "Allow to Re-Open Prod Order."; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'T18908';
        //     Caption = 'Allow to Re-Open Finish Production Order';
        // }
        //ReOpenPrOrd-NE
        //T13754-NE
        //InvOpnChk-NS
        field(74983; "Allow to Open Inventory Period"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'InvOpnChk';
            Caption = 'Allow to Open Inventory Period';
        }
        //InvOpnChk-NE
        //T12883-NS
        field(74984; "Allow to Update Dimension"; boolean)
        {
            DataClassification = ToBeClassified;
        }
        //T12883-NE
    }

    var
        myInt: Integer;
}