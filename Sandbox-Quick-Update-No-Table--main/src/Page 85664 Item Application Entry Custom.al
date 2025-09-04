page 85664 "Item Application Entry Custom"
{
    ApplicationArea = All;
    Caption = 'Item Application Entry Custom';
    PageType = List;
    SourceTable = "Item Application Entry";
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
                field("Cost Application"; Rec."Cost Application")
                {
                    ToolTip = 'Specifies the value of the Cost Application field.', Comment = '%';
                }
                field("Created By User"; Rec."Created By User")
                {
                    ToolTip = 'Specifies the value of the Created By User field.', Comment = '%';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Specifies the value of the Creation Date field.', Comment = '%';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
                field("Inbound Item Entry No."; Rec."Inbound Item Entry No.")
                {
                    ToolTip = 'Specifies the number of the item ledger entry corresponding to the inventory increase or positive quantity in inventory.';
                }
                field("Item Ledger Entry No."; Rec."Item Ledger Entry No.")
                {
                    ToolTip = 'Specifies one or more item application entries for each inventory transaction that is posted.';
                }
                field("Last Modified By User"; Rec."Last Modified By User")
                {
                    ToolTip = 'Specifies the value of the Last Modified By User field.', Comment = '%';
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ToolTip = 'Specifies the value of the Last Modified Date field.', Comment = '%';
                }
                field("Outbound Entry is Updated"; Rec."Outbound Entry is Updated")
                {
                    ToolTip = 'Specifies the value of the Outbound Entry is Updated field.', Comment = '%';
                }
                field("Outbound Item Entry No."; Rec."Outbound Item Entry No.")
                {
                    ToolTip = 'Specifies the number of the item ledger entry corresponding to the inventory decrease for this entry.';
                }
                field("Output Completely Invd. Date"; Rec."Output Completely Invd. Date")
                {
                    ToolTip = 'Specifies the value of the Output Completely Invd. Date field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the posting date that corresponds to the posting date of the item ledger entry, for which this item application entry was created.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity of the item that is being applied from the inventory decrease in the Outbound Item Entry No. field, to the inventory increase in the Inbound Item Entry No. field.';
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
                field("Transferred-from Entry No."; Rec."Transferred-from Entry No.")
                {
                    ToolTip = 'Specifies the value of the Transferred-from Entry No. field.', Comment = '%';
                }
            }
        }
    }
}
