page 85657 "Stagging Group GRN Details" //T14049
{

    Caption = 'Stagging Group GRN Details';
    PageType = List;
    SourceTable = "Stagging Group GRN Details";
    ApplicationArea = All;
    UsageCategory = History;
    InsertAllowed = false;
    Description = 'T14049-N';
    ModifyAllowed = true;
    DeleteAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("From Company"; Rec."From Company")
                {
                    ToolTip = 'Specifies the value of the From Company field.', Comment = '%';
                }
                field("From Entry No."; Rec."From Entry No.")
                {
                    ToolTip = 'Specifies the value of the From Entry No. field.', Comment = '%';
                }
                field("From Group GRN Date"; Rec."From Group GRN Date")
                {
                    ToolTip = 'Specifies the value of the From Group GRN Date field.', Comment = '%';
                }
                field("GRN No"; Rec."GRN No")
                {
                    ToolTip = 'Specifies the value of the GRN No field.', Comment = '%';
                }
                field("Item No"; Rec."Item No")
                {
                    ToolTip = 'Specifies the value of the Item No field.', Comment = '%';
                }
                field("Lot No"; Rec."Lot No")
                {
                    ToolTip = 'Specifies the value of the Lot No field.', Comment = '%';
                }
                field("Shipment No"; Rec."Shipment No")
                {
                    ToolTip = 'Specifies the value of the Shipment No field.', Comment = '%';
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
                field("To Company"; Rec."To Company")
                {
                    ToolTip = 'Specifies the value of the To Company field.', Comment = '%';
                }
                field("To Group GRN Date"; Rec."To Group GRN Date")
                {
                    ToolTip = 'Specifies the value of the To Group GRN Date field.', Comment = '%';
                }
                field("To Entry No."; Rec."To Entry No.")
                {
                    ToolTip = 'Specifies the value of the To Entry No. field.', Comment = '%';
                }
            }
        }
    }
}
