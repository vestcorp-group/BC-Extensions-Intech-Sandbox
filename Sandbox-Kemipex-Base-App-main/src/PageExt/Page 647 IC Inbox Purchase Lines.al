pageextension 50604 "IC Inbox Purchase Lines" extends "IC Inbox Purchase Lines"
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
            field("Variant Code"; rec."Variant Code") //added bayas
            {
                ApplicationArea = add;
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