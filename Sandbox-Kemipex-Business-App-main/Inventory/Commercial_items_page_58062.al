Page 58062 Commercial_Items//T12370-Full Comment    //T13413-Full UnComment
{
    PageType = List;
    SourceTable = Item;
    Editable = false;
    Caption = 'Commercial Items';
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTableView = where("Inventory Posting Group" = filter('PD'), "Sales Blocked" = filter(false), Blocked = filter(false));
    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    Caption = 'Item Commercial Name';
                    ApplicationArea = all;
                }
                field("Search Description"; rec."Search Description")
                {
                    Caption = 'Item Short Name';
                    ApplicationArea = all;
                }
                field("Description 2"; rec."Description 2")
                {
                    Caption = 'Packing Description';
                    ApplicationArea = all;
                }
                // field(Blocked; Blocked)
                // {
                //     ApplicationArea = all;
                // }
                // field("Block Reason"; "Block Reason")
                // {
                //     ApplicationArea = all;
                // }
                field("Tariff No."; rec."Tariff No.")
                {
                    Caption = 'HS Code';
                    ApplicationArea = all;
                }
                field("Country of Origin"; country_region.Name)
                {
                    ApplicationArea = all;
                }
                field(GenericName; rec.GenericName)
                {
                    ApplicationArea = all;
                }
                field(Inventory; rec.Inventory)
                {
                    ApplicationArea = all;
                    DecimalPlaces = 0 : 3;
                }
                field("Base UOM"; rec."Base Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Sales Unit of Measure"; rec."Sales Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("First Packing"; FirstPack)
                {
                    ApplicationArea = all;
                }
                field("First Packing Value"; FirstPack_D)
                {
                    ApplicationArea = all;
                    DecimalPlaces = 4;
                }
                field("Second Packing"; SecondPack)
                {
                    ApplicationArea = All;
                }
                field("Second Packing Value"; SecondPack_D)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 3;
                }
                field("Packing Qty."; PackingQty)
                {
                    ApplicationArea = All;
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
    var
        FirstPack: Code[20];
        FirstPack_D: Decimal;
        SecondPack: Code[20];
        SecondPack_D: Decimal;
        PackingQty: Decimal;
        Country_Desc: Text;
        country_region: Record "Country/Region";
        Item_uom: Record "Item Unit of Measure";
        UOM: Record "Unit of Measure";
        Itemlistpage: page "Item Card";

    trigger OnAfterGetRecord()
    var
    begin
        Clear(country_region);
        if country_region.Get(rec."Country/Region of Origin Code") then;

        //   UOM.SetRange("Decimal Allowed", false);
        Clear(FirstPack_D);
        Item_uom.Reset();
        Item_uom.SetCurrentKey("Qty. per Unit of Measure");
        Item_uom.SetRange("Item No.", rec."No.");
        // Item_uom.SetRange(Code, UOM.Code);
        if Item_uom.FindFirst() then
            FirstPack_D := Item_uom."Qty. per Unit of Measure";
        FirstPack := Item_uom.Code;
        Item_uom.Next();
        SecondPack := Item_uom.Code;
        SecondPack_D := Item_uom."Qty. per Unit of Measure";
        if Item_uom.FindSet() then
            PackingQty := SecondPack_D / FirstPack_D;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.KFZEConsolidatedInventory.Page.LoadConsolidatedInvtData(Rec."No.");
    end;

}