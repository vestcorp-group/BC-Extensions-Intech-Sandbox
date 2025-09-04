pageextension 75072 Posted_Service_Invoices_75072 extends "Posted Service Invoices"
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