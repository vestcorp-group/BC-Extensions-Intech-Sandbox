pageextension 53000 VendorCardPExt extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("IC Company Code"; Rec."IC Company Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Blocked)
        {
            field("Blocked Reason"; rec."Blocked Reason")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        //Error('Not allowed to delete the record!');
    end;
}
