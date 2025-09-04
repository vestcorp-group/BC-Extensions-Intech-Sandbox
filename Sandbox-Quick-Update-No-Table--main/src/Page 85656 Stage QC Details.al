page 85656 "Stage QC Details"
{
    ApplicationArea = All;
    Caption = 'Stage QC Details';
    PageType = List;
    SourceTable = "Stage QC Details";
    UsageCategory = History;
    InsertAllowed = false;
    Description = 'T13919-NS';
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
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Quality Parameter Code"; Rec."Quality Parameter Code")
                {
                    ToolTip = 'Specifies the value of the Quality Parameter Code field.', Comment = '%';
                }
                field("Vendor COA Value Result"; Rec."Vendor COA Value Result")
                {
                    ToolTip = 'Specifies the value of the Vendor COA Value Result field.', Comment = '%';
                }
                field("Vendor COA Text Result"; Rec."Vendor COA Text Result")
                {
                    ToolTip = 'Specifies the value of the Vendor COA Text Result field.', Comment = '%';
                }
                field("Actual Value"; Rec."Actual Value")
                {
                    ToolTip = 'Specifies the value of the QC Value field.', Comment = '%';
                }
                field("Actual Text"; Rec."Actual Text")
                {
                    ToolTip = 'Specifies the value of the QC Text Value field.', Comment = '%';
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ToolTip = 'Specifies the value of the Purchase Order No. field.', Comment = '%';
                }
                field("Purchase Order Line No."; Rec."Purchase Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Purchase Order Line No. field.', Comment = '%';
                }
                field("ILE Entry No."; Rec."ILE Entry No.")
                {
                    ToolTip = 'Specifies the value of the ILE Entry No. field.', Comment = '%';
                }
                field("ILE Lot No."; Rec."ILE Lot No.")
                {
                    ToolTip = 'Specifies the value of the ILE Lot No. field.', Comment = '%';
                }
                field("Sample Collector ID"; Rec."Sample Collector ID")
                {
                    ToolTip = 'Specifies the value of the Sample Collector ID field.', Comment = '%';
                }
                field("Date of Sample Collection"; Rec."Date of Sample Collection")
                {
                    ToolTip = 'Specifies the value of the Date of Sample Collection field.', Comment = '%';
                }
                field("Sample Provider ID"; Rec."Sample Provider ID")
                {
                    ToolTip = 'Specifies the value of the Sample Provider ID field.', Comment = '%';
                }
                field(Result; Rec.Result)
                {
                    ToolTip = 'Specifies the value of the Result field.', Comment = '%';
                }

                field("Sample Date and Time"; Rec."Sample Date and Time")
                {
                    ToolTip = 'Specifies the value of the Sample Date and Time field.', Comment = '%';
                }
                field(Required; Rec.Required) //14042025
                {
                    ToolTip = 'Specifies the value of the Required field.', Comment = '%';
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
            }
        }
    }
}
