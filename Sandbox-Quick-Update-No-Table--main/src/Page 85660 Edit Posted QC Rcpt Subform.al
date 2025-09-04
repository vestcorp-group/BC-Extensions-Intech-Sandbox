page 85660 "Edit Posted QC Rcpt. Subform"
{
    ApplicationArea = all;
    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Posted QC Rcpt. Line";
    Permissions = tabledata "Posted QC Rcpt. Line" = RM;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Actual Text"; Rec."Actual Text")
                {
                    ToolTip = 'Specifies the value of the QC Text Value field.', Comment = '%';
                    Editable = true;
                }
                field("Actual Value"; Rec."Actual Value")
                {
                    ToolTip = 'Specifies the value of the QC Value field.', Comment = '%';
                    Editable = true;
                }
                field("COA Max.Value"; Rec."COA Max.Value")
                {
                    ToolTip = 'Specifies the value of the COA Max.Value field.';
                    Editable = true;
                }
                field("COA Min.Value"; Rec."COA Min.Value")
                {
                    ToolTip = 'Specifies the value of the COA Min.Value field.';
                    Editable = true;
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                    Editable = true;
                }
                field("Decimal Places"; Rec."Decimal Places")
                {
                    ToolTip = 'Specifies the value of the Decimal Places field.', Comment = '%';
                    Editable = true;
                }
                field("Default Value"; Rec."Default Value")
                {
                    ToolTip = 'Specifies the value of the Default Value field.', Comment = '%';
                    Editable = true;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    Editable = true;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ToolTip = 'Specifies the value of the Item Code field.', Comment = '%';
                    Editable = true;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ToolTip = 'Specifies the value of the Item Description field.', Comment = '%';
                    Editable = true;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                    Editable = true;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ToolTip = 'Specifies the value of the Mandatory field.', Comment = '%';
                    Editable = true;
                }
                field("Max.Value"; Rec."Max.Value")
                {
                    ToolTip = 'Specifies the value of the Max.Value field.', Comment = '%';
                    Editable = true;
                }
                field(Method; Rec.Method)
                {
                    ToolTip = 'Specifies the value of the Method field.', Comment = '%';
                    Editable = true;
                }
                field("Method Description"; Rec."Method Description")
                {
                    ToolTip = 'Specifies the value of the Method Description field.', Comment = '%';
                    Editable = true;
                }
                field("Min.Value"; Rec."Min.Value")
                {
                    ToolTip = 'Specifies the value of the Min.Value field.', Comment = '%';
                    Editable = true;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Notes; Rec.Notes)
                {
                    ToolTip = 'Specifies the value of the Notes field.';
                    Editable = true;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ToolTip = 'Specifies the value of the Operation No. field.', Comment = '%';
                    Editable = true;
                }
                field(Print; Rec.Print)
                {
                    ToolTip = 'Specifies the value of the Print field.', Comment = '%';
                    Editable = true;
                }
                field("QC Status"; Rec."QC Status")
                {
                    ToolTip = 'Specifies the value of the QC Status field.';
                    Editable = true;
                }
                field("Quality Order No."; Rec."Quality Order No.")
                {
                    ToolTip = 'Specifies the value of the Quality Order No. field.', Comment = '%';
                }
                field("Quality Parameter Code"; Rec."Quality Parameter Code")
                {
                    ToolTip = 'Specifies the value of the Quality Parameter Code field.', Comment = '%';
                }
                field("Quantity to Rework"; Rec."Quantity to Rework")
                {
                    ToolTip = 'Specifies the value of the Quantity to Rework field.', Comment = '%';
                }
                field("Rejected Qty."; Rec."Rejected Qty.")
                {
                    ToolTip = 'Specifies the value of the Rejected Qty. field.', Comment = '%';
                }
                field(Rejection; Rec.Rejection)
                {
                    ToolTip = 'Specifies the value of the Rejection field.', Comment = '%';
                    Editable = true;
                }
                field(Required; Rec.Required)
                {
                    ToolTip = 'Specifies the value of the Required field.', Comment = '%';
                    Editable = true;
                }
                field(Result; Rec.Result)
                {
                    ToolTip = 'Specifies the value of the Result field.', Comment = '%';
                    Editable = true;
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ToolTip = 'Specifies the value of the Rounding Precision field.', Comment = '%';
                    Editable = true;
                }
                field("Selected QC Parameter"; Rec."Selected QC Parameter")
                {
                    ToolTip = 'Specifies the value of the Selected QC Parameter field.', Comment = '%';
                }
                field("Show in COA"; Rec."Show in COA")
                {
                    ToolTip = 'Specifies the value of the Show in COA field.', Comment = '%';
                    Editable = true;
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
                field("Text Value"; Rec."Text Value")
                {
                    ToolTip = 'Specifies the value of the Text Value field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.', Comment = '%';
                }
                field("Vendor COA Text Result"; Rec."Vendor COA Text Result")
                {
                    ToolTip = 'Specifies the value of the Vendor COA Text Result field.', Comment = '%';
                    Editable = true;
                }
                field("Vendor COA Value Result"; Rec."Vendor COA Value Result")
                {
                    ToolTip = 'Specifies the value of the Vendor COA Value Result field.', Comment = '%';
                    Editable = true;
                }
            }
        }
    }
}
