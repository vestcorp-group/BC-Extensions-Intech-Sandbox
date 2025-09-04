pageextension 50476 VatPostingSetupExt extends "VAT Posting Setup"//T12370-Full Comment
{
    layout
    {
        //T13730-NS AS

        addafter("Purchase VAT Account")
        {
            
            field("Sales OTV Account"; Rec."Sales OTV Account")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales OTV Account field.', Comment = '%';
            }
            field("Purchase OTV Account"; Rec."Purchase OTV Account")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase OTV Account field.', Comment = '%';
            }
        }
         //T13730-NE AS
         
        // Add changes to page layout here
        // addafter("VAT %")
        // {
        //     field("Out of scope"; rec."Out of scope")
        //     {
        //         ApplicationArea = all;
        //     }
        // }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}