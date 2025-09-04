query 50102 "Inventory Movement"
{
    QueryType = Normal;
    Description = 'T47531';

    elements
    {
        dataitem(Location; Location)
        {
            column(LocationCode; Code)
            {

            }
            dataitem(Item; Item)
            {
                SqlJoinType = CrossJoin;
                column(No_; "No.")
                {

                }

                dataitem(Item_Variant; "Item Variant")
                {
                    SqlJoinType = LeftOuterJoin;
                    DataItemLink = "Item No." = Item."No.";
                    column(VariantCode; Code)
                    {

                    }
                    column(VariantItem_No_; "Item No.")
                    {

                    }
                    dataitem(Value_Entry; "Value Entry")
                    {
                        DataItemLink = "Item No." = Item_Variant."Item No.", "Location Code" = Location.Code, "Variant Code" = Item_Variant.Code;
                        SqlJoinType = RightOuterJoin;
                        // column(TotalEntries)
                        // {
                        //     Method = Count;
                        // }
                        column(Item_No_; "Item No.")
                        {

                        }
                        column(Location_Code; "Location Code")
                        {

                        }
                        column(Variant_Code; "Variant Code")
                        {

                        }
                        column(Item_Ledger_Entry_Type; "Item Ledger Entry Type")
                        {

                        }
                        column(Posting_Date; "Posting Date")
                        {

                        }
                        column(Document_Type; "Document Type")
                        {

                        }
                        column(Item_Ledger_Entry_Quantity; "Item Ledger Entry Quantity")
                        {
                            Method = Sum;
                        }
                        column(Cost_Amount__Actual_; "Cost Amount (Actual)")
                        {
                            Method = Sum;
                        }
                        column(Cost_Amount__Expected_; "Cost Amount (Expected)")
                        {
                            Method = Sum;
                        }
                    }
                }
            }
        }
    }
}