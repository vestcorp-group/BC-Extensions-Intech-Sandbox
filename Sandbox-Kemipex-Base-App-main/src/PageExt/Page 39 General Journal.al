// /// <summary>//T12370-Full Comment
// /// PageExtension General Journal Ext (ID 60105) extends Record MyTargetPage.
// /// </summary>
// pageextension 54005 "General Journal Ext" extends "General Journal"
// {
//     layout
//     {
//         // Add changes to page layout here
//         addafter("Document No.")
//         {
//             field("Upload Document No."; Rec."Upload Document No.")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field("Upload Document Line No."; rec."Upload Document Line No.")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field("FA Posting Type"; Rec."FA Posting Type")
//             {
//                 ApplicationArea = all;
//             }

//         }
//     }

//     actions
//     {
//         // Add changes to page actions here
//         addafter(Reconcile)
//         {
//             action(CreateLinesFrom)
//             {
//                 Caption = 'Create Lines';
//                 ApplicationArea = All;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Image = CreateDocument;
//                 trigger OnAction()
//                 begin
//                     Clear(OpenStagingGenjournal);
//                     OpenStagingGenjournal.SetJournalBatch(Rec."Journal Template Name", Rec."Journal Batch Name", false);
//                     OpenStagingGenjournal.LookupMode := true;
//                     OpenStagingGenjournal.RunModal();

//                 end;

//             }
//         }

//         addlast("F&unctions")
//         {
//             action("IC-Profit Elimination")
//             {
//                 Caption = 'IC-Profit Elimination';
//                 Image = Report;
//                 ApplicationArea = All;
//                 Visible = false;

//                 trigger OnAction();
//                 begin
//                     report.Run(50600, true, false);
//                 end;
//             }

//             action(GenerateElimination)
//             {
//                 Caption = 'IC-Generate Elimination';
//                 Image = Process;
//                 ApplicationArea = All;
//                 Visible = false;

//                 trigger OnAction();
//                 var
//                     "Elimination Proces": Codeunit "Elimination Proces";
//                 begin
//                     "Elimination Proces".GenerateLines(20200120D, 20210427D);
//                 end;
//             }
//         }
//     }

//     var
//         OpenStagingGenjournal: page "Open Voucher Lines";
// }