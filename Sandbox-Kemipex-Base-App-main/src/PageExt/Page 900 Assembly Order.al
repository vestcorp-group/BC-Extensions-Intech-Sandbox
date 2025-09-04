pageextension 51211 KMP_PageExtAssemblyOrder extends "Assembly Order"//T12370-Full Comment 50251 change in to-51211 HyperCare-yaksh
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field(CustomBOENumber; rec.CustomBOENumber)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addbefore(Quantity)
        {
            field(Vessel; rec.Vessel)
            {
                ApplicationArea = all;
            }
        }
        addafter(Status)
        {
            field("Blanket Assembly Order No."; rec."Blanket Assembly Order No.")
            {
                ApplicationArea = ALL;
                Editable = false;
            }
            field("Sample Variant Code"; Rec."Variant Code")
            {
                ApplicationArea = All;
                Visible = true;
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