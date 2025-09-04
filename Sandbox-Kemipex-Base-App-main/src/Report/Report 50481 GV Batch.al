// report 50481 "GV Batch"//T12370-Full Comment
// {
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     ProcessingOnly = true;
//     dataset
//     {
//         dataitem("G/L Account"; "G/L Account")
//         {
//             RequestFilterFields = "No.", "Date Filter";
//             trigger OnAfterGetRecord()
//             var
//                 GLEntry: Record "G/L Entry";
//             begin
//                 GenJnlBatch.Get(GenTemplateName_g, GenBatchName_g);
//                 "G/L Account".TestField("Vendor/Customer No.");
//                 if TransactionType = TransactionType::"Per Transaction" then begin
//                     FromDate := GetRangeMin("Date Filter");
//                     ToDate := GetRangeMax("Date Filter");
//                     if (FromDate = 0D) then
//                         Error('Date filter must have value ');
//                     GLEntry.reset;
//                     GlEntry.setrange("G/L Account No.", "No.");
//                     GLEntry.SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
//                     if GLEntry.FindSet then
//                         repeat
//                             Insert_PosGV(GLEntry, "G/L Account");
//                         until GLEntry.next = 0;
//                 end else begin
//                     if DocNo = '' then
//                         Error('Document No. must have a value');
//                     if PostDate = 0D then
//                         Error('Posting Date must have a value');
//                     if Desc = '' then
//                         Error('Description must have a value');
//                     Insert_ClosingPosGV(GLEntry, "G/L Account")
//                 end;
//             end;

//             trigger OnPostDataItem()
//             begin
//                 Message('Entries Created Successfully');
//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(Filter)
//                 {
//                     field(TransactionType; TransactionType)
//                     {
//                         ApplicationArea = All;
//                     }
//                     field(GenTemplateName_g; GenTemplateName_g)
//                     {
//                         Caption = 'Gen. Template Name';
//                         ShowMandatory = true;
//                         ApplicationArea = All;
//                         TableRelation = "Gen. Journal Template";

//                     }
//                     field(GenBatchName_g; GenBatchName_g)
//                     {
//                         Caption = 'Gen. Batch Name';
//                         ShowMandatory = true;
//                         ApplicationArea = All;
//                         trigger OnLookup(var Text: Text): Boolean
//                         var
//                             GenJournalBatch: Record "Gen. Journal Batch";
//                         begin
//                             if GenTemplateName_g = '' then
//                                 Error('Gen. Template Name must have a value');
//                             GenJournalBatch.Reset();
//                             GenJournalBatch.SetRange("Journal Template Name", GenTemplateName_g);
//                             if GenJournalBatch.FindSet() then;
//                             if Page.RunModal(251, GenJournalBatch) = Action::LookupOK then begin
//                                 GenBatchName_g := GenJournalBatch.Name;
//                             end;
//                         end;
//                     }
//                     field(DocNo; DocNo)
//                     {
//                         Caption = 'Document No.';
//                         ApplicationArea = All;
//                     }
//                     field(PostDate; PostDate)
//                     {
//                         Caption = 'Posting Date';
//                         ApplicationArea = All;
//                     }
//                     field(Desc; Desc)
//                     {
//                         Caption = 'Description';
//                         ApplicationArea = All;
//                     }
//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {
//                 action(ActionName)
//                 {
//                     ApplicationArea = All;

//                 }
//             }
//         }
//     }

//     local procedure Insert_PosGV(var GLEntries: Record "G/L Entry"; var GLAccount: Record "G/L Account")
//     var
//         GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";

//     begin
//         GenJournalLine.LockTable();
//         GenJournalLine.Init();
//         GenJournalLine."Journal Template Name" := GenTemplateName_g;
//         GenJournalLine."Journal Batch Name" := GenBatchName_g;
//         GenJournalLine."Line No." := GetLastLineNo(GenTemplateName_g, GenBatchName_g);
//         GenJournalLine."Document No." := GLEntries."Document No.";
//         GenJournalLine."External Document No." := GLEntries."External Document No.";
//         GenJournalLine.Insert(true);
//         //GenJournalLine."Document Type" := GLEntries."Document Type"::Payment;
//         GenJournalLine."Posting Date" := GLEntries."Posting Date";
//         if GLAccount.Type = GLAccount.Type::Customer then
//             GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer
//         else
//             GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;

//         GenJournalLine.Validate("Account No.", GLAccount."Vendor/Customer No.");
//         GenJournalLine.Validate("Currency Code", '');
//         GenJournalLine.Validate(Amount, GLEntries.Amount);
//         GenJournalLine.Validate("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
//         GenJournalLine.Validate("Bal. Account No.", GLAccount."No.");
//         GenJournalLine.Description := GLEntries.Description;
//         // GenJournalLine.Validate("Shortcut Dimension 1 Code", GLEntries."Global Dimension 1 Code");
//         // GenJournalLine.Validate("Shortcut Dimension 2 Code", GLEntries."Global Dimension 2 Code");
//         // GenJournalLine.validate("Dimension Set ID", GLEntries."Dimension Set ID");
//         GenJournalLine.Modify(true);
//     end;

//     local procedure Insert_ClosingPosGV(var GLEntries: Record "G/L Entry"; var GLAccount: Record "G/L Account")
//     var
//         GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
//     begin

//         GenJournalLine.LockTable();
//         GenJournalLine.Init();
//         GenJournalLine."Journal Template Name" := GenTemplateName_g;
//         GenJournalLine."Journal Batch Name" := GenBatchName_g;
//         GenJournalLine."Line No." := GetLastLineNo(GenTemplateName_g, GenBatchName_g);
//         GenJournalLine."Document No." := DocNo;
//         GenJournalLine."External Document No." := GLEntries."External Document No.";
//         GenJournalLine.Insert(true);

//         GenJournalLine."Posting Date" := PostDate;
//         if GLAccount.Type = GLAccount.Type::Customer then
//             GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer
//         else
//             GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;

//         GenJournalLine.Validate("Account No.", GLAccount."Vendor/Customer No.");
//         GenJournalLine.Validate("Currency Code", '');
//         "G/L Account".CalcFields("Net Change");
//         GenJournalLine.Validate(Amount, "G/L Account"."Net Change");
//         GenJournalLine.Validate("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
//         GenJournalLine.Validate("Bal. Account No.", GLAccount."No.");
//         GenJournalLine.Description := Desc;
//         GenJournalLine.Modify(true);
//     end;

//     local procedure GetLastLineNo(var JournalTemplateName_l: code[50]; var JournalBatchName_l: code[50]): Integer;
//     var
//         GenJournalLine: Record "Gen. Journal Line";
//     begin
//         GenJournalLine.Reset();
//         GenJournalLine.SetRange("Journal Template Name", JournalTemplateName_l);
//         GenJournalLine.SetRange("Journal Batch Name", JournalBatchName_l);
//         if GenJournalLine.FindLast() then
//             exit(GenJournalLine."Line No." + 10000)
//         else
//             exit(10000)
//     end;

//     var
//         TransactionType: Option "Per Transaction",Closing;
//         GenTemplateName_g: code[50];
//         GenBatchName_g: Code[50];
//         GenJnlBatch: Record "Gen. Journal Batch";
//         GenJournalLine: Record "Gen. Journal Line";
//         NoSeriesManagement: Codeunit NoSeriesManagement;
//         DocNo: code[20];
//         Desc: text[100];
//         PostDate: Date;
//         FromDate: Date;
//         ToDate: Date;

// }