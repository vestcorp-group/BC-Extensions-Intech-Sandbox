pageextension 85201 UserSetup50121 extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            //ReOpenPrOrd-NS
            field("Allow to Re-Open Prod Order."; Rec."Allow to Re-Open Prod Order.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow to Re-Open Finish Production Order field.';
            }
            //ReOpenPrOrd-NE

            //T11452-NS
            field("Posting Restriction"; Rec."Posting Restriction")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting Restriction field.';
            }
            //T11452-NE
            field("Allow to view Sales Price"; Rec."Allow to view Sales Price")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow to view Sales Price Detail field.', Comment = '%';
                Description = 'T13852';
            }
            //14042025-OS
            // field("Sales Support User"; Rec."Sales Support User")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Sales Support User field.', Comment = '%';
            // }
            //14042025-OE
        }
    }


    actions
    {
        addfirst(Processing)
        {
            //T11452-NS
            action("User Posting Date Update")
            {
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                RunObject = report "User Posting Date Update";
            }
            //T11452-NE
        }
    }
}