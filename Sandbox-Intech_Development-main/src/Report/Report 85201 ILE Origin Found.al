Report 85201 "ILE Origin Found"
{
    // /****** Object:  StoredProcedure [dbo].[Hirel_InvtAging]    Script Date: 01-10-2016 11:13:50 ******/
    // SET ANSI_NULLS ON
    // GO
    // SET QUOTED_IDENTIFIER ON
    // GO
    // CREATE PROC [dbo].[ATE_InvtAging]
    // @asondt smalldatetime
    // 
    // as
    // BEGIN
    // 
    // 
    //             select a.[Entry No_],a.[Location Code],
    // [Posting Date] = case when min(a.[Posting Date]) <= '2015-12-31' then min(a.[Document Date])
    //                       when  min(a.[Posting Date]) > '2015-12-31'  then min(a.[Posting Date]) end,
    //             EntType = (Case When a.[Entry Type] = 0 Then 'Purchase'
    //                                                                         When a.[Entry Type] = 1 Then 'Sale'
    //                                                                         When a.[Entry Type] = 2 Then 'Positive Adjmt.'
    //                                                                         When a.[Entry Type] = 3 Then 'Negative Adjmt.'
    //                                                                         When a.[Entry Type] = 4 Then 'Transfer'
    //                                                                         When a.[Entry Type] = 5 Then 'Consumption'
    //                                                                         When a.[Entry Type] = 6 Then 'Output' end),
    //             a.[Item No_],min(i.[Description]) as [Description] , min( a.Quantity) Quantity,min(a.[Remaining Quantity]) as [Remaining Quantity] ,abs(sum(isnull(b.Quantity,0))) as ApplQty,
    // [Cost Amt] =  (Select (SUM([Cost Amount (Actual)])  + SUM([Cost Amount (Expected)])) AS ItemCost FROM [A_T_E_ Enterprises Pvt_ Ltd_$Value Entry]
    //                   WHERE [Posting Date] <= @asondt and [Item Ledger Entry No_] = a.[Entry No_])
    //             from [A_T_E_ Enterprises Pvt_ Ltd_$Item Ledger Entry] a ,[A_T_E_ Enterprises Pvt_ Ltd_$Item Application Entry] b,[A_T_E_ Enterprises Pvt_ Ltd_$Item] i
    //             where  a.[Entry No_] = b.[Inbound Item Entry No_] and  i.No_ = a.[Item No_]
    // and b.[Posting Date] <= @asondt and b.[Posting Date] <= @asondt
    //             group by a.[Entry No_],a.[Location Code],a.[Item No_],a.[Entry Type]
    //             having abs(sum(isnull(b.Quantity,0))) <>0
    //       End;
    // 
    // 
    // EXEC ATE_InvtAging '2016-03-01'

    Permissions = TableData "Item Ledger Entry" = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.");
            RequestFilterFields = "Entry No.", "Item No.";


            trigger OnAfterGetRecord()
            var
                ILEAppDetail_lRec: Record "ILE Application Detail";
                ConILEAppDetail_lRec: Record "ILE Application Detail";
                ItemAppEntry_lRec: Record "Item Application Entry";
                OriginEntry_lBln: Boolean;
                ILEOriginEntry_lRec: Record "ILE Origin Detail";
                ModILE_lRec: Record "Item Ledger Entry";
                FoundForEntryNo_lInt: Integer;
            begin
                Curr_gInt += 1;
                Win_gDlg.Update(2, Curr_gInt);

                RecurssiveCount_gInt := 0;

                if ("Entry Type" in ["entry type"::"Positive Adjmt.", "entry type"::Output, "entry type"::"Assembly Output"]) and (Quantity > 0) then begin
                    ModILE_lRec.Get("Entry No.");
                    ModILE_lRec."Origin Found" := true;
                    ModILE_lRec.Modify;

                    CurrReport.Skip;
                end;

                if ("Entry Type" = "entry type"::Purchase) and (Quantity > 0) then begin
                    ModILE_lRec.Get("Entry No.");
                    ModILE_lRec."Origin Found" := true;
                    ModILE_lRec.Modify;

                    CurrReport.Skip;
                end;

                //Remove Old Applied Orignin Entry when it force call find origin again  //Example Entry No - 501402
                if ("Origin Found") and (ForceFindOrigin_gBln) then begin
                    ILEOriginEntry_lRec.Reset;
                    ILEOriginEntry_lRec.SetRange("ILE No.", "Entry No.");
                    ILEOriginEntry_lRec.DeleteAll;

                    ModILE_lRec.Get("Entry No.");
                    ModILE_lRec."Origin Found" := false;
                    ModILE_lRec.Modify;

                    Commit;
                end;

                if "Entry No." = 11410 then begin
                    //InsertError_lFnc("Entry No.",'Entry Type = Negative Adj but Quantity > 0');
                    //CurrReport.SKIP


                    ModILE_lRec.Get("Entry No.");
                    if (ModILE_lRec."Entry Type" = ModILE_lRec."entry type"::"Negative Adjmt.") and (ModILE_lRec.Quantity > 0) then
                        ModILE_lRec."Entry Type" := ModILE_lRec."entry type"::"Positive Adjmt.";

                    ModILE_lRec."Origin Found" := true;
                    ModILE_lRec.Modify;

                    InsertOriginEntry_lFnc("Entry No.", Quantity, "Item Ledger Entry");  //Self Origin Entry

                    CurrReport.Skip;
                end;


                //Service Credit Memo Entry Not Applied to any incoming document entry //Example Entry No - 536712
                if ("Entry Type" = "entry type"::Sale) and ("Document Type" = "document type"::"Service Credit Memo") and (Quantity > 0) then begin
                    ItemAppEntry_lRec.Reset;
                    ItemAppEntry_lRec.SetRange("Item Ledger Entry No.", "Entry No.");
                    ItemAppEntry_lRec.SetRange("Inbound Item Entry No.", "Entry No.");
                    ItemAppEntry_lRec.SetRange("Outbound Item Entry No.", 0);  //Outbound = 0 mean it is not applied to any old entry
                    if ItemAppEntry_lRec.FindFirst then begin
                        ModILE_lRec.Get("Entry No.");
                        ModILE_lRec."Origin Found" := true;
                        ModILE_lRec.Modify;

                        InsertOriginEntry_lFnc("Entry No.", Quantity, "Item Ledger Entry");  //Self Origin Entry

                        CurrReport.Skip;
                    end;
                end;

                //Sales Return Receipt Not Applied to any origin entry  //Example Entry No = 497067
                if ("Entry Type" = "entry type"::Sale) and ("Document Type" in ["document type"::"Sales Return Receipt", "document type"::"Sales Credit Memo"]) and (Quantity > 0) then begin
                    ItemAppEntry_lRec.Reset;
                    ItemAppEntry_lRec.SetRange("Item Ledger Entry No.", "Entry No.");
                    ItemAppEntry_lRec.SetRange("Inbound Item Entry No.", "Entry No.");
                    ItemAppEntry_lRec.SetRange("Outbound Item Entry No.", 0);  //Outbound = 0 mean it is not applied to any old entry
                    if ItemAppEntry_lRec.FindFirst then begin
                        ModILE_lRec.Get("Entry No.");
                        ModILE_lRec."Origin Found" := true;
                        ModILE_lRec.Modify;

                        InsertOriginEntry_lFnc("Entry No.", Quantity, "Item Ledger Entry");  //Self Origin Entry

                        CurrReport.Skip;
                    end;
                end;

                //Reverse Consumption Not Applied to Origal Consumption Entry //Exmaple Entry No = 532966   (consumption is done before data upgrade and we have post negative consumtion after live so it is not applied to each other)
                if ("Entry Type" = "entry type"::Consumption) and (Quantity > 0) then begin
                    ItemAppEntry_lRec.Reset;
                    ItemAppEntry_lRec.SetRange("Item Ledger Entry No.", "Entry No.");
                    ItemAppEntry_lRec.SetRange("Inbound Item Entry No.", "Entry No.");
                    ItemAppEntry_lRec.SetRange("Outbound Item Entry No.", 0);  //Outbound = 0 mean it is not applied to any old entry
                    if ItemAppEntry_lRec.FindFirst then begin
                        ModILE_lRec.Get("Entry No.");
                        ModILE_lRec."Origin Found" := true;
                        ModILE_lRec.Modify;

                        InsertOriginEntry_lFnc("Entry No.", Quantity, "Item Ledger Entry");  //Self Origin Entry

                        CurrReport.Skip;
                    end;
                end;
                if ("Entry Type" = "entry type"::"Assembly Consumption") and (Quantity > 0) then begin
                    ItemAppEntry_lRec.Reset;
                    ItemAppEntry_lRec.SetRange("Item Ledger Entry No.", "Entry No.");
                    ItemAppEntry_lRec.SetRange("Inbound Item Entry No.", "Entry No.");
                    ItemAppEntry_lRec.SetRange("Outbound Item Entry No.", 0);  //Outbound = 0 mean it is not applied to any old entry
                    if ItemAppEntry_lRec.FindFirst then begin
                        ModILE_lRec.Get("Entry No.");
                        ModILE_lRec."Origin Found" := true;
                        ModILE_lRec.Modify;

                        InsertOriginEntry_lFnc("Entry No.", Quantity, "Item Ledger Entry");  //Self Origin Entry

                        CurrReport.Skip;
                    end;
                end;

                FoundForEntryNo_lInt := "Entry No.";

                //For Reverse Consumption we will find the origin entry of orignal consumption entry
                //IF ("Entry Type" = "Entry Type"::Consumption) AND (Quantity > 0) THEN BEGIN
                //  ConILEAppDetail_lRec.RESET;
                //  ConILEAppDetail_lRec.SETRANGE("ILE No.",FoundForEntryNo_lInt);
                //  ConILEAppDetail_lRec.SETRANGE("Create By Item Application Ent",TRUE);
                //  IF ConILEAppDetail_lRec.FINDFIRST THEN
                //    FoundForEntryNo_lInt := ConILEAppDetail_lRec."Applied ILE No.";
                //END;

                ILEAppDetail_lRec.Reset;
                ILEAppDetail_lRec.SetRange("ILE No.", FoundForEntryNo_lInt);

                //Special Case Entry No - 330006 (for trasnfer positive entry we doesn't need to check for negative adjustment)
                if ("Entry Type" = "entry type"::Transfer) and (Quantity > 0) then
                    ILEAppDetail_lRec.SetRange("Create By Item Application Ent", true);

                //For Undo Service Shipment & Undo Sales Shipment We only focus on applied Worksheet Entry No  //Example Entry No - 501402
                if ("Entry Type" = "entry type"::Sale) and (Quantity > 0) then
                    ILEAppDetail_lRec.SetRange("Create By Item Application Ent", true);

                //For Undo Consumption We only focus on applied Worksheet Entry No  //Example Entry No - 309963
                if ("Entry Type" = "entry type"::Consumption) and (Quantity > 0) then
                    ILEAppDetail_lRec.SetRange("Create By Item Application Ent", true);

                //T39892-NS
                if ("Entry Type" = "entry type"::"Assembly Consumption") and (Quantity > 0) then
                    ILEAppDetail_lRec.SetRange("Create By Item Application Ent", true);
                //T39892-NE

                if not ILEAppDetail_lRec.FindSet then begin
                    InsertError_lFnc("Entry No.", 'Application Not Found');
                    CurrReport.Skip
                end;

                BuffTable_gRecTmp.Reset;
                BuffTable_gRecTmp.DeleteAll;
                LineNo_gInt := 0;

                repeat
                    OriginEntry_lBln := IsOriginEntry_lFnc(ILEAppDetail_lRec."Applied ILE No.");
                    if OriginEntry_lBln then begin
                        InsertOriginEntry_lFnc(ILEAppDetail_lRec."Applied ILE No.", ILEAppDetail_lRec."Applied Quantity", "Item Ledger Entry");
                    end else begin
                        LineNo_gInt += 1;
                        Clear(BuffTable_gRecTmp);
                        BuffTable_gRecTmp.Init;
                        BuffTable_gRecTmp."Line No." := LineNo_gInt;
                        BuffTable_gRecTmp."Integer 1" := ILEAppDetail_lRec."Applied ILE No.";
                        BuffTable_gRecTmp."Boolean 1" := false;
                        BuffTable_gRecTmp."Decimal 1" := ILEAppDetail_lRec."Applied Quantity";
                        BuffTable_gRecTmp.Insert(true);
                    end;
                until ILEAppDetail_lRec.Next = 0;

                if ("Entry Type" = "entry type"::Transfer) and (Quantity > 0) then
                    FoundOriginEntryTranPositive_lFnc
                else
                    FoundOriginEntry_lFnc;

                //IF "Remaining Quantity" = 0 THEN BEGIN
                ILEOriginEntry_lRec.Reset;
                ILEOriginEntry_lRec.SetRange("ILE No.", "Entry No.");
                if ILEOriginEntry_lRec.FindFirst then begin
                    ModILE_lRec.Get("Entry No.");
                    ModILE_lRec."Origin Found" := true;
                    ModILE_lRec.Modify;
                end;
                //END;

                if not "Origin Found" then
                    InsertError_lFnc("Entry No.", 'Origin Not Found');

                Commit;
            end;

            trigger OnPostDataItem()
            begin
                Win_gDlg.Close;
            end;

            trigger OnPreDataItem()
            begin
                TABChar_gTxt[1] := 9; //TAB Char
                if not ForceFindOrigin_gBln then
                    SetRange("Origin Found", false);

                Win_gDlg.Open('Find Origin Entry....\Total Entry #1###########\Current Entry #2###########');
                Win_gDlg.Update(1, Count);
                Curr_gInt := 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Option)
                {
                    Caption = 'Option';
                    field("Create Error File"; CreateFile_gBln)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Create Error File';
                    }
                    field("Force Find Origin"; ForceFindOrigin_gBln)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Force Find Origin';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        FileMgmt_lCdu: Codeunit "File Management";
        FileExtension_lTxt: Text[100];
        FileFilter_lTxt: Text[100];
        SaveFileName_lTxt: Text;
    begin
        if CreateFile_gBln and (ErrorCount_gInt > 0) then begin
            SaveErrorLogFile_lFnc;
            // if Confirm('Do you want to download Error Log File?', true) then begin
            //     //FileMgt_lCdu.ExportAttToClientFile_gFnc(ClientFileName_gTxt);
            //     FileExtension_lTxt := FileMgmt_lCdu.GetExtension(ClientFileName_gTxt);
            //     FileFilter_lTxt := UpperCase(FileExtension_lTxt) + ' (*.' + FileExtension_lTxt + ')|*.' + FileExtension_lTxt;
            //     SaveFileName_lTxt := FileMgmt_lCdu.SaveFileDialog('Download File', ClientFileName_gTxt, FileFilter_lTxt);

            //     FileMgmt_lCdu.CopyClientFile(ClientFileName_gTxt, SaveFileName_lTxt, true);
            // end;
        end;
        //MESSAGE(FORMAT(RecurssiveCount_gInt));
    end;

    trigger OnPreReport()
    begin
        if CreateFile_gBln then begin
            Clear(TextFile_gFil);
            Clear(OutStreamObj_gOsm);
        end;

        if not CurrReport.UseRequestPage then begin
            ForceFindOrigin_gBln := false;
            CreateFile_gBln := false;
        end;

        if not GuiAllowed then begin
            ForceFindOrigin_gBln := false;
            CreateFile_gBln := false;
        end
    end;

    var
        BuffTable_gRecTmp: Record "Buffer Table Export Data" temporary;
        LineNo_gInt: Integer;
        Win_gDlg: Dialog;
        Curr_gInt: Integer;
        TextFile_gFil: File;
        OutStreamObj_gOsm: OutStream;
        InStream_gIns: InStream;
        TempBlob: Codeunit "Temp Blob";
        ServerFileName_gTxt: Text[250];
        ClientFileName_gTxt: Text;
        ErrorCount_gInt: Integer;
        TABChar_gTxt: Text[1];
        ErrorExists_gBln: Boolean;
        CreateFile_gBln: Boolean;
        RecurssiveCount_gInt: Integer;
        ForceFindOrigin_gBln: Boolean;

    local procedure FoundOriginEntryTranPositive_lFnc()
    var
        ILEOriginEntry_lRec: Record "ILE Origin Detail";
        ItemAppEntry_lRec: Record "Item Application Entry";
        OriginEntry_lBln: Boolean;
        AppliedQty_lDec: Decimal;
        AvailableAppQty_lDec: Decimal;
    begin
        //For Entry Type = Trasnfer and Qty > 0 we will find the application entry from Item Application Table Directly
        //Example Trasnfer Entry No. = 245291


        BuffTable_gRecTmp.Reset;
        BuffTable_gRecTmp.SetRange("Boolean 1", false);
        if BuffTable_gRecTmp.Count > 1 then
            Error('Transfer From entry count cannot be more than one');

        BuffTable_gRecTmp.FindFirst;

        ItemAppEntry_lRec.Reset;
        ItemAppEntry_lRec.SetRange("Inbound Item Entry No.", "Item Ledger Entry"."Entry No.");
        ItemAppEntry_lRec.SetRange("Outbound Item Entry No.", BuffTable_gRecTmp."Integer 1");
        ItemAppEntry_lRec.SetFilter("Transferred-from Entry No.", '<>%1', 0);
        if not ItemAppEntry_lRec.FindFirst then begin
            FoundOriginEntry_lFnc;
            exit;
        end;

        OriginEntry_lBln := IsOriginEntry_lFnc(ItemAppEntry_lRec."Transferred-from Entry No.");
        if OriginEntry_lBln then begin
            InsertOriginEntry_lFnc(ItemAppEntry_lRec."Transferred-from Entry No.", ItemAppEntry_lRec.Quantity, "Item Ledger Entry");
        end else begin
            ILEOriginEntry_lRec.Reset;
            ILEOriginEntry_lRec.SetRange("ILE No.", ItemAppEntry_lRec."Transferred-from Entry No.");
            if ILEOriginEntry_lRec.FindSet then begin
                BuffTable_gRecTmp.Delete(true);
                AvailableAppQty_lDec := BuffTable_gRecTmp."Decimal 1";
                if AvailableAppQty_lDec < 0 then
                    Error('Qty applied cannot be lessthan zero');

                repeat
                    if ILEOriginEntry_lRec."Applied Quantity" < AvailableAppQty_lDec then begin
                        AppliedQty_lDec := ILEOriginEntry_lRec."Applied Quantity";
                        AvailableAppQty_lDec -= AppliedQty_lDec;
                    end else begin
                        AppliedQty_lDec := AvailableAppQty_lDec;
                        AvailableAppQty_lDec := 0;
                    end;

                    InsertOriginEntry_lFnc(ILEOriginEntry_lRec."Applied ILE No.", AppliedQty_lDec, "Item Ledger Entry");
                until ILEOriginEntry_lRec.Next = 0;

            end;
        end;
    end;

    local procedure FoundOriginEntry_lFnc()
    var
        ILE_lRec: Record "Item Ledger Entry";
        ILEAppDetail_lRec: Record "ILE Application Detail";
        ILEOriginEntry_lRec: Record "ILE Origin Detail";
        OriginEntry_lBln: Boolean;
        AppliedQty_lDec: Decimal;
        AvailableAppQty_lDec: Decimal;
    begin
        BuffTable_gRecTmp.Reset;
        BuffTable_gRecTmp.SetRange("Boolean 1", false);
        if BuffTable_gRecTmp.FindSet then begin
            repeat
                ILEOriginEntry_lRec.Reset;
                ILEOriginEntry_lRec.SetRange("ILE No.", BuffTable_gRecTmp."Integer 1");
                if ILEOriginEntry_lRec.FindSet then begin
                    BuffTable_gRecTmp.Delete(true);
                    AvailableAppQty_lDec := BuffTable_gRecTmp."Decimal 1";
                    if AvailableAppQty_lDec < 0 then
                        Error('Qty applied cannot be lessthan zero');


                    repeat
                        if ILEOriginEntry_lRec."Applied Quantity" < AvailableAppQty_lDec then begin
                            AppliedQty_lDec := ILEOriginEntry_lRec."Applied Quantity";
                            AvailableAppQty_lDec -= AppliedQty_lDec;
                        end else begin
                            AppliedQty_lDec := AvailableAppQty_lDec;
                            AvailableAppQty_lDec := 0;
                        end;

                        InsertOriginEntry_lFnc(ILEOriginEntry_lRec."Applied ILE No.", AppliedQty_lDec, "Item Ledger Entry");
                    until ILEOriginEntry_lRec.Next = 0;
                end else begin
                    BuffTable_gRecTmp.Delete(true);

                    ILEAppDetail_lRec.Reset;
                    ILEAppDetail_lRec.SetRange("ILE No.", BuffTable_gRecTmp."Integer 1");
                    ILEAppDetail_lRec.SetFilter("Applied Quantity", '>%1', 0);
                    if ILEAppDetail_lRec.FindSet then begin
                        repeat
                            OriginEntry_lBln := IsOriginEntry_lFnc(ILEAppDetail_lRec."Applied ILE No.");
                            if OriginEntry_lBln then begin
                                InsertOriginEntry_lFnc(ILEAppDetail_lRec."Applied ILE No.", ILEAppDetail_lRec."Applied Quantity", "Item Ledger Entry");
                            end else begin
                                LineNo_gInt += 1;
                                Clear(BuffTable_gRecTmp);
                                BuffTable_gRecTmp.Init;
                                BuffTable_gRecTmp."Line No." := LineNo_gInt;
                                BuffTable_gRecTmp."Integer 1" := ILEAppDetail_lRec."Applied ILE No.";
                                BuffTable_gRecTmp."Boolean 1" := false;
                                BuffTable_gRecTmp."Decimal 1" := ILEAppDetail_lRec."Applied Quantity";
                                BuffTable_gRecTmp.Insert(true);
                            end;

                        until ILEAppDetail_lRec.Next = 0;
                    end;
                end;

            until BuffTable_gRecTmp.Next = 0;
        end else
            exit;

        RecurssiveCount_gInt += 1;
        if RecurssiveCount_gInt > 900 then begin
            if not FindDirectApplication_gFnc then begin
                InsertError_lFnc("Item Ledger Entry"."Entry No.", '900+ Recurssive call');
                exit;
            end else
                exit;
        end;


        FoundOriginEntry_lFnc;
    end;

    local procedure IsOriginEntry_lFnc(EntryNo_iInt: Integer): Boolean
    var
        ILE_lRec: Record "Item Ledger Entry";
        ILEAppDetail_lRec: Record "ILE Application Detail";
    begin
        ILE_lRec.Get(EntryNo_iInt);
        if ILE_lRec."Entry Type" in [ILE_lRec."entry type"::Purchase, ILE_lRec."entry type"::"Positive Adjmt.", ILE_lRec."entry type"::Output, ILE_lRec."entry type"::"Assembly Output"] then begin

            if (ILE_lRec."Entry Type" = ILE_lRec."entry type"::Purchase) then begin
                if ILE_lRec.Quantity > 0 then
                    exit(true)
                else
                    exit(false);
            end else
                exit(true);

        end else
            if (ILE_lRec."Entry Type" = ILE_lRec."entry type"::Sale) and (ILE_lRec.Quantity > 0) then begin  //Sales Ship Entry - 231627 Applied to Sales Return - 228452

                if not ILE_lRec."Origin Found" then
                    exit(true)
                else begin
                    //If it is applied its self than it is our origin entry //Example Entry no - 331559
                    ILEAppDetail_lRec.Reset;
                    ILEAppDetail_lRec.SetRange("ILE No.", ILE_lRec."Entry No.");
                    ILEAppDetail_lRec.SetRange("Applied ILE No.", ILE_lRec."Entry No.");
                    ILEAppDetail_lRec.SetRange("Create By Item Application Ent", true);
                    if ILEAppDetail_lRec.FindFirst then
                        exit(true)
                    else
                        exit(false);
                end;
            end else
                if (ILE_lRec."Entry Type" = ILE_lRec."entry type"::Consumption) and (ILE_lRec.Quantity > 0) then begin  // Reverse Consumption Entry

                    if not ILE_lRec."Origin Found" then
                        exit(true)
                    else begin
                        //If it is applied its self than it is our origin entry //Example Entry no - 499708
                        ILEAppDetail_lRec.Reset;
                        ILEAppDetail_lRec.SetRange("ILE No.", ILE_lRec."Entry No.");
                        ILEAppDetail_lRec.SetRange("Applied ILE No.", ILE_lRec."Entry No.");
                        ILEAppDetail_lRec.SetRange("Create By Item Application Ent", true);
                        if ILEAppDetail_lRec.FindFirst then
                            exit(true)
                        else
                            exit(false);
                    end;

                end else
                    //T39892-NS
                    if (ILE_lRec."Entry Type" = ILE_lRec."entry type"::"Assembly Consumption") and (ILE_lRec.Quantity > 0) then begin  // Reverse Consumption Entry

                        if not ILE_lRec."Origin Found" then
                            exit(true)
                        else begin
                            //If it is applied its self than it is our origin entry //Example Entry no - 499708
                            ILEAppDetail_lRec.Reset;
                            ILEAppDetail_lRec.SetRange("ILE No.", ILE_lRec."Entry No.");
                            ILEAppDetail_lRec.SetRange("Applied ILE No.", ILE_lRec."Entry No.");
                            ILEAppDetail_lRec.SetRange("Create By Item Application Ent", true);
                            if ILEAppDetail_lRec.FindFirst then
                                exit(true)
                            else
                                exit(false);
                        end;
                        //T39892-NE
                    end else
                        exit(false);
    end;

    local procedure InsertOriginEntry_lFnc(AppliedILENo_iInt: Integer; AppliedQty_iDec: Decimal; OrignalILE_iRec: Record "Item Ledger Entry")
    var
        AppliedILE_lRec: Record "Item Ledger Entry";
        ILEOriginEntry_lRec: Record "ILE Origin Detail";
        AppliedQtySum_lDec: Decimal;
        TotalApplied_lDec: Decimal;
    begin
        if ILEOriginEntry_lRec.Get(OrignalILE_iRec."Entry No.", AppliedILENo_iInt) then begin

            //It is possible that a big output entry can apply to sales shipment line multiple times so that case we need increase the sum of appled qty in our application
            // for example check this ILE Application - 501402|501398|471035|404995|379692|484012
            // Entry No - 501402 is applied two times to output entry - 379692 (6 + 6)

            ILEOriginEntry_lRec.Reset;
            ILEOriginEntry_lRec.SetRange("ILE No.", OrignalILE_iRec."Entry No.");
            if ILEOriginEntry_lRec.FindSet then begin
                repeat
                    if ILEOriginEntry_lRec."Applied Quantity" < 0 then
                        ILEOriginEntry_lRec.FieldError("Applied Quantity", 'cannot be lessthan zero');

                    AppliedQtySum_lDec += ILEOriginEntry_lRec."Applied Quantity";
                until ILEOriginEntry_lRec.Next = 0;
            end;

            if AppliedQtySum_lDec >= Abs(OrignalILE_iRec.Quantity) then
                exit;

            if (AppliedQty_iDec > 0) and (AppliedQtySum_lDec + AppliedQty_iDec <= Abs(OrignalILE_iRec.Quantity)) then begin
                ILEOriginEntry_lRec.Get(OrignalILE_iRec."Entry No.", AppliedILENo_iInt);
                ILEOriginEntry_lRec."Applied Quantity" += AppliedQty_iDec;
                ILEOriginEntry_lRec.Modify;
            end;

            exit;
        end;

        Clear(ILEOriginEntry_lRec);
        ILEOriginEntry_lRec.Reset;
        ILEOriginEntry_lRec.SetRange("ILE No.", OrignalILE_iRec."Entry No.");
        if ILEOriginEntry_lRec.FindSet then begin
            repeat
                if ILEOriginEntry_lRec."Applied Quantity" < 0 then
                    ILEOriginEntry_lRec.FieldError("Applied Quantity", 'cannot be lessthan zero');

                AppliedQtySum_lDec += ILEOriginEntry_lRec."Applied Quantity";
            until ILEOriginEntry_lRec.Next = 0;
        end;

        if AppliedQtySum_lDec >= Abs(OrignalILE_iRec.Quantity) then
            exit;



        if AppliedQty_iDec < 0 then
            Error('Applied Quantity cannot be less than zero');

        //IF AppliedQtySum_lDec + AppliedQty_iDec > ABS(OrignalILE_iRec.Quantity) THEN
        //  ERROR('Total Applied Quantity %1 cannot be more than Item Ledger Entry Quantity %2',AppliedQtySum_lDec + AppliedQty_iDec,ABS(OrignalILE_iRec.Quantity));


        TotalApplied_lDec := 0;
        ILEOriginEntry_lRec.Reset;
        ILEOriginEntry_lRec.SetRange("ILE No.", OrignalILE_iRec."Entry No.");
        ILEOriginEntry_lRec.SetRange("Applied ILE No.", AppliedILENo_iInt);
        if ILEOriginEntry_lRec.FindSet then begin
            repeat
                TotalApplied_lDec += ILEOriginEntry_lRec."Applied Quantity";
            until ILEOriginEntry_lRec.Next = 0;
        end;

        if TotalApplied_lDec >= AppliedQty_iDec then
            exit;

        AppliedILE_lRec.Get(AppliedILENo_iInt);
        Clear(ILEOriginEntry_lRec);
        ILEOriginEntry_lRec.Init;
        ILEOriginEntry_lRec."ILE No." := OrignalILE_iRec."Entry No.";
        ILEOriginEntry_lRec."Applied ILE No." := AppliedILE_lRec."Entry No.";
        ILEOriginEntry_lRec."Applied Document No." := AppliedILE_lRec."Document No.";
        ILEOriginEntry_lRec."Applied Entry Type" := AppliedILE_lRec."Entry Type".AsInteger();
        ILEOriginEntry_lRec."Applied Posting Date" := AppliedILE_lRec."Posting Date";

        if AppliedQty_iDec <= Abs(OrignalILE_iRec.Quantity) then
            ILEOriginEntry_lRec."Applied Quantity" := AppliedQty_iDec
        else
            ILEOriginEntry_lRec."Applied Quantity" := Abs(OrignalILE_iRec.Quantity);

        ILEOriginEntry_lRec."Orignal Quantity" := OrignalILE_iRec.Quantity;
        ILEOriginEntry_lRec."Orignal Entry Type" := OrignalILE_iRec."Entry Type".AsInteger();
        ILEOriginEntry_lRec."Orignal Posting Date" := OrignalILE_iRec."Posting Date";
        ILEOriginEntry_lRec.Insert(true);
    end;

    local procedure CreateFile_lFnc()
    var
        SalesSetup_lRec: Record "Sales & Receivables Setup";
        FileMgt_lCdu: Codeunit "File Management";
    begin
        if not CreateFile_gBln then
            exit;

        ErrorCount_gInt := 0;
        //ServerFileName_gTxt := FileMgt_lCdu.ServerTempFileName('txt');

        TempBlob.CreateOutStream(OutStreamObj_gOsm);
        TempBlob.CreateInStream(InStream_gIns);

        //TextFile_gFil.Create(ServerFileName_gTxt);
        //TextFile_gFil.CreateOutstream(OutStreamObj_gOsm);

        OutStreamObj_gOsm.WriteText('Entry No.' + TABChar_gTxt);
        OutStreamObj_gOsm.WriteText('Error');
        ClearLastError;
    end;

    local procedure SaveErrorLogFile_lFnc()
    var
        FileMgt_lCdu: Codeunit "File Management";
    begin
        if not CreateFile_gBln then
            exit;

        if ErrorCount_gInt = 0 then
            exit;

        //TextFile_gFil.Close;
        //ClientFileName_gTxt := FileMgt_lCdu.ClientTempFileName('txt');
        //ClientFileName_gTxt := TEMPORARYPATH + 'Help.txt';
        //FileMgt_lCdu.DownloadToFile(ServerFileName_gTxt, ClientFileName_gTxt);

        ClientFileName_gTxt := 'ErrorLog_' + Format(Today, 0, '<Year4><Month,2><Day,2>') + '_' + Format(Time, 0, '<Hours24,2><Minutes,2><Seconds,2>') + '.txt';
        DownloadFromStream(InStream_gIns, 'Download Log File', '', '', ClientFileName_gTxt);
    end;


    procedure InsertError_lFnc(EntryNo_iInt: Integer; Error_iTxt: Text)
    begin
        if not CreateFile_gBln then
            exit;

        if not ErrorExists_gBln then begin
            CreateFile_lFnc;
        end;

        ErrorExists_gBln := true;

        ErrorCount_gInt += 1;

        OutStreamObj_gOsm.WriteText();
        OutStreamObj_gOsm.WriteText(Format(EntryNo_iInt) + ' - ' + TABChar_gTxt);
        OutStreamObj_gOsm.WriteText(Format(Error_iTxt));
    end;


    procedure FindDirectApplication_gFnc(): Boolean
    var
        ILEAppDetail_lRec: Record "ILE Application Detail";
        ILEOrigin_lRec: Record "ILE Origin Detail";
    begin
        //For Example Entry No. - 527427 is applied to 49 Trasnfer Entry and there is more completed recursive loop so we will direct find origin from applied entry origin

        ILEAppDetail_lRec.Reset;
        ILEAppDetail_lRec.SetRange("ILE No.", "Item Ledger Entry"."Entry No.");
        ILEAppDetail_lRec.SetRange("Applied Entry Type", ILEAppDetail_lRec."applied entry type"::Transfer);
        ILEAppDetail_lRec.SetFilter("Applied Quantity", '>%1', 0);
        if ILEAppDetail_lRec.FindSet then begin
            repeat
                ILEOrigin_lRec.Reset;
                ILEOrigin_lRec.SetRange("ILE No.", ILEAppDetail_lRec."Applied ILE No.");
                ILEOrigin_lRec.SetFilter("Applied Quantity", '<=%1&>%2', ILEAppDetail_lRec."Applied Quantity", 0);
                if ILEOrigin_lRec.FindSet then begin
                    repeat
                        InsertOriginEntry_lFnc(ILEOrigin_lRec."Applied ILE No.", ILEOrigin_lRec."Applied Quantity", "Item Ledger Entry");
                    until ILEOrigin_lRec.Next = 0;
                end;
            until ILEAppDetail_lRec.Next = 0;
        end;

        ILEOrigin_lRec.Reset;
        ILEOrigin_lRec.SetRange("ILE No.", "Item Ledger Entry"."Entry No.");
        if ILEOrigin_lRec.FindFirst then
            exit(true)
        else
            exit(false);
    end;
}

