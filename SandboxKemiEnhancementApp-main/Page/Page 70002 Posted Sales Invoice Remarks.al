page 70002 "Posted Sales Invoice Remarks"//T12370-Full Comment UAT 12-12-2024
{

    PageType = Listpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Order Remarks";
    Caption = 'Remarks';
    AutoSplitKey = true;
    MultipleNewLines = true;
    DelayedInsert = True;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Comments; rec.Comments)
                {
                    Caption = 'Remarks';
                    ApplicationArea = All;
                    Width = 200;

                }
            }
        }
    }



    var
        myInt: Integer;
}