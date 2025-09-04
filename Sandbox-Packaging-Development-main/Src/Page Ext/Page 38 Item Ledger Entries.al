pageextension 80204 ILEExt extends "Item Ledger Entries"
{
    layout
    {
        addafter("Gross Weight 2")
        {
            field("Packaging Code"; Rec."Packaging Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Packaging Code field.', Comment = '%';
            }
        }
    }
}
