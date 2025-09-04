pageextension 85206 Generalledgersetup_85206 extends "General Ledger Setup"
{
    layout
    {
        //T13883-NS 270225
        addafter("Allow Deferral Posting To")
        {

            field("Posting Restriction"; Rec."Posting Restriction")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting Restriction field.', Comment = '%';
            }
        }

    }
    actions
    {
        addfirst(Processing)
        {
            //T13883-NS
            action("GL Posting Date Update")
            {
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                RunObject = report "GL Posting Date Update";
            }
            //T13883-NE
        }
    }
    //T13883-NE 270225
}
