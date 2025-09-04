Report 75375 "Auto Finish Prod Order Batch"
{
    ProcessingOnly = true;
    //AutoFinishProdOrder
    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = sorting(Status, "No.") where(Status = const(Released));
            column(ReportForNavId_33027920; 33027920)
            {
            }

            trigger OnAfterGetRecord()
            var
                AutoFinishPO_lCdu: Codeunit "Auto Finish Prod Order";
                ProdOrder_lRec: Record "Production Order";
                ProdOrderLine_lRec: Record "Prod. Order Line";
            begin
                CurrRec_gInt += 1;
                Windows_gDlg.Update(2, CurrRec_gInt);

                ProdOrderLine_lRec.Reset;
                ProdOrderLine_lRec.SetRange(Status, Status);
                ProdOrderLine_lRec.SetRange("Prod. Order No.", "No.");
                ProdOrderLine_lRec.SetFilter("Remaining Quantity", '<>%1', 0);
                if ProdOrderLine_lRec.FindFirst then
                    CurrReport.Skip;

                Commit;

                ClearLastError;

                ProdOrder_lRec.Get(Status, "No.");
                Clear(AutoFinishPO_lCdu);
                if not AutoFinishPO_lCdu.Run(ProdOrder_lRec) then begin
                    ProdOrder_lRec."Error on Finish PO" := CopyStr(GetLastErrorText, 1, MaxStrLen(ProdOrder_lRec."Error on Finish PO"));
                    ProdOrder_lRec.Modify;
                    ErrorCount_gInt += 1;
                    Windows_gDlg.Update(4, ErrorCount_gInt);
                end else begin
                    FinishCount_gInt += 1;
                    Windows_gDlg.Update(3, FinishCount_gInt);
                end;
            end;

            trigger OnPreDataItem()
            begin
                FinishCount_gInt := 0;
                ErrorCount_gInt := 0;
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

    trigger OnPostReport()
    begin
        Message('%1 - Order Finish\%2 - Error', FinishCount_gInt, ErrorCount_gInt);
    end;

    trigger OnPreReport()
    begin
        Windows_gDlg.Open(Text000);
    end;

    var
        FinishCount_gInt: Integer;
        ErrorCount_gInt: Integer;
        Windows_gDlg: Dialog;
        Text000: label 'Finishing Production Order\Total #1###########\Current #2##############\Success #3###########\Error #4#################';
        CurrRec_gInt: Integer;
}

