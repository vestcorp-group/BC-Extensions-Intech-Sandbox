pageextension 50055 ItemBudgetEntriesExt50055 extends "Item Budget Entries"
{
    layout
    {
        addafter("Budget Dimension 3 Code")
        {

            //T51238-NS
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salesperson Code field.', Comment = '%';
            }
            field("Salesperson Name"; Rec."Salesperson Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salesperson Name field.', Comment = '%';
            }
            field("Team Code"; Rec."Team Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Team Code field.', Comment = '%';
            }
            field("Team Name"; Rec."Team Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Team Name field.', Comment = '%';
            }
            field("Country code"; Rec."Country code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Country code field.', Comment = '%';
            }
            field("Country Name"; Rec."Country Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Country Name field.', Comment = '%';
            }
            //T51238-NE
        }
    }
}