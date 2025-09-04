page 50480 "Kemipex Notification entry"
{

    ApplicationArea = All;
    Caption = 'Kemipex Notification entry';
    PageType = List;
    SourceTable = "Kemipex Notification Entry";
    UsageCategory = Administration;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field("Recipient User ID"; Rec."Recipient User ID")
                {
                    ApplicationArea = All;
                }
                field("Sender User ID"; Rec."Sender User ID")
                {
                    ApplicationArea = All;
                }
                field("Triggered By Record"; Rec."Triggered By Record")
                {
                    ApplicationArea = All;
                }
                field(Handled; Rec.Handled)
                {
                    ApplicationArea = All;
                }
                field("Approval Entry No."; rec."Approval Entry No.")
                {
                    ApplicationArea = all;
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
