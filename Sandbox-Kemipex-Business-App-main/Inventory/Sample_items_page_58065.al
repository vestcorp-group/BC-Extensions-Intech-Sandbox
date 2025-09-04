Page 58065 Sample_Items//T12370-Full Comment    //T13413-Full UnComment
{
    PageType = List;
    SourceTable = Item;
    Editable = false;
    Caption = 'Sample Items';
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTableView = where("Inventory Posting Group" = filter('SAMPLE'));
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
                    Caption = 'Packing';
                    ApplicationArea = all;
                }
                field(Blocked; rec.Blocked)
                {
                    ApplicationArea = all;
                }
                field("Block Reason"; rec."Block Reason")
                {
                    ApplicationArea = all;
                }
                field("Tariff No."; rec."Tariff No.")
                {
                    Caption = 'HS Code';
                    ApplicationArea = all;
                }
                field("Country of Origin"; country_region.Name)
                {
                    ApplicationArea = all;
                }
                field(Inventory; rec.Inventory)
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3;
                }
                field("Base UOM"; rec."Base Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field(No_of_variance; No_of_variance_)
                {
                    Caption = 'No. of Variance';
                    ApplicationArea = all;
                    Editable = false;
                    trigger OnDrillDown()
                    begin

                        item_variance_t.Reset();
                        item_variance_t.SetRange("Item No.", rec."No.");
                        Page.Run(page::"Item Variants", item_variance_t);
                    end;
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
        Country_Desc: Text;
        country_region: Record "Country/Region";
        Item_uom: Record "Item Unit of Measure";
        No_of_variance_: Integer;
        item_variance_t: Record "Item Variant";

    trigger OnAfterGetRecord()
    var
        item_variance: Record "Item Variant";

    begin
        Clear(country_region);
        if country_region.Get(Rec."Country/Region of Origin Code") then;

        Clear(FirstPack_D);
        Item_uom.Reset();
        Item_uom.SetCurrentKey("Qty. per Unit of Measure");
        Item_uom.SetRange("Item No.", Rec."No.");
        if Item_uom.FindFirst() then
            FirstPack_D := Item_uom."Qty. per Unit of Measure";
        FirstPack := Item_uom.Code;

        if item_variance.findset() then
            item_variance.SetRange("Item No.", Rec."No.");
        No_of_variance_ := item_variance.Count();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.KFZEConsolidatedInventory.Page.LoadConsolidatedInvtData(Rec."No.");
    end;

}