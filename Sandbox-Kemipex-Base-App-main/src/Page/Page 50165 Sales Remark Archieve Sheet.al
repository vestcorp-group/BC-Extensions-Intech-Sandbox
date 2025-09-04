page 50165 "Sales Remark Archieve Sheet"//T12370-N
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Remark Archieve";
    AutoSplitKey = true;
    DelayedInsert = true;
    Editable = false;
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