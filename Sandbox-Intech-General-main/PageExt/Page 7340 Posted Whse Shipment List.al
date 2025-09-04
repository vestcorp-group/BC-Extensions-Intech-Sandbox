pageextension 75076 Posted_Whse_Ship_List_75076 extends "Posted Whse. Shipment List"
{
    layout
    {
        //PostingDateView-NS
        modify("Posting Date")
        {
            Visible = true;
        }
        moveafter("No."; "Posting Date")
        //PostingDateView-NE

    }
}