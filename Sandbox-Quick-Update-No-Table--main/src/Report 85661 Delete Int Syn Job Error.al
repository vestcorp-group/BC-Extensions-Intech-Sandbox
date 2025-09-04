Report 85661 "Delete Int Syn Job Error"
{
    //T51626-N
    Caption = 'Delete Integration Sync Job Errors';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    ApplicationArea = All;
    Permissions = tabledata "Integration Synch. Job Errors" = RD;

    dataset
    {
        dataitem("IntSyncJobError"; "Integration Synch. Job Errors")
        {

            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            var
                IntSyncJob_lRec: Record "Integration Synch. Job Errors";
            begin
                CurrentRec_gDec += 1;
                Windows_gDlg.Update(2, CurrentRec_gDec);
                Windows_gDlg.Update(4, "No.");

                Clear(IntSyncJob_lRec);
                IntSyncJob_lRec.SetRange("No.", IntSyncJobError."No.", IntSyncJobError."No." + 10000);
                IntSyncJob_lRec.DeleteAll(true);
                Commit();
            end;

            trigger OnPostDataItem()
            begin
                Windows_gDlg.Close;
            end;

            trigger OnPreDataItem()
            begin
                Windows_gDlg.Open('Total Record : #1#########\' + 'Current Record : #2##########\Start At #3###########\Entry No. #4#############');
                Windows_gDlg.Update(1, Count);
                Windows_gDlg.Update(3, CurrentDateTime);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Windows_gDlg: Dialog;
        CurrentRec_gDec: Decimal;
}

