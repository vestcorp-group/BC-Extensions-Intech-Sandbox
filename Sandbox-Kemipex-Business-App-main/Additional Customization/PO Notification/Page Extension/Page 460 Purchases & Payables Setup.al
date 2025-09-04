pageextension 58037 PurchNPayableSetup extends "Purchases & Payables Setup"//T12370-Full Comment Hypercare
{
    layout
    {
        addlast(General)
        {
            field("Procurement E-Mail"; Rec."Procurement E-Mail")
            {
                ApplicationArea = All;
            }
            field("Purchase Order Tolerance %"; Rec."Purchase Order Tolerance %")
            {
                ApplicationArea = All;
                Caption = 'Purchase Order Tolerance %';
                ToolTip = 'Specifies the tolerance over which approval will be requested.';

            }
        }
    }
}
