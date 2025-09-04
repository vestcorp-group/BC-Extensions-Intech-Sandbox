pageextension 80215 ItemVariantCardExt extends "Item Variant Card"
{
    layout
    {
        addlast(ItemVariant)
        {
            field("Packaging Code"; Rec."Packaging Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Packaging Code field.', Comment = '%';
            }
        }
    }
}
