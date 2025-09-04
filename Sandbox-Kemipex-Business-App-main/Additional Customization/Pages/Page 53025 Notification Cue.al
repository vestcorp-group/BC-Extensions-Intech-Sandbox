page 53025 "Notification Cue"//T12370-Full Comment  //T13413-Full UnComment
{
    Caption = 'Notification Cue';
    PageType = CardPart;
    SourceTable = "Custom Notification Entries";

    layout
    {
        area(content)
        {
            cuegroup(Notification)
            {
                field(NoOfNotifications; NoOfNotifications)
                {
                    ApplicationArea = All;
                    Caption = 'Pending Notifications';
                    StyleExpr = OutboxCueStyle;
                    trigger OnDrillDown()
                    var
                        NotificationEntries: Page "Custom Notification Entries";
                    begin
                        Clear(NotificationEntries);
                        NotificationEntries.SetTableView(CustomNotifications);
                        NotificationEntries.Caption('Notifications for ' + UserId);
                        NotificationEntries.Run();
                    end;
                }
            }
        }

    }
    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GETTABLE(Rec);
                    CueSetup.OpenCustomizePageForCurrentUser(CueRecordRef.NUMBER);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        GetUpdatedData();
    end;

    trigger OnAfterGetRecord()
    begin
        GetUpdatedData();
    end;

    local procedure GetUpdatedData()
    begin
        Clear(CustomNotifications);
        CustomNotifications.SetRange("User Id", UserId);
        if CustomNotifications.FindSet() then
            NoOfNotifications := CustomNotifications.Count;

        if NoOfNotifications = 0 then
            OutboxCueStyle := 'Favorable'
        else
            OutboxCueStyle := 'Unfavorable';
    end;

    var
        NoOfNotifications: Integer;
        CustomNotifications: Record "Custom Notification Entries";
        CueSetup: Codeunit 9701;
        OutboxCueStyle: Text;
}
