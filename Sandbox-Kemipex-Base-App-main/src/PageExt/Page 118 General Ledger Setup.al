pageextension 50603 GenLedgSetup extends "General Ledger Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Control1900309501")
        {
            group("Custom IC Setup")
            {
                Caption = 'Custom IC Setup';

                field("Eliminating Gen. Journal"; rec."Eliminating Gen. Journal")
                {
                    ApplicationArea = all;
                }

                group(positiveAmounts)
                {
                    Caption = 'Eliminating GL accounts for positive amount';
                    field("Eliminating GL account Debit"; rec."Eliminating GL account Debit")
                    {
                        ApplicationArea = All;
                    }
                    field("Eliminating GL account Credit"; rec."Eliminating GL account Credit")
                    {
                        ApplicationArea = All;
                    }
                }
                group(negAmounts)
                {
                    Caption = 'Eliminating GL accounts for negative amount';
                    field("Eliminating GL account Debitn"; rec."Eliminating GL account Debit-n")
                    {
                        ApplicationArea = All;
                    }
                    field("Eliminating GL account Creditn"; rec."Eliminating GL account Creditn")
                    {
                        ApplicationArea = All;
                    }
                }
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