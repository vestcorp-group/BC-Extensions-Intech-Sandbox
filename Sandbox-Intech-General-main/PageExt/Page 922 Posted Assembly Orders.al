
pageextension 75070 Posted_Assembly_Orders_75070 extends "Posted Assembly Orders"
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