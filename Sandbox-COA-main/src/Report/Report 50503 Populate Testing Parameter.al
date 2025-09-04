report 50503 "Populate Testing Parameter"
{
    ApplicationArea = All;
    Caption = 'Populate Testing Parameter';
    UsageCategory = Administration;
    ProcessingOnly = true;
    UseRequestPage = true;

    trigger OnPostReport()
    var
        PostedLotParameter: Record "Posted Lot Testing Parameter";
        LotParameter: Record "Lot Testing Parameter";
        ItemTestingParameter: Record "Item Testing Parameter";
    begin
        Clear(PostedLotParameter);
        PostedLotParameter.SetFilter("Item No.", '<>%1', '');
        if PostedLotParameter.FindSet() then begin
            repeat
                Clear(ItemTestingParameter);
                ItemTestingParameter.SetRange("Item No.", PostedLotParameter."Item No.");
                ItemTestingParameter.SetRange(Code, PostedLotParameter.Code);
                if ItemTestingParameter.FindFirst() then begin
                    PostedLotParameter.Priority := ItemTestingParameter.Priority;
                    PostedLotParameter."Show in COA" := ItemTestingParameter."Show in COA";
                    PostedLotParameter."Default Value" := ItemTestingParameter."Default Value";
                    PostedLotParameter.Modify();
                end
            until PostedLotParameter.Next() = 0;
        end;

        Clear(LotParameter);
        LotParameter.SetFilter("Item No.", '<>%1', '');
        if LotParameter.FindSet() then begin
            repeat
                Clear(ItemTestingParameter);
                ItemTestingParameter.SetRange("Item No.", LotParameter."Item No.");
                ItemTestingParameter.SetRange(Code, LotParameter.Code);
                if ItemTestingParameter.FindFirst() then begin
                    LotParameter.Priority := ItemTestingParameter.Priority;
                    LotParameter."Show in COA" := ItemTestingParameter."Show in COA";
                    LotParameter."Default Value" := LotParameter."Default Value";
                    LotParameter.Modify();
                end
            until LotParameter.Next() = 0;
        end;
    end;
}
