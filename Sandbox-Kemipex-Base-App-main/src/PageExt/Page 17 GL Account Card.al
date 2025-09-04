// pageextension 50383 "G/L Card Ext" extends "G/L Account Card"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         addafter(name) // B GL Account table ext 50481 for Balance Transfer
//         {
//             field(Type1; Rec.Type)
//             {
//                 Caption = 'Type';
//                 ApplicationArea = all;
//             }
//             field("Vendor/Customer No."; Rec."Vendor/Customer No.")
//             {
//                 ApplicationArea = all;
//             }
//             field("Vendor/Customer Name"; Rec."Vendor/Customer Name")
//             {
//                 ApplicationArea = all;
//             }
//         }
//     }

//     actions
//     {
//         addafter("F&unctions")
//         {
//             action("Release To Company")
//             {
//                 Caption = 'Release to Companies';

//                 ApplicationArea = All;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 var
//                     ReleaseToCompany: Codeunit "Release to Company";
//                 begin
//                     ReleaseToCompany.ReleaseGLMaster(Rec);
//                 end;
//             }
//         }

//         // Add changes to page actions here
//     }

//     var
//         myInt: Integer;
// }