pageextension 50803 InventorySetupExt extends "Inventory Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Stock Count Template"; rec."Stock Count Template")
            {
                ApplicationArea = All;
            }
            field("Stock Count Batch"; rec."Stock Count Batch")
            {
                ApplicationArea = All;
            }
            field("Allow Inv. Post. Group Modify"; rec."Allow Inv. Post. Group Modify")
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