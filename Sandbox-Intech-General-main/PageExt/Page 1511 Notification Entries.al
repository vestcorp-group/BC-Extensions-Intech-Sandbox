pageextension 75057 Notification_Entries_75057 extends "Notification Entries"
{
    layout
    {
        addafter("Recipient User ID")
        {
            field("Workflow Code"; Rec."Workflow Code")
            {
                ApplicationArea = all;
            }

        }
    }
}