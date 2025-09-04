// pageextension 50386 ItemCharge_page extends "Item Charges"//T12370-Full Comment
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
//                     ReleaseToCompany.ReleaseItemChargeToCompany(Rec);
//                 end;
//             }

//         }

//     }
// }