pageextension 75029 Item_Card_75029 extends "Item Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Common Item No.")
        {
            field("GST Import Duty Code"; Rec."GST Import Duty Code")
            {
                ApplicationArea = Basic;
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