pageextension 53015 PurchasingAgentRC extends "Purchasing Agent Role Center"//T12370-Full Comment   //T13413-Full UnComment
{
    layout
    {
        addafter("User Tasks Activities")
        {
            group(Notification)
            {
                ShowCaption = false;
                part("Notification Cue"; "Notification Cue")
                {
                    ApplicationArea = All;
                    Caption = 'Notifications';
                    ShowFilter = false;
                }
            }
        }
    }
}
