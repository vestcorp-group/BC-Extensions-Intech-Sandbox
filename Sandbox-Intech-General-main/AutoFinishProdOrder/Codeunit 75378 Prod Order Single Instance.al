Codeunit 75378 "Prod. Order - Single Instance"
{
    SingleInstance = true;
    //AutoFinishProdOrder
    trigger OnRun()
    begin
    end;

    var
        TmpBufferTable_gRec: Record "Buffer Table ExpData AutoFin" temporary;
        LineNo_gInt: Integer;
        ErrorCount_gInt: Integer;
        FinishCount_gInt: Integer;
        Windows_gDlg: Dialog;
        Text000: label 'Finishing Production Order\Total #1###########\Current #2##############\Success #3###########\Error #4#################';
        CurrRec_gInt: Integer;


    procedure ClearTempTable_gFnc()
    begin
        TmpBufferTable_gRec.Reset;
        TmpBufferTable_gRec.DeleteAll;
        LineNo_gInt := 0;
    end;


    procedure GetMarkedProdOrderDetails_gFnc(ProductionOrder_iRec: Record "Production Order"): Boolean
    begin
        TmpBufferTable_gRec.Reset;
        TmpBufferTable_gRec.SetRange("Document No.", ProductionOrder_iRec."No.");
        TmpBufferTable_gRec.SetRange("Boolean 1", true);
        if TmpBufferTable_gRec.FindFirst then
            exit(true);

        exit(false);
    end;


    procedure UpdateTable_gFnc(ProductionOrder_iRec: Record "Production Order"; Selection_iBln: Boolean)
    begin
        TmpBufferTable_gRec.Reset;
        TmpBufferTable_gRec.SetRange("Document No.", ProductionOrder_iRec."No.");
        if not TmpBufferTable_gRec.FindSet then begin
            LineNo_gInt += 10000;
            TmpBufferTable_gRec."Document No." := ProductionOrder_iRec."No.";
            TmpBufferTable_gRec."Line No." := LineNo_gInt;
            TmpBufferTable_gRec."Boolean 1" := Selection_iBln;
            TmpBufferTable_gRec.Insert;
        end else begin
            TmpBufferTable_gRec."Boolean 1" := Selection_iBln;
            TmpBufferTable_gRec.Modify;
        end;
    end;


    procedure CopyTable_gFnc(var TmpBufferTable_vRec: Record "Buffer Table ExpData AutoFin" temporary)
    begin
        TmpBufferTable_gRec.Reset;
        TmpBufferTable_gRec.SetRange("Boolean 1", true);
        if TmpBufferTable_gRec.IsEmpty then
            Error('There is nothing to create');

        TmpBufferTable_vRec.Copy(TmpBufferTable_gRec, true);
    end;


    procedure FinishProdOrder_gFnc()
    var
        AutoFinishPO_lCdu: Codeunit "Auto Finish Prod Order";
        ProdOrder_lRec: Record "Production Order";
    begin
        if not Confirm('Do you want to Finish Mark Production Order?', false) then
            exit;

        CurrRec_gInt := 0;
        ErrorCount_gInt := 0;
        FinishCount_gInt := 0;

        TmpBufferTable_gRec.Reset;
        TmpBufferTable_gRec.SetRange("Boolean 1", true);
        if TmpBufferTable_gRec.FindSet then begin
            Windows_gDlg.Open(Text000);
            Windows_gDlg.Update(1, TmpBufferTable_gRec.Count);
            repeat
                CurrRec_gInt += 1;
                Windows_gDlg.Update(2, CurrRec_gInt);
                ProdOrder_lRec.Get(ProdOrder_lRec.Status::Released, TmpBufferTable_gRec."Document No.");
                Clear(AutoFinishPO_lCdu);
                if not AutoFinishPO_lCdu.Run(ProdOrder_lRec) then begin
                    ProdOrder_lRec."Error on Finish PO" := CopyStr(GetLastErrorText, 1, MaxStrLen(ProdOrder_lRec."Error on Finish PO"));
                    ProdOrder_lRec.Modify;
                    ErrorCount_gInt += 1;
                    Windows_gDlg.Update(4, ErrorCount_gInt);
                end else begin
                    FinishCount_gInt += 1;
                    Windows_gDlg.Update(3, FinishCount_gInt);
                    TmpBufferTable_gRec.Delete;
                end;
                Commit;
                ClearLastError;
            until TmpBufferTable_gRec.Next = 0;
            Windows_gDlg.Close;
            Message('%1 - Order Finish\%2 - Error', FinishCount_gInt, ErrorCount_gInt);
        end else
            Error('There is nothing to Finish');
    end;
}

