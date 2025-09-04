pageextension 50118 TranOrdSubform extends "Transfer Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Net Weight field.', Comment = '%';
            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gross Weight field.', Comment = '%';
            }
        }
        addafter(Quantity)
        {

            field("Unit Price"; Rec."Unit Price")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit Price field.', Comment = '%';
            }
        }
    }
}
