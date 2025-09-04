Page 74992 "Update Dimension Batch"
{
    //UpdateDimensionBatch
    PageType = List;
    SourceTable = "Update Dimension Batch";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = Basic;
                }
                field("Last Modify By"; Rec."Last Modify By")
                {
                    ApplicationArea = Basic;
                }
                field("Last Modify DateTime"; Rec."Last Modify DateTime")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Dimension Batch")
            {
                ApplicationArea = Basic;
                Caption = 'Update Dimension Batch';
                Image = UnlimitedCredit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Update Dimension Batch";
            }
            action("&Navigate")
            {
                ApplicationArea = Basic;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';

                trigger OnAction()
                var
                    NavigateForm: Page Navigate;
                begin
                    NavigateForm.SetDoc(Rec."Posting Date", Rec."Document No.");
                    NavigateForm.Run;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF UserId <> 'BCADMIN' then
            Error('Only BCADMIN user can open this page');
    end;
}
