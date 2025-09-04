pageextension 85651 ICInboxTran85651 extends "IC Inbox Transactions"
{
    actions
    {
        addfirst(processing)
        { ////T13919 NG-NS 010325 IC Partner Code Auto Process
            action("Accept Inbox Transcations")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Report.Run(Report::"Process IC Company Inbox", TRUE);
                end;
            }
            //NG-NE 010325 IC Partner Code Auto Process
        }
    }
}
