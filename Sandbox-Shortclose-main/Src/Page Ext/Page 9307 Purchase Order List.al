pageextension 79659 P79659 extends "Purchase Order List"
{
    trigger OnOpenPage()
    begin
        Rec.SetRange("Short Close Boolean", false);
    end;
}