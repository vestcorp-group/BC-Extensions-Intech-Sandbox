// pageextension 50258 KMP_PagExtICPartnersList extends "IC Partner List"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         addafter(Blocked)
//         {
//             field("Default Profit %"; rec."Default Profit %")
//             {
//                 ApplicationArea = All;
//             }
//         }
//     }

//     actions
//     {
//         addfirst(Creation)
//         {
//             action("IC Profit Margins")
//             {
//                 ApplicationArea = All;
//                 Caption = 'IC Profit Margins';
//                 Image = MarketingSetup;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 ToolTip = 'View or edit the profit margins for the intercompany';
//                 RunObject = page "Intercompany Profit Margins";
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }