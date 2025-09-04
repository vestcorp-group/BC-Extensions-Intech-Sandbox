page 80004 "Select Item Category"//T12370-Full Comment
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item Category";
    DeleteAllowed = false;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater("Item Category List")
            {
                field(Select; rec.Select)
                {
                    ApplicationArea = All;

                }
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
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