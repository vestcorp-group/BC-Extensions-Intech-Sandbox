pageextension 75034 General_Journal_75034 extends "General Journal"
{
    layout
    {

        addafter(ShortcutDimCode8)
        {
            field("Error Log"; Rec."Error Log")
            {
                ApplicationArea = Basic;
                Style = Unfavorable;
                StyleExpr = true;
            }

        }
    }
    actions
    {
        addafter(Post)
        {
            action("Journal Post (1 by 1)")
            {
                ApplicationArea = Basic;
                Image = UnLinkAccount;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    GenJnlLine_lRec: Record "Gen. Journal Line";
                begin
                    GenJnlLine_lRec.Reset;
                    GenJnlLine_lRec.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJnlLine_lRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    Report.RunModal(Report::"INT_Gen Jnl Register 1 by 1", true, false, GenJnlLine_lRec);
                end;
            }
            action("Line Narration")
            {
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Caption = 'Line Narration';
                Image = LineDescription;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Select this option to enter narration for a particular line.';

                trigger OnAction()
                var
                    GenNarration: Record "Gen. Journal Narration";
                    LineNarrationPage: Page "Line Narration";
                begin
                    GetGenJnlNarration(GenNarration, true);
                    LineNarrationPage.SetTableView(GenNarration);
                    LineNarrationPage.RunModal();

                    // ShowOldNarration();
                    VoucherFunctions.ShowOldNarration(Rec);
                    CurrPage.Update(true);
                end;
            }
            action("Voucher Narration")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Voucher Narration';
                Image = LineDescription;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Select this option to enter narration for the voucher.';

                trigger OnAction()
                var
                    GenNarration: Record "Gen. Journal Narration";
                    VoucherNarration: Page "Voucher Narration";
                begin
                    GenNarration.Reset();
                    GenNarration.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenNarration.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    GenNarration.SetRange("Document No.", Rec."Document No.");
                    GenNarration.SetFilter("Gen. Journal Line No.", '%1', 0);
                    VoucherNarration.SetTableView(GenNarration);
                    VoucherNarration.RunModal();

                    // ShowOldNarration();
                    VoucherFunctions.ShowOldNarration(Rec);
                    CurrPage.Update(true);
                end;
            }
        }
    }

    local procedure GetGenJnlNarration(var GenNarration: Record "Gen. Journal Narration"; LineNarration: Boolean)
    begin
        GenNarration.Reset();
        GenNarration.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenNarration.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        GenNarration.SetRange("Document No.", Rec."Document No.");
        if LineNarration then
            GenNarration.SetRange("Gen. Journal Line No.", Rec."Line No.")
        else
            GenNarration.SetFilter("Gen. Journal Line No.", '%1', 0);
    end;

    var
        VoucherFunctions: Codeunit "Voucher Functions";
}
