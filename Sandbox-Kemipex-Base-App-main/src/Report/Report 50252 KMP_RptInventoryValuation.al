report 50252 KMP_RptInventoryValuation//T12370-N
{
    ObsoleteState = Pending;
    ObsoleteReason = 'Report not required(Confirmed by user)';
    RDLCLayout = './Layouts/KMP_RptInventoryValuation.rdl';
    Caption = 'Inventory Valuation Report';

    dataset
    {
        dataitem(DataItem1; "Item Ledger Entry")
        {
            UseTemporary = true;
            column(Company_Name_; Description)
            { }
            column(Item_No_; "Item No.")
            { }
            column(Quantity; Quantity)
            { }
            column(Reserved_Quantity; "Reserved Quantity")
            { }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            { }
            column(Entry_No_; SlNoG)
            { }

            dataitem(DataItem2; Item)
            {
                column(Description; Description)
                { }
                column(Search_Description; "Search Description")
                { }
                // column(Qty__on_Purch__Order; "Qty. on Purch. Order")
                // { }
                column(Qty__on_Purch__Order; QtyInTransitG)
                { }
                column(Safety_Stock_Quantity; "Safety Stock Quantity")
                { }
                column(Inventory_Posting_Group; "Inventory Posting Group")
                { }
                column(Unit_Cost; "Unit Cost")
                { }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    DataItem2.ChangeCompany(DataItem1.Description);
                    DataItem2.SetRange("No.", DataItem1."Item No.");
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                    PurchLineL: Record "Purchase Line";
                begin
                    SlNoG += 1;
                    Clear(QtyInTransitG);
                    PurchLineL.ChangeCompany(DataItem1.Description);
                    PurchLineL.SetCurrentKey("Document Type", "Document No.", "Line No.", "No.");
                    PurchLineL.SetRange("Document Type", PurchLineL."Document Type"::Order);
                    PurchLineL.SetRange("No.", "No.");
                    PurchLineL.SetFilter(CustomR_ETD, '<=%1', WorkDate());
                    PurchLineL.SetFilter(CustomR_ETA, '>%1', WorkDate());
                    if PurchLineL.FindSet() then
                        PurchLineL.CalcSums("Quantity (Base)");
                    QtyInTransitG := PurchLineL."Quantity (Base)";
                end;
            }
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
        ItemLedEntryG: Record "Item Ledger Entry";
        AsOfDate: Date;
        AsOfDateParameterValue: Date;
        ItemNo: Text[20];
        CompanyInfo: Record 79;
        CompanyNameValue: Text[50];
        CompanyInfoVatRegNoValue: Text[20];
        CompanyAddr1Value: Text[50];
        CompanyAddr2Value: Text[50];
        CompanyNameG: Text;

        QuantityG: Boolean;
        CompanyG: Record Company;
        EntryNoG: Integer;
        SlNoG: Integer;
        QtyInTransitG: Decimal;
    //Added on 8-Jul-2019
    local procedure InsertTempRecord(var ItemLedEntryP: Record "Item Ledger Entry")
    var
        myInt: Integer;
    begin
        EntryNoG += 1;
        DataItem1.Init();
        DataItem1 := ItemLedEntryP;
        DataItem1."Entry No." := EntryNoG;
        DataItem1.Description := ItemLedEntryP.CurrentCompany();
        DataItem1."Applies-to Entry" := ItemLedEntryP."Entry No.";
        DataItem1.Insert();
    end;

    trigger OnPreReport()
    var
        myInt: Integer;
        CompanyInfoRec: Record "Company Information";
        ItemL: Record item;
        RecShortName: Record "Company Short Name";//20MAY2022
    begin
        Clear(DataItem1);
        Clear(EntryNoG);
        Clear(SlNoG);
        AsOfDateParameterValue := AsOfDate;
        if CompanyNameG > '' then
            CompanyG.SetRange(Name, CompanyNameG);
        CompanyG.FindSet();
        repeat
            //20MAY2022-start
            Clear(RecShortName);
            RecShortName.SetRange(Name, CompanyG.Name);
            RecShortName.SetRange("Block in Reports", true);
            if not RecShortName.FindFirst() then begin
                ItemLedEntryG.ChangeCompany(CompanyG.Name);
                ItemL.ChangeCompany(CompanyG.Name);
                ItemLedEntryG.SetCurrentKey("Posting Date", "Item No.");
                ItemLedEntryG.SetFilter("Posting Date", '<=' + Format(AsOfDate));
                if ItemNo > '' then
                    ItemLedEntryG.SetRange("Item No.", ItemNo);
                if ItemLedEntryG.FindSet() then
                    repeat
                        if ItemL.Get(ItemLedEntryG."Item No.") and (Uppercase(ItemL."Inventory Posting Group") <> 'SAMPLE') then
                            InsertTempRecord(ItemLedEntryG);
                    until ItemLedEntryG.Next() = 0;
            end;
        until CompanyG.Next() = 0;

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
    end;
}

