pageextension 50112 "Value Entries Ext" extends "Value Entries"
{
    layout
    {
        addafter("Item No.")
        {

            field("Variant Code"; Rec."Variant Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Variant Code field.', Comment = '%';
            }
        }

    }
}
