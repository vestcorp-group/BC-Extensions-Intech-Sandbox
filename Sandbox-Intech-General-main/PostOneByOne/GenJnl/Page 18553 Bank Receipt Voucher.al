pageextension 75036 Bank_Receipt_Voucher_75036 extends "Bank Receipt Voucher"
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
        }

        addafter("Bank Charges")
        {
            action("TDS Receivable")
            {
                Image = ListPage;
                ApplicationArea = All;

                trigger OnAction()
                var
                    GenJnlLine_lRec: Record "Gen. Journal Line";
                begin
                    //I-C0059-1001707-01-NS
                    GenJnlLine_lRec.RESET;
                    GenJnlLine_lRec.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    GenJnlLine_lRec.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    GenJnlLine_lRec.SETRANGE("Line No.", Rec."Line No.");
                    PAGE.RUNMODAL(Page::"TDS Receivable", GenJnlLine_lRec);
                    //I-C0059-1001707-01-NE
                end;

            }
        }
    }
}
