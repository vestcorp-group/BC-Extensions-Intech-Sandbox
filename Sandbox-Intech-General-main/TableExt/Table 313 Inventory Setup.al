tableextension 75000 Inventory_Setup_75000 extends "Inventory Setup"
{
    fields
    {
        //InvOpnChk-NS
        field(74981; "Check Inventory Period Open"; Boolean)
        {
            Caption = 'Check Inventory Period Open';
            Description = 'InvOpnChk';
            DataClassification = ToBeClassified;
        }
        //InvOpnChk-NE
    }
}
