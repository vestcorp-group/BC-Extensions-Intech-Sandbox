page 58215 "Item UOM Factbox"//T12370-Full Comment
{
    PageType = CardPart;
    SourceTable = "Item Unit of Measure";
    Caption = 'Item Unit Conversion';
    SourceTableView = sorting("Item No.", "Qty. per Unit of Measure") order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Unit';
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    Caption = 'Conversion';
                    ApplicationArea = All;
                }
                field("Net Weight"; rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Packing Weight"; rec."Packing Weight")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}