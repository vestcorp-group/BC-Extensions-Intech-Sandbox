page 50166 "Sales Remark Sheet"//T12370-N
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Remark";
    AutoSplitKey = true;
    DelayedInsert = true;
    Caption = 'Remarks';


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Remark; rec.Remark)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}