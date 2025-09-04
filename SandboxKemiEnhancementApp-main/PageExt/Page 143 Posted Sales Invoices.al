pageextension 70031 PostedSalesInvoiceListPage extends 143//T12370-Full Comment     //T13415-N

{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            // field("Customer Alternate Short Name"; rec."Customer Alternate Short Name")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }
            field("Customer Short Name"; rec."Customer Short Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}