// query 53100 PurchaseRcptines//T12370-Full Comment
// {
//     QueryType = Normal;

//     Caption = 'Purchase Receipt Lines';

//     elements
//     {
//         dataitem(Purch__Rcpt__Line; "Purch. Rcpt. Line")
//         {
//             column(Document_No_; "Document No.")
//             {

//             }
//             column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
//             column(Type; Type) { }
//             column(No_; "No.") { }
//             column(Description; Description) { }
//             column(Description_2; "Description 2") { }
//             column(Location_Code; "Location Code") { }
//             column(Unit_of_Measure; "Unit of Measure Code") { }
//             column(Quantity; Quantity) { }
//             column(Gross_Weight; "Gross Weight") { }
//             column(Net_Weight; "Net Weight") { }
//             column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
//             column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code") { }
//             dataitem(Item_Ledger_Entry; "Item Ledger Entry")
//             {
//                 DataItemTableFilter = "Source Type" = const(Vendor), "Entry Type" = const(Purchase);
//                 DataItemLink = "Document No." = Purch__Rcpt__Line."Document No.", "Source No." = Purch__Rcpt__Line."Buy-from Vendor No.", "Item No." = Purch__Rcpt__Line."No.";
//                 column(Serial_No_; "Serial No.")
//                 {

//                 }
//                 column(SupplierBatchNo2; "Supplier Batch No. 2")
//                 {
//                 }
//                 column(LotNo; "Lot No.")
//                 {
//                 }
//                 column(CustomBOENumber; CustomBOENumber)
//                 {
//                 }
//                 column(CustomLotNumber; CustomLotNumber)
//                 {
//                 }
//                 column(CustomBOENumber2; CustomBOENumber2)
//                 {
//                 }
//                 column(Tracking_Quantity; Quantity)
//                 {
//                 }
//                 column(WarrantyDate; "Warranty Date")
//                 {
//                 }
//                 column(AnalysisDate; "Analysis Date")
//                 {
//                 }
//                 column(OfSpec; "Of Spec")
//                 {
//                 }
//                 column(ExpirationDate; "Expiration Date")
//                 {
//                 }
//                 column(Manufacturing_Date_2; "Manufacturing Date 2")
//                 {

//                 }
//                 column(Expiry_Period_2; "Expiry Period 2")
//                 {

//                 }

//             }
//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnBeforeOpen()
//     begin

//     end;
// }