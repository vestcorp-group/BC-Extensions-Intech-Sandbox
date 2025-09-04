page 50103 "Company List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Company;
    Description = 'T48239';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Display Name"; Rec."Display Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    procedure SetSelection(var Comp: Record Company)
    begin
        CurrPage.SetSelectionFilter(Comp);
    end;
}