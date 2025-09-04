pageextension 50101 SalesQuoteSubform50101 extends "Sales Quote Subform"
{
    layout
    {
        addafter(Description)
        {
            field(HSNCode; rec.HSNCode)
            {
                Editable = false;
                ApplicationArea = all;
                Caption = 'Item HS Code';
            }
            field(CountryOfOrigin; rec.CountryOfOrigin)
            {
                Editable = false;
                ApplicationArea = all;
                Caption = 'Item Country of Origin';
            }
            field(LineHSNCode; rec.LineHSNCode)
            {
                Caption = 'Line HS Code';
                ApplicationArea = all;
            }
        }
        addafter(Quantity)
        {
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Base UOM 2"; rec."Base UOM 2")
            {
                ApplicationArea = All;
                Caption = 'Base UOM';
            }
            field("Unit Price Base UOM 2"; Rec."Unit Price Base UOM 2")
            {
                ApplicationArea = all;
            }
        }
    }
}

