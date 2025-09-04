Page 74993 "Update Posting Date Batch"
{
    //UpdatePostingDateBatch
    PageType = List;
    SourceTable = "Update Posting Date Batch";
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
                field("New Posting Date"; Rec."New Posting Date")
                {
                    ToolTip = 'Specifies the value of the New Posting Date field.';
                }
                field("New Document Date"; Rec."New Document Date")
                {
                    ToolTip = 'Specifies the value of the New Document Date field.';
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
            action("Update Posting Date Batch")
            {
                ApplicationArea = Basic;
                Caption = 'Update Posting Date Batch';
                Image = UnlimitedCredit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Update Posting Date Batch";
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
