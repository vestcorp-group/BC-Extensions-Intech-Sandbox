pageextension 80209 PosRtnShptSubExt extends "Posted Return Shipment Subform"
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