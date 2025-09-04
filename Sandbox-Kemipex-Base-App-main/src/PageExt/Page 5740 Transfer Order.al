pageextension 50146 KMP_PagExtTransferOrder extends "Transfer Order"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field(CustomBOENumber; rec.CustomBOENumber)
            {
                Caption = 'Custom BOE No.';
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
}