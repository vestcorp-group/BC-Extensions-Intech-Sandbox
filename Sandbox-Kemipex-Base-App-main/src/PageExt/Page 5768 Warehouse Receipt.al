pageextension 50108 KMP_PageExtWarehouseReceiptHdr extends "Warehouse Receipt"//T12370-Full Comment
{
    layout
    {
        addafter("Sorting Method")
        {
            field(CustomBOENumber; rec.CustomBOENumber)
            {
                ApplicationArea = All;
                Caption = 'Custom BOE No.';
                Editable = false;
            }
        }
    }
}