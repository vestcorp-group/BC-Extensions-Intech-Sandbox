/* Report 74983 "INT_Wh Jnl Register 1 by 1" //T13754-NS already in Import Inventory and Balance
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Warehouse Journal Line"; "Warehouse Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name";


            trigger OnAfterGetRecord()
            var
                ModWhJnlLine_lRec: Record "Warehouse Journal Line";
                WHNlReg_lCud: Codeunit "Whse. Jnl.-Register";

            begin
                Curr_gInt += 1;
                Win.Update(1, Curr_gInt);

                Commit;

                ModWhJnlLine_lRec.Reset;
                ModWhJnlLine_lRec.SetRange("Journal Template Name", "Journal Template Name");
                ModWhJnlLine_lRec.SetRange("Journal Batch Name", "Journal Batch Name");
                ModWhJnlLine_lRec.SetRange("Line No.", "Line No.");
                ModWhJnlLine_lRec.FindFirst;

                ClearLastError;
                Clear(WHNlReg_lCud);
                if not WHNlReg_lCud.Run(ModWhJnlLine_lRec) then begin
                    ModWhJnlLine_lRec."Error Log" := CopyStr(GetLastErrorText, 1, 250);
                    ModWhJnlLine_lRec.Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Win.Close;
                WhJln_gCdu.SetHideDia_gFnc(false);
            end;

            trigger OnPreDataItem()
            begin
                Win.Open('#1################');

                if GetFilter("Journal Template Name") = '' then
                    Error('Filter Journal Template Name');


                if GetFilter("Journal Batch Name") = '' then
                    Error('Filter Journal Batch Name');

                WhJln_gCdu.SetHideDia_gFnc(TRUE);
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
        WhJln_gCdu: Codeunit "Hide Wh Jnl Reg Dialog";
}

 */