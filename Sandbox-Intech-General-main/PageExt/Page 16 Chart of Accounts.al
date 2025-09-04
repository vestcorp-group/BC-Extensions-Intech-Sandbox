pageextension 75065 ChartofAct_75065 extends "Chart of Accounts"
{
    layout
    {
        addlast(Control1)
        {
            //I-C0059-1001701-01-NS
            field("Balance at Date_Custom"; Rec."Balance at Date_Custom")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Credit Amount_Custom"; Rec."Credit Amount_Custom")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Credit Amount (Source Code Filter) field.';
                Visible = false;
            }
            field("Debit Amount_Custom"; Rec."Debit Amount_Custom")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Debit Amount (Source Code Filter) field.';
                Visible = false;
            }
            field("Net Change_Custom"; Rec."Net Change_Custom")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Net Change (Source Code Filter) field.';
                Visible = false;
            }
        }
        //I-C0059-1001701-01-NE
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}