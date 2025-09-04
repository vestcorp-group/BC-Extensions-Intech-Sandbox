pageextension 50211 PosTraRcptExt extends "Posted Transfer Receipts"
{
    layout
    {
        //Hypercare-10-03-25-NS
        addlast(Control1)
        {
            field("Transfer Order No."; Rec."Transfer Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the related transfer order.';
            }
        }
        //Hypercare-10-03-25-NE
    }
}
