pageextension 53010 companyHub extends "COHUB Role Center"//T12370-Full Comment     //T13413-Full UnComment
{
    layout
    {
        addafter(CompanyKPIInfo)
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
