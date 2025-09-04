// pageextension 50390 ReportSelectionSalesExt extends "Report Selection - Sales"//T12370-Full Comment
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
//             action(Release)
//             {
//                 Caption = 'Release to Companies';
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 trigger OnAction()
//                 var
//                     ReleaseToCompany: Codeunit "Release to Company";
//                 begin
//                     ReleaseToCompany.ReleaseReportSelectionToCompany(rec);
//                 end;
//             }

//         }
//     }

//     var
//         myInt: Integer;
// }