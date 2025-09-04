pageextension 75066 DetailGST_PageExt75066 extends "Detailed GST Ledger Entry"
{
    layout
    {
        addlast(General)
        {
            //GSTPurchLia-NS
            field("Orignal GST Group Type"; Rec."Orignal GST Group Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GST Group Type field.';
            }
            //GSTPurchLia-NE
        }
    }
}
