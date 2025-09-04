// query 53102 SalesShipmentLine//T12370-Full Comment
// {
//     QueryType = Normal;

//     Caption = 'Sales Shipment Line';

//     elements
//     {
//         dataitem(Sales_Shipment_Line; "Sales Shipment Line")
//         {
//             column(Document_No_; "Document No.")
//             {

//             }
//             column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
//             column(Type; Type) { }
//             column(No_; "No.") { }
//             column(Description; Description) { }
//             column(Description_2; "Description 2") { }
//             column(Location_Code; "Location Code") { }
//             column(Unit_of_Measure; "Unit of Measure Code") { }
//             column(Quantity; Quantity) { }
//             column(Unit_Price; "Unit Price") { }
//             //            column(Unit_Cost__LCY_; "Unit Cost (LCY)") { }
//             //          column(Unit_Cost; "Unit Cost") { }
//             //column(Line_Discount_Amount; "Line Discount Amount") { }
//             //column(Amount; Amount) { }
//             //column(Amount_Including_VAT; "Amount Including VAT") { }
//             //column(Line_Amount; "Line Amount") { }
//             //        column(Line_Discount__; "Line Discount %") { }
//             //      column(Gen__Prod__Posting_Group; "Gen. Prod. Posting Group") { }
//             //    column(Gen__Bus__Posting_Group; "Gen. Bus. Posting Group") { }
//             column(Gross_Weight; "Gross Weight") { }
//             column(Net_Weight; "Net Weight") { }
//             //    column(Item_Category_Code; "Item Category Code") { }
//             //  column(VAT__; "VAT %") { }
//             column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
//             column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code") { }
//             column(ItemGenericName; "Item Generic Name")
//             {
//             }
//             dataitem(Item_Ledger_Entry; "Item Ledger Entry")
//             {
//                 DataItemTableFilter = "Source Type" = const(Customer), "Entry Type" = const(Sale);
//                 DataItemLink = "Document No." = Sales_Shipment_Line."Document No.", "Source No." = Sales_Shipment_Line."Sell-to Customer No.", "Item No." = Sales_Shipment_Line."No.";
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