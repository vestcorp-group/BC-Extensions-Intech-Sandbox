pageextension 50501 PosQCRcptHdrExt extends "Posted QC Rcpt"
{
    PromotedActionCategories = 'New,Process,Report,Print';
    actions
    {
        // Add changes to page actions here
        addafter(Print)
        {
            //T13827-NS
            action("Print COA")
            {
                ApplicationArea = All;
                Caption = 'Print COA';
                Image = Print;
                PromotedCategory = Category4;
                Promoted = true;
                trigger OnAction()
                var
                    PostedQCRcptHeader_lRec: Record "Posted QC Rcpt. Header";
                    COAForPostedQcRcpt_lRpt: Report "COA For Posted Qc Rcpt";
                begin
                    Clear(COAForPostedQcRcpt_lRpt);
                    PostedQCRcptHeader_lRec.Reset();
                    PostedQCRcptHeader_lRec.SetRange("No.", Rec."No.");
                    COAForPostedQcRcpt_lRpt.SetTableView(PostedQCRcptHeader_lRec);
                    COAForPostedQcRcpt_lRpt.RunModal();
                end;
            }
            //T13827-NE
        }
    }
}