pageextension 70027 "Posted Sales Cr. Memo Subform" extends "Posted Sales Cr. Memo Subform"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here
        addafter("Unit Price")
        {
            field("Customer Requested Unit Price"; rec."Customer Requested Unit Price")//T13395-N
            {
                ApplicationArea = All;
            }
        }

    }
}