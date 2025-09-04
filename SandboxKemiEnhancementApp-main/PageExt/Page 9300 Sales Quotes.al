pageextension 70013 SalesQuotesListPage extends 9300//T12370-Full Comment   //T13415-N
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            // field("Customer Alternate Short Name"; Rec."Customer Alternate Short Name")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }
            field("Customer Short Name"; Rec."Customer Short Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}