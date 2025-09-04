pageextension 50263 KMP_BankAccountcard extends "Bank Account Card"//T12370-Full Comment
{
    //     layout
    //     {
    //         // Add changes to page layout here
    //         addafter("Bank Clearing Code")
    //         {

    //         }
    //     }

    actions
    {
        addlast(reporting)
        {
            action("Reconciliation Statement")
            {
                ApplicationArea = All;
                Caption = 'Reconciliation Statement';
                Image = BankAccountStatement;
                trigger OnAction()
                var
                    BankAccountL: Record "Bank Account";
                begin
                    BankAccountL.SetRange("No.", rec."No.");
                    Report.Run(Report::"Bank Reconciliation", true, true, BankAccountL);
                end;
            }
        }
    }

    //     var
    //         myInt: Integer;
}