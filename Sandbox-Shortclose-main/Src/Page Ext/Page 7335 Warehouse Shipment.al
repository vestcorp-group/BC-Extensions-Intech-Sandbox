pageextension 79656 P79656WhseShipmentExt extends "Warehouse Shipment"
{
    layout
    {
        addlast(General)
        {
            field("Completely Picked"; Rec."Completely Picked")
            {
                ApplicationArea = All;
            }
        }
    }


}