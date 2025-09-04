pageextension 75075 Posted_Whse_Receipt_List_75075 extends "Posted Whse. Receipt List"
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