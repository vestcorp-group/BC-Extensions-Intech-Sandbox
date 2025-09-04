// page 53038 APISalesShipmentHeader//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'LP - API Sales Shipment Header';
//     PageType = API;
//     SourceTable = "Sales Shipment Header";
//     Permissions = tabledata "Sales Shipment Header" = R;
//     DataCaptionFields = "No.";
//     UsageCategory = History;
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     InsertAllowed = false;

//     // Powerautomate Category
//     EntityName = 'SalesShipmentHeader';
//     EntitySetName = 'SalesShipmentheaders';
//     EntityCaption = 'SalesShipmentHeader';
//     EntitySetCaption = 'SalesShipmentHeaders';
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
//                 field("Bill_to_Customer_No"; rec."Bill-to Customer No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Bill_to_Name"; rec."Bill-to Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Order_Date"; Rec."Order Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Posting_Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Document_Date"; rec."Document Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("External_Document_No"; rec."External Document No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Payment_Terms_Code"; rec."Payment Terms Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Order_No"; rec."Order No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Salesperson_Code"; Rec."Salesperson Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Salesperson_Name"; rec."Salesperson Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Incoterm"; rec."Transaction Specification")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(POL; Rec."Exit Point")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(POD; Rec."Area")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Transport_Method"; rec."Transport Method")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ship_to_Code"; rec."Ship-to Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ship_to_Name"; rec."Ship-to Name")
//                 {
//                     ApplicationArea = all;
//                 }

//             }

//         }
//     }
// }
