page 80003 "Item LIst For Selection"//T12370-Full Comment T12946-Code Uncommented
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Item;
    DeleteAllowed = false;
    Editable = true;

    layout
    {
        area(Content)
        {

            repeater(ItemList)
            {
                field(Select; rec.Select)
                {
                    ApplicationArea = All;
                }
                field("Item No"; rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item Name"; rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Search Description"; rec."Search Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Item Short Name';
                }

                field(Inventory; rec.Inventory)
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