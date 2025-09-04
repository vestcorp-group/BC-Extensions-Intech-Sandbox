pageextension 50607 ICPartnerCard extends "IC Partner Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Blocked)
        {
            field("Default Profit %"; rec."Default Profit %")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        myInt: Integer;
}