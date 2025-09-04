pageextension 58247 ItemAvailabilityVariant extends "Item Avail. by Variant Lines"//T12370-Full Comment,T12855
{
    layout
    {
        addafter(Description)
        {
            field(HSNCode; Rec.HSNCode)
            {
                ApplicationArea = all;
                Caption = 'HS Code';
            }
            field("Packing Description"; Rec."Packing Description")
            {
                ApplicationArea = all;
            }
            field(CountryOfOrigin; rec.CountryOfOrigin)
            {
                ApplicationArea = all;
                Caption = 'Country of Origin';
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