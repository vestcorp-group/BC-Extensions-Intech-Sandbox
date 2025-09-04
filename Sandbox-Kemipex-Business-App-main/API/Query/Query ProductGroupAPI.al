/* query 53005 ProductGroupAPI
{
    QueryType = Normal;

    elements
    {
        dataitem(Product_Group; "Product Group")
        {
            column(Code; Code)
            {

            }
            column(Description; Description) { }
        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
} */