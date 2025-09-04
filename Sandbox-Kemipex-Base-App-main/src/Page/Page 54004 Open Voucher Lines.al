// /// <summary>//T12370-Full Comment
// /// Page Staging Gen. Journal (ID 60103).
// /// </summary>

// page 54004 "Open Voucher Lines"
// {
//     Caption = 'Open Voucher Lines';
//     PageType = List;
//     SourceTable = "Staging Gen. Journal Line";
//     SourceTableView = sorting("Upload Batch No.", "Document No.", "Line No.") WHERE(Status = FILTER(Open));
//     InsertAllowed = false;
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     layout
//     {
//         area(Content)
//         {
//             repeater(General)
//             {
//                 field("Upload Batch No."; Rec."Upload Batch No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Document No."; rec."Document No.")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Gen. Doc"; Rec."Gen. Doc")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Created Document No.';
//                 }
//                 field("Line No."; rec."Line No.")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("External Document No."; rec."External Document No.")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Account Type"; rec."Account Type")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Account No."; rec."Account No.")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Currency Code"; rec."Currency Code")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field(Amount; rec.Amount)
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("IC Partner G/L Account No."; rec."IC Partner G/L Account No.")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field(Status; rec.Status)
//                 {
//                     ApplicationArea = All;
//                     Editable = NonEdiTablestatus;

//                 }
//                 field("Uploaded By"; Rec."Uploaded By")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Uploaded Date/Time"; Rec."Uploaded Date/Time")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Modify By"; Rec."Modify By")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Modify On"; Rec."Modify On")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }

//             }
//         }

//     }
//     trigger OnOpenPage()
//     begin
//         Rec.SetRange(IC, ShowICRecord);
//     end;

//     trigger OnQueryClosePage(CloseAction: Action): Boolean
//     begin
//         if CloseAction in [ACTION::OK, ACTION::LookupOK] then
//             CreateLines;
//     end;


//     /// <summary>
//     /// SetJournalBatch.
//     /// </summary>
//     /// <param name="JournalTemplateName_p">VAR code[50].</param>
//     /// <param name="JournalBatchName_p">VAR Code[50].</param>
//     /// <param name="ICDocument">Boolean.</param>
//     procedure SetJournalBatch(var JournalTemplateName_p: code[50]; var JournalBatchName_p: Code[50]; ICDocument: Boolean)
//     begin
//         GenJnlBatch.Get(JournalTemplateName_p, JournalBatchName_p);
//         ShowICRecord := ICDocument;
//     end;

//     /// <summary>
//     /// CreateLines.
//     /// </summary>
//     procedure CreateLines()
//     begin
//         CurrPage.SetSelectionFilter(Rec);
//         Clear(StagingGenJournalLine_G);
//         clear(ProcessStagingActivities);
//         StagingGenJournalLine_G.Copy(Rec);
//         StagingGenJournalLine_G.setfilter(Status, '%1|%2', StagingGenJournalLine_G.Status::Open, StagingGenJournalLine_G.Status::Error);
//         if StagingGenJournalLine_G.FindSet() then begin
//             ProcessStagingActivities.SetJournalBatch(GenJnlBatch."Journal Template Name", GenJnlBatch.Name);
//             repeat
//                 if not ProcessStagingActivities.Run(StagingGenJournalLine_G) then begin
//                     StagingGenJournalLine_G.Status := StagingGenJournalLine_G.Status::Error;
//                     StagingGenJournalLine_G."Error Remarks" := Copystr(GetLastErrorText, 1, 250);
//                     StagingGenJournalLine_G.Modify(true)
//                 end;
//                 Commit();
//             until StagingGenJournalLine_G.next = 0;
//         end;

//     end;

//     trigger OnAfterGetRecord()
//     begin
//         NonEdiTablestatus := true;
//         if rec.Status = rec.Status::Created then
//             NonEdiTablestatus := false;


//     end;



//     var
//         StagingGenJournalLine_G: Record "Staging Gen. Journal Line";
//         GenJnlBatch: Record "Gen. Journal Batch";
//         ProcessStagingActivities: Codeunit "Process Gen Journal Activitie";
//         ShowICRecord: Boolean;
//         NonEdiTablestatus: Boolean;
// }