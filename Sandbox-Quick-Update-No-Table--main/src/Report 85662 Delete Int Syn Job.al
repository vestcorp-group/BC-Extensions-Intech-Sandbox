Report 85662 "Delete Int Syn Job"
{
    //T51626-N
    Caption = 'Delete Integration Sync Job';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    ApplicationArea = All;
    Permissions = tabledata "Integration Synch. Job" = RD;

    dataset
    {
        dataitem("IntSyncJobError"; "Integration Synch. Job")
        {

            trigger OnAfterGetRecord()
            var
                IntSyncJob_lRec: Record "Integration Synch. Job";
            begin
                CurrentRec_gDec += 1;
                Windows_gDlg.Update(2, CurrentRec_gDec);

                Delete(true);
                IF CurrentRec_gDec Mod 1000 = 0 Then
                    Commit();
            end;

            trigger OnPostDataItem()
            begin
                Windows_gDlg.Close;
            end;

            trigger OnPreDataItem()
            begin
                Windows_gDlg.Open('Total Record : #1#########\' + 'Current Record : #2##########\Start At #3###########');
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

