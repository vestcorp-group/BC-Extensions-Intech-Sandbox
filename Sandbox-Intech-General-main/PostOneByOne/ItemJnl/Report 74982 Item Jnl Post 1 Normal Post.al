/* Report 74982 "Item Jnl Post - 1 Normal Post" //T13754-NS already in Import Inventory and Balance
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Journal Line"; "Item Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name";


            trigger OnAfterGetRecord()
            var
                T83_lRec: Record "Item Journal Line";
                ItemJnlPost_lCdu: Codeunit "Item Jnl.-Post";
                ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
                BinContent_lRec: Record "Bin Content";
                ReservationEntry_lRec: Record "Reservation Entry";
            begin
                Curr_gInt += 1;
                Win.Update(1, Curr_gInt);

                Commit;

                T83_lRec.Reset;
                T83_lRec.SetRange("Journal Template Name", "Journal Template Name");
                T83_lRec.SetRange("Journal Batch Name", "Journal Batch Name");
                //T83_lRec.SETRANGE("Line No.","Line No.","Line No." + 90000);
                T83_lRec.SetRange("Line No.", "Line No.");
                T83_lRec.FindFirst;

                ClearLastError;
                Clear(ItemJnlPostBatch);
                if not ItemJnlPostBatch.Run(T83_lRec) then begin
                    T83_lRec."Error Log" := CopyStr(GetLastErrorText, 1, 250);
                    T83_lRec.Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Win.Close;
            end;

            trigger OnPreDataItem()
            begin
                Win.Open('#1################');

                if GetFilter("Journal Template Name") = '' then
                    Error('Filter Journal Template Name');


                if GetFilter("Journal Batch Name") = '' then
                    Error('Filter Journal Batch Name');
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
}

 */