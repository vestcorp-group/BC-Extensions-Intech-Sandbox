page 85661 "Permission Users"
{
    ApplicationArea = All;
    Caption = 'Permission Users';
    PageType = List;
    SourceTable = User;
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
                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the name of the user. If the user must enter credentials when they sign in, this is the name they must enter.';
                }
                field("Application ID"; Rec."Application ID")
                {
                    ToolTip = 'Specifies the value of the Application ID field.', Comment = '%';
                }
                field("Authentication Email"; Rec."Authentication Email")
                {
                    ToolTip = 'Specifies the Microsoft account that this user uses to sign in to Office 365 or SharePoint Online.';
                }
                field("Change Password"; Rec."Change Password")
                {
                    ToolTip = 'Specifies if the user will be prompted to change the password at next login.';
                }
                field("Contact Email"; Rec."Contact Email")
                {
                    ToolTip = 'Specifies the user''s email address.';
                }
                field("Exchange Identifier"; Rec."Exchange Identifier")
                {
                    ToolTip = 'Specifies the value of the Exchange Identifier field.', Comment = '%';
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ToolTip = 'Specifies a date past which the user will no longer be authorized to log on to the Windows client.';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ToolTip = 'Specifies the full name of the user.';
                }
                field("License Type"; Rec."License Type")
                {
                    ToolTip = 'Specifies the type of license that applies to the user.';
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies whether the user can access companies in the current environment. This field does not reflect any changes in Microsoft 365 Accounts.';
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
                    ToolTip = 'Specifies an ID that uniquely identifies the user. This value is generated automatically and should not be changed.';
                }
                field("Windows Security ID"; Rec."Windows Security ID")
                {
                    ToolTip = 'Specifies the Windows Security ID of the user. This is only relevant for Windows authentication.';
                }
            }
        }
    }
}
