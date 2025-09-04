// page 53039 APISalesShipmentLines//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'LP - API Sales Shipment Lines';
//     PageType = API;
//     SourceTable = "Sales Shipment Line";
//     Permissions = tabledata "Sales Shipment Line" = R;
//     DataCaptionFields = "No.";
//     UsageCategory = History;
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     InsertAllowed = false;

//     // Powerautomate Category
//     EntityName = 'SalesShipmentLine';
//     EntitySetName = 'SalesShipmentLines';
//     EntityCaption = 'SalesShipmentLine';
//     EntitySetCaption = 'SalesShipmentLines';
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
//                 field("Bill_to_Customer_No"; rec."Bill-to Customer No.")
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
//                 field("Order_No"; rec."Order No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Blanket_Order_No"; rec."Blanket Order No.")
//                 {
//                     ApplicationArea = all;
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
//                 field(HSNCode; rec.HSNCode)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(LineHSNCode; rec.LineHSNCode)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(CountryOfOrigin; rec.CountryOfOrigin)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(LineCountryOfOrigin; rec.LineCountryOfOrigin)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Item_Generic_Name"; rec."Item Generic Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Line_Generic_Name"; rec."Line Generic Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Packing_Description"; Rec."Description 2")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Quantity; Rec.Quantity)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Quantity_Base"; rec."Quantity (Base)")
//                 {
//                     ApplicationArea = All;
//                 }

//             }

//         }
//     }
// }
