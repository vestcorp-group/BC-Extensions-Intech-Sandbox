pageextension 50804 PostedVarianceButton extends "Phys. Inventory Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("Delete Entries")
        {
            action("Posted Variance Report")
            {
                ApplicationArea = All;
                Image = Report;
                Caption = 'Posted Variance Report';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    ItemJournalLine: Record "Item Journal Line";
                    VarianceReport: Report PostedVarianceReport;
                    InvSetup: Record "Inventory Setup";
                begin

                    Clear(VarianceReport);
                    InvSetup.Get();
                    VarianceReport.SetParam(InvSetup."Stock Count Template", Rec."Journal Batch Name", Rec."Document No.", Rec."Posting Date");
                    VarianceReport.Run();
                end;
            }
        }
    }

    var
        myInt: Integer;
}