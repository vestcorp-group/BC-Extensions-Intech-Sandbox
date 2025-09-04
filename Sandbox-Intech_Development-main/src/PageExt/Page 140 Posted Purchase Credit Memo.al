pageextension 50138 PostedPurCrMemoExt extends "Posted Purchase Credit Memo"
{

    actions
    {
        addafter("&Print")
        {
            action("Commercial Invoice")
            {
                ApplicationArea = All;
                Description = 'T49070';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Invoice;
                trigger OnAction()
                var
                    SalesCrMemoHeader_lRec: Record "Purch. Cr. Memo Hdr.";
                begin
                    SalesCrMemoHeader_lRec.Reset();
                    SalesCrMemoHeader_lRec.SetRange("No.", Rec."No.");
                    if SalesCrMemoHeader_lRec.FindFirst() then
                        REPORT.RUNMODAL(Report::"Commercial Invoice PRS", TRUE, FALSE, SalesCrMemoHeader_lRec);
                end;
            }
        }
    }

}