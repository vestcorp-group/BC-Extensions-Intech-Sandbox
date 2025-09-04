Report 74986 "Correct Source ID DGLE"
{
    Caption = 'Correct Source ID in Detail GST Ledger Entries';
    ApplicationArea = All;
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Detailed GST Ledger Entry"; "Detailed GST Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.");
            RequestFilterFields = "Document No.";
            trigger OnAfterGetRecord()
            var
                SIH_lRec: Record "Sales Invoice Header";
                SCHM_lRec: Record "Sales Cr.Memo Header";
                PIH_lRec: Record "Purch. Inv. Header";
                PCMH_lRec: Record "Purch. Cr. Memo Hdr.";
            begin
                CurrentRec_gDec += 1;
                Windows_gDlg.Update(2, CurrentRec_gDec);
                IF "Detailed GST Ledger Entry"."Entry Type" <> "Detailed GST Ledger Entry"."Entry Type"::"Initial Entry" then
                    CurrReport.Skip();

                If "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::Invoice Then begin
                    IF SIH_lRec.GET("Detailed GST Ledger Entry"."Document No.") then begin
                        IF "Detailed GST Ledger Entry"."Source No." = SIH_lRec."Sell-to Customer No." then
                            CurrReport.skip;

                        "Detailed GST Ledger Entry"."Source No." := SIH_lRec."Sell-to Customer No.";
                        "Detailed GST Ledger Entry".Modify();
                    end;

                    IF PIH_lRec.GET("Detailed GST Ledger Entry"."Document No.") then begin
                        IF "Detailed GST Ledger Entry"."Source No." = PIH_lRec."Pay-to Vendor No." then
                            CurrReport.skip;

                        "Detailed GST Ledger Entry"."Source No." := PIH_lRec."Pay-to Vendor No.";
                        "Detailed GST Ledger Entry".Modify();
                    end;
                end;

                If "Detailed GST Ledger Entry"."Document Type" = "Detailed GST Ledger Entry"."Document Type"::"Credit Memo" Then begin
                    IF SCHM_lRec.GET("Detailed GST Ledger Entry"."Document No.") then begin
                        IF "Detailed GST Ledger Entry"."Source No." = SCHM_lRec."Sell-to Customer No." then
                            CurrReport.Skip();

                        "Detailed GST Ledger Entry"."Source No." := SCHM_lRec."Sell-to Customer No.";
                        "Detailed GST Ledger Entry".Modify();
                    end;

                    IF PCMH_lRec.GET("Detailed GST Ledger Entry"."Document No.") then begin
                        IF "Detailed GST Ledger Entry"."Source No." = PCMH_lRec."Pay-to Vendor No." then
                            CurrReport.skip;

                        "Detailed GST Ledger Entry"."Source No." := PCMH_lRec."Pay-to Vendor No.";
                        "Detailed GST Ledger Entry".Modify();
                    end;
                end;

                IF CurrentRec_gDec Mod 1000 = 0 then
                    Commit();
            end;

            trigger OnPostDataItem()
            begin
                Windows_gDlg.Close;
            end;

            trigger OnPreDataItem()
            begin
                Windows_gDlg.Open('Total Record : #1#########\' + 'Current Record : #2##########\');
                Windows_gDlg.Update(1, Count);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Windows_gDlg: Dialog;
        CurrentRec_gDec: Decimal;
}