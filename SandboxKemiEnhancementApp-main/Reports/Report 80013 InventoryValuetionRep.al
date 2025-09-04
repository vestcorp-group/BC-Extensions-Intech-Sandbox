report 80013 InventoryValuetionRep//T12370-Full Comment T12946-Code Uncommented
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Inventory Valuation Report';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Layout_80013_InventoryvaluetionRep.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            PrintOnlyIfDetail = true;

            column(CompanyNameSorting; CompanyNameSorting) { }
            column(ItemNameSorting; ItemNameSorting) { }
            column(UOMSorting; UOMSorting) { }
            // column(QuantityOption; QuantityG)
            // { }
            column(Number; Number) { }
            column(AsOfDateParameterValue; AsOfDateParameterValue) { }
            column(Company_Name_; ShortNameCom."Short Name")
            { }
            column(SelectedCompanyName; SelectedCompanyName) { }
            column(GrandTotal; GrandTotal)
            { }
            dataitem(Item; Item)
            {
                DataItemTableView = sorting("No.");
                PrintOnlyIfDetail = true;
                column(Item_No; "No.")
                {
                    IncludeCaption = true;
                }
                column(Description; Description)
                { }
                // column(QuantityOption; QuantityG)
                // { }
                column(Search_Description; "Search Description")
                { }
                column(Safety_Stock_Quantity; "Safety Stock Quantity") { }
                column(Qty_On_Purch_Order; QtyInTransitG) { }
                // column(UnitCost2; UnitCost2) { }

                column(Reserved_Quantity; ReservedQty)
                { }
                column(Base_Unit_of_Measure; "Base Unit of Measure") { }


                dataitem(DataItem1; "Item Ledger Entry")
                {
                    DataItemLink = "Item No." = field("No.");
                    // DataItemTableView = sorting("Item No.");
                    // UseTemporary = true;
                    CalcFields = "Reserved Quantity";
                    column(Item_No_; "Item No.")
                    { }
                    column(Quantity; Round(Quantity, 0.00001))//Format(Quantity, 0, '<Precision,2:2><Standard Format,0>'))
                    {
                        DecimalPlaces = 2;
                    }
                    column(QuantityOption; QuantityG)
                    { }
                    column(UnitCost2; UnitCost2) { }
                    // column(Reserved_Quantity; "Reserved Quantity")
                    // { }
                    column(Unit_of_Measure_Code; Item."Base Unit of Measure")//"Unit of Measure Code")
                    { }
                    column(decimalboolean; decimalboolean) { }
                    column(EntryNo_; SlNoG) { }


                    trigger OnPreDataItem() //DataItem1
                    var
                    begin
                        DataItem1.ChangeCompany(SelectedComapny[Integer.Number]);
                        DataItem1.SetFilter("Posting Date", '<=' + Format(AsOfDate));

                        if CompanyNameSorting = true then
                            DataItem1.SetCurrentKey(Description);

                        if UOMSorting = true then
                            DataItem1.SetCurrentKey("Unit of Measure Code");
                    end;

                    trigger OnAfterGetRecord()
                    var
                        PurchLineL: Record "Purchase Line";
                        ILE: Record "Item Ledger Entry";
                        ILE2: Record "Item Ledger Entry";
                        Invent: Decimal;
                        DateForReserved: Date;
                        UnitofMeasure: Record "Unit of Measure";
                        ItemRec: Record Item;

                    Begin
                        SlNoG += 1;
                        Clear(QtyInTransitG);
                        Clear(ReservedQty);
                        Clear(Invent);


                        if ItemNoCode <> Item."No." then begin
                            ItemNoCode := Item."No.";
                            ILE.Reset();
                            ILE.ChangeCompany(SelectedComapny[Integer.Number]);
                            ILE.SetRange("Item No.", Item."No.");
                            ILE.SetFilter("Posting Date", '<=' + Format(AsOfDate));
                            ILE.CalcSums(Quantity);
                            Invent := ILE.Quantity;
                            ILE2.Reset();
                            ILE2.ChangeCompany(SelectedComapny[Integer.Number]);
                            ILE2.SetRange("Item No.", Item."No.");
                            // ILE2.SetFilter("Posting Date", '%1..%2', 0D, DateForReserved);
                            if ILE2.FindSet() then begin
                                repeat
                                    ILE2.CalcFields(ILE2."Reserved Quantity");
                                    ReservedQty += ILE2."Reserved Quantity";
                                Until ILE2.Next() = 0;
                            end;
                            //if Invent = 0 then
                            //    ReservedQty := 0;

                            PurchLineL.ChangeCompany(SelectedComapny[Integer.Number]);
                            PurchLineL.SetCurrentKey("Document Type", "Document No.", "Line No.", "No.");
                            PurchLineL.SetRange("Document Type", PurchLineL."Document Type"::Order);
                            PurchLineL.SetRange("No.", Item."No.");
                            PurchLineL.SetFilter(CustomR_ETD, '<=%1', WorkDate());
                            PurchLineL.SetFilter(CustomR_ETA, '>%1', WorkDate());
                            if PurchLineL.FindSet() then begin
                                PurchLineL.CalcSums("Quantity (Base)");
                                PurchLineL.CalcSums("Qty. Received (Base)");
                                QtyInTransitG := PurchLineL."Quantity (Base)" - PurchLineL."Qty. Received (Base)";
                            end;
                        end;

                        clear(UnitCost2);

                        AverageCostCalcOverview.Reset();
                        AverageCostCalcOverview.ChangeCompany(SelectedComapny[Integer.Number]);
                        AverageCostCalcOverview.SetRange("Item No.", DataItem1."Item No.");
                        AverageCostCalcOverview.SetRange("Valuation Date", 0D, AsOfDate);
                        if AverageCostCalcOverview.FindLast() then begin
                            if AverageCostCalcOverview.Quantity <> 0 then
                                UnitCost2 := Round((AverageCostCalcOverview."Cost Amount (Actual)" + AverageCostCalcOverview."Cost Amount (Expected)") / AverageCostCalcOverview.Quantity, 0.01)
                            else
                                UnitCost2 := Round(Item."Unit Cost", 0.01);
                        end
                        else
                            UnitCost2 := Round(Item."Unit Cost", 0.01);

                        //UK::09062020>>
                        decimalboolean := FALSE;
                        if (UnitofMeasure.Get(Item."Base Unit of Measure")) AND (UnitofMeasure."Decimal Allowed") then
                            decimalboolean := TRUE;

                        //UK::09062020<<

                    End;
                }

                trigger OnPreDataItem() // Item
                var
                begin
                    Item.ChangeCompany(SelectedComapny[Integer.Number]);

                    ShortNameCom.Get(SelectedComapny[Integer.Number]);


                    if ItemNameSorting = true then
                        Item.SetCurrentKey("Search Description");

                    if ItemCategory <> '' then
                        Item.SetFilter("Item Category Code", ItemCategory);

                    if InventoryPostingGroup <> '' then
                        Item.SetFilter("Inventory Posting Group", InventoryPostingGroup)
                    else
                        Item.SetFilter("Inventory Posting Group", '<>%1', 'SAMPLE');

                    if ItemNo <> '' then
                        Item.SetFilter("No.", ItemNo);


                    Clear(ItemNoCode);
                    clear(ItemCode2);

                end;

                trigger OnAfterGetRecord() // Item
                var
                    ILERec: Record "Item Ledger Entry";
                    Invtry: Decimal;


                begin
                    //Gk
                    Clear(QtyInTransitG);
                    clear(UnitCost2);
                    Clear(ReservedQty);
                    Clear(Invtry);
                    CLEAR(decimalboolean);
                    // if QuantityG = false then begin
                    //     if ItemCode2 <> Item."No." then begin
                    //         ItemCode2 := Item."No.";
                    //         ILERec.Reset();
                    //         ILERec.ChangeCompany(SelectedComapny[Integer.Number]);
                    //         ILERec.SetRange("Item No.", Item."No.");
                    //         ILERec.SetFilter("Posting Date", '<=' + Format(AsOfDate));
                    //         if ILERec.FindSet() then begin
                    //             ILERec.CalcSums(Quantity);
                    //             Invtry := ILERec.Quantity;
                    //             if Invtry <= 0 then
                    //                 CurrReport.Skip();
                    //         end;
                    //     end;
                    // end;

                end;

            }
            trigger OnPreDataItem() // Integer
            var
            begin
                AsOfDateParameterValue := AsOfDate;
                SetRange(Number, 1, CountCompRec);
            end;

            trigger OnAfterGetRecord() // Integer
            var
                ItemLedgerEntryG: Record "Item Ledger Entry";
                EntryNo: Integer;
                CompanyShortNameRec: Record "Company Short Name";
                ItemRec: Record Item;

            begin
                ItemRec.reset;
                ItemRec.ChangeCompany(SelectedComapny[Integer.Number]);
                if ItemRec.FindSet() then
                    SelectedComapny[Integer.Number] := SelectedComapny[Integer.Number]
                else
                    CurrReport.skip;

                ItemLedgerEntryG.reset;
                ItemLedgerEntryG.ChangeCompany(SelectedComapny[Integer.Number]);
                if ItemLedgerEntryG.FindSet() then
                    SelectedComapny[Integer.Number] := SelectedComapny[Integer.Number]
                else
                    CurrReport.skip;
            end;

        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group("Sorting Option")
                {
                    field("Company Name Sorting"; CompanyNameSorting)
                    {
                        ApplicationArea = All;
                    }
                    field("Item Name Sorting"; ItemNameSorting)
                    {
                        ApplicationArea = All;
                    }
                    field("UOM Sorting"; UOMSorting)
                    {
                        ApplicationArea = All;
                    }

                    field("Include Item With Quantity 0"; QuantityG)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Filter Option")
                {
                    field(AsOfDate; AsOfDate)
                    {
                        ApplicationArea = All;
                        Caption = 'As of';
                    }

                    field("Company Group"; CompanyGroup)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        var
                            CompanyShortNameRec1: Record "Company Short Name";
                        begin
                            if CompanyGroup = '' then begin
                                CompanyShortNameRec1.Reset();
                                CompanyShortNameRec1.SetRange(Select, true);
                                if CompanyShortNameRec1.FindSet() then
                                    CompanyShortNameRec1.ModifyAll(Select, false);
                            end else
                                if CompanyGroup <> '' then begin
                                    CompanyShortNameRec1.Reset();
                                    CompanyShortNameRec1.SetRange(Select, true);
                                    if CompanyShortNameRec1.FindSet() then
                                        CompanyShortNameRec1.ModifyAll(Select, false);
                                    if TextManagement.MakeTextFilter(CompanyGroup) = 0 then;
                                    CompanyShortNameRec1.Reset();
                                    CompanyShortNameRec1.SetFilter(Name, CompanyGroup);
                                    if CompanyShortNameRec1.FindSet() then
                                        CompanyShortNameRec1.ModifyAll(Select, true);
                                end;
                        end;

                        trigger OnDrillDown()
                        var
                            CompanySelectionPage: Page 80006;
                            CompanyShortName: Record "Company Short Name";
                            CompanyShortName1: Record "Company Short Name";
                            I: Integer;
                        begin
                            if CompanyGroup <> '' then begin
                                CompanyShortName1.Reset();
                                CompanyShortName1.SetRange(Select, true);
                                if CompanyShortName1.FindSet() then
                                    CompanyShortName1.ModifyAll(Select, false);
                                if TextManagement.MakeTextFilter(CompanyGroup) = 0 then;
                                CompanyShortName1.Reset();
                                CompanyShortName1.SetFilter(Name, CompanyGroup);
                                if CompanyShortName1.FindSet() then
                                    CompanyShortName1.ModifyAll(Select, true);
                            end;
                            Commit();
                            // Clear(CompanySelectionPage);
                            // CompanySelectionPage.Editable(true);
                            // CompanySelectionPage.LookupMode(True);
                            // // CompanySelectionPage.Editable(true);
                            // CompanySelectionPage.SetRecord(CompanyShortName);
                            // if CompanySelectionPage.RunModal() = Action::LookupOK then begin
                            //     CompanySelectionPage.GetRecord(CompanyShortName);

                            //UK::09062020>>
                            // if Page.RunModal(80006, CompanyShortName) = Action::LookupOK then begin

                            CompanySelectionPage.SetTableView(CompanyShortName);
                            CompanySelectionPage.Editable(true);
                            if CompanySelectionPage.RunModal() = Action::OK then begin
                                //UK::09062020<<
                                Clear(CompanyGroup);
                                Clear(I);
                                CompanyShortName.Reset();
                                CompanyShortName.SetRange(Select, true);
                                if CompanyShortName.FindSet() then begin
                                    Clear(CompanyGroup);
                                    repeat
                                        CompanyGroup += CompanyShortName.Name + '|';
                                    until CompanyShortName.Next() = 0;
                                end;
                                if StrLen(CompanyGroup) <> 0 then begin
                                    I := StrLen(CompanyGroup);
                                    CompanyGroup := DelStr(CompanyGroup, I);
                                end;

                                if CompanyGroup <> '' then
                                    if TextManagement.MakeTextFilter(CompanyGroup) = 0 then;
                            end;
                        end;
                    }
                    field("Item Category"; ItemCategory)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        var
                            ItemCategoryRec1: Record "Item Category";
                        Begin
                            if ItemCategory = '' then begin
                                ItemCategoryRec1.Reset();
                                ItemCategoryRec1.SetRange(Select, true);
                                if ItemCategoryRec1.FindSet() then
                                    ItemCategoryRec1.ModifyAll(Select, false);
                            end
                            else
                                if ItemCategory <> '' then begin
                                    if TextManagement.MakeTextFilter(ItemCategory) = 0 then;
                                    ItemCategoryRec1.Reset();
                                    ItemCategoryRec1.SetRange(Select, true);
                                    if ItemCategoryRec1.FindSet() then
                                        ItemCategoryRec1.ModifyAll(Select, false);
                                    ItemCategoryRec1.Reset();
                                    ItemCategoryRec1.SetFilter(Code, ItemCategory);
                                    if ItemCategoryRec1.FindSet() then
                                        ItemCategoryRec1.ModifyAll(Select, True);
                                end;
                        End;

                        trigger OnDrillDown()
                        var
                            ItemCategoryPage: Page 80004;
                            ItemCategoryRec: Record "Item Category";
                            ItemCategoryRec1: Record "Item Category";
                            I: Integer;
                        begin
                            if ItemCategory <> '' then begin
                                if TextManagement.MakeTextFilter(ItemCategory) = 0 then;
                                ItemCategoryRec1.Reset();
                                ItemCategoryRec1.SetRange(Select, true);
                                if ItemCategoryRec1.FindSet() then
                                    ItemCategoryRec1.ModifyAll(Select, false);
                                ItemCategoryRec1.Reset();
                                ItemCategoryRec1.SetFilter(Code, ItemCategory);
                                if ItemCategoryRec1.FindSet() then
                                    ItemCategoryRec1.ModifyAll(Select, True);
                            end;
                            Commit();
                            // Clear(ItemCategoryPage);
                            // ItemCategoryPage.LookupMode(true);
                            // ItemCategoryPage.Editable(true);
                            // ItemCategoryPage.SetRecord(ItemCategoryRec);
                            // // ItemCategoryPage.SetTableView(ItemCategoryRec);
                            // if ItemCategoryPage.RunModal() = Action::LookupOK then begin
                            //     ItemCategoryPage.GetRecord(ItemCategoryRec);
                            //UK::09062020>>
                            // if Page.RunModal(80004, ItemCategoryRec) = Action::LookupOK then begin
                            ItemCategoryPage.SetTableView(ItemCategoryRec);
                            ItemCategoryPage.Editable(true);
                            if ItemCategoryPage.RunModal() = Action::OK then begin
                                //UK::09062020<<
                                Clear(ItemCategory);
                                Clear(I);

                                ItemCategoryRec.Reset();
                                ItemCategoryRec.SetRange(Select, true);
                                if ItemCategoryRec.FindSet() then begin
                                    Clear(ItemCategory);
                                    repeat
                                        ItemCategory += Format(ItemCategoryRec.Code) + '|';
                                    until ItemCategoryRec.Next() = 0;
                                end;
                                if StrLen(ItemCategory) <> 0 then begin
                                    I := StrLen(ItemCategory);
                                    ItemCategory := DelStr(ItemCategory, I);
                                end;
                                if ItemCategory <> '' then
                                    if TextManagement.MakeTextFilter(ItemCategory) = 0 then;
                            end;
                        end;
                    }
                    field("Inventory Posting Group"; InventoryPostingGroup)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        var
                            InventoryPostingGroupRec1: Record "Inventory Posting Group";
                        begin
                            if InventoryPostingGroup = '' then begin
                                InventoryPostingGroupRec1.Reset();
                                InventoryPostingGroupRec1.SetRange(Select, true);
                                if InventoryPostingGroupRec1.FindSet() then
                                    InventoryPostingGroupRec1.ModifyAll(Select, false);
                            end
                            else
                                if InventoryPostingGroup <> '' then begin
                                    InventoryPostingGroupRec1.Reset();
                                    InventoryPostingGroupRec1.SetRange(Select, true);
                                    if InventoryPostingGroupRec1.FindSet() then
                                        InventoryPostingGroupRec1.ModifyAll(Select, false);
                                    if TextManagement.MakeTextFilter(InventoryPostingGroup) = 0 then;
                                    InventoryPostingGroupRec1.Reset();
                                    InventoryPostingGroupRec1.SetFilter(Code, InventoryPostingGroup);
                                    if InventoryPostingGroupRec1.FindSet() then
                                        InventoryPostingGroupRec1.ModifyAll(Select, true);
                                end;
                        end;

                        trigger OnDrillDown()
                        var
                            InventoryPostingGroupPage: Page 80005;
                            InventoryPostingGroupRec: Record "Inventory Posting Group";
                            InventoryPostingGroupRec1: Record "Inventory Posting Group";
                            I: Integer;
                        begin

                            if InventoryPostingGroup <> '' then begin
                                InventoryPostingGroupRec1.Reset();
                                InventoryPostingGroupRec1.SetRange(Select, true);
                                if InventoryPostingGroupRec1.FindSet() then
                                    InventoryPostingGroupRec1.ModifyAll(Select, false);
                                if TextManagement.MakeTextFilter(InventoryPostingGroup) = 0 then;
                                InventoryPostingGroupRec1.Reset();
                                InventoryPostingGroupRec1.SetFilter(Code, InventoryPostingGroup);
                                if InventoryPostingGroupRec1.FindSet() then
                                    InventoryPostingGroupRec1.ModifyAll(Select, true);
                            end;
                            Commit();
                            // clear(InventoryPostingGroupPage);
                            // InventoryPostingGroupPage.LookupMode(true);
                            // InventoryPostingGroupPage.SetRecord(InventoryPostingGroupRec);
                            // // InventoryPostingGroupPage.SetTableView(InventoryPostingGroupRec);
                            // InventoryPostingGroupPage.Editable(true);
                            // if InventoryPostingGroupPage.RunModal() = Action::LookupOK then begin
                            //     InventoryPostingGroupPage.GetRecord(InventoryPostingGroupRec);
                            //UK::09062020>>
                            //if Page.RunModal(80005, InventoryPostingGroupRec) = Action::LookupOK then begin
                            InventoryPostingGroupPage.SetTableView(InventoryPostingGroupRec);
                            InventoryPostingGroupPage.Editable(true);
                            if InventoryPostingGroupPage.RunModal() = Action::OK then begin
                                //UK::09062020<<
                                InventoryPostingGroupRec.Reset();
                                InventoryPostingGroupRec.SetRange(Select, true);
                                if InventoryPostingGroupRec.FindSet() then begin
                                    Clear(InventoryPostingGroup);
                                    repeat
                                        InventoryPostingGroup += Format(InventoryPostingGroupRec.Code) + '|';
                                    until InventoryPostingGroupRec.Next() = 0;
                                end;
                                if StrLen(InventoryPostingGroup) <> 0 then begin
                                    I := StrLen(InventoryPostingGroup);
                                    InventoryPostingGroup := DelStr(InventoryPostingGroup, I);
                                end;

                                if InventoryPostingGroup <> '' then
                                    if TextManagement.MakeTextFilter(InventoryPostingGroup) = 0 then;
                            end;
                        end;
                    }
                    field("Item No."; ItemNo)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        var
                            ItemRec1: Record Item;
                        begin
                            if ItemNo = '' then begin
                                ItemRec1.Reset();
                                ItemRec1.SetRange(Select, true);
                                if ItemRec1.FindSet() then
                                    ItemRec1.ModifyAll(Select, false);
                            end
                            else
                                if ItemNo <> '' then begin
                                    ItemRec1.Reset();
                                    ItemRec1.SetRange(Select, true);
                                    if ItemRec1.FindSet() then
                                        ItemRec1.ModifyAll(Select, false);
                                    if TextManagement.MakeTextFilter(ItemNo) = 0 then;
                                    ItemRec1.Reset();
                                    ItemRec1.SetFilter("No.", ItemNo);
                                    if ItemRec1.FindSet() then
                                        ItemRec1.ModifyAll(Select, true);
                                end;
                        end;

                        trigger OnDrillDown()
                        var
                            ItemSeleCtionPage: Page 80003;
                            ItemRec: Record Item;
                            ItemRec1: Record Item;
                            I: Integer;
                        Begin
                            if ItemNo <> '' then begin
                                ItemRec1.Reset();
                                ItemRec1.SetRange(Select, true);
                                if ItemRec1.FindSet() then
                                    ItemRec1.ModifyAll(Select, false);
                                if TextManagement.MakeTextFilter(ItemNo) = 0 then;
                                ItemRec1.Reset();
                                ItemRec1.SetFilter("No.", ItemNo);
                                if ItemRec1.FindSet() then
                                    ItemRec1.ModifyAll(Select, true);
                            end;
                            Commit();

                            if ItemCategory <> '' then
                                ItemRec.SetFilter("Item Category Code", ItemCategory);
                            if InventoryPostingGroup <> '' then
                                ItemRec.SetFilter("Inventory Posting Group", InventoryPostingGroup);
                            if ItemRec.FindSet() then begin
                                // Clear(ItemSeleCtionPage);
                                // ItemSeleCtionPage.LookupMode(true);
                                // ItemSeleCtionPage.SetRecord(ItemRec);
                                // // ItemSeleCtionPage.SetTableView(ItemRec);
                                // ItemSeleCtionPage.Editable(true);
                                // if ItemSeleCtionPage.RunModal() = Action::LookupOK then begin
                                //     ItemSeleCtionPage.GetRecord(ItemRec);
                                //UK::09062020>>
                                //if Page.RunModal(80003, ItemRec) = Action::LookupOK then begin
                                ItemSeleCtionPage.SetTableView(ItemRec);
                                ItemSeleCtionPage.Editable(true);
                                if ItemSeleCtionPage.RunModal() = Action::OK then begin
                                    //UK::09062020<<
                                    ItemRec.SetRange(Select, true);
                                    if ItemRec.FindSet() then begin
                                        Clear(ItemNo);
                                        repeat
                                            ItemNo += Format(ItemRec."No.") + '|';
                                        until ItemRec.Next() = 0;
                                    end;
                                    if StrLen(ItemNo) <> 0 then begin
                                        I := StrLen(ItemNo);
                                        ItemNo := DelStr(ItemNo, I);
                                    end;
                                end;
                            end;
                        End;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    local procedure InsertTempRecord(VAr ItemLedEntryP: Record "Item Ledger Entry"; var EntryNo: integer)
    var
        ItemRec1: Record Item;
    begin
        EntryNoG := EntryNo;

        // ItemLedEntryP.CalcFields("Reserved Quantity"); // GK
        DataItem1.Init();
        DataItem1 := ItemLedEntryP;
        //SD
        ItemRec1.ChangeCompany(SelectedComapny[Integer.Number]);
        if ItemRec1.Get(ItemLedEntryP."Item No.") then
            DataItem1."Unit of Measure Code" := ItemRec1."Base Unit of Measure";
        //SD
        DataItem1."Entry No." := EntryNoG;
        DataItem1.Description := SelectedComapny[Integer.Number];//ItemLedEntryP.CurrentCompany();
        DataItem1."Applies-to Entry" := ItemLedEntryP."Entry No.";
        DataItem1.Insert();
    end;

    var
        CompanyGroup: Text[250];
        ItemCategory: Text[250];
        QtyInTransitG: Decimal;
        ItemCode2: code[25];
        UnitCost2: Decimal;
        AverageCostCalcOverview: Record "Average Cost Calc. Overview";
        ItemNo: Text[1500];
        AsOfDate: Date;
        AsOfDateParameterValue: Date;
        InventoryPostingGroup: Text[250];
        TextManagement: Codeunit TextManagement;
        CountCompRec: Integer;
        EntryNoG: Integer;
        SlNoG: Integer;
        J: Integer;
        SelectedComapny: array[15] of Text;
        SelectedCompanyName: Text[100];
        ShortNameCom: Record "Company Short Name";
        CompanyShortName: Record "Company Short Name";
        QuantityG: Boolean;
        CompanyNameSorting: Boolean;
        ItemNameSorting: Boolean;
        UOMSorting: Boolean;
        GrandTotal: Decimal;
        ItemNoCode: Code[25];
        ReservedQty: Decimal;

    trigger OnInitReport()
    var
        CompanyShortNameRec1: Record "Company Short Name";
        ItemCategoryRec1: Record "Item Category";
        InventoryPostingGroupRec1: Record "Inventory Posting Group";
        ItemRec1: Record Item;

    Begin
        AsOfDate := workdate;

        if CompanyGroup <> '' then begin
            CompanyShortNameRec1.Reset();
            CompanyShortNameRec1.SetRange(Select, true);
            if CompanyShortNameRec1.FindSet() then
                CompanyShortNameRec1.ModifyAll(Select, false);
            if TextManagement.MakeTextFilter(CompanyGroup) = 0 then;
            CompanyShortNameRec1.Reset();
            CompanyShortNameRec1.SetFilter(Name, CompanyGroup);
            if CompanyShortNameRec1.FindSet() then
                CompanyShortNameRec1.ModifyAll(Select, true);
        end;
        if ItemCategory <> '' then begin
            if TextManagement.MakeTextFilter(ItemCategory) = 0 then;
            ItemCategoryRec1.Reset();
            ItemCategoryRec1.SetRange(Select, true);
            if ItemCategoryRec1.FindSet() then
                ItemCategoryRec1.ModifyAll(Select, false);
            ItemCategoryRec1.Reset();
            ItemCategoryRec1.SetFilter(Code, ItemCategory);
            if ItemCategoryRec1.FindSet() then
                ItemCategoryRec1.ModifyAll(Select, True);
        end;

        if InventoryPostingGroup <> '' then begin
            InventoryPostingGroupRec1.Reset();
            InventoryPostingGroupRec1.SetRange(Select, true);
            if InventoryPostingGroupRec1.FindSet() then
                InventoryPostingGroupRec1.ModifyAll(Select, false);
            if TextManagement.MakeTextFilter(InventoryPostingGroup) = 0 then;
            InventoryPostingGroupRec1.Reset();
            InventoryPostingGroupRec1.SetRange(Code, InventoryPostingGroup);
            if InventoryPostingGroupRec1.FindSet() then
                InventoryPostingGroupRec1.ModifyAll(Select, true);
        end;


        if ItemNo <> '' then begin
            ItemRec1.Reset();
            ItemRec1.SetRange(Select, true);
            if ItemRec1.FindSet() then
                ItemRec1.ModifyAll(Select, false);
            if TextManagement.MakeTextFilter(ItemNo) = 0 then;
            ItemRec1.Reset();
            ItemRec1.SetRange("No.", ItemNo);
            if ItemRec1.FindSet() then
                ItemRec1.ModifyAll(Select, true);
        end;

    end;

    trigger OnPreReport()
    var

    Begin
        GrandTotal := 0;
        if CompanyGroup <> '' then begin
            CompanyShortName.Reset();
            CompanyShortName.SetFilter(Name, CompanyGroup);
            if CompanyShortName.FindSet() then begin
                CountCompRec := CompanyShortName.Count;
                J := 0;
                repeat
                    j += 1;
                    SelectedComapny[J] := CompanyShortName.Name;
                    //GK for Company Name 05/15/20
                    if j = 1 then
                        SelectedCompanyName := CompanyShortName.Name
                    else
                        if J <> 1 then
                            SelectedCompanyName := 'Group of Companies';
                //GK for Company Name 05/15/20
                until CompanyShortName.Next() = 0;
            end;
        end
        else
            if CompanyGroup = '' then begin
                if CompanyShortName.FindSet() then begin
                    CountCompRec := CompanyShortName.Count;
                    J := 0;
                    repeat
                        j += 1;
                        SelectedComapny[J] := CompanyShortName.Name;
                    until CompanyShortName.Next() = 0;
                end;
                //GK for Company Name 05/15/20
                SelectedCompanyName := 'Group of Companies';
                //GK for Company Name 05/15/20
            end;
    end;

    trigger OnPostReport()
    var
        ItemRec1: Record Item;
        InventoryPostingGroupRec1: Record "Inventory Posting Group";
        ItemCategoryRec1: Record "Item Category";
        CompanyShortNameRec1: Record "Company Short Name";
    Begin
        ItemRec1.Reset();
        ItemRec1.SetRange(Select, true);
        if ItemRec1.FindSet() then
            ItemRec1.ModifyAll(Select, false);

        InventoryPostingGroupRec1.Reset();
        InventoryPostingGroupRec1.SetRange(Select, true);
        if InventoryPostingGroupRec1.FindSet() then
            InventoryPostingGroupRec1.ModifyAll(Select, false);

        ItemCategoryRec1.Reset();
        ItemCategoryRec1.SetRange(Select, true);
        if ItemCategoryRec1.FindSet() then
            ItemCategoryRec1.ModifyAll(Select, false);

        CompanyShortNameRec1.Reset();
        CompanyShortNameRec1.SetRange(Select, true);
        if CompanyShortNameRec1.FindSet() then
            CompanyShortNameRec1.ModifyAll(Select, false);

        // Page.RunModal(38, DataItem1);
        // Report.Run(80013,true,false);
    end;

    var
        decimalboolean: Boolean;
}