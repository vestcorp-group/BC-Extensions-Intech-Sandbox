pageextension 75071 Posted_Service_Ship_75071 extends "Posted Service Shipments"
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