page 53024 "Custom Notification Entries"//T12370-Full Comment   //T13413-Full UnComment
{
    ApplicationArea = All;
    Caption = 'Custom Notification Entries';
    PageType = List;
    SourceTable = "Custom Notification Entries";
    SourceTableView = sorting("Notification Date") order(descending); //where("User Id"=const())
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = true;
    ShowFilter = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Notification Date"; Rec."Notification Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notification Date field.';
                }
                field("Notification"; Rec."Notification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notification field.';
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("User Id", UserId);
    end;
}
