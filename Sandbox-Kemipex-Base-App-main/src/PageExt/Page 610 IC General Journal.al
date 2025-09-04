// /// <summary>//T12370-Full Comment
// /// PageExtension General Journal Ext (ID 60105) extends Record MyTargetPage.
// /// </summary>
// pageextension 54008 "IC General Journal Ext" extends "IC General Journal"
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
//                     OpenStagingGenjournal.SetJournalBatch(Rec."Journal Template Name", Rec."Journal Batch Name", true);
//                     OpenStagingGenjournal.LookupMode := true;
//                     OpenStagingGenjournal.RunModal();
//                 end;
//             }
//         }
//     }

//     var
//         OpenStagingGenjournal: page "Open Voucher Lines";

// }