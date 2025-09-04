pageextension 50551 "Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Email Template"; Rec."Email Template")
            {
                ApplicationArea = All;
            }
        }
    }
}
