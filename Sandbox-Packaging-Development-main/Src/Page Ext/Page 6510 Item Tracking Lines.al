pageextension 80213 ItemTrackingLinesExt extends "Item Tracking Lines"
{
    layout
    {
        addafter("Quantity (Base)")
        {
            field("Unit of Measure Code"; Rec."Unit of Measure Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit of Measure Code field.', Comment = '%';
            }
            field("Packaging Code"; Rec."Packaging Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Packaging Code field.', Comment = '%';

            }
        }
    }
}
