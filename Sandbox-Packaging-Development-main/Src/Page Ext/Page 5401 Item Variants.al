pageextension 80214 ItemVariantExt extends "Item Variants"
{
    layout
    {
        addlast(Control1)
        {
            field("Packaging Code"; Rec."Packaging Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Packaging Code field.', Comment = '%';
            }
        }
    }
}
