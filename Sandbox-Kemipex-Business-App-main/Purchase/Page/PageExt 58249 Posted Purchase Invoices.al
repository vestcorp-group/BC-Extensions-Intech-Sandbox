pageextension 58249 PostedPurchpageext extends "Posted Purchase Invoices"//T12370-Full Comment//HyperCare
{
    layout
    {
        addafter("No. Printed")
        {
            field("User ID"; rec."User ID")
            {
                ApplicationArea = all;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean
    begin
        Error('Not allowed to delete the record!');
    end;
}