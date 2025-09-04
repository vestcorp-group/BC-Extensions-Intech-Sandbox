page 50285 Vessels//T12370-N
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Vessel;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for vessel';
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of quantity that the vessel can hold.';
                }
            }
        }
    }

    var
        myInt: Integer;
}