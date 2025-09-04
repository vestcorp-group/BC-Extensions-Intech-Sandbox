pageextension 75028 GL_Account_Card_75028 extends "G/L Account Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Default Deferral Template Code")
        {
            field("GST Import Duty Code"; Rec."GST Import Duty Code")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}