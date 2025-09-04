pageextension 80202 SalesOrderSubformExt extends "Sales Order Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Packaging Code"; Rec."Packaging Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Packaging Code field.', Comment = '%';
            }
        }
    }
}
