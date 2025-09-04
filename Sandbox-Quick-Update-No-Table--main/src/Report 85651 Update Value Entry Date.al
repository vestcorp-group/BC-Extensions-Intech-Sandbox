report 85651 "Update Value Entry Date"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/R85651.rdl';
    Permissions = tabledata "Value Entry" = RM, tabledata "G/L Entry" = RM;

    dataset
    {
        dataitem(VE; "Value Entry")
        {

            RequestFilterFields = "Posting Date", "Document No.";

            column(EntryNo_VE; "Entry No.")
            {
            }
            column(PostingDate_VE; "Posting Date")
            {
            }
            column(ItemLedgerEntryType_VE; "Item Ledger Entry Type")
            {
            }
            column(DocumentType_VE; "Document Type")
            {
            }
            column(DocumentNo_VE; "Document No.")
            {
            }
            column(Adjustment_VE; Adjustment)
            {
            }
            column(SourceCode_VE; "Source Code")
            {
            }
            column(ItemLedgerEntryNo_VE; "Item Ledger Entry No.")
            {
            }
            column(NewPostingDate; NewPostingdate_gDte)
            {
            }

            trigger OnAfterGetRecord()
            var
                CheckVE_lRec: Record "Value Entry";
                ModValueEntry_lRec: Record "Value Entry";
                GLItemLedgRelation: Record "G/L - Item Ledger Relation";
                GLEntry: Record "G/L Entry";
            begin
                CurrentRec_gDec += 1;
                Windows_gDlg.Update(2, CurrentRec_gDec);

                CheckVE_lRec.RESET;
                CheckVE_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry No.");
                CheckVE_lRec.SetRange("Document No.", "Document No.");
                CheckVE_lRec.SetRange("Document Type", "Document Type");
                CheckVE_lRec.SetFilter("Source Code", '<>%1', "Source Code");
                CheckVE_lRec.FindFirst();
                NewPostingdate_gDte := CheckVE_lRec."Posting Date";

                IF VE."Posting Date" = NewPostingdate_gDte then
                    CurrReport.Skip();

                IF UpdateDate_gBln Then begin
                    EntryUpd_gInt += 1;
                    Windows_gDlg.Update(3, EntryUpd_gInt);

                    ModValueEntry_lRec.GET("Entry No.");
                    ModValueEntry_lRec."Posting Date" := NewPostingdate_gDte;
                    ModValueEntry_lRec."Document Date" := NewPostingdate_gDte;
                    ModValueEntry_lRec."VAT Reporting Date" := NewPostingdate_gDte;
                    ModValueEntry_lRec.Modify();

                    GLItemLedgRelation.RESET;
                    GLItemLedgRelation.SetCurrentKey("Value Entry No.");
                    GLItemLedgRelation.SetRange("Value Entry No.", ModValueEntry_lRec."Entry No.");
                    if GLItemLedgRelation.FindSet() then
                        repeat
                            GLEntry.Get(GLItemLedgRelation."G/L Entry No.");
                            GLEntry."Posting Date" := NewPostingdate_gDte;
                            GLEntry."Document Date" := NewPostingdate_gDte;
                            GLEntry."VAT Reporting Date" := NewPostingdate_gDte;
                            GLEntry.Modify();
                        until GLItemLedgRelation.Next() = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Windows_gDlg.Close;
            end;

            trigger OnPreDataItem()
            begin
                IF VE.GetFilter("Posting Date") = '' then
                    Error('Enter Posting Date Filter');

                VE.SetRange("Source Code", 'INVTADJMT');

                IF UpdateDate_gBln then begin
                    IF NOT COnfirm('You have selected Update Date in GL Entry and Value Entry, Do you want to contnue?', TRUE) then
                        Error('Not Confirm');
                end;


                Windows_gDlg.Open('Total Record : #1#########\' + 'Current Record : #2##########\Entry Updated #3##########');
                Windows_gDlg.Update(1, Count);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(UpdateDate_gBln; UpdateDate_gBln)
                {
                    ApplicationArea = All;
                    Caption = 'Update Date in Value Entry and GL Entry';
                }
            }
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
        NewPostingdate_gDte: Date;
        UpdateDate_gBln: Boolean;
        EntryUpd_gInt: Integer;
}