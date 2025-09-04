page 80005 "Inven. Posting Group Selection"//T12370-Full Comment  T12946-Code Uncommented
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Inventory Posting Group";
    DeleteAllowed = false;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(PostingGroupList)
            {
                field(Select; rec.Select)
                {
                    ApplicationArea = All;

                }
                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
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