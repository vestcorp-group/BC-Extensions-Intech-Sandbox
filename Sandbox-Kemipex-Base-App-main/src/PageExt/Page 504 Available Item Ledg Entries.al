pageextension 50296 KMP_PageExtAvailableItemLedEnt extends "Available - Item Ledg. Entries"//T12937-Full UnComment
{
    layout
    {
        // Add changes to page layout here
        addafter("Lot No.")
        {
            field(CustomLotNumber; rec.CustomLotNumber)
            {
                ApplicationArea = All;
                Caption = 'Custom Lot No.';

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