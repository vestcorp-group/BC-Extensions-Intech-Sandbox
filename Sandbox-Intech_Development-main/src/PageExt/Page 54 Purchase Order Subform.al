pageextension 85222 PurOrdSubformExt extends "Purchase Order Subform"
{
    layout
    {
        modify("Net Weight")
        {
            Visible = true;
        }
        modify("Gross Weight")
        {
            Visible = true;
        }
    }
}
