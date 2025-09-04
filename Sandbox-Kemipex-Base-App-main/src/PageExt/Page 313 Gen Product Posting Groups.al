// pageextension 50388 Gen_prod_posting_GP_page extends "Gen. Product Posting Groups"//T12370-Full Comment
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
//                     ReleaseToCompany.ReleaseGenProdPostGroupToCompany(Rec);
//                 end;
//             }
//         }
//     }
// }