// page 53033 APIPurchaseReceiptLines//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'LP - API Purchase Receipt Lines';
//     PageType = API;
//     SourceTable = "Purch. Rcpt. Line";
//     Permissions = tabledata "Purch. Rcpt. Line" = R;
//     DataCaptionFields = "No.";
//     UsageCategory = History;
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     InsertAllowed = false;

//     // Powerautomate Category
//     EntityName = 'PurchaseReceiptLine';
//     EntitySetName = 'PurchaseReceiptLines';
//     EntityCaption = 'PurchaseReceiptLine';
//     EntitySetCaption = 'PurchaseReceiptLines';
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
//                 field(Type; Rec.Type)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Buy_from_Vendor_No"; Rec."Buy-from Vendor No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Document_No"; Rec."Document No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Line_No"; Rec."Line No.")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("No"; Rec."No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Location_Code"; Rec."Location Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Posting_Group"; Rec."Posting Group")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Variant_Code"; rec."Variant Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Unit_of_Measure_Code"; Rec."Unit of Measure Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Item_HS_Code"; Rec."Item HS Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Item_COO; Rec.Item_COO)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Item_short_name; Rec.Item_short_name)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Quantity; Rec.Quantity)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Base_UOM"; Rec."Base UOM")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Quantity_Base"; Rec."Quantity (Base)")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Unit_Price_Base_UOM"; Rec."Unit Price Base UOM")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Direct_Unit_Cost"; Rec."Direct Unit Cost")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field(CustomETD; Rec.CustomETD)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(CustomETA; Rec.CustomETA)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(CustomR_ETD; Rec.CustomR_ETD)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(CustomR_ETA; Rec.CustomR_ETA)
//                 {
//                     ApplicationArea = All;
//                 }

//             }

//         }
//     }
// }
