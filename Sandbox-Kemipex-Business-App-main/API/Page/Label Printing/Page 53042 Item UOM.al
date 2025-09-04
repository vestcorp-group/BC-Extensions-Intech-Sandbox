// page 53042 APIItemUOM//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'LP - API Item UOM';
//     PageType = API;
//     SourceTable = "Item Unit of Measure";
//     Permissions = tabledata "Item Unit of Measure" = R;
//     DataCaptionFields = Code;
//     UsageCategory = History;
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     InsertAllowed = false;

//     // Powerautomate Category
//     EntityName = 'ItemUOM';
//     EntitySetName = 'ItemUOMs';
//     EntityCaption = 'ItemUOM';
//     EntitySetCaption = 'ItemUOMs';
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
//                 field(Code; rec.Code)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Qty_per_Unit_of_Measure"; rec."Qty. per Unit of Measure")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Net_Weight"; rec."Net Weight")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Packing_Weight"; rec."Packing Weight")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Decimal_Allowed"; rec."Decimal Allowed")
//                 {
//                     ApplicationArea = all;
//                 }
//             }

//         }
//     }
// }
