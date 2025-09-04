// pageextension 50391 ReportSeclectionPurcExt extends "Report Selection - Purchase"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//     }

//     actions
//     {
//         // Add changes to page actions here 
//         addfirst(Processing)
//         {
//             action(Release2)
//             {
//                 Caption = 'Release to Companies';
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 trigger OnAction()
//                 var
//                     releasetocompany: Codeunit "Release to Company";

//                 begin
//                     releasetocompany.ReleaseReportSelectionToCompany(Rec);
//                 end;
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }