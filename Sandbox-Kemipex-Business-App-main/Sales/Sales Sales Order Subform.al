pageextension 53003 SalesOrderHyExt extends "Sales Order Subform"//Hypercare
{
    layout
    {
        addafter("Unit Price")
        {
            field("Selling Price"; rec."Selling Price")
            {
                ApplicationArea = all;
                Editable = false;
                Description = 'T50307';

            }
            field("Initial Price"; rec."Initial Price")
            {
                ApplicationArea = all;
                Description = 'T50307';
                Editable = false;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}