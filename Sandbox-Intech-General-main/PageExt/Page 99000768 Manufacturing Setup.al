pageextension 75082 "Manufacturing Setup Ext" extends "Manufacturing Setup"
{
    layout
    {
        addlast(General)
        {
            field("Check Consumption Booked"; Rec."Check Consumption Booked")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Check Consumption Booked field.', Comment = '%';
                Description = 'ManuChk';
            }
            field("Check Prod Order Status"; Rec."Check Prod Order Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Check Prod Order Status field.', Comment = '%';
                Description = 'ManuChk';
            }
        }
    }
}
