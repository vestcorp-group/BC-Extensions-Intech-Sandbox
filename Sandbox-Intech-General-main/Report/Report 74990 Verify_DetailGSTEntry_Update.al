report 74990 Verify_DetailGSTEntry_Update
{
    //Correct_DocNo_DGST_TransferReceipt
    ApplicationArea = All;
    Caption = 'DetailGSTLedgerEntry Verify Document No.';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Verify_DetailGSTEntry_Update.rdlc';
    dataset
    {
        dataitem(DetailedGSTLedgerEntry; "Detailed GST Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "Entry No.";
            column(PostingDate; "Posting Date")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(SuggestedTRNo_gCod; SuggestedTRNo_gCod)
            {
            }

            trigger OnAfterGetRecord()
            var
                TSH_lRec: Record "Transfer Shipment Header";
                TRH_lRec: Record "Transfer Receipt Header";
                ModDGLE_lRec: Record "Detailed GST Ledger Entry";
            begin
                IF StrLen(DetailedGSTLedgerEntry."External Document No.") > 20 then
                    CurrReport.skip;

                IF DetailedGSTLedgerEntry."External Document No." = '' then
                    CurrReport.skip;

                IF TSH_lRec.GET(DetailedGSTLedgerEntry."External Document No.") Then begin
                    IF TSH_lRec."Transfer Order No." = '' then
                        CurrReport.skip;

                    TRH_lRec.Reset();
                    TRH_lRec.Setrange("Transfer Order No.", TSH_lRec."Transfer Order No.");
                    TRH_lRec.FindFirst();
                    IF TRH_lRec.Count > 1 then
                        Error('More record found');

                    SuggestedTRNo_gCod := TRH_lRec."No.";

                    IF SuggestedTRNo_gCod = DetailedGSTLedgerEntry."Document No." then
                        CurrReport.Skip();

                    ModDGLE_lRec.GET("Entry No.");
                    ModDGLE_lRec."Document No." := SuggestedTRNo_gCod;
                    ModDGLE_lRec.Modify();
                end Else
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                DetailedGSTLedgerEntry.SetRange("Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
                DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Purchase);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        IF UserId <> 'BCADMIN' then
            Error('Only BCADMIN can Run Report');
    end;

    var
        SuggestedTRNo_gCod: Code[20];
}
