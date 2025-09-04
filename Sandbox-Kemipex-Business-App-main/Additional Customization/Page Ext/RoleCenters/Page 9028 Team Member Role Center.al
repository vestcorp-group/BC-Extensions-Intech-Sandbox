pageextension 53017 TeamMemberExt extends "Team Member Role Center"//T12370-Full Comment    //T13413-Full UnComment
{
    layout
    {
        addbefore(Emails)
        {
            group(Notification)
            {
                ShowCaption = false;
                part("Notification Cue"; "Notification Cue")
                {
                    ApplicationArea = All;
                    Caption = 'Notifications';
                }
            }
        }
    }
}
