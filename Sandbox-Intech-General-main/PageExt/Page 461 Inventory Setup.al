pageextension 75054 Inventory_Setup_75054 extends "Inventory Setup"
{
    layout
    {
        addlast(General)
        {
            //InvOpnChk-NS
            field("Check Inventory Period Open"; Rec."Check Inventory Period Open")
            {
                ApplicationArea = All;
            }
            //InvOpnChk-NE
        }
    }
}