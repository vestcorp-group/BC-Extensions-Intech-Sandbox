report 58209 Summ_sampleInventoryReport//T12370-Full Comment    //T13413-Full UnComment
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Sample Inventory Summary Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Summ_Sample_Inventory.rdl';
    dataset
    {
        dataitem("Item Variant"; "Item Variant")
        {
            column(Item_No_; "Item No.") { }
            column(Code; Code) { }
            column(UOM; Itemrec."Base Unit of Measure") { }
            column(DescriptionV; Description) { }
            column(ItemDescription; Itemrec.Description) { }
            column(COO; Itemrec."Country/Region of Origin Code") { }
            column(COO_description; CountryRegion.Name) { }
            column(HS_code; itemrec."Tariff No.") { }
            column(Inventory; Inventory) { }

            trigger OnAfterGetRecord()
            var
                ILE: Record "Item Ledger Entry";
                company: Record Company;
                RecShortName: Record "Company Short Name";//20MAY2022
            begin
                Clear(Inventory);
                Clear(ILE);
                Clear(CountryRegion);
                if Itemrec.get("Item No.") then;
                if CountryRegion.Get(Itemrec."Country/Region of Origin Code") then;

                company.SetFilter(Name, '<>%1', CurrentCompany);
                repeat
                    Clear(RecShortName);//20MAY2022-start
                    RecShortName.SetRange(Name, company.Name);
                    RecShortName.SetRange("Block in Reports", true);
                    if not RecShortName.FindFirst() then begin
                        ILE.ChangeCompany(company.Name);
                        ILE.Reset();
                        ILE.SetRange("Item No.", "Item No.");
                        ILE.SetRange("Variant Code", Code);
                        if ile.FindSet() then begin
                            ILE.CalcSums(Quantity);
                            Inventory += ILE.Quantity;
                        end;
                    end;
                until company.Next() = 0;
                if Inventory = 0 then CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                "Item Variant".SetFilter("Item No.", itemfilter);
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
                field(itemFilter; itemFilter)
                {
                    Caption = 'Item';
                    ApplicationArea = all;
                    TableRelation = Item where("Inventory Posting Group" = filter('SAMPLE'));
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

    var
        Inventory: Decimal;
        Itemrec: Record Item;
        CountryRegion: Record "Country/Region";
        itemFilter: Code[30];
}