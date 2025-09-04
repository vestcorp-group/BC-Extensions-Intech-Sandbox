#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
pageextension 58184 SalesPricePgExt extends "Price List Lines"//T12370-Full Comment //31-12-2024-Sales Price
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
{
    layout
    {
        //T13852-OS
        /* addafter(EndingDate)//31-12-2024-Sales Price  
        {
            field("Currency 2"; rec."Currency 2")
            {
                ApplicationArea = all;

            }
            field("Unit Price 2"; rec."Unit Price 2")
            {
                ApplicationArea = all;
            }
        } */
        //T13852-OE


    }
    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}

