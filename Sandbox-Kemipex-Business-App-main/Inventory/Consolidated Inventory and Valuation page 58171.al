page 58171 "Consol Inventory and Valution"//T12370-Full Comment     //T13413-Full UnComment
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Consolidated Inventory and Valuation';
    SourceTableView = sorting("Search Description") order(ascending) where("Inventory Posting Group" = filter('PD'), "Consolidated Inventory" = filter('<>0'));
    SourceTable = item;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Permissions = tabledata item = rm;
    // SourceTableTemporary = true;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Width = 7;
                }
                field("Search Description"; rec."Search Description")
                {
                    ApplicationArea = all;
                    Caption = 'Item Short Name';
                    Width = 40;
                }
                field("Country/Region of Origin Code"; rec."Country/Region of Origin Code")
                {
                    ApplicationArea = all;
                    Caption = 'Country of Origin';
                    Width = 3;
                }
                field(ItemPriceCurrency; ItemPriceCurrency)
                {
                    ApplicationArea = all;
                    Caption = 'Selling Price Currency';
                    Width = 4;
                }
                field(itemPrice; itemPrice)
                {
                    ApplicationArea = all;
                    Caption = 'Selling Price';
                    DecimalPlaces = 0;
                    Width = 7;
                }
                field("Base Unit of Measure"; rec."Base Unit of Measure")
                {
                    ApplicationArea = all;
                    Caption = 'Base UOM';
                    Width = 3;
                }
                field(AvailableInventory; AvailableInventory)
                {
                    ApplicationArea = all;
                    Caption = 'Consolidated Available Inventory';
                    DecimalPlaces = 0 : 3;
                    Style = Strong;
                    StyleExpr = true;
                    Width = 10;
                }
                field(ReservedQty; ReservedQty)
                {
                    ApplicationArea = all;
                    Caption = 'Sales Reserved Qty.';
                    DecimalPlaces = 0 : 3;
                    Width = 10;
                }
                field(ProductionInventory; ProductionInventory)
                {
                    ApplicationArea = all;
                    Caption = 'Production Reserved Qty.';
                    DecimalPlaces = 0 : 3;
                    Width = 10;
                }
                field("Consolidated Inventory"; rec."Consolidated Inventory")
                {
                    DecimalPlaces = 0 : 3;
                    ApplicationArea = all;
                    Width = 10;
                }
                field(TotalValue; TotalValue)
                {
                    ApplicationArea = all;
                    Caption = 'Inventory Value';
                    DecimalPlaces = 0;
                    Width = 10;
                }
            }
        }

        area(FactBoxes)
        {
            part(ItemPicture; "Item Picture")
            {
                Editable = false;
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "No." = FIELD("No."),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                              "Location Filter" = FIELD("Location Filter"),
                              "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                              "Variant Filter" = FIELD("Variant Filter");
            }
            part("Inventory Details"; "Item Company Wise Inventory")
            {
                ApplicationArea = all;
                SubPageLink = "Item No." = field("No.");
                Visible = false;
            }
            part(KFZEConsolidatedInventory; "Item Comp Wise Inventory temp")
            {
                ApplicationArea = all;
                Caption = 'Consolidated Inventory';
            }
            part("ItemUOM"; "Item UOM Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "Item No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Item Price")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Price;

                trigger OnAction()
                var
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed by base App-30-04-2022
                    SalesPriceRec: Record "Price List Line";    //T13413-N
                // SalesPriceRec: Record "Sales Price";     //T13413-O
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed by base App-30-04-2022
                begin
                    SalesPriceRec.Reset();
                    SalesPriceRec.SetRange("Asset No.", Rec."No.");  //T13413-N
                    // SalesPriceRec.SetRange("Item No.", Rec."No.");   //T13413-O
                    Page.RunModal(Page::"item Price List", SalesPriceRec);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        updateInventory: Report UpdateConsolInventoryreport;
    begin
        updateInventory.Run();
    end;

    trigger OnAfterGetRecord()
    var
        valueentry: Record "Value Entry";
        company: Record Company;
        ILE: Record "Item Ledger Entry";
        Item: Record Item;
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed by base App-30-04-2022
        SalesPriceRec: Record "Price List Line";    //T13413-N
        // SalesPriceRec: Record "Sales Price"; //T13413-O
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed by base App-30-04-2022
        CountryRegionRec: Record "Country/Region";
        ReservervationEntry: Record "Reservation Entry";
        RecShortName: Record "Company Short Name";//08-09-2022
    begin
        //Clear(TotalInventory);
        Clear(TotalValue);
        Clear(ItemPriceCurrency);
        Clear(itemPrice);
        Clear(CountryofOrigin);
        Clear(ReservedQty);
        Clear(AvailableInventory);
        Clear(ProductionInventory);

        if CountryRegionRec.Get(Rec."Country/Region of Origin Code") then
            CountryofOrigin := CountryRegionRec.Name;
        SalesPriceRec.SetRange("Asset No.", rec."No.");  //T13413-N
        // SalesPriceRec.SetRange("Item No.", rec."No.");   //T13413-O
        if SalesPriceRec.FindFirst() then begin
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed by base App-30-04-2022
            ItemPriceCurrency := SalesPriceRec."Currency 2";

            itemPrice := SalesPriceRec."Unit Price 2";
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed by base App-30-04-2022
        end;

        company.SetFilter(Name, '<>%1', rec.CurrentCompany);
        repeat

            Clear(RecShortName);//08-09-2022
            RecShortName.SetRange(Name, company.Name);
            RecShortName.SetRange("Block in Reports", true);
            if not RecShortName.FindFirst() then begin
                /*  Ile.Reset();
                             ILE.ChangeCompany(company.Name);
                             ile.SetRange("Item No.", "No.");
                             ILE.CalcSums(Quantity);
                             TotalInventory += ILE.Quantity;
                 */
                Ile.Reset();
                ILE.ChangeCompany(company.Name);
                ile.SetRange("Item No.", rec."No.");
                ILE.SetRange("Production Wh.", true);
                ILE.CalcSums(Quantity);
                ProductionInventory += ILE.Quantity;

                ReservervationEntry.ChangeCompany(company.Name);
                ReservervationEntry.SetRange("Reservation Status", ReservervationEntry."Reservation Status"::Reservation);
                ReservervationEntry.SetRange("Source Type", 32);
                ReservervationEntry.SetRange("Item No.", Rec."No.");
                ReservervationEntry.SetRange("Source Subtype", 0);
                ReservervationEntry.SetRange(Positive, true);
                ReservervationEntry.CalcSums("Quantity (Base)");
                ReservedQty += Abs(ReservervationEntry."Quantity (Base)");

                valueentry.ChangeCompany(company.Name);
                valueentry.SetRange("Item No.", rec."No.");
                valueentry.CalcSums("Cost Amount (Actual)");
                valueentry.CalcSums("Cost Amount (Expected)");
                TotalValue += valueentry."Cost Amount (Actual)" + valueentry."Cost Amount (Expected)";
            end;
        until company.Next() = 0;
        AvailableInventory := rec."Consolidated Inventory" - ReservedQty - ProductionInventory;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.KFZEConsolidatedInventory.Page.LoadConsolidatedInvtData(Rec."No.");
    end;

    var
        TotalValue: Decimal;
        //  TotalInventory: Decimal;
        ItemPriceCurrency: Code[10];
        itemPrice: Decimal;
        CountryofOrigin: Text;
        ReservedQty: Decimal;
        AvailableInventory: Decimal;
        ProductionInventory: Decimal;
}