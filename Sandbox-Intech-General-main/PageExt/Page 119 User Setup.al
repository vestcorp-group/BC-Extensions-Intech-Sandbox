pageextension 75051 User_Setup_75051 extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            //ReOpenPrOrd-NS

            /* //T13754-NS already in Intech Dev
             field("Allow to Re-Open Prod Order."; Rec."Allow to Re-Open Prod Order.")
             {
                 ApplicationArea = All;
                 ToolTip = 'Specifies the value of the Allow to Re-Open Finish Production Order field.';
             } */
            //ReOpenPrOrd-NE

            //InvOpnChk-NS
            field("Allow to Open Inventory Period"; Rec."Allow to Open Inventory Period")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow to Open Inventory Period field.';
            }
            //InvOpnChk-NE
            //T12883-NS
            field("Allow to Update Dimension"; Rec."Allow to Update Dimension")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow to Update Dimension field.', Comment = '%';
            }
            //T12883-NE
        }
    }
}