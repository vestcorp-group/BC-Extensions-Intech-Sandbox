pageextension 75081 WarehouseReceipt_75081 extends "Warehouse Receipt"
{
    layout
    {
        addafter("Sorting Method")
        {
            //T12240-NS
            field("LR/RR No."; Rec."LR/RR No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LR/RR No. field.', Comment = '%';
            }
            field("LR/RR Date"; Rec."LR/RR Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LR/RR Date field.', Comment = '%';
            }
            field("Shipping Agent Code"; Rec."Shipping Agent Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipping Agent Service Code field.', Comment = '%';
            }
            //T12240-NE
        }
    }
}