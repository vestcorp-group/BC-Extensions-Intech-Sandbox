pageextension 50485 TeamSalespersonpageext extends "Team Salespeople"//T12370-Full Comment
{
    layout
    {
        addafter("Salesperson Name")
        {
            field(Manager; Rec.Manager)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the manager of the team';
            }
        }
    }
}