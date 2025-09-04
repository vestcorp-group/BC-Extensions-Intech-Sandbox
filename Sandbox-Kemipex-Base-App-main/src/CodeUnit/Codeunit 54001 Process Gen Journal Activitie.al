/// <summary>               //T12370-Full Comment
/// Codeunit Process Staging Activitie (ID 60100).
/// </summary>
codeunit 54001 "Process Gen Journal Activitie"      //T13413-FullUnComment
{
    TableNo = "Staging Gen. Journal Line";
    trigger OnRun()
    begin
        TempStagingGenjournal_g.TransferFields(Rec);
        TempStagingGenjournal_g.Insert();
        InsertGenJournalLine();
        StagingGenjournal_g.Get(TempStagingGenjournal_g."Document No.", TempStagingGenjournal_g."Line No.");
        StagingGenjournal_g."Gen. Doc" := GenJournalLine_g."Document No.";
        StagingGenjournal_g."Journal Template Name" := GenJnlBatch."Journal Template Name";
        StagingGenjournal_g."Journal Batch Name" := GenJnlBatch.Name;
        StagingGenjournal_g.Status := StagingGenjournal_g.Status::Created;
        StagingGenjournal_g.Modify();
        TempStagingGenjournal_g.DeleteAll();
        Commit();
    end;
    /// <summary>
    /// ImportStagingGenJournal.
    /// </summary>
    procedure ImportStagingGenJournal()
    begin
        Xmlport.Run(54001, false, true);
    end;
    /// <summary>
    /// ProcessStagingGenJournal. 
    /// </summary>
    procedure InsertGenJournalLine()
    begin
        FindGenJournalDocNo(TempStagingGenjournal_g."Document No.");
        GenJournalLine_g.Init();
        GenJournalLine_g."Journal Template Name" := GenJnlBatch."Journal Template Name";
        GenJournalLine_g."Journal Batch Name" := GenJnlBatch.Name;
        GenJournalLine_g."Line No." := FindLineNo;
        if DocumentNo <> '' then
            GenJournalLine_g."Document No." := DocumentNo
        else
            if GenJnlBatch."No. Series" <> '' then
                GenJournalLine_g."Document No." := NoSeriesManagement.GetNextNo(GenJnlBatch."No. Series", Today, true)
            else
                GenJournalLine_g."Document No." := TempStagingGenjournal_g."Document No.";
        GenJournalLine_g."Upload Document No." := TempStagingGenjournal_g."Document No.";
        GenJournalLine_g."Upload Document Line No." := TempStagingGenjournal_g."Line No.";
        GenJournalLine_g."External Document No." := TempStagingGenjournal_g."External Document No.";
        GenJournalLine_g."Posting Date" := TempStagingGenjournal_g."Posting Date";
        GenJournalLine_g.validate("Account Type", TempStagingGenjournal_g."Account Type");
        GenJournalLine_g.validate("Account No.", TempStagingGenjournal_g."Account No.");
        GenJournalLine_g.Description := TempStagingGenjournal_g.Description;
        if TempStagingGenjournal_g."Currency Code" <> '' then begin
            currencies.get(TempStagingGenjournal_g."Currency Code");
            GenJournalLine_g.validate("Currency Code", TempStagingGenjournal_g."Currency Code");
        end;
        GenJournalLine_g.validate(Amount, TempStagingGenjournal_g.Amount);
        GenJournalLine_g.validate("IC Account No.", TempStagingGenjournal_g."IC Partner G/L Account No.");
        GenJournalLine_g.Insert;
    end;

    local procedure FindGenJournalDocNo(Var DoumentNo_p: Code[50])
    begin
        Clear(DocumentNo);
        GenJournalLine_g2.reset;
        GenJournalLine_g2.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Upload Document No.");
        GenJournalLine_g2.SetRange("Journal Template Name", GenJnlBatch."Journal Template Name");
        GenJournalLine_g2.SetRange("Journal Batch Name", GenJnlBatch.Name);
        GenJournalLine_g2.SetRange("Upload Document No.", DoumentNo_p);
        if GenJournalLine_g2.FindFirst() then
            DocumentNo := GenJournalLine_g2."Document No.";

    end;

    local procedure FindLineNo() LineNo: Integer;
    begin
        GenJournalLine_g2.reset;
        GenJournalLine_g2.SetRange("Journal Template Name", GenJnlBatch."Journal Template Name");
        GenJournalLine_g2.SetRange("Journal Batch Name", GenJnlBatch.Name);
        if GenJournalLine_g2.FindLast() then
            exit(GenJournalLine_g2."Line No." + 10000)
        else
            exit(10000);
    end;

    /// <summary>
    /// SetJournalBatch.
    /// </summary>
    /// <param name="JournalTemplateName_p">VAR code[50].</param>
    /// <param name="JournalBatchName_p">VAR Code[50].</param>
    procedure SetJournalBatch(var JournalTemplateName_p: code[50]; var JournalBatchName_p: Code[50])
    begin
        GenJnlBatch.Get(JournalTemplateName_p, JournalBatchName_p);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnAfterCode', '', true, true)]
    local procedure "Gen. Jnl.-Post Batch_OnAfterCode"
    (
        var GenJournalLine: Record "Gen. Journal Line";
        PreviewMode: Boolean
    )
    begin
        repeat
            if not PreviewMode then begin
                StagingGenjournal_g.Reset();
                StagingGenjournal_g.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
                StagingGenjournal_g.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
                StagingGenjournal_g.SetRange(Status, StagingGenjournal_g.Status::Created);
                StagingGenjournal_g.modifyall(Status, StagingGenjournal_g.Status::Closed);
            end;
        until GenJournalLine.Next() = 0;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGlobalGLEntry', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnBeforeInsertGlobalGLEntry"
    (
        var GlobalGLEntry: Record "G/L Entry";
        GenJournalLine: Record "Gen. Journal Line";
        GLRegister: Record "G/L Register"
    )
    begin
        GlobalGLEntry."Upload Document No." := GenJournalLine."Upload Document No.";
    end;


    var
        TempStagingGenjournal_g: Record "Staging Gen. Journal Line" temporary;
        StagingGenjournal_g: Record "Staging Gen. Journal Line";
        StagingGenjournal_g2: Record "Staging Gen. Journal Line";
        GenJournalLine_g: Record "Gen. Journal Line";
        GenJournalLine_g2: Record "Gen. Journal Line";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        GenJnlBatch: Record "Gen. Journal Batch";
        FindDocGenJournalLine_g: Record "Gen. Journal Line";
        DocumentNo: code[20];
        LineNo: Integer;
        currencies: Record Currency;

}