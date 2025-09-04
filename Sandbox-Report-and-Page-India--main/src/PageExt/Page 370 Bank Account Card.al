pageextension 50117 BankAccExt extends "Bank Account Card"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here
        addafter("Bank Branch No.")
        {
            field("Branch Name"; rec."Branch Name")
            {
                ApplicationArea = all;

            }
            /*  // Hide by B, MS update
            field("IFSC CODE"; rec."IFSC CODE")
             {
                 ApplicationArea = all;
             } */
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}