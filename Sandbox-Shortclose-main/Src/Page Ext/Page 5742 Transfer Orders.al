pageextension 79660 P79660_TransferOrders extends "Transfer Orders"
{
    trigger OnOpenPage()
    begin
        Rec.SetRange("Short Close Boolean", false);
    end;
}