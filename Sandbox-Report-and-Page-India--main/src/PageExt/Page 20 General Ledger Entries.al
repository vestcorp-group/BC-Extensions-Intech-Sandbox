pageextension 64105 "GLE" extends "General Ledger Entries"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
        // addafter("Print Voucher")
        // {
        //     action("Voucher Report")
        //     {
        //         ApplicationArea = all;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedOnly = true;
        //         trigger OnAction()
        //         var

        //         begin
        //             GLE.Reset();
        //             GLE.SetRange("Document No.", rec."Document No.");
        //             if GLE.FindFirst() then begin
        //                 Report.RunModal(64120, true, false, GLE);
        //             end;




        //         end;
        //     }

        // }
        addafter("Print Voucher")
        {
            action("Voucher Report")
            {
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction();
                var
                    GLEntry_LRec: Record "G/L Entry";
                begin
                    GLEntry_LRec.Reset();
                    // GLEntry_LRec.SetRange("Entry No.", Rec."Entry No.");
                    GLEntry_LRec.SetRange("Document No.", Rec."Document No.");
                    // GLEntry_LRec.SetRange("Transaction No.", Rec."Transaction No.");
                    // GLEntry_LRec.SetFilter("Source Code", '%1', 'PAYMENTJNL');
                    // GLEntry_LRec.SetRange("Document No.", Rec."Document No.");
                    // GLEntry_LRec.SetRange("Posting Date", Rec."Posting Date");
                    if GLEntry_LRec.FindFirst() then begin
                        if (GLEntry_LRec."Source Code" <> 'PAYMENTJNL') AND (GLEntry_LRec."Source Code" <> 'CASHRECJNL') AND (GLEntry_LRec."Source Code" <> 'BANKPYMTV') then
                            Report.RunModal(50008, true, false, GLEntry_LRec)
                        else
                            if (GLEntry_LRec."Source Code" = 'PAYMENTJNL') or (GLEntry_LRec."Source Code" = 'BANKPYMTV') then
                                Report.RunModal(50007, true, false, GLEntry_LRec)
                            else
                                if GLEntry_LRec."Source Code" = 'CASHRECJNL' then
                                    Report.RunModal(50009, true, false, GLEntry_LRec);


                        // GLEntry_LRec.Reset;
                        // GLEntry_LRec.SetCurrentKey("Document No.", "Posting Date");
                        // GLEntry_LRec.SetRange("Document No.", rec."Document No.");
                        // GLEntry_LRec.SetRange("Posting Date", rec."Posting Date");
                        // If GLEntry_LRec.FindSet() then
                        //     Report.Run(Report::"New Posted Voucher", TRUE, FALSE, GLEntry_LRec);
                    end;
                end;
            }
        }
        // modify("Print Voucher")
        // {
        //     Visible = false;
        // }
    }

    var
        myInt: Integer;
        GLE: Record "G/L Entry";
}