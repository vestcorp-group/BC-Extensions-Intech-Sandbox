// page 53041 APIItem//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'LP - API Item';
//     PageType = API;
//     SourceTable = Item;
//     Permissions = tabledata Item = R;
//     DataCaptionFields = "No.";
//     UsageCategory = History;
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     InsertAllowed = false;

//     // Powerautomate Category
//     EntityName = 'Item';
//     EntitySetName = 'Items';
//     EntityCaption = 'Item';
//     EntitySetCaption = 'Items';
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
//                 field("No"; rec."No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Item_Short_Name"; rec."Search Description")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Packing_Description"; Rec."Description 2")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Assembly_BOM"; rec."Assembly BOM")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Base_Unit_of_Measure"; rec."Base Unit of Measure")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Type; rec.Type)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Inventory_Posting_Group"; rec."Inventory Posting Group")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Vendor_Item_No"; rec."Vendor Item No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Vendor_item_description; rec.Vendor_item_description)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("HSN_Code"; rec."Tariff No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Legal_of_Origin_Code"; rec."Country/Region of Origin Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Vendor_Country_of_Origin"; rec."Vendor Country of Origin")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Sales_Unit_of_Measure"; rec."Sales Unit of Measure")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Item_Tracking_Code"; rec."Item Tracking Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Expiration_Calculation"; rec."Expiration Calculation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Blocked; rec.Blocked)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Sales_Blocked"; rec."Sales Blocked")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Purchasing_Blocked"; rec."Purchasing Blocked")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Generic_Description"; rec."Generic Description")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Market_Industry_Desc"; rec."Market Industry Desc.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Item_Category_Desc"; rec."Item Category Desc.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Saber_Code"; rec."Saber Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Precautionary_Statement"; rec."Precautionary Statement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pictogram_Code"; rec."Pictogram Code")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }
// }
