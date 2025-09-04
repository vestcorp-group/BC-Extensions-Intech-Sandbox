// page 53035 APIPostedAssemblyOrderHeader//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'LP - API Posted Assembly Order Header';
//     PageType = API;
//     SourceTable = "Posted Assembly Header";
//     Permissions = tabledata "Posted Assembly Header" = R;
//     DataCaptionFields = "No.";
//     UsageCategory = History;
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     InsertAllowed = false;

//     // Powerautomate Category
//     EntityName = 'PostedAssemblyOrderHeader';
//     EntitySetName = 'PostedAssemblyOrderheaders';
//     EntityCaption = 'PostedAssemblyOrderHeader';
//     EntitySetCaption = 'PostedAssemblyOrderHeaders';
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
//                 field("No"; Rec."No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Packing_Description; rec."Description 2")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Item_No"; rec."Item No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Variant_Code"; rec."Variant Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Posting_Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Location_Code"; rec."Location Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Quantity; rec.Quantity)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Quantity_Base"; Rec."Quantity (Base)")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Blanket_Assembly_Order_No"; rec."Blanket Assembly Order No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Reversed; rec.Reversed)
//                 {
//                     ApplicationArea = all;
//                 }
//             }

//         }
//     }
// }
