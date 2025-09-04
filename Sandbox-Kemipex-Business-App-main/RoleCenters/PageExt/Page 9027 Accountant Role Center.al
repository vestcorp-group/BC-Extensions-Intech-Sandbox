pageextension 58041 AccountantRoleCenter extends "Accountant Role Center"//T12370-Full Comment      //T13413-Full UnComment
{
    layout
    {
        modify(Control9)
        {
            Visible = true;
        }
        addafter(Control1902304208)
        {
            part(AccountSchedulePart; AccountSchedulePart)
            {
                ApplicationArea = all;
            }
        }
        //Additional Customization
        addafter(Control103)
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
    actions
    {
    }
    var
        myInt: Integer;
}