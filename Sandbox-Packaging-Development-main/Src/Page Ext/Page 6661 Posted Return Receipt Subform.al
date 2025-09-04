pageextension 80210 PosRtnRcptSubExt extends "Posted Return Receipt Subform"
{
    layout
    {
        // Add changes to page layout here
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