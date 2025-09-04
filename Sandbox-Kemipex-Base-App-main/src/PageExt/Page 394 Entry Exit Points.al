// pageextension 50385 POL_page extends "Entry/Exit Points"//T12370-Full Comment
// {
//     actions
//     {
//         addfirst(Creation)
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
//                     Releasetocompany: Codeunit "Release to Company";
//                 begin
//                     Releasetocompany.ReleasePOLtoCompany(Rec);
//                 end;
//             }
//         }
//     }
// }