// pageextension 50384 POD_page extends Areas//T12370-Full Comment
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
//                     releasetocompany: Codeunit "Release to Company";
//                 begin
//                     releasetocompany.ReleasePODtoCompany(Rec);
//                 end;
//             }

//         }
//         // Add changes to page actions here
//     }

// }