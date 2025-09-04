pageextension 50255 Page_UnitofMeasure extends "Units of Measure"//T12370-Full Comment Hypercare 26-02-2025
{
    layout
    {
        addafter("International Standard Code")
        {
            field("Decimal Allowed"; rec."Decimal Allowed")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies whether decimal values for these units of measure are allowed.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}