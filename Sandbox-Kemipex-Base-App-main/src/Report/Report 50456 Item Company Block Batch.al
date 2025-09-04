report 50456 "Item Company Block Batch"//T12370-Full Comment
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Description = 'T52085';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            var
                ItemCompanyblockRec: Record "Item Company Block";
                CompanyRec: Record Company;
                ItemRec: Record Item;
                RecShortName: Record "Company Short Name";
            begin
                //20MAY2022-start
                Clear(RecShortName);
                RecShortName.SetRange(Name, CompanyRec.Name);
                RecShortName.SetRange("Block in Reports", true);
                if not RecShortName.FindFirst() then begin
                    if CompanyRec.FindSet() then begin
                        repeat
                            ItemRec.ChangeCompany(CompanyRec.Name);
                            if ItemRec.Get(Item."No.") then begin
                                if not ItemCompanyblockRec.Get(ItemRec."No.", CompanyRec.Name) then begin
                                    ItemCompanyblockRec.Init();
                                    ItemCompanyblockRec."Item No." := ItemRec."No.";
                                    ItemCompanyblockRec.Company := CompanyRec.Name;
                                    if ItemCompanyblockRec.Insert then ItemCompanyblockRec.ValidateItemCompanyBlock(ItemRec."No.");
                                end;
                            end;
                        until CompanyRec.Next() = 0;
                    end;
                end;
            end;
        }
    }
    // ItemCompanyblockRec.Blocked := ItemRec.Blocked;
    // ItemCompanyblockRec."Sales Blocked" := ItemRec."Sales Blocked";
    // ItemCompanyblockRec."Purchase Blocked" := ItemRec."Purchasing Blocked";
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

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
        myInt: Integer;
}