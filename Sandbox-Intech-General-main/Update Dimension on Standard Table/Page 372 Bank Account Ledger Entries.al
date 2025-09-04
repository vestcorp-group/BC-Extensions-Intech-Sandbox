pageextension 74990 BankAcc_Ledger_Entries_74990 extends "Bank Account Ledger Entries"
{
    Caption = 'Bank Account Ledger Entries';
    layout
    {
        modify("Shortcut Dimension 3 Code")
        {
            Visible = SD3CodeVisible;
        }
        modify("Shortcut Dimension 4 Code")
        {
            Visible = SD4CodeVisible;
        }
        modify("Shortcut Dimension 5 Code")
        {
            Visible = SD5CodeVisible;
        }
        modify("Shortcut Dimension 6 Code")
        {
            Visible = SD6CodeVisible;
        }
        modify("Shortcut Dimension 7 Code")
        {
            Visible = SD7CodeVisible;
        }
        modify("Shortcut Dimension 8 Code")
        {
            Visible = SD8CodeVisible;
        }
    }
    var
        //[InDataSet]
        SD3CodeVisible: Boolean;
        //[InDataSet]
        SD4CodeVisible: Boolean;
        //[InDataSet]
        SD5CodeVisible: Boolean;
        //[InDataSet]
        SD6CodeVisible: Boolean;
        //[InDataSet]
        SD7CodeVisible: Boolean;
        //[InDataSet]
        SD8CodeVisible: Boolean;

    trigger OnOpenPage()
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        GeneralLedgerSetup.Get();
        If GeneralLedgerSetup."Shortcut Dimension 3 Code" <> '' then
            SD3CodeVisible := True;

        If GeneralLedgerSetup."Shortcut Dimension 4 Code" <> '' then
            SD4CodeVisible := true;

        If GeneralLedgerSetup."Shortcut Dimension 5 Code" <> '' then
            SD5CodeVisible := True;

        If GeneralLedgerSetup."Shortcut Dimension 6 Code" <> '' then
            SD6CodeVisible := True;

        If GeneralLedgerSetup."Shortcut Dimension 7 Code" <> '' then
            SD7CodeVisible := True;

        If GeneralLedgerSetup."Shortcut Dimension 8 Code" <> '' then
            SD8CodeVisible := True;
    end;
}