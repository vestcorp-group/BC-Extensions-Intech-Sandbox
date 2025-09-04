pageextension 64101 SalesInvoice_64101 extends "Sales Invoice"
{
    layout
    {
        // 24-12-24 AS-NS

        addlast(General)
        {

            field(Shipping; Rec.Shipping)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipping field.', Comment = '%';
            }
        }

        // 24-12-24 AS-NE
    }
}
