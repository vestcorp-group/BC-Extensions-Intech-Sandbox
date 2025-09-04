pageextension 75073 Posted_Return_Shipments_75073 extends "Posted Return Shipments"
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
