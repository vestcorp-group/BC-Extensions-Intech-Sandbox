pageextension 70028 "Posted Return Recpt. Subform" extends "Posted Return Receipt Subform"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here
        addafter("Unit of Measure")
        {
            field("Customer Requested Unit Price"; rec."Customer Requested Unit Price")//T13395-N
            {
                ApplicationArea = All;
            }
        }

    }
}