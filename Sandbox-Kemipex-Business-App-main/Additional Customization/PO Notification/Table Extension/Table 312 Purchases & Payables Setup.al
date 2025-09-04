tableextension 58014 PurchNPayable extends "Purchases & Payables Setup"//T12370-Full Comment //Hypercare
{
    fields
    {
        field(58000; "Procurement E-Mail"; Text[200])
        {
            Caption = 'Procurement E-Mail';
            DataClassification = ToBeClassified;
        }
        field(53204; "Purchase Order Tolerance %"; Integer)
        {
            Caption = 'Purchase Order Tolerance %';
            DataClassification = CustomerContent;
        }
    }
}
