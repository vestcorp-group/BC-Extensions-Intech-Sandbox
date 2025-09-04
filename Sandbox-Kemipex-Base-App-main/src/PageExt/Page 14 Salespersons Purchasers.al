pageextension 50262 KMP_PagExtSalesPurchaserList extends "Salespersons/Purchasers"//T12370-Full Comment
{
    layout
    {
        addafter(Name)
        {
            field("Short Name"; rec."Short Name")
            {
                ApplicationArea = all;
            }
        }
    }

//     var
//         myInt: Integer;
 }