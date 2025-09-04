// page 53043 APIItemPictogram//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'LP - API Item Pictogram';
//     PageType = API;
//     SourceTable = "Item Pictogram";
//     Permissions = tabledata "Item Pictogram" = R;
//     DataCaptionFields = "Item No.";
//     UsageCategory = History;
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     InsertAllowed = false;

//     // Powerautomate Category
//     EntityName = 'ItemPictogram';
//     EntitySetName = 'ItemPictograms';
//     EntityCaption = 'ItemPictogram';
//     EntitySetCaption = 'ItemPictograms';
//     // ODataKeyFields = SystemId;
//     Extensible = false;

//     APIPublisher = 'Kemipex';
//     APIGroup = 'LabelPrinting';
//     APIVersion = 'v2.0';


//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Item_No"; rec."Item No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pictogram_Code"; rec."Pictogram Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Print_Sequence"; rec."Print Sequence")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }
// }
