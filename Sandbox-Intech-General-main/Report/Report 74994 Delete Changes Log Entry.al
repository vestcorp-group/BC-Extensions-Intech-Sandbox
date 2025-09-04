report 74994 "Delete Changes Log Entry"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = tabledata "Change Log Entry" = rd;

    dataset
    {
        dataitem("Change Log Entry"; "Change Log Entry")
        {
            DataItemTableView = sorting("Entry No.") order(ascending);
            RequestFilterFields = "Entry No.", "Date and Time";
            trigger OnAfterGetRecord()
            var
                CLE_lRec: Record "Change Log Entry";
            begin
                CurrentRec_gDec := "Entry No.";
                Windows_gDlg.Update(2, CurrentRec_gDec);

                CLE_lRec.RESET;
                CLE_lRec.Setrange("Entry No.", CurrentRec_gDec, CurrentRec_gDec + 1000);
                CLE_lRec.DeleteAll();
                CurrentRec_gDec += 1000;
                Commit();

            end;

            trigger OnPostDataItem()
            begin
                Windows_gDlg.Close;
            end;

            trigger OnPreDataItem()
            begin
                Windows_gDlg.Open('Total Record : #1#########\' + 'Current Record : #2##########\ Start At #3#######');
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

    trigger OnPreReport()
    begin
        IF UserId <> 'BCADMIN' then
            Error('Only BCADMIN User can open this page');
    end;

    var
        Windows_gDlg: Dialog;
        CurrentRec_gDec: Decimal;
}

