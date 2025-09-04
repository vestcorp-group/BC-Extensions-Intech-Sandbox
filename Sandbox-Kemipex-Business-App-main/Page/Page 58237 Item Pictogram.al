
// page 58237 "Item Pictogram"//T12370-Full Comment
// {
//     Caption = 'Item Pictogram';
//     DataCaptionFields = "Item No.";
//     PageType = List;
//     SourceTable = "Item Pictogram";
//     PopulateAllFields = true;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Item No."; rec."Item No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pictogram Code"; rec."Pictogram Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Print Sequence"; rec."Print Sequence")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }
// }
