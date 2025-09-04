pageextension 50605 "Handled IC Inbox Purch. Lines" extends "Handled IC Inbox Purch. Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter("Unit Cost")
        {
            field("Profit % IC"; rec."Profit % IC")
            {
                ApplicationArea = all;
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