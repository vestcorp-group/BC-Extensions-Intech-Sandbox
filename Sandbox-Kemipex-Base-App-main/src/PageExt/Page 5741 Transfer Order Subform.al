pageextension 50147 KMP_PagExtTransferOrderSubform extends "Transfer Order Subform"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field(CustomBOENumber; rec.CustomBOENumber)
            {
                Caption = 'Custom BOE No.';
                ApplicationArea = All;
            }
        }
    }
}