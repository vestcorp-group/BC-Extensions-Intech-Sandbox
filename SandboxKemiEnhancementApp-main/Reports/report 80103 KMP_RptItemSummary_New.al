report 80103 KMP_RptItemSummary_New//T12370-Full Comment
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './Layouts/Layout_80103_KMP_RptItemSummary.rdl';
    Caption = 'Inventory Summary Report';
    dataset
    {
        dataitem(DataItem1; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Item No.");
            UseTemporary = true;
            CalcFields = "Reserved Quantity";
            column(Company_Name_; ShortNameCom."Short Name") //Description Repalced by ShortNameCom."Short Name"
            { }
            column(Item_No_; "Item No.")
            { }
            column(Quantity; Quantity)
            { }
            column(Reserved_Quantity; ItemLedEntryG."Reserved Quantity")
            { }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            { }
            column(Entry_No_; SlNoG)
            { }

            dataitem(DataItem2; Item)
            {
                RequestFilterFields = "Inventory Posting Group";
                // DataItemLink = "No." = field("Item No.");
                CalcFields = "Qty. on Purch. Order";
                column(Description; Description)
                { }
                column(Search_Description; "Search Description")
                { }
                column(Qty__on_Purch__Order; Quantity__on_Purch__Order) //"Qty. on Purch. Order" is replaced by "Quantity__on_Purch__Order"
                { }
                column(Safety_Stock_Quantity; "Safety Stock Quantity")
                { }
                column(Inventory_Posting_Group; "Inventory Posting Group")
                { }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    DataItem2.ChangeCompany(DataItem1.Description);
                    DataItem2.SetRange("No.", DataItem1."Item No.");
                end;

                trigger OnAfterGetRecord()
                begin


                    SlNoG += 1;
                    IF (ItemCode <> DataItem1."Item No.") OR (Comp1 <> DataItem1.Description) then begin
                        ItemCode := DataItem1."Item No.";
                        comp1 := DataItem1.Description;
                        Clear(Quantity__on_Purch__Order);
                        PurchaseLine.Reset();
                        PurchaseLine.ChangeCompany(DataItem1.Description);
                        PurchaseLine.SetCurrentKey("Document Type", "Document No.", "Line No.", "No.");
                        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                        PurchaseLine.SetRange("No.", DataItem2."No.");
                        PurchaseLine.SetFilter(CustomR_ETD, '<=%1', WorkDate());
                        PurchaseLine.SetFilter(CustomR_ETA, '>%1', WorkDate());
                        if PurchaseLine.FindSet() then begin
                            PurchaseLine.CalcSums("Outstanding Qty. (Base)");
                            Quantity__on_Purch__Order := PurchaseLine."Outstanding Qty. (Base)";
                        end;
                    end
                    else
                        IF (ItemCode <> DataItem1."Item No.") AND (Comp1 <> DataItem1.Description) then begin
                            ItemCode := DataItem1."Item No.";
                            comp1 := DataItem1.Description;
                            Clear(Quantity__on_Purch__Order);
                            PurchaseLine.Reset();
                            PurchaseLine.ChangeCompany(DataItem1.Description);
                            PurchaseLine.SetCurrentKey("Document Type", "Document No.", "Line No.", "No.");
                            PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                            PurchaseLine.SetRange("No.", DataItem2."No.");
                            PurchaseLine.SetFilter(CustomR_ETD, '<=%1', WorkDate());
                            PurchaseLine.SetFilter(CustomR_ETA, '>%1', WorkDate());
                            if PurchaseLine.FindSet() then begin
                                PurchaseLine.CalcSums("Outstanding Qty. (Base)");
                                Quantity__on_Purch__Order := PurchaseLine."Outstanding Qty. (Base)";
                            end;
                        end
                        else begin
                            Quantity__on_Purch__Order := 0;
                            ItemCode := DataItem1."Item No.";
                            comp1 := DataItem1.Description;
                        end;
                END;
            }
            column(Quantity__on_Purch__Order2; Quantity__on_Purch__Order2)
            { }
            column(CompanyNameValue; CompanyNameValue)
            { }
            column(CompanyInfoVatRegNoValue; CompanyInfoVatRegNoValue)
            { }
            column(CompanyAddr1Value; CompanyAddr1Value)
            { }
            column(CompanyAddr2Value; CompanyAddr2Value)
            { }
            column(AsOfDateParameterValue; AsOfDateParameterValue)
            { }
            column(QuantityOption; QuantityG)
            { }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                DataItem1.ChangeCompany(DataItem1.Description);
            end;

            trigger OnAfterGetRecord()
            Var
                QtyOnPurchOrder: Decimal;
            begin
                ShortNameCom.Get(DataItem1.Description);
                ItemLedEntryG.ChangeCompany(DataItem1.Description);
                ItemLedEntryG.Get(DataItem1."Applies-to Entry");
                ItemLedEntryG.CalcFields("Reserved Quantity");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(AsOfDate; AsOfDate)
                {
                    ApplicationArea = All;
                    Caption = 'As of';
                }

                field(ItemNo; ItemNo)
                {
                    ApplicationArea = All;
                    Caption = 'Item No.';
                    TableRelation = Item;
                    // trigger OnDrillDown()
                    // var
                    //     myInt: Integer;
                    //     selectedItemNo: Record Item;
                    //     ItemList: Page KMP_ItemLit;
                    // begin
                    //     //Message(Rec.TransactionNumber);
                    //     ItemList.LookupMode(true);
                    //     if ItemList.RUNMODAL = ACTION::LookupOK then begin
                    //         ItemList.GETRECORD(selectedItemNo);
                    //         ItemNo := selectedItemNo."No.";
                    //     end;
                    // end;
                }
                field("Exclude Item With Quantity 0"; QuantityG)
                {
                    ApplicationArea = All;
                }
                field("Company Name"; CompanyNameG)
                {
                    ApplicationArea = all;
                    TableRelation = Company;
                    // trigger OnDrillDown()
                    // var
                    //     CompaniesL: Page Companies;
                    // begin
                    //     CompanyG.findfirst();
                    //     CompaniesL.LookupMode(true);
                    //     CompaniesL.SetRecord(CompanyG);
                    //     if CompaniesL.RunModal() = Action::LookupOK then
                    //         CompaniesL.SetSelectionFilter(CompanyG);
                    // end;
                }
            }
        }


    }

    var
        ShortNameCom: Record "Company Short Name";

        Quantity__on_Purch__Order: Decimal;
        Quantity__on_Purch__Order2: Decimal;
        PurchaseLine: Record "Purchase Line";
        PurchaseLine2: Record "Purchase Line";
        ItemLedEntryG: Record "Item Ledger Entry";

        AsOfDate: Date;
        AsOfDateParameterValue: Date;
        ItemNo: Text[20];
        CompanyInfo: Record "Company Information";
        CompanyNameValue: Text[50];
        CompanyInfoVatRegNoValue: Text[20];
        CompanyAddr1Value: Text[50];
        CompanyAddr2Value: Text[50];
        CompanyNameG: Text;
        QuantityG: Boolean;
        CompanyG: Record Company;
        EntryNoG: Integer;
        comp2: Text[80];
        comp1: Text[80];
        SlNoG: Integer;
        ItemCode: Code[20];
        ItemCode2: Code[20];
        UOMG: Code[20];
        TextManagement: Codeunit TextManagement;
        InventoryPostingGroup: Text[250];
    //Added on 8-Jul-2019
    local procedure InsertTempRecord(var ItemLedEntryP: Record "Item Ledger Entry")
    var
        ItemRec: Record Item;
    begin
        ItemLedEntryP.CalcFields("Reserved Quantity");
        EntryNoG += 1;
        DataItem1.Init();
        DataItem1 := ItemLedEntryP;
        DataItem1."Entry No." := EntryNoG;
        //SD
        if ItemRec.Get(ItemLedEntryP."Item No.") then
            DataItem1."Unit of Measure Code" := ItemRec."Base Unit of Measure";
        //SD
        DataItem1.Description := ItemLedEntryP.CurrentCompany();
        DataItem1."Applies-to Entry" := ItemLedEntryP."Entry No.";
        DataItem1.Insert();
    end;

    trigger OnPreReport()
    var
        CompanyInfoRec: Record "Company Information";
        ItemL: Record item;
        ItemLedEntryG2: Record "Item Ledger Entry";
        RecShortName: Record "Company Short Name";
    begin
        Clear(DataItem1);
        Clear(EntryNoG);
        Clear(SlNoG);
        Clear(UOMG);
        Clear(Quantity__on_Purch__Order2);
        AsOfDateParameterValue := AsOfDate;
        InventoryPostingGroup := DataItem2.GetFilter("Inventory Posting Group");
        if CompanyNameG > '' then
            CompanyG.SetRange(Name, CompanyNameG);
        CompanyG.FindSet();
        repeat
            Clear(RecShortName);//20MAY2022-start
            RecShortName.SetRange(Name, CompanyG."Name");
            RecShortName.SetRange("Block in Reports", true);
            if not RecShortName.FindFirst() then begin
                CLEAR(ItemCode);
                ItemL.ChangeCompany(CompanyG.Name);
                ItemLedEntryG2.ChangeCompany(CompanyG.Name);
                ItemLedEntryG.ChangeCompany(CompanyG.Name);
                ItemLedEntryG.SetCurrentKey("Posting Date", "Item No.");
                ItemLedEntryG.SetFilter("Posting Date", '<=' + Format(AsOfDate));
                if ItemNo > '' then
                    ItemLedEntryG.SetRange("Item No.", ItemNo);
                if ItemLedEntryG.FindSet() then
                    repeat
                        // if ItemL.Get(ItemLedEntryG."Item No.") and (Uppercase(ItemL."Inventory Posting Group") <> 'SAMPLE') then begin
                        ItemL.Reset();
                        ItemL.SetRange("No.", ItemLedEntryG."Item No.");
                        if InventoryPostingGroup <> '' then begin
                            IF TextManagement.MakeTextFilter(InventoryPostingGroup) = 0 THEN
                                ItemL.SetFilter("Inventory Posting Group", InventoryPostingGroup);
                        end
                        else
                            if InventoryPostingGroup = '' then
                                ItemL.SetFilter("Inventory Posting Group", '<>%1', 'SAMPLE');
                        if ItemL.FindFirst() then begin
                            InsertTempRecord(ItemLedEntryG);
                        end;
                    until ItemLedEntryG.Next() = 0;
            end;
        until CompanyG.Next() = 0;
        //CurrReport.SetTableView(ItemLedEntryG);

        // RecordName.SetFilter("Posting Date", '<=' + Format(AsOfDate));
        // RecordName.SetFilter("Item No.", ItemNo);
        // AsOfDateParameterValue := AsOfDate;
        // CurrReport.SetTableView(RecordName);

        // CompanyInfoRec.SetFilter(Name, CompanyInfo.CurrentCompany);
        // if CompanyInfoRec.FindFirst() then begin
        //     CompanyNameValue := CompanyInfoRec.Name;
        //     CompanyInfoVatRegNoValue := CompanyInfoRec."VAT Registration No.";
        //     CompanyAddr1Value := CompanyInfoRec.Address;
        //     CompanyAddr2Value := CompanyInfoRec."Address 2";
        // end;

        if CompanyNameG > '' then
            CompanyNameValue := CompanyNameG
        else
            CompanyNameValue := 'Group of Companies';

    end;

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        AsOfDate := WorkDate();
        // CompanyNameG := 'Caspian Consolidate Group';
    end;
}

