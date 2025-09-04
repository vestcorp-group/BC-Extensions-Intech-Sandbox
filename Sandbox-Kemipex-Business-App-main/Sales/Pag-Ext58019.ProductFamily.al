// pageextension 58019 ProductFamily extends "Product Family"//T12370-Full Comment
// {
//     actions
//     {
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
//                 begin
//                     rec.companytransfer(xRec);
//                 end;
//             }
//         }
//     }
// }
