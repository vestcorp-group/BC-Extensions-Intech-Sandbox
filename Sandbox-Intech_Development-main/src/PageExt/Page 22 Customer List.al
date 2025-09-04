pageextension 50113 CustList extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Customer")
        {
            action("Query Inv Move")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Qu: Query "Inventory Movement";
                begin
                    Qu.SetRange(Posting_Date, 20230401D, 20230430D);
                    Qu.Open();
                    Qu.Read();
                end;
            }
        }
    }

    var
        myInt: Integer;
}