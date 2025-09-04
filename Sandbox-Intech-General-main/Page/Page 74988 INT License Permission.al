page 74998 "INT License Permission"
{
    ApplicationArea = All;
    Caption = 'License Permission';
    PageType = List;
    SourceTable = "License Permission";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Delete Permission"; Rec."Delete Permission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Delete Permission field.';
                }
                field("Execute Permission"; Rec."Execute Permission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Execute Permission field.';
                }
                field("Insert Permission"; Rec."Insert Permission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insert Permission field.';
                }
                field("Limited Usage Permission"; Rec."Limited Usage Permission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Limited Usage Permission field.';
                }
                field("Modify Permission"; Rec."Modify Permission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Modify Permission field.';
                }
                field("Object Number"; Rec."Object Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object Number field.';
                }
                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object Type field.';
                }
                field("Read Permission"; Rec."Read Permission")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Read Permission field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }

    trigger OnOpenPage()

    begin
        Rec.SetRange("Object Number", 50000, 99999);
        Rec.SetRange("Read Permission", Rec."Read Permission"::Yes);
    end;
}
