page 85663 "Tenant Permission Custom"
{
    ApplicationArea = All;
    Caption = 'Tenant Permission Custom';
    PageType = List;
    SourceTable = "Tenant Permission";
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("App ID"; Rec."App ID")
                {
                    ToolTip = 'Specifies the value of the App ID field.', Comment = '%';
                }
                field("Delete Permission"; Rec."Delete Permission")
                {
                    ToolTip = 'Specifies the value of the Delete Permission field.', Comment = '%';
                }
                field("Execute Permission"; Rec."Execute Permission")
                {
                    ToolTip = 'Specifies the value of the Execute Permission field.', Comment = '%';
                }
                field("Insert Permission"; Rec."Insert Permission")
                {
                    ToolTip = 'Specifies the value of the Insert Permission field.', Comment = '%';
                }
                field("Modify Permission"; Rec."Modify Permission")
                {
                    ToolTip = 'Specifies the value of the Modify Permission field.', Comment = '%';
                }
                field("Object ID"; Rec."Object ID")
                {
                    ToolTip = 'Specifies the ID of the object to which the permissions apply.';
                }
                field("Object Name"; Rec."Object Name")
                {
                    ToolTip = 'Specifies the value of the Object Name field.', Comment = '%';
                }
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the type of object that the permissions apply to in the current database.';
                }
                field("Read Permission"; Rec."Read Permission")
                {
                    ToolTip = 'Specifies the value of the Read Permission field.', Comment = '%';
                }
                field("Role ID"; Rec."Role ID")
                {
                    ToolTip = 'Specifies the permission set.';
                }
                field("Role Name"; Rec."Role Name")
                {
                    ToolTip = 'Specifies the name of the permission set.';
                }
                field("Security Filter"; Rec."Security Filter")
                {
                    ToolTip = 'Specifies a security filter that applies to this permission set to limit the access that this permission set has to the data contained in this table.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the type of permission.';
                }
            }
        }
    }
}
