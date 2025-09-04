// page 53034 APIAssemblyOrderHeader//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'LP - API Assembly Order Header';
//     PageType = API;
//     SourceTable = "Assembly Header";
//     Permissions = tabledata "Assembly Header" = R;
//     DataCaptionFields = "No.";
//     UsageCategory = History;
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     InsertAllowed = false;

//     // Powerautomate Category
//     EntityName = 'AssemblyOrderHeader';
//     EntitySetName = 'AssemblyOrderheaders';
//     EntityCaption = 'AssemblyOrderHeader';
//     EntitySetCaption = 'AssemblyOrderHeaders';
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
//                 field("Document_Type"; Rec."Document Type")
//                 {
//                     ApplicationArea = All;
//                 }
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
//                 field(Status; Rec.Status)
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
//                 field("Quantity_to_Assemble"; rec."Quantity to Assemble")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Quantity_to_Assemble_Base"; rec."Quantity to Assemble (Base)")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Remaining_Quantity"; rec."Remaining Quantity")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Remaining_Quantity_Base"; rec."Remaining Quantity (Base)")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Assembled_Quantity"; rec."Assembled Quantity")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Assembled_Quantity_Base"; rec."Assembled Quantity (Base)")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Blanket_Assembly_Order_No"; rec."Blanket Assembly Order No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Vessel; Rec.Vessel)
//                 {
//                     ApplicationArea = all;
//                 }
//             }

//         }
//     }
// }
