pageextension 85240 MDMDataSyncExt extends "Master Data Synch. Tables"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(JobQueueEntry)
        {
            action("Create Job Queue Custom")
            {
                ApplicationArea = basic;
                trigger OnAction()

                var
                    JobQueEntry_lRec: Record "Job Queue Entry";
                begin
                    JobQueEntry_lRec.Reset();
                    JobQueEntry_lRec.SetRange("Object Type to Run", JobQueEntry_lRec."Object Type to Run"::Codeunit);
                    JobQueEntry_lRec.SetRange("Object ID to Run", Codeunit::"Integration Synch. Job Runner");
                    JobQueEntry_lRec.SetRange("Record ID to Process", rec.RecordId());
                    if not JobQueEntry_lRec.FindFirst() then begin
                        JobQueEntry_lRec.InitRecurringJob(20);
                        JobQueEntry_lRec."Object Type to Run" := JobQueEntry_lRec."Object Type to Run"::Codeunit;
                        JobQueEntry_lRec."Object ID to Run" := Codeunit::"Integration Synch. Job Runner";
                        JobQueEntry_lRec."Record ID to Process" := rec.RecordId();
                        JobQueEntry_lRec."Run in User Session" := false;
                        if rec."Table ID" = 0 then begin
                            Error('Table Id missing!!!');
                        end else
                            JobQueEntry_lRec.Description := CopyStr(StrSubstNo(Rec."Table Caption", rec.Name, 'Int'), 1, MaxStrLen(JobQueEntry_lRec.Description));
                        JobQueEntry_lRec."Maximum No. of Attempts to Run" := 10;
                        JobQueEntry_lRec.Status := JobQueEntry_lRec.Status::Ready;
                        JobQueEntry_lRec."Rerun Delay (sec.)" := 30;
                        JobQueEntry_lRec."Inactivity Timeout Period" := 680;
                        JobQueEntry_lRec."Job Queue Category Code" := 'MDM INTEG';
                        Codeunit.Run(Codeunit::"Job Queue - Enqueue", JobQueEntry_lRec)
                    end else
                        Error('Job queue already exist %1', JobQueEntry_lRec.ID);
                end;
            }
        }
        // Add changes to page actions here
    }
}