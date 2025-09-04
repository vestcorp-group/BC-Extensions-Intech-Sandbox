pageextension 85653 SalOrdExt extends "Sales Order"
{
    actions
    {
        modify("Send IC Sales Order")
        {
            Enabled = false;
            Visible = false;
        }
    }
}
