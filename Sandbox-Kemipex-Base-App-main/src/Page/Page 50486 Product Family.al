page 50486 "Product Family"//T12370-N
{
    ApplicationArea = All;
    Caption = 'Product Family';
    PageType = List;
    SourceTable = "Product Family";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Product Family Name"; Rec."Product Family Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Family Name field.';
                }
                field("Minimum Stock Quantity"; Rec."Minimum Stock Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Stock Quantity field.';
                }
            }
        }
    }
}
