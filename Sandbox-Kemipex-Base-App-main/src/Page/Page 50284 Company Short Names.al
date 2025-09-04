page 50284 "Company Short Names"//T12370-Full Comment
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory =  Lists;
    SourceTable = "Company Short Name";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Short Name"; rec."Short Name")
                {
                    ApplicationArea = all;
                }
                field("Block in Reports"; rec."Block in Reports")
                {
                    ApplicationArea = all;
                }
                field("Block in PowerBI"; rec."Block in PowerBI")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    var
        myInt: Integer;
}