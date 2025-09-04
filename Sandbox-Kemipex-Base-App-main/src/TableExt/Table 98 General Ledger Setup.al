tableextension 50603 GenLedgSetup extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50600; "Default Profit %"; Decimal)
        {
            Caption = 'Default Profit %';
            ObsoleteState = Removed;
            ObsoleteReason = 'Field added to IC partner Record';

        }
        field(50601; "Eliminating GL accounts"; Text[250])
        {
            Caption = 'Eliminating GL account - Debit';
            ObsoleteState = Removed;
        }
        field(50602; "Eliminating GL account Credit"; Code[20])
        {
            Caption = 'Eliminating GL account - Credit';
            TableRelation = "G/L Account"."No.";
        }
        field(50603; "Eliminating GL account Debit"; Text[20])
        {
            Caption = 'Eliminating GL account - Debit';
            TableRelation = "G/L Account"."No.";
        }
        field(50604; "Eliminating Gen. Journal"; Code[20])
        {
            Caption = 'Eliminating Gen. Journal';
            TableRelation = "Gen. Journal Batch".Name where("Template Type" = filter(General));
        }
        field(50605; "Eliminating GL account Creditn"; Code[20])
        {
            Caption = 'Eliminating GL account - Credit';
            TableRelation = "G/L Account"."No.";
        }
        field(50606; "Eliminating GL account Debit-n"; Text[20])
        {
            Caption = 'Eliminating GL account - Debit';
            TableRelation = "G/L Account"."No.";
        }
    }

    var
        myInt: Integer;
}