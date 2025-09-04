pageextension 80026 SaleInvoiceSubform_Ext extends "Sales Invoice Subform"//T12370-Full Comment
{
    layout
    {
        addafter(Description)
        {
            field("Item Generic Name"; rec."Item Generic Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Line Generic Name"; rec."Line Generic Name")
            {
                ApplicationArea = all;
            }
        }
        addafter("Unit Price")
        {
            field("Customer Requested Unit Price"; rec."Customer Requested Unit Price")//T13395-N
            {
                ApplicationArea = All;
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