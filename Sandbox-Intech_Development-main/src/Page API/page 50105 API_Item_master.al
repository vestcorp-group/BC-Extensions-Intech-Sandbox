

page 50105 API_Item_master
{
    APIGroup = 'PowerBIReport';
    APIPublisher = 'ISPL';
    APIVersion = 'v2.0';
    Caption = 'apiItem_master';
    DelayedInsert = true;
    EntityName = 'item_master';
    EntityCaption = 'item_master';
    EntitySetName = 'item_master';
    EntitySetCaption = 'item_master';
    PageType = API;
    SourceTable = Item;
    Editable = false;
    DataAccessIntent = ReadOnly;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(baseUnitofMeasure; Rec."Base Unit of Measure")
                {
                    Caption = 'Base Unit of Measure';
                }
                field(unitPrice; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                }
                field(inventoryCtrl; Rec.Inventory)
                {
                    Caption = 'InventoryCtrl';
                }
                field(createdFromNonstockItem; Rec."Created From Nonstock Item")
                {
                    Caption = 'Created From Nonstock Item';
                    Visible = false;
                }
                field(stockkeepingUnitExists; Rec."Stockkeeping Unit Exists")
                {
                    Caption = 'Stockkeeping Unit Exists';
                    Visible = false;
                }
                field(routingNo; Rec."Routing No.")
                {
                    Caption = 'Routing No.';
                }
                field(shelfNo; Rec."Shelf No.")
                {
                    Caption = 'Shelf No.';
                    Visible = false;
                }
                field(costingMethod; Rec."Costing Method")
                {
                    Caption = 'Costing Method';
                    Visible = false;
                }
                field(costisAdjusted; Rec."Cost is Adjusted")
                {
                    Caption = 'Cost is Adjusted';
                    Visible = false;
                }
                field(standardCost; Rec."Standard Cost")
                {
                    Caption = 'Standard Cost';
                    Visible = false;
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field(lastDirectCost; Rec."Last Direct Cost")
                {
                    Caption = 'Last Direct Cost';
                    Visible = false;
                }
                field(priceProfitCalculation; Rec."Price/Profit Calculation")
                {
                    Caption = 'Price/Profit Calculation';
                    Visible = false;
                }
                field(profit; Rec."Profit %")
                {
                    Caption = 'Profit %"';
                    Visible = false;
                }
                field(inventoryPostingGroup; Rec."Inventory Posting Group")
                {
                    Caption = 'Inventory Posting Group';
                    Visible = false;
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                    Visible = false;
                }
                field(vATProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                    Visible = false;
                }
                field(itemDiscGroup; Rec."Item Disc. Group")
                {
                    Caption = 'Item Disc. Group';
                    Visible = false;
                }
                field(vendorNo; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                }
                field(vendorItemNo; Rec."Vendor Item No.")
                {
                    Caption = 'Vendor Item No.';
                }
                field(tariffNo; Rec."Tariff No.")
                {
                    Caption = 'Tariff No.';
                    Visible = false;
                }
                field(searchDescription; Rec."Search Description")
                {
                    Caption = 'Search Description';
                    Visible = false;
                }
                field(overheadRate; Rec."Overhead Rate")
                {
                    Caption = 'Overhead Rate';
                    Visible = false;
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                    Caption = 'Indirect Cost %';
                    Visible = false;
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                    Visible = false;
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                    Visible = false;
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                    Visible = false;
                }
                field(salesUnitofMeasure; Rec."Sales Unit of Measure")
                {
                    Caption = 'Sales Unit of Measure';
                    Visible = false;
                }
                field(replenishmentSystem; Rec."Replenishment System")
                {
                    Caption = 'Replenishment System';
                    Visible = false;
                }
                field(purchUnitofMeasure; Rec."Purch. Unit of Measure")
                {
                    Caption = 'Purch. Unit of Measure';
                    Visible = false;
                }
                field(leadTimeCalculation; Rec."Lead Time Calculation")
                {
                    Caption = 'Lead Time Calculation';
                    Visible = false;
                }
                field(manufacturingPolicy; Rec."Manufacturing Policy")
                {
                    Caption = 'Manufacturing Policy';
                    Visible = false;
                }
                field(flushingMethod; Rec."Flushing Method")
                {
                    Caption = 'Flushing Method';
                    Visible = false;
                }
                field(assemblyPolicy; Rec."Assembly Policy")
                {
                    Caption = 'Assembly Policy';
                    Visible = false;
                }
                field(itemTrackingCode; Rec."Item Tracking Code")
                {
                    Caption = 'Item Tracking Code';
                    Visible = false;
                }
                field(defaultDeferralTemplateCode; Rec."Default Deferral Template Code")
                {
                    Caption = 'Default Deferral Template Code';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(ItemList)
            {
                ApplicationArea = All;
                Caption = 'Advanced View';
                Image = CustomerList;
                ToolTip = 'Open the Items page showing all possible columns.';

                trigger OnAction()
                var
                    ItemList: Page "Item List";
                begin
                    ItemList.SetTableView(Rec);
                    ItemList.SetRecord(Rec);
                    ItemList.LookupMode := true;

                    Commit();
                    if ItemList.RunModal() = ACTION::LookupOK then begin
                        ItemList.GetRecord(Rec);
                        CurrPage.Close();
                    end;
                end;
            }
        }
       /*  area(Promoted) Need to Resolve Promoted on Live 02-02-2025 ABA
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(ItemList_Promoted; ItemList)
                {
                }
            }
        } */
    }
}

