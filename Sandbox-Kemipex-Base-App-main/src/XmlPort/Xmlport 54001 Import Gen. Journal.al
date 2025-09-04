/// <summary>
/// XmlPort Import Purchase Invoice (ID 60101).
/// </summary>
xmlport 54001 "Import Gen. Journal"
{
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                UseTemporary = true;
                textelement(Posting_Date) { }
                textelement(Document_No) { }
                textelement(Account_Type) { }
                textelement(Account_No) { }
                textelement(Description) { }
                textelement(Currency_Code) { }
                textelement(Amount) { }
                textelement(IC_Partner_GL_Account_No) { }
                textelement(ExternalDocumentNo) { }
                trigger OnPreXmlItem()
                begin
                    Clear(LineNo);
                    StagingGenJournalLine2.Reset();
                    if StagingGenJournalLine2.FindLast() then
                        LineNo := StagingGenJournalLine2."Line No.";
                end;

                trigger OnAfterInsertRecord()
                begin
                    if RecordCount = 0 then begin
                        Clear(TransactionNo);
                        TransactionNo := LastTransactionNo();
                    end else begin
                        LineNo += 10000;
                        StagingGenJournalLine.Init();
                        StagingGenJournalLine."Upload Batch No." := TransactionNo;
                        evaluate(StagingGenJournalLine."Posting Date", Posting_Date);
                        StagingGenJournalLine."Document No." := Document_No;
                        StagingGenJournalLine."Line No." := LineNo;
                        StagingGenJournalLine.Insert(true);
                        evaluate(StagingGenJournalLine."Account Type", Account_Type);
                        StagingGenJournalLine.validate("Account No.", Account_No);
                        StagingGenJournalLine.Description := Description;
                        StagingGenJournalLine.validate("Currency Code", Currency_Code);
                        StagingGenJournalLine."Uploaded By" := UserId;
                        StagingGenJournalLine."Uploaded Date/Time" := CurrentDateTime;
                        if Amount <> '' then
                            Evaluate(StagingGenJournalLine.Amount, Amount);
                        StagingGenJournalLine.Validate("IC Partner G/L Account No.", IC_Partner_GL_Account_No);
                        if IC_Partner_GL_Account_No <> '' then
                            StagingGenJournalLine.IC := true;
                        StagingGenJournalLine."External Document No." := ExternalDocumentNo;
                        StagingGenJournalLine.Modify;
                        ic := false;
                        StagingGenJournalLine2.Reset();
                        StagingGenJournalLine2.SetRange("Document No.", Document_No);
                        if StagingGenJournalLine2.FindFirst then begin
                            repeat
                                if StagingGenJournalLine2.IC then begin
                                    StagingGenJournalLine3.Reset();
                                    StagingGenJournalLine3.SetRange("Document No.", StagingGenJournalLine2."Document No.");
                                    StagingGenJournalLine3.ModifyAll(IC, true);
                                    IC := true;
                                end;
                            until (StagingGenJournalLine2.Next() = 0) or (IC);
                        end;
                    end;
                    RecordCount += 1;
                end;

                trigger OnAfterInitRecord()
                begin
                    Int1 += 1;
                    Integer.Number := Int1;
                end;

            }

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
                    /*field(Name; SourceExpression)
                    {

                    }
                    */
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = all; // added by B
                }
            }
        }
    }
    local procedure LastTransactionNo() LastTransNo: Integer;
    begin
        Clear(StagingGenJournalLine2);
        StagingGenJournalLine2.Reset();
        StagingGenJournalLine2.SetCurrentKey("Upload Batch No.");
        StagingGenJournalLine2.Ascending(true);
        if StagingGenJournalLine2.FindLast() then
            exit(StagingGenJournalLine2."Upload Batch No." + 1)
        else
            exit(1);
    end;

    trigger OnPreXmlPort()
    begin

    end;

    var
        Int1: Integer;
        RecordCount: Integer;
        StagingGenJournalLine: Record "Staging Gen. Journal Line";
        StagingGenJournalLine2: Record "Staging Gen. Journal Line";
        StagingGenJournalLine3: Record "Staging Gen. Journal Line";
        LineNo: Integer;
        IC: Boolean;
        TransactionNo: Integer;
}