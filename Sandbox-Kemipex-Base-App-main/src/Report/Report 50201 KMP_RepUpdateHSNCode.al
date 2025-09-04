//To update the HSN code in Sales Line
report 50201 KMP_RepUpdateHSNCode//T12370-Full Comment // //T-12855 Report uncommented
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Update Sales Line HSN Code';
    dataset
    {
        dataitem(Item; Item)
        {
            trigger OnPreDataItem()
            begin
                Item.FindFirst();
            end;

            trigger OnAfterGetRecord()
            var
                SalesLineL: Record "Sales Line";
            begin
                SalesLineL.SetRange("No.", Item."No.");
                SalesLineL.SetRange(HSNCode, '');
                SalesLineL.ModifyAll(HSNCode, item."Tariff No.");
            end;
        }
    }


}