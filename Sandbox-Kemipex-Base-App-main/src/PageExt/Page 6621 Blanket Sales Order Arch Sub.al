pageextension 50432 Archive extends "Blanket Sales Order Arch. Sub."//T12370-Full Comment
{
    layout
    {
        addafter(Description)
        {
            field(HSNCode; rec.HSNCode)
            {
                ApplicationArea = all;
            }
            field(LineHSNCode; rec.LineHSNCode)
            {
                ApplicationArea = all;
            }
            field(CountryOfOrigin; rec.CountryOfOrigin)
            {
                ApplicationArea = all;
            }
            field(LineCountryOfOrigin; rec.LineCountryOfOrigin)
            {
                ApplicationArea = all;
            }
        }
        // Add changes to page layout here
        addafter(Quantity)
        {
            field("Base UOM 2"; rec."Base UOM 2")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Base UOM';
            }
            field("Unit Price Base UOM 2"; rec."Unit Price Base UOM 2")
            {
                ApplicationArea = All;
                Caption = 'Unit Price Base UOM';
            }
        }
        addbefore(Description)
        {
            field("IMCO Code"; rec."IMCO Class")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}