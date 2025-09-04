Report 50128 "ILE Application Found"
{
    // //Item No. = 1030000000030Z03100L

    Permissions = TableData "Item Ledger Entry" = rm;
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem(ILE; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.");
            RequestFilterFields = "Entry No.", "Item No.";

            trigger OnAfterGetRecord()
            var
                NegativeILE_lRec: Record "Item Ledger Entry" temporary;
                ILEApplication_lRec: Record "ILE Application Detail";
                ModILE_lRec: Record "Item Ledger Entry";
            begin
                Curr_gInt += 1;
                Win_gDlg.Update(2, Curr_gInt);

                if ("Entry Type" in ["entry type"::"Positive Adjmt.", "entry type"::Output, "entry type"::"Assembly Output"]) and (Quantity > 0) then begin
                    if Quantity = "Remaining Quantity" then begin
                        ILEApplication_lRec.Reset;
                        ILEApplication_lRec.SetRange("ILE No.", "Entry No.");
                        ILEApplication_lRec.DeleteAll;

                        if "Applied Found" then begin
                            ModILE_lRec.Get("Entry No.");
                            ModILE_lRec."Applied Found" := false;
                            ModILE_lRec.Modify;
                            Commit;
                        end;

                        CurrReport.Skip;
                    end;
                end;

                if ("Entry Type" = "entry type"::Purchase) and (Quantity > 0) then begin
                    ModILE_lRec.Get("Entry No.");
                    ModILE_lRec."Applied Found" := true;
                    ModILE_lRec.Modify;
                    Commit;
                    CurrReport.Skip
                end else begin
                    if ("Entry Type" in ["entry type"::"Positive Adjmt.", "entry type"::Output, "entry type"::"Assembly Output"]) and (Quantity > 0) then begin
                        ModILE_lRec.Get("Entry No.");
                        ModILE_lRec."Applied Found" := true;
                        ModILE_lRec.Modify;
                        Commit;

                        CurrReport.Skip;
                    end;
                end;

                //Delete Application Entry when it run by force method
                if (ForceFindOrigin_gBln) and ("Applied Found") then begin
                    ILEApplication_lRec.Reset;
                    ILEApplication_lRec.SetRange("ILE No.", "Entry No.");
                    ILEApplication_lRec.SetRange("Create By Item Application Ent", false);
                    ILEApplication_lRec.DeleteAll;

                    ModILE_lRec.Get("Entry No.");
                    ModILE_lRec."Applied Found" := false;
                    ModILE_lRec.Modify;
                    Commit;
                end;

                MailTempItemEntry_gRecTmp.Reset;
                MailTempItemEntry_gRecTmp.DeleteAll;
                FindAppliedEntry(ILE);

                MailTempItemEntry_gRecTmp.Reset;
                if MailTempItemEntry_gRecTmp.FindSet then begin
                    repeat
                        if not ILEApplication_lRec.Get("Entry No.", MailTempItemEntry_gRecTmp."Entry No.") then begin
                            Clear(ILEApplication_lRec);
                            ILEApplication_lRec.Init;
                            ILEApplication_lRec."ILE No." := "Entry No.";
                            ILEApplication_lRec."Applied ILE No." := MailTempItemEntry_gRecTmp."Entry No.";
                            ILEApplication_lRec."Applied Document No." := MailTempItemEntry_gRecTmp."Document No.";
                            ILEApplication_lRec."Applied Entry Type" := MailTempItemEntry_gRecTmp."Entry Type".AsInteger();
                            ILEApplication_lRec."Applied Posting Date" := MailTempItemEntry_gRecTmp."Posting Date";
                            ILEApplication_lRec."Applied Quantity" := MailTempItemEntry_gRecTmp.Quantity;


                            ILEApplication_lRec."Orignal Quantity" := Quantity;
                            ILEApplication_lRec."Orignal Entry Type" := "Entry Type".AsInteger();
                            ILEApplication_lRec."Orignal Posting Date" := "Posting Date";

                            ILEApplication_lRec.Insert(true);
                        end;
                    until MailTempItemEntry_gRecTmp.Next = 0;
                end;

                if "Remaining Quantity" = 0 then begin
                    ModILE_lRec.Get("Entry No.");
                    ModILE_lRec."Applied Found" := true;
                    ModILE_lRec.Modify;
                end;

                Commit;
            end;

            trigger OnPostDataItem()
            begin
                Win_gDlg.Close;
            end;

            trigger OnPreDataItem()
            begin
                if not ForceFindOrigin_gBln then
                    SetRange("Applied Found", false);

                Win_gDlg.Open('Find Application Entry....\Total Entry #1###########\Current Entry #2###########');
                Win_gDlg.Update(1, Count);
                Curr_gInt := 0;
            end;
        }
        dataitem(ApplicationEntryFound; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.");
            RequestFilterFields = "Entry No.", "Item No.";


            trigger OnAfterGetRecord()
            var
                ItemAppEntry_lRec: Record "Item Application Entry";
                MainILE_lRec: Record "Item Ledger Entry";
                ILEApplication_lRec: Record "ILE Application Detail";
                ModILE_lRec: Record "Item Ledger Entry";
                ConsiderEntry_lBln: Boolean;
            begin
                Curr_gInt += 1;
                Win_gDlg.Update(2, Curr_gInt);

                if Quantity <= 0 then begin
                    ModILE_lRec.Get("Entry No.");
                    ModILE_lRec."Applied Wksh Entry Found" := true;
                    ModILE_lRec.Modify;
                    Commit;

                    CurrReport.Skip;
                end;

                if ("Entry Type" in ["entry type"::"Positive Adjmt.", "entry type"::Output, "entry type"::"Assembly Output"]) and (Quantity > 0) then begin
                    ModILE_lRec.Get("Entry No.");
                    ModILE_lRec."Applied Wksh Entry Found" := true;
                    ModILE_lRec.Modify;
                    Commit;

                    CurrReport.Skip;
                end;

                //Delete Application Entry when it run by force method
                if (ForceFindOrigin_gBln) and ("Applied Wksh Entry Found") then begin
                    ILEApplication_lRec.Reset;
                    ILEApplication_lRec.SetRange("ILE No.", "Entry No.");
                    ILEApplication_lRec.SetRange("Create By Item Application Ent", true);
                    ILEApplication_lRec.DeleteAll;

                    ModILE_lRec.Get("Entry No.");
                    ModILE_lRec."Applied Wksh Entry Found" := false;
                    ModILE_lRec.Modify;
                    Commit;
                end;

                //Service Credit Memo Entry Not Applied to any incoming document entry //Example Entry No - 536712
                if ("Entry Type" = "entry type"::Sale) and ("Document Type" in ["document type"::"Service Credit Memo", "document type"::"Sales Credit Memo"]) and (Quantity > 0) then begin
                    ItemAppEntry_lRec.Reset;
                    ItemAppEntry_lRec.SetRange("Item Ledger Entry No.", "Entry No.");
                    ItemAppEntry_lRec.SetRange("Inbound Item Entry No.", "Entry No.");
                    ItemAppEntry_lRec.SetRange("Outbound Item Entry No.", 0);  //Outbound = 0 mean it is not applied to any old entry
                    if ItemAppEntry_lRec.FindFirst then begin
                        ModILE_lRec.Get("Entry No.");
                        ModILE_lRec."Applied Wksh Entry Found" := true;
                        ModILE_lRec.Modify;

                        InsertApplicationWkshEntry_lFnc(ApplicationEntryFound, ApplicationEntryFound);  //Self Origin Entry

                        CurrReport.Skip;
                    end;
                end;

                //Sales Return Receipt Not Applied to any origin entry  //Example Entry No = 497067
                if ("Entry Type" = "entry type"::Sale) and ("Document Type" = "document type"::"Sales Return Receipt") and (Quantity > 0) then begin
                    ItemAppEntry_lRec.Reset;
                    ItemAppEntry_lRec.SetRange("Item Ledger Entry No.", "Entry No.");
                    ItemAppEntry_lRec.SetRange("Inbound Item Entry No.", "Entry No.");
                    ItemAppEntry_lRec.SetRange("Outbound Item Entry No.", 0);  //Outbound = 0 mean it is not applied to any old entry
                    if ItemAppEntry_lRec.FindFirst then begin
                        ModILE_lRec.Get("Entry No.");
                        ModILE_lRec."Applied Wksh Entry Found" := true;
                        ModILE_lRec.Modify;

                        InsertApplicationWkshEntry_lFnc(ApplicationEntryFound, ApplicationEntryFound);  //Self Origin Entry

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
                        ModILE_lRec."Applied Wksh Entry Found" := true;
                        ModILE_lRec.Modify;

                        InsertApplicationWkshEntry_lFnc(ApplicationEntryFound, ApplicationEntryFound);  //Self Origin Entry

                        CurrReport.Skip;
                    end;
                end;


                ConsiderEntry_lBln := false;
                case "Entry Type" of
                    "entry type"::Transfer:
                        ConsiderEntry_lBln := true;  //TrasnferPostive Entry
                    "entry type"::Sale:   //SalesReturn,UndoShipment
                        begin
                            if "Document Type" in ["document type"::"Sales Shipment", "document type"::"Sales Return Receipt", "document type"::"Sales Credit Memo"] then
                                ConsiderEntry_lBln := true;

                            if ("Document Type" = "document type"::"Service Shipment") and (Quantity > 0) then  //Undo Service Shipment
                                ConsiderEntry_lBln := true;
                        end;
                    "entry type"::Consumption:
                        ConsiderEntry_lBln := true;  //Reverse Consumption
                end;

                if not ConsiderEntry_lBln then
                    CurrReport.Skip;


                ItemAppEntry_lRec.Reset;
                ItemAppEntry_lRec.SetRange("Item Ledger Entry No.", "Entry No.");
                ItemAppEntry_lRec.SetRange("Inbound Item Entry No.", "Entry No.");
                if ItemAppEntry_lRec.Count > 1 then
                    Error('Item Application Entry count %1 cannot be more than one for Entry No. %2', ItemAppEntry_lRec.Count, "Entry No.");


                ItemAppEntry_lRec.FindFirst;

                //There is some entry found with outbound entry = 0  //Example - 217574
                if ItemAppEntry_lRec."Outbound Item Entry No." = 0 then
                    CurrReport.Skip;

                MainILE_lRec.Get(ItemAppEntry_lRec."Outbound Item Entry No.");

                InsertApplicationWkshEntry_lFnc(ApplicationEntryFound, MainILE_lRec);

                ModILE_lRec.Get("Entry No.");
                ModILE_lRec."Applied Wksh Entry Found" := true;
                ModILE_lRec.Modify;
                Commit;
            end;

            trigger OnPostDataItem()
            begin
                Win_gDlg.Close;
            end;

            trigger OnPreDataItem()
            begin
                if not ForceFindOrigin_gBln then
                    SetRange("Applied Wksh Entry Found", false);

                Win_gDlg.Open('Find Application Entry....\Total Entry #1###########\Current Entry #2###########');
                Win_gDlg.Update(1, Count);
                Curr_gInt := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    Caption = 'Option';
                    field("Force Find Application"; ForceFindOrigin_gBln)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Force Find Application';
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

    trigger OnPreReport()
    begin
        if (not CurrReport.UseRequestPage) or (not GuiAllowed) then
            ForceFindOrigin_gBln := false;
    end;

    var
        MailTempItemEntry_gRecTmp: Record "Item Ledger Entry" temporary;
        Win_gDlg: Dialog;
        Curr_gInt: Integer;
        FilterILE_gRec: Record "Item Ledger Entry";
        ForceFindOrigin_gBln: Boolean;

    local procedure FindAppliedEntry(ItemLedgEntry: Record "Item Ledger Entry")
    var
        ItemApplnEntry: Record "Item Application Entry";
    begin
        if ItemLedgEntry.Positive then begin
            ItemApplnEntry.Reset;
            ItemApplnEntry.SetCurrentkey("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
            ItemApplnEntry.SetRange("Inbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SetFilter("Outbound Item Entry No.", '<>%1', 0);
            //ItemApplnEntry.SETRANGE("Cost Application",TRUE);
            if ItemApplnEntry.Find('-') then
                repeat
                    InsertTempEntry(ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                until ItemApplnEntry.Next = 0;
        end else begin
            ItemApplnEntry.Reset;
            ItemApplnEntry.SetCurrentkey("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
            ItemApplnEntry.SetRange("Outbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SetRange("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
            //ItemApplnEntry.SETRANGE("Cost Application",TRUE);
            if ItemApplnEntry.Find('-') then
                repeat
                    InsertTempEntry(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                until ItemApplnEntry.Next = 0;
        end;
    end;

    local procedure InsertTempEntry(EntryNo: Integer; AppliedQty: Decimal)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemLedgEntry.Get(EntryNo);
        if AppliedQty * ItemLedgEntry.Quantity < 0 then
            exit;

        if not MailTempItemEntry_gRecTmp.Get(EntryNo) then begin
            MailTempItemEntry_gRecTmp.Init;
            MailTempItemEntry_gRecTmp := ItemLedgEntry;
            MailTempItemEntry_gRecTmp.Quantity := AppliedQty;
            MailTempItemEntry_gRecTmp.Insert;
        end else begin
            MailTempItemEntry_gRecTmp.Quantity := MailTempItemEntry_gRecTmp.Quantity + AppliedQty;
            MailTempItemEntry_gRecTmp.Modify;
        end;
    end;


    procedure "----Other-----"()
    begin
    end;


    procedure InsertApplicationWkshEntry_lFnc(OrignalILE_iRec: Record "Item Ledger Entry"; AppliedILE_iRec: Record "Item Ledger Entry")
    var
        ILEApplication_lRec: Record "ILE Application Detail";
    begin
        if ILEApplication_lRec.Get(OrignalILE_iRec."Entry No.", AppliedILE_iRec."Entry No.") then
            exit;

        Clear(ILEApplication_lRec);
        ILEApplication_lRec.Init;
        ILEApplication_lRec."ILE No." := OrignalILE_iRec."Entry No.";
        ILEApplication_lRec."Applied ILE No." := AppliedILE_iRec."Entry No.";
        ILEApplication_lRec."Applied Document No." := AppliedILE_iRec."Document No.";
        ILEApplication_lRec."Applied Entry Type" := AppliedILE_iRec."Entry Type".AsInteger();
        ILEApplication_lRec."Applied Posting Date" := AppliedILE_iRec."Posting Date";
        ILEApplication_lRec."Applied Quantity" := OrignalILE_iRec.Quantity;


        ILEApplication_lRec."Orignal Quantity" := OrignalILE_iRec.Quantity;
        ILEApplication_lRec."Orignal Entry Type" := OrignalILE_iRec."Entry Type".AsInteger();
        ILEApplication_lRec."Orignal Posting Date" := OrignalILE_iRec."Posting Date";
        ILEApplication_lRec."Create By Item Application Ent" := true;

        ILEApplication_lRec.Insert(true);
    end;
}

