Codeunit 75018 Transfer_Order_Dim_Upd_LocDef
{
    //LocDefaultDimUpd-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeOnRun', '', false, false)]
    local procedure OnBeforeOnRun(var TransferHeader: Record "Transfer Header"; var HideValidationDialog: Boolean; var SuppressCommit: Boolean; var IsHandled: Boolean);
    var
        TmpDimSetEntry_lRecTmp: Record "Dimension Set Entry" temporary;
        DefaultDimension_lRec: Record "Default Dimension";
        DimChagMt: Codeunit "INTGEN_Dimension Changes Mgt";

    begin
        TmpDimSetEntry_lRecTmp.Reset;
        TmpDimSetEntry_lRecTmp.DeleteAll;
        DimChagMt.FillDimSetEntry_gFnc(TransferHeader."Dimension Set ID", TmpDimSetEntry_lRecTmp);



        DefaultDimension_lRec.Reset;
        DefaultDimension_lRec.SetRange("Table ID", 14);
        DefaultDimension_lRec.SetRange("No.", TransferHeader."Transfer-from Code");
        DefaultDimension_lRec.SetFilter("Dimension Value Code", '<>%1', '');
        if DefaultDimension_lRec.FindSet then begin
            repeat
                DimChagMt.UpdateDimSetEntry_gFnc(TmpDimSetEntry_lRecTmp, DefaultDimension_lRec."Dimension Code", DefaultDimension_lRec."Dimension Value Code");
            until DefaultDimension_lRec.Next = 0;
        end else
            exit;

        TransferHeader."Dimension Set ID" := DimChagMt.GetDimensionSetID_gFnc(TmpDimSetEntry_lRecTmp);
        DimChagMt.UpdGlobalDimFromSetID_gFnc(TransferHeader."Dimension Set ID", TransferHeader."Shortcut Dimension 1 Code", TransferHeader."Shortcut Dimension 2 Code");
        TransferHeader.Modify();

        LineDimUpd_TS(TransferHeader);
    end;

    local procedure LineDimUpd_TS(TH_iRec: Record "Transfer Header")
    var
        TL_lRec: Record "Transfer Line";
        TmpDimSetEntry_lRecTmp: Record "Dimension Set Entry" temporary;
        DefaultDimension_lRec: Record "Default Dimension";
        DimChagMt: Codeunit "INTGEN_Dimension Changes Mgt";
    begin
        TL_lRec.Reset();
        TL_lRec.Setrange("Document No.", TH_iRec."No.");
        TL_lRec.Setrange("Derived From Line No.", 0);
        IF TL_lRec.FindSet() Then begin
            repeat
                Clear(DimChagMt);

                TmpDimSetEntry_lRecTmp.Reset;
                TmpDimSetEntry_lRecTmp.DeleteAll;
                DimChagMt.FillDimSetEntry_gFnc(TL_lRec."Dimension Set ID", TmpDimSetEntry_lRecTmp);

                DefaultDimension_lRec.Reset;
                DefaultDimension_lRec.SetRange("Table ID", 14);
                DefaultDimension_lRec.SetRange("No.", TH_iRec."Transfer-from Code");
                DefaultDimension_lRec.SetFilter("Dimension Value Code", '<>%1', '');
                if DefaultDimension_lRec.FindSet then begin
                    repeat
                        DimChagMt.UpdateDimSetEntry_gFnc(TmpDimSetEntry_lRecTmp, DefaultDimension_lRec."Dimension Code", DefaultDimension_lRec."Dimension Value Code");
                    until DefaultDimension_lRec.Next = 0;
                end else
                    exit;

                TL_lRec."Dimension Set ID" := DimChagMt.GetDimensionSetID_gFnc(TmpDimSetEntry_lRecTmp);
                DimChagMt.UpdGlobalDimFromSetID_gFnc(TL_lRec."Dimension Set ID", TL_lRec."Shortcut Dimension 1 Code", TL_lRec."Shortcut Dimension 2 Code");
                TL_lRec.Modify()

            until TL_lRec.NExt = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeOnRun', '', false, false)]
    local procedure OnBeforeOnRun_TR(var TransferHeader2: Record "Transfer Header"; HideValidationDialog: Boolean; SuppressCommit: Boolean; var IsHandled: Boolean);
    var
        TmpDimSetEntry_lRecTmp: Record "Dimension Set Entry" temporary;
        DefaultDimension_lRec: Record "Default Dimension";
        DimChagMt: Codeunit "INTGEN_Dimension Changes Mgt";
    begin
        // TmpDimSetEntry_lRecTmp.Reset;
        // TmpDimSetEntry_lRecTmp.DeleteAll;
        // DimChagMt.FillDimSetEntry_gFnc(TransferHeader2."Dimension Set ID", TmpDimSetEntry_lRecTmp);

        // DefaultDimension_lRec.Reset;
        // DefaultDimension_lRec.SetRange("Table ID", 14);
        // DefaultDimension_lRec.SetRange("No.", TransferHeader2."Transfer-from Code");
        // DefaultDimension_lRec.SetFilter("Dimension Value Code", '<>%1', '');
        // if DefaultDimension_lRec.FindSet then begin
        //     repeat
        //         DimChagMt.UpdateDimSetEntry_gFnc(TmpDimSetEntry_lRecTmp, DefaultDimension_lRec."Dimension Code", DefaultDimension_lRec."Dimension Value Code");
        //     until DefaultDimension_lRec.Next = 0;
        // end else
        //     exit;

        // TransferHeader2."Dimension Set ID" := DimChagMt.GetDimensionSetID_gFnc(TmpDimSetEntry_lRecTmp);
        // DimChagMt.UpdGlobalDimFromSetID_gFnc(TransferHeader2."Dimension Set ID", TransferHeader2."Shortcut Dimension 1 Code", TransferHeader2."Shortcut Dimension 2 Code");
        // TransferHeader2.Modify();

        LineDimUpd_TR(TransferHeader2);
    end;

    local procedure LineDimUpd_TR(TH_iRec: Record "Transfer Header")
    var
        TL_lRec: Record "Transfer Line";
        TmpDimSetEntry_lRecTmp: Record "Dimension Set Entry" temporary;
        DefaultDimension_lRec: Record "Default Dimension";
        DimChagMt: Codeunit "INTGEN_Dimension Changes Mgt";
    begin
        TL_lRec.Reset();
        TL_lRec.Setrange("Document No.", TH_iRec."No.");
        TL_lRec.Setrange("Derived From Line No.", 0);
        IF TL_lRec.FindSet() Then begin
            repeat
                Clear(DimChagMt);

                TmpDimSetEntry_lRecTmp.Reset;
                TmpDimSetEntry_lRecTmp.DeleteAll;
                DimChagMt.FillDimSetEntry_gFnc(TL_lRec."Dimension Set ID", TmpDimSetEntry_lRecTmp);

                DefaultDimension_lRec.Reset;
                DefaultDimension_lRec.SetRange("Table ID", 14);
                DefaultDimension_lRec.SetRange("No.", TH_iRec."Transfer-to Code");
                DefaultDimension_lRec.SetFilter("Dimension Value Code", '<>%1', '');
                if DefaultDimension_lRec.FindSet then begin
                    repeat
                        DimChagMt.UpdateDimSetEntry_gFnc(TmpDimSetEntry_lRecTmp, DefaultDimension_lRec."Dimension Code", DefaultDimension_lRec."Dimension Value Code");
                    until DefaultDimension_lRec.Next = 0;
                end else
                    exit;

                TL_lRec."Dimension Set ID" := DimChagMt.GetDimensionSetID_gFnc(TmpDimSetEntry_lRecTmp);
                DimChagMt.UpdGlobalDimFromSetID_gFnc(TL_lRec."Dimension Set ID", TL_lRec."Shortcut Dimension 1 Code", TL_lRec."Shortcut Dimension 2 Code");
                TL_lRec.Modify()

            until TL_lRec.NExt = 0;
        end;
    end;

    //LocDefaultDimUpd-NE
}

