page 85662 "Permission User Subform"
{
    ApplicationArea = All;
    Caption = 'Permission User Subform';
    PageType = List;
    SourceTable = "Access Control";
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Permissions = tabledata "Access Control" = md; //27-05-2025-N

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the name of the user.';
                }
                field("App ID"; Rec."App ID")
                {
                    ToolTip = 'Specifies the value of the App ID field.', Comment = '%';
                }
                field("App Name"; Rec."App Name")
                {
                    ToolTip = 'Specifies the name of the extension.';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the company that the permission set applies to.';
                }
                field("Role ID"; Rec."Role ID")
                {
                    ToolTip = 'Specifies the ID of a permission set.';
                }
                field("Role Name"; Rec."Role Name")
                {
                    ToolTip = 'Specifies the name of the permission set.';
                }
                field(Scope; Rec.Scope)
                {
                    ToolTip = 'Specifies the value of the Scope field.', Comment = '%';
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
                field("User Security ID"; Rec."User Security ID")
                {
                    ToolTip = 'Specifies the Windows security identification (SID) of each Windows login that has been created in the current database.';
                }
            }
        }
    }

    //27-05-2025-NS
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if UserId <> 'INTECH.DEVELOPER' then
            Error('You can not open this page.');
    end;
    //27-05-2025-NE
}
