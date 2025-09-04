pageextension 51212 SalesQuoteExt extends "Sales Quote"
{
    layout
    {
        //T52085-NS
        addfirst(factboxes)
        {
            part("Inventory Details"; "Item Company Wise Inventory")
            {
                ApplicationArea = all;
                Provider = SalesLines;
                SubPageLink = "Item No." = field("No.");
            }
        }
        //T52085-NE
    }


}