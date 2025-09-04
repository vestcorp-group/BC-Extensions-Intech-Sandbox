page 80006 "Comapny Selection"//T12370-Full Comment T12946-Code Uncommented
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Company Short Name";
    DeleteAllowed = false;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater("Compnies")
            {
                field(Select; rec.Select)
                {
                    ApplicationArea = All;

                }
                field("Company Name"; rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Short Name"; rec."Short Name")
                {
                    ApplicationArea = All;
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