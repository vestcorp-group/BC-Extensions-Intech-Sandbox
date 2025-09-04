page 70003 "Posted Sales Shipment Remarks"//T12370-Full Comment
{

    PageType = ListPart;
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
                    Width = 200;
                    ApplicationArea = All;

                }
            }
        }
    }


}


