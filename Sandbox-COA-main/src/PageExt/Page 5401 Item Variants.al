// pageextension 50511 "Item Variant List" extends "Item Variants"//T12370-Full Comment
// {
//     layout
//     {
//     }

//     actions
//     {
//         addafter(Translations)
//         {
//             action("Testing Parameters") //AJAY >>
//             {
//                 ApplicationArea = all;
//                 Caption = 'Testing Parameters';
//                 ToolTip = 'View or edit a list of all the testing parameters';
//                 Image = AnalysisView;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Page "Item Variant Test Parameters";
//                 RunPageLink = "Item No." = field("Item No."), "Variant Code" = field(Code);
//                 //RunPageLink = "Item No." = field("Item No.");
//             }
//             action("Copy Testing Parameters")  //AJAY >>
//             {

//                 ApplicationArea = All;
//                 Caption = 'Copy Testing Parameters';
//                 Image = CopyItem;
//                 ToolTip = 'Copy the item Variant testing parameter.';
//                 trigger OnAction()
//                 var
//                     ItemVariant: Record "Item Variant";
//                     CopyItemVariantReport: Report "Copy Testing Parameter";
//                 begin
//                     //ItemVariant.SetRange("Item No.", Rec."Item No.");
//                     //ItemVariant.SetRange(Code, Rec.Code);
//                     //Report.Run(Report::"Copy Testing Parameter", true, true, ItemVariant);
//                     CopyItemVariantReport.ReportFiletr2(Rec."Item No.", Rec.Code);
//                     CopyItemVariantReport.RunModal;
//                 end;
//             }//AJAY<<
//         }
//     }

//     var
//         myInt: Integer;
// }