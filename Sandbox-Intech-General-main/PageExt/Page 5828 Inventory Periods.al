pageextension 75055 Inventory_Periods_75055 extends "Inventory Periods"
{
    layout
    {
        addafter(Closed)
        {
            //InvOpnChk-NS
            field("Open For Entry"; Rec."Open For Entry")
            {
                ApplicationArea = All;
            }
            //InvOpnChk-NE
        }
    }
}