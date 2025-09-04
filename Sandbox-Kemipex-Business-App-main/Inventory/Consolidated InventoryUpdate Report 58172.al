report 58172 UpdateConsolInventoryreport//T12370-Full Comment   //T13413-Full UnComment
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata Item = rm;
    UseRequestPage = false;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = where("Inventory Posting Group" = filter('<>Sample'));
            //   column(Inventory_Posting_Group; "Inventory Posting Group"){}

            trigger OnAfterGetRecord()
            var
                valueentry: Record "Value Entry";
                company: Record Company;
                ILE: Record "Item Ledger Entry";
                TotalValue: Decimal;
                TotalInventory: Decimal;
                ProductionInventoryVar: Decimal;
                RecShortName: Record "Company Short Name";
            begin
                Clear(TotalInventory);
                Clear(TotalValue);
                Clear(ProductionInventoryVar);

                company.SetFilter(Name, '<>%1', CurrentCompany);
                repeat
                    //20JUNE2022-start
                    Clear(RecShortName);
                    RecShortName.SetRange(Name, company.Name);
                    RecShortName.SetRange("Block in Reports", true);
                    if not RecShortName.FindFirst() then begin
                        Clear(ILE);
                        ILE.ChangeCompany(company.Name);
                        ILE.SetRange("Item No.", "No.");
                        ILE.CalcSums(Quantity);
                        TotalInventory += ILE.Quantity;
                    end;
                //20JUNE2022-end
                until company.Next() = 0;
                Item."Consolidated Inventory" := TotalInventory;
                if Item.Modify() then;
            end;
        }
    }
}