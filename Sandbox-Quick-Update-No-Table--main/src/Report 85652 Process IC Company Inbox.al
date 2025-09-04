Report 85652 "Process IC Company Inbox"
{
    //T13919 NG-N 010325 IC Partner Code Auto Process
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("IC Inbox Transaction"; "IC Inbox Transaction")
        {
            RequestFilterFields = "Source Type";
            trigger OnAfterGetRecord()
            var
                IC_Partner_Process_EH: Codeunit IC_Partner_Process_EH;
            begin
                CurrentRec_gDec += 1;
                Windows_gDlg.Update(2, CurrentRec_gDec);

                ClearLastError();
                Clear(IC_Partner_Process_EH);
                IF IC_Partner_Process_EH.Run("IC Inbox Transaction") Then begin
                    Succ_gInt += 1;
                    Windows_gDlg.Update(3, Succ_gInt);
                end Else begin
                    Failed_gInt += 1;
                    Windows_gDlg.Update(4, Failed_gInt);
                end;
                Commit();
            end;

            trigger OnPostDataItem()
            begin
                Windows_gDlg.Close;
                Message('Total Line Process : %1\Successfully Process : %2\Error Found : %3', CurrentRec_gDec, Succ_gInt, Failed_gInt);
            end;

            trigger OnPreDataItem()
            begin
                Windows_gDlg.Open('Total Record : #1#########\' + 'Current Record : #2##########\Success #3###########\Failed #4##########');
                Windows_gDlg.Update(1, Count);
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
        Succ_gInt: Integer;
        Failed_gInt: Integer;
}