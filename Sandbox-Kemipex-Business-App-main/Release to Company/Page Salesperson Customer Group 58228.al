// pageextension 58228 SPCustomergrouppageext extends "Sales Person Customer Group"
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