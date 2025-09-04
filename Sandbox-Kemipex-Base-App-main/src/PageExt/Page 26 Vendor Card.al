// pageextension 50382 VendorCardExt extends "Vendor Card"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//     }

//     actions
//     {
//         addafter(PayVendor)
//         {
//             action("Release to Companies")
//             {
//                 Caption = 'Release to Companies';

//                 ApplicationArea = All;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 var
//                     ReleasetoCompany: Codeunit "Release to Company";
//                 begin
//                     ReleasetoCompany.ReleaseVendorMaster(Rec);
//                 end;
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }