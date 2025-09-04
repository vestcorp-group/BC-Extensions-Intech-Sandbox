Report 74984 "INT_Gen Jnl Register 1 by 1"
{
    ProcessingOnly = true;
    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name";


            trigger OnAfterGetRecord()
            var
                ModGenHlnLine_lRec: Record "Gen. Journal Line";
                GenJnlPost_lCud: Codeunit "Gen. Jnl.-Post";

            begin
                Curr_gInt += 1;
                Win.Update(1, Curr_gInt);

                Commit;

                ModGenHlnLine_lRec.Reset;
                ModGenHlnLine_lRec.SetRange("Journal Template Name", "Journal Template Name");
                ModGenHlnLine_lRec.SetRange("Journal Batch Name", "Journal Batch Name");
                ModGenHlnLine_lRec.SetRange("Document No.", "Document No.");
                ModGenHlnLine_lRec.FindFirst;

                ClearLastError;
                Clear(GenJnlPost_lCud);
                if not GenJnlPost_lCud.Run(ModGenHlnLine_lRec) then begin
                    ModGenHlnLine_lRec."Error Log" := CopyStr(GetLastErrorText, 1, 250);
                    ModGenHlnLine_lRec.Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Win.Close;
                GnJln_gCdu.SetHideDia_gFnc(false);
            end;

            trigger OnPreDataItem()
            begin
                Win.Open('#1################');

                if GetFilter("Journal Template Name") = '' then
                    Error('Filter Journal Template Name');


                if GetFilter("Journal Batch Name") = '' then
                    Error('Filter Journal Batch Name');

                GnJln_gCdu.SetHideDia_gFnc(TRUE);
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
        Win: Dialog;
        Curr_gInt: Integer;
        NewLineNo_gInt: Integer;
        GnJln_gCdu: Codeunit "Hide Gen Jnl Reg Dialog";
}

