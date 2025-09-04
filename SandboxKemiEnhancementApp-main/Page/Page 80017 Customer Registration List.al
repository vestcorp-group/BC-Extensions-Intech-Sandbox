page 80017 "Customer Registration List"//T12370-Full Comment
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Customer Registration";

    layout
    {
        area(Content)
        {

            repeater("Customer Registration")
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Customer Registration Type"; rec."Customer Registration Type")
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