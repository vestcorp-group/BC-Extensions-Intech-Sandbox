// pageextension 58227 Customergrouppageext extends "Customer Group"//T12370-Full Comment
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
//                     myInt: Integer;
//                 begin
//                     rec.companytransfer(xRec);
//                 end;
//             }

//         }
//         // Add changes to page actions here
//     }
//     var
//         myInt: Integer;
// }