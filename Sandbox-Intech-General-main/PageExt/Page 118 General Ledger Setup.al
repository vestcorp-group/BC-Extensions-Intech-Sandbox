pageextension 75067 GLSetupExt_75067 extends "General Ledger Setup"
{
    layout
    {
        addlast(General)
        {
            //GSTPurchLia-NS
            field("Skip Intetrim Entry RC"; Rec."Skip Intetrim Entry RC")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Skip Interim Entry Create Purchase Reverse Charge Case field.';
            }
            //GSTPurchLia-NE
        }
    }
}
