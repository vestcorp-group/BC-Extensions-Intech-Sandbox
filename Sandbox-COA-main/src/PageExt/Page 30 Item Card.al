// pageextension 50501 "Item Card Ext" extends "Item Card"//T12370-Full Comment
// {
//     layout
//     {
//     }
//     actions
//     {
//         addafter(ApprovalEntries)
//         {
//             action("Testing Parameters")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Testing Parameters';
//                 ToolTip = 'View or edit a list of all the testing parameters';
//                 Image = AnalysisView;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 RunObject = Page "Item Testing Parameters";
//                 RunPageLink = "Item No." = field("No.");
//             }
//             action("Copy Testing Parameters")  //AJAY >>
//             {
//                 ApplicationArea = All;
//                 Caption = 'Copy Testing Parameters';
//                 ToolTip = 'You can copy item testing parameter from existing list';
//                 Image = CopyWorksheet;
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 trigger OnAction()
//                 var
//                     ItemRec: Record Item;
//                     CopyItemTestingParameterReport: Report "Copy Item Testing Parameter";
//                 begin
//                     //ItemRec.SetRange("No.", rec."No.");
//                     //Report.Run(Report::"Copy Item Testing Parameter", true, true, ItemRec);
//                     CopyItemTestingParameterReport.ReportFiletr2(rec."No.");
//                     CopyItemTestingParameterReport.RunModal;

//                 end;
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }