// pageextension 58263 Phyinvcountkem extends "Phys. Inv. Journal Kemipex"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//     }

//     actions
//     {
//         // Add changes to page actions here

//         addafter(CountingDataSheet)
//         {
//             action(CountingDataSheet1)
//             {
//                 ApplicationArea = All;
//                 Image = Print;
//                 Caption = 'Print/Export Counting Sheet-New';
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 PromotedCategory = Category9;
//                 trigger OnAction()
//                 var
//                     CountingSheet: Report "Counting Sheet1";
//                 begin
//                     Clear(CountingSheet);
//                     CountingSheet.SetParam(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Document No.", Rec."Posting Date");
//                     CountingSheet.Run();
//                 end;

//             }
//         }
//         modify(CountingDataSheet)
//         {
//             Visible = false;
//         }
//     }

//     var
//         myInt: Integer;
// }