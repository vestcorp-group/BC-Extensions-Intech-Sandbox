codeunit 50601 "Elimination Proces"
{
    Permissions = tabledata 32 = rmid, tabledata 17 = rmid;

    procedure GenerateLines(startDate: Date; endDate: Date)
    var
        bussinesUnit: Record "Business Unit";
        BU_List: List of [Text];
    begin
        lineNo := 10000;

        testSetup();
        clearProfitEliminationTable();

        bussinesUnit.Reset();
        if bussinesUnit.FindFirst() then begin
            repeat
                BU_List.add(bussinesUnit.Code);

                CheckScenario5(bussinesUnit, startDate, endDate);  //IC Purchase orders  also covering scenario no.3
                CheckScenario1(bussinesUnit, startDate, endDate);  //Tansfer Order for IC PO
                //CheckScenario4(bussinesUnit, startDate, endDate);  //Remove PO (Scenario5) from IC Profit Elimination Table if normal non IC partner PO exist in the same period
                CheckScenario2(bussinesUnit, startDate, endDate);  //look for transfer orders that happend in selected period if they originate from IC partner PO. Meaning there is no PO in elimination table yet becuase po is out of date range
                                                                   //CheckScenario6(bussinesUnit, startDate, endDate);  //Scenario covered using scenario no.1 and scenario no.3
                                                                   //CheckScenario3(bussinesUnit, startDate, endDate);  //Scenario covered using scenario no.5

            until bussinesUnit.Next() = 0;

            preapareGenJnl_To_Post(BU_List, endDate);
        end else
            Error('This compnay does not have bussines units specified. This process can only run in consolidation compnay');
    end;

    local procedure testSetup()
    var
        genLedgSetup: Record "General Ledger Setup";
        genJnlBatches: Record "Gen. Journal Batch";
        genJnl: Record "Gen. Journal Line";
    begin
        genLedgSetup.Get();
        genLedgSetup.TestField("Eliminating GL account Debit");
        genLedgSetup.TestField("Eliminating GL account Credit");
        genLedgSetup.TestField("Eliminating GL account Debit-n");
        genLedgSetup.TestField("Eliminating GL account Creditn");
        genLedgSetup.TestField("Eliminating Gen. Journal");

        genJnlBatches.Reset();
        genJnlBatches.SetFilter("Template Type", '%1', genJnlBatches."Template Type"::General);
        genJnlBatches.SetFilter(Name, '%1', genLedgSetup."Eliminating Gen. Journal");
        if genJnlBatches.FindFirst() then begin
            genJnlBatches.TestField("No. Series");

            genJnl.Reset();
            genJnl.SetFilter("Journal Template Name", '%1', genJnlBatches."Journal Template Name");
            genJnl.SetFilter("Journal Batch Name", '%1', genJnlBatches.Name);
            if not genJnl.IsEmpty then
                Error('Please ensure that General Journal : %1 is empty before running this process.', genJnlBatches.Name);
        end else
            Error('Jounral Batch named: %1, does not exist. Please see Gen. Ledger Setup -> Eliminating Gen. Journal', genLedgSetup."Eliminating Gen. Journal");
    end;

    local procedure clearProfitEliminationTable()
    var
        profit_elimintaion: Record "IC Profit Elimination";
    begin
        profit_elimintaion.Reset();
        profit_elimintaion.DeleteAll(true);
        en := 0;
    end;

    local procedure insertElimination(BU_Code: Code[20]; ILE_EntryNo: Integer; SourceNo: Code[20]; PostingDate: Date; LotNo: Code[50]; itemNo: code[20]; remQty: decimal; ProfitIC: Decimal; unitCost: Decimal; totalValue: Decimal; UnrealizedProfit: Decimal; CompanyName: Text[30]; scenario: Integer)
    var
        profit_elimintaion: Record "IC Profit Elimination";
        profit_elimintaion_Entries: Record "IC Profit Elimination";
    begin
        profit_elimintaion_Entries.SetFilter(entryNo, '%1', ILE_EntryNo);
        profit_elimintaion_Entries.SetFilter("Bussines Unit", '%1', BU_Code);
        if profit_elimintaion_Entries.IsEmpty then begin
            en += 1;
            profit_elimintaion."Bussines Unit" := BU_Code;
            profit_elimintaion.entryNo := ILE_EntryNo;
            profit_elimintaion."IC Source No." := SourceNo;
            profit_elimintaion.postingDate := PostingDate;
            profit_elimintaion."Lot No." := LotNo;
            profit_elimintaion."Item No." := itemNo;
            profit_elimintaion."Remaining Quantity" := remQty;
            profit_elimintaion."Profit % IC" := ProfitIC;
            profit_elimintaion.unitCost := unitCost;
            profit_elimintaion.totalValue := totalValue;
            profit_elimintaion."Unrealized Profit" := UnrealizedProfit;
            profit_elimintaion.BU_CompName := CompanyName;
            profit_elimintaion.Scenario := scenario;
            profit_elimintaion.EN := en;
            profit_elimintaion.Insert(true);
        end;
    end;

    local procedure preapareGenJnl_To_Post(BU_List: List of [Text]; endDate: Date)
    var
        profit_elimintaion: Record "IC Profit Elimination";
        genLedgSetup: Record "General Ledger Setup";
        genJnlBatches: Record "Gen. Journal Batch";
        genLedgEntry: Record "G/L Entry";
        genJnl: Record "Gen. Journal Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        lastGLEntryNo: Integer;
        JnlDocNo: Code[20];
        bu: Text;
    begin
        genLedgSetup.Get();

        profit_elimintaion.Reset();
        if profit_elimintaion.FindFirst() then begin
            genJnlBatches.Reset();
            genJnlBatches.SetFilter("Template Type", '%1', genJnlBatches."Template Type"::General);
            genJnlBatches.SetFilter(Name, '%1', genLedgSetup."Eliminating Gen. Journal");
            if genJnlBatches.FindFirst() then begin
                JnlDocNo := NoSeriesMgt.GetNextNo(genJnlBatches."No. Series", 0D, TRUE);

                foreach bu in BU_List do begin
                    profit_elimintaion.Reset();
                    profit_elimintaion.SetFilter("Bussines Unit", '%1', bu);
                    if profit_elimintaion.FindSet(false) then begin
                        profit_elimintaion.CalcSums("Unrealized Profit");

                        //if amount is negative use another set of gl acounts from setup that are only used for negative amounts
                        if profit_elimintaion."Unrealized Profit" < 0 then begin
                            insertGenJnlLine(genJnlBatches, JnlDocNo, bu, endDate, genLedgSetup."Eliminating GL account Debit-n", profit_elimintaion."Unrealized Profit" * -1);
                            insertGenJnlLine(genJnlBatches, JnlDocNo, bu, endDate, genLedgSetup."Eliminating GL account Creditn", profit_elimintaion."Unrealized Profit");
                        end else begin
                            insertGenJnlLine(genJnlBatches, JnlDocNo, bu, endDate, genLedgSetup."Eliminating GL account Debit", profit_elimintaion."Unrealized Profit");
                            insertGenJnlLine(genJnlBatches, JnlDocNo, bu, endDate, genLedgSetup."Eliminating GL account Credit", profit_elimintaion."Unrealized Profit" * -1);
                        end;
                    end;
                end;

                lastGLEntryNo := 0;
                genLedgEntry.Reset();
                genLedgEntry.SetFilter("IC Elimination", '%1', true);
                if genLedgEntry.FindLast() then
                    lastGLEntryNo := genLedgEntry."Entry No.";

                genJnl.Reset();
                genJnl.SetFilter("Journal Template Name", '%1', genJnlBatches."Journal Template Name");
                genJnl.SetFilter("Journal Batch Name", '%1', genJnlBatches.Name);
                if genJnl.FindSet(true) then
                    CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", genJnl);

                genLedgEntry.Reset();
                genLedgEntry.SetFilter("IC Elimination", '%1', true);
                if genLedgEntry.FindLast() then
                    if lastGLEntryNo < genLedgEntry."Entry No." then
                        reversePreviusICEliminations(lastGLEntryNo);

                genJnl.Reset();
                genJnl.SetFilter("Journal Template Name", '%1', genJnlBatches."Journal Template Name");
                genJnl.SetFilter("Journal Batch Name", '%1', genJnlBatches.Name);
                if genJnl.FindSet(true) then
                    genJnl.DeleteAll(true);
            end;
        end;
    end;

    local procedure reversePreviusICEliminations(lastGLEntryNo: Integer)
    var
        genLedgEntry: Record "G/L Entry";
    begin
        genLedgEntry.SetFilter("Entry No.", '..%1', lastGLEntryNo);
        genLedgEntry.SetFilter("IC Elimination", '%1', true);
        genLedgEntry.SetFilter("IC Elimination Reversed", '%1', false);
        if genLedgEntry.FindSet(true) then
            repeat
                genLedgEntry.Amount := 0;
                genLedgEntry."VAT Amount" := 0;
                genLedgEntry."Debit Amount" := 0;
                genLedgEntry."Credit Amount" := 0;
                genLedgEntry."Additional-Currency Amount" := 0;
                genLedgEntry."Add.-Currency Debit Amount" := 0;
                genLedgEntry."Add.-Currency Credit Amount" := 0;
                genLedgEntry."IC Elimination Reversed" := true;
                genLedgEntry.Modify(true);
            until genLedgEntry.Next() = 0;
        Message('Reversing Prevous GL : ' + Format(format(lastGLEntryNo)));
    end;

    local procedure insertGenJnlLine(genJnlBatches: Record "Gen. Journal Batch"; jnlDocNo: code[20]; "BU Code": code[20]; endDate: Date; EliminatingGL: Text[20]; "Unrealized Profit": Decimal)
    var
        genJnl: Record "Gen. Journal Line";
    begin
        genJnl.validate("Journal Template Name", genJnlBatches."Journal Template Name");
        genJnl.validate("Journal Batch Name", genJnlBatches.Name);
        genJnl.Validate("Document No.", jnlDocNo);
        genJnl.validate("Line No.", lineNo);
        genJnl.Insert(true);

        genJnl.validate("Posting Date", endDate);
        genJnl.validate("Business Unit Code", "BU Code");
        genJnl.validate("Account Type", genJnl."Account Type"::"G/L Account");
        genJnl.Validate("Account No.", EliminatingGL);
        genJnl.Validate(Amount, "Unrealized Profit");
        genJnl.Description := genJnl.Description;
        genJnl."IC Elimination" := true;
        genJnl.Modify(true);

        lineNo += 10000;
    end;

    local procedure CheckScenario5(bussinesUnit: Record "Business Unit"; startDate: Date; endDate: Date)
    var
        ICPartner: Record "IC Partner";
        itemLedgerEntires: Record "Item Ledger Entry";
        valEntry: Record "Value Entry";
        unitCost: Decimal;
        totalValue: Decimal;
        "Unrealized Profit": Decimal;
        "Profit % IC": Decimal;
    begin
        //Scenario 5 IC Purchase orders  also covering scenario no.3
        ICPartner.Reset();
        ICPartner.ChangeCompany(bussinesUnit."Company Name");
        ICPartner.SetFilter("Vendor No.", '<>%1', '');
        if ICPartner.FindSet(false) then
            repeat
                ICPartner.TestField("Default Profit %");

                itemLedgerEntires.Reset();
                itemLedgerEntires.CHANGECOMPANY(bussinesUnit."Company Name");
                itemLedgerEntires.SetFilter("Posting Date", '%1..%2', startDate, endDate);
                itemLedgerEntires.SetFilter("Remaining Quantity", '<>%1', 0);
                itemLedgerEntires.SetFilter("Source Type", '%1', itemLedgerEntires."Source Type"::Vendor);
                itemLedgerEntires.SetFilter("Source No.", '%1', ICPartner."Vendor No.");
                if itemLedgerEntires.FindSet(false) then
                    repeat
                        unitCost := 0;
                        "Profit % IC" := 0;
                        "Unrealized Profit" := 0;

                        valEntry.Reset();
                        valEntry.CHANGECOMPANY(bussinesUnit."Company Name");
                        valEntry.SetFilter("Item Ledger Entry No.", '%1', itemLedgerEntires."Entry No.");
                        valEntry.SetFilter("Item Charge No.", '%1', '');
                        if valEntry.FindSet(false) then begin
                            valEntry.CalcSums("Cost Amount (Actual)");
                            unitCost := valEntry."Cost Amount (Actual)" / itemLedgerEntires.Quantity;
                        end;

                        totalValue := itemLedgerEntires."Remaining Quantity" * unitCost;

                        if itemLedgerEntires."Profit % IC" <> 0 then
                            "Profit % IC" := itemLedgerEntires."Profit % IC"
                        else
                            "Profit % IC" := ICPartner."Default Profit %";

                        "Unrealized Profit" := calcUnrializedProfit(totalValue, "Profit % IC");
                        //(totalValue / (1 + ("Profit % IC" / 100))) * ("Profit % IC" / 100);

                        insertElimination(bussinesUnit.Code, itemLedgerEntires."Entry No.", itemLedgerEntires."Source No.", itemLedgerEntires."Posting Date", itemLedgerEntires."Lot No.", itemLedgerEntires."Item No.", itemLedgerEntires."Remaining Quantity", "Profit % IC", unitCost, totalValue, "Unrealized Profit", bussinesUnit."Company Name", 5);
                    until itemLedgerEntires.Next() = 0;
            until ICPartner.Next() = 0;
    end;

    local procedure CheckScenario1(bussinesUnit: Record "Business Unit"; startDate: Date; endDate: Date)
    var
        itemLedgerEntires_Transfers: Record "Item Ledger Entry";
        profit_elimintaion: Record "IC Profit Elimination";
        totalValue: Decimal;
        "Unrealized Profit": Decimal;
    begin
        //Scenario 1 look for transfers after scenario 5 found IC PO
        profit_elimintaion.SetFilter(Scenario, '%1', 5);
        if profit_elimintaion.FindFirst() then
            repeat
                itemLedgerEntires_Transfers.Reset();
                itemLedgerEntires_Transfers.CHANGECOMPANY(bussinesUnit."Company Name");
                itemLedgerEntires_Transfers.SetFilter("Posting Date", '%1..%2', startDate, endDate);
                itemLedgerEntires_Transfers.SetFilter("Document Type", '<>%1', itemLedgerEntires_Transfers."Document Type"::"Purchase Receipt");
                itemLedgerEntires_Transfers.SetFilter("Remaining Quantity", '<>%1', 0);
                itemLedgerEntires_Transfers.SetFilter("Lot No.", '%1', profit_elimintaion."Lot No.");
                itemLedgerEntires_Transfers.SetFilter("Item No.", '%1', profit_elimintaion."Item No.");
                if itemLedgerEntires_Transfers.FindSet(false) then
                    repeat
                        totalValue := 0;
                        "Unrealized Profit" := 0;

                        totalValue := itemLedgerEntires_Transfers."Remaining Quantity" * profit_elimintaion.unitCost;
                        "Unrealized Profit" := calcUnrializedProfit(totalValue, profit_elimintaion."Profit % IC");
                        //(totalValue / (1 + (profit_elimintaion."Profit % IC" / 100))) * (profit_elimintaion."Profit % IC" / 100);

                        insertElimination(bussinesUnit.Code, itemLedgerEntires_Transfers."Entry No.", itemLedgerEntires_Transfers."Source No.", itemLedgerEntires_Transfers."Posting Date", itemLedgerEntires_Transfers."Lot No.", itemLedgerEntires_Transfers."Item No.", itemLedgerEntires_Transfers."Remaining Quantity", profit_elimintaion."Profit % IC", profit_elimintaion.unitCost, totalValue, "Unrealized Profit", bussinesUnit."Company Name", 1);
                    until itemLedgerEntires_Transfers.Next() = 0;
            until profit_elimintaion.Next() = 0;
    end;

    local procedure CheckScenario4(bussinesUnit: Record "Business Unit"; startDate: Date; endDate: Date)
    var
        itemLedgerEntires_forRemoval: Record "Item Ledger Entry";
        profit_elimintaion: Record "IC Profit Elimination";
    begin
        //Remove PO (Scenario5) from IC Profit Elimination Table if normal non IC partner PO transaction exist in the same period
        //if it is an IC partners PO do not remove or apply scenario 4
        //loop trugh elimination table
        // search for POs with same lot no and item no in the same time period as filter set out then
        // if lot no and item no match
        // then remove record from elimination table
        //Message('Scenari 4 work in progress...');
        profit_elimintaion.SetFilter(Scenario, '%1', 5);
        if profit_elimintaion.FindFirst() then
            repeat
                itemLedgerEntires_forRemoval.Reset();
                itemLedgerEntires_forRemoval.CHANGECOMPANY(bussinesUnit."Company Name");
                itemLedgerEntires_forRemoval.SetFilter("Entry No.", '<>%1', profit_elimintaion.entryNo);
                itemLedgerEntires_forRemoval.SetFilter("Posting Date", '%1..%2', startDate, endDate);
                itemLedgerEntires_forRemoval.SetFilter("Document Type", '%1', itemLedgerEntires_forRemoval."Document Type"::"Purchase Receipt");
                itemLedgerEntires_forRemoval.SetFilter("Remaining Quantity", '<>%1', 0);
                itemLedgerEntires_forRemoval.SetFilter("Lot No.", '%1', profit_elimintaion."Lot No.");
                itemLedgerEntires_forRemoval.SetFilter("Item No.", '%1', profit_elimintaion."Item No.");
                if itemLedgerEntires_forRemoval.FindSet(false) then
                    repeat
                        if not Is_from_IC_PO(itemLedgerEntires_forRemoval."Source No.", bussinesUnit) then begin
                            profit_elimintaion."Unrealized Profit" := 0;
                            profit_elimintaion.Scenario := 4;
                            profit_elimintaion.Modify(true);
                        end;
                    until itemLedgerEntires_forRemoval.Next() = 0;
            until profit_elimintaion.Next() = 0;
    end;

    local procedure CheckScenario2(bussinesUnit: Record "Business Unit"; startDate: Date; endDate: Date)
    var
        itemLedgerEntires: Record "Item Ledger Entry";
        OG_ItemLedgerEntry: Record "Item Ledger Entry";
        ProfitPct_ItemLedgerEntry: Record "Item Ledger Entry";
        valEntry: Record "Value Entry";
        unitCost: Decimal;
        profitPct: Decimal;
        totalValue: Decimal;
        "Unrealized Profit": Decimal;
    begin
        //look for transfer orders that happend in selected period if they originate from IC partner PO. Meaning there is no PO in elimination table yet becuase po is out of date range
        itemLedgerEntires.Reset();
        itemLedgerEntires.CHANGECOMPANY(bussinesUnit."Company Name");
        itemLedgerEntires.SetFilter("Remaining Quantity", '<>%1', 0);
        itemLedgerEntires.SetFilter("Posting Date", '%1..%2', startDate, endDate);
        itemLedgerEntires.SetFilter("Document Type", '<>%1', itemLedgerEntires."Document Type"::"Purchase Receipt");
        if itemLedgerEntires.FindSet(false) then
            repeat
                OG_ItemLedgerEntry.Reset();
                OG_ItemLedgerEntry.CHANGECOMPANY(bussinesUnit."Company Name");
                //OG_ItemLedgerEntry.SetFilter("Posting Date", '..%1', startDate);
                OG_ItemLedgerEntry.SetFilter("Lot No.", '%1', itemLedgerEntires."Lot No.");
                OG_ItemLedgerEntry.SetFilter("Item No.", '%1', itemLedgerEntires."Item No.");
                OG_ItemLedgerEntry.SetFilter("Source Type", '%1', OG_ItemLedgerEntry."Source Type"::Vendor);
                OG_ItemLedgerEntry.SetFilter("Source No.", '<>%1', '');
                //if OG_ItemLedgerEntry.FindSet(false) then
                if OG_ItemLedgerEntry.FindFirst() then
                    //repeat
                    if Is_from_IC_PO(OG_ItemLedgerEntry."Source No.", bussinesUnit) then begin
                        unitCost := 0;
                        profitPct := 0;
                        "Unrealized Profit" := 0;

                        valEntry.Reset();
                        valEntry.CHANGECOMPANY(bussinesUnit."Company Name");
                        valEntry.SetFilter("Item Ledger Entry No.", '%1', itemLedgerEntires."Entry No.");
                        valEntry.SetFilter("Item Charge No.", '%1', '');
                        if valEntry.FindSet(false) then begin
                            valEntry.CalcSums("Cost Amount (Actual)");
                            unitCost := valEntry."Cost Amount (Actual)" / itemLedgerEntires.Quantity;
                        end;

                        totalValue := itemLedgerEntires."Remaining Quantity" * unitCost;

                        ProfitPct_ItemLedgerEntry.Reset();
                        ProfitPct_ItemLedgerEntry.SetCurrentKey("Posting Date");
                        ProfitPct_ItemLedgerEntry.CHANGECOMPANY(bussinesUnit."Company Name");
                        ProfitPct_ItemLedgerEntry.SetFilter("Posting Date", '..%1', endDate);
                        ProfitPct_ItemLedgerEntry.SetFilter("Lot No.", '%1', itemLedgerEntires."Lot No.");
                        ProfitPct_ItemLedgerEntry.SetFilter("Item No.", '%1', itemLedgerEntires."Item No.");
                        ProfitPct_ItemLedgerEntry.SetFilter("Source Type", '%1', OG_ItemLedgerEntry."Source Type"::Vendor);
                        ProfitPct_ItemLedgerEntry.SetFilter("Source No.", '<>%1', '');
                        ProfitPct_ItemLedgerEntry.SetFilter("Profit % IC", '<>%1', 0);
                        if ProfitPct_ItemLedgerEntry.FindLast() then
                            profitPct := ProfitPct_ItemLedgerEntry."Profit % IC"
                        else
                            profitPct := profit_from_IC(OG_ItemLedgerEntry."Source No.", bussinesUnit);
                        "Unrealized Profit" := calcUnrializedProfit(totalValue, profitPct);

                        insertElimination(bussinesUnit.Code, itemLedgerEntires."Entry No.", itemLedgerEntires."Source No.", itemLedgerEntires."Posting Date", itemLedgerEntires."Lot No.", itemLedgerEntires."Item No.", itemLedgerEntires."Remaining Quantity", profitPct, unitCost, totalValue, "Unrealized Profit", bussinesUnit."Company Name", 2);
                    end;
            //until OG_ItemLedgerEntry.Next() = 0;
            until itemLedgerEntires.Next() = 0;
    end;

    local procedure Is_from_IC_PO("Source No": Code[20]; bussinesUnit: Record "Business Unit"): Boolean
    var
        ICPartner: Record "IC Partner";
    begin
        ICPartner.Reset();
        ICPartner.CHANGECOMPANY(bussinesUnit."Company Name");
        ICPartner.SetFilter("Vendor No.", '%1', "Source No");
        if ICPartner.FindFirst() then
            exit(true)
        else
            exit(false);
    end;

    local procedure profit_from_IC("Source No": Code[20]; bussinesUnit: Record "Business Unit"): Decimal
    var
        ICPartner: Record "IC Partner";
    begin
        ICPartner.Reset();
        ICPartner.CHANGECOMPANY(bussinesUnit."Company Name");
        ICPartner.SetFilter("Vendor No.", '%1', "Source No");
        if ICPartner.FindFirst() then begin
            ICPartner.TestField("Default Profit %");
            exit(ICPartner."Default Profit %")
        end else
            Error('Could not find IC partner: %1 in compnay %2', "Source No", bussinesUnit);
    end;

    local procedure calcUnrializedProfit(totalValue: Decimal; ProfitICpct: Decimal): Decimal
    begin
        if (totalValue <> 0) and (ProfitICpct <> 0) then begin
            if ProfitICpct > 0 then
                exit((totalValue / (1 + (ProfitICpct / 100))) * (ProfitICpct / 100))
            else
                exit((totalValue / (1 - (ProfitICpct / 100))) * (ProfitICpct / 100))
        end else
            exit(0);
    end;

    procedure forceSecnario4()
    var
        ile: Record "Item Ledger Entry";
    begin
        if ile.get('51693') then begin
            ile."Lot No." := '0701321010001@302-06962157-21';
            ile."Item No." := 'IT0001228';
            ile.Modify(false);
        end;
    end;

    var
        lineNo: Integer;
        en: Integer;
}