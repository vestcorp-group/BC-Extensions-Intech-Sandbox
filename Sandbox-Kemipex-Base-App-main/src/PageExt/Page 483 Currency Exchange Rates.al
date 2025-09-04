// pageextension 50389 Cur_FX_page extends "Currency Exchange Rates"//T12370-Full Comment
// {
//     actions
//     {
//         addfirst(Creation)
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
//                     ReleaseToCompany: Codeunit "Release to Company";
//                 begin
//                     ReleaseToCompany.ReleaseFXRateToCompany(Rec);
//                 end;
//             }
//         }
//     }
// }