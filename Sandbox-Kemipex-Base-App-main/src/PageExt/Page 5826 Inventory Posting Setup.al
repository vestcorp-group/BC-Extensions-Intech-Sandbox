// pageextension 50387 inventorypostingsetuppageext extends "Inventory Posting Setup"//T12370-Full Comment
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
//                     ReleaseToCompany.ReleaseInventorypostingSetupToCompany(Rec);
//                 end;
//             }
//         }
//         // Add changes to page actions here
//     }
//     var
//         myInt: Integer;
// }