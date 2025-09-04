// PageExtension 75025 pageextension75025 extends "Item Journal"//T13754-NS already in Import Inventory and Balance
// {
//     layout
//     {

//         addafter(ShortcutDimCode8)
//         {
//             field("Error Log"; Rec."Error Log")
//             {
//                 ApplicationArea = Basic;
//                 Style = Unfavorable;
//                 StyleExpr = true;
//             }

//         }
//     }
//     actions
//     {

//         addafter("Post and &Print")
//         {
//             action("Item Journal Post (1 by 1)")
//             {
//                 ApplicationArea = Basic;
//                 Image = UnLinkAccount;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 var
//                     ItemJnlLine: Record "Item Journal Line";
//                 begin
//                     ItemJnlLine.Reset;
//                     ItemJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
//                     ItemJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
//                     Report.RunModal(Report::"Item Jnl Post - 1 Normal Post", true, false, ItemJnlLine);
//                 end;
//             }
//         }
//     }

//     var
//         item_grec: Record Item;
// }

