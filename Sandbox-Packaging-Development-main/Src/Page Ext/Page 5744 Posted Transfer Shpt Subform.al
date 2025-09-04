pageextension 80208 PosTraShptExt extends "Posted Transfer Shpt. Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Packaging Code"; Rec."Packaging Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Packaging Code field.', Comment = '%';
            }
        }
    }
}
