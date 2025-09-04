pageextension 53007 "PageExt 609 IC Partner Card" extends "IC Partner Card"//T13919-N
{
    layout
    {
        addlast(General)
        {
            //IC API -NS     
            field("API Company ID"; Rec."API Company ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the API Company ID field.', Comment = '%';
            }
            //IC API -NE
        }
    }
    actions
    {
        // Add changes to page actions here
    }
    var
}