
// page 53032 APIPurchaseReceiptHeader//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'LP - API Purchase Receipt Header';
//     PageType = API;
//     SourceTable = "Purch. Rcpt. Header";
//     Permissions = tabledata "Purch. Rcpt. Header" = R;
//     DataCaptionFields = "No.";
//     UsageCategory = History;
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     InsertAllowed = false;

//     // Powerautomate Category
//     EntityName = 'PurchaseReceiptHeader';
//     EntitySetName = 'PurchaseReceiptheaders';
//     EntityCaption = 'PurchaseReceiptHeader';
//     EntitySetCaption = 'PurchaseReceiptHeaders';
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
//                 field("Buy_from_Vendor_No"; Rec."Buy-from Vendor No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Buy_from_Vendor_Name"; Rec."Buy-from Vendor Name")
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
//                 field("Payment_Terms_Code"; rec."Payment Terms Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Vendor_Order_No"; rec."Vendor Order No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Vendor_Invoice_No"; rec."Vendor Invoice No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(CustomBOENumber; rec.CustomBOENumber)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Incoterm"; rec."Transaction Specification")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(POL; Rec."Entry Point")
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

//             }

//         }
//     }
// }
