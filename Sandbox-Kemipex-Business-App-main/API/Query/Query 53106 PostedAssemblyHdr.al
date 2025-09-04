// query 53106 PostedAssemblyHdr//T12370-Full Comment
// {
//     Caption = 'Posted Assembly Header';
//     QueryType = Normal;

//     elements
//     {
//         dataitem(PostedAssemblyHeader; "Posted Assembly Header")
//         {
//             column(No; "No.")
//             {
//             }
//             column(ItemNo; "Item No.")
//             {
//             }
//             column(LocationCode; "Location Code")
//             {
//             }
//             column(AssembletoOrder; "Assemble to Order")
//             {
//             }
//             column(BinCode; "Bin Code")
//             {
//             }
//             column(BlanketAssemblyOrderNo; "Blanket Assembly Order No.")
//             {
//             }
//             column(Comment; Comment)
//             {
//             }
//             column(CostAmount; "Cost Amount")
//             {
//             }
//             column(Description; Description)
//             {
//             }
//             column(Description2; "Description 2")
//             {
//             }
//             column(DueDate; "Due Date")
//             {
//             }
//             column(DimensionSetID; "Dimension Set ID")
//             {
//             }
//             column(EndingDate; "Ending Date")
//             {
//             }
//             column(GenProdPostingGroup; "Gen. Prod. Posting Group")
//             {
//             }
//             column(IndirectCost; "Indirect Cost %")
//             {
//             }
//             column(InventoryPostingGroup; "Inventory Posting Group")
//             {
//             }
//             column(ItemRcptEntryNo; "Item Rcpt. Entry No.")
//             {
//             }
//             column(OrderNo; "Order No.")
//             {
//             }
//             column(OverheadRate; "Overhead Rate")
//             {
//             }
//             column(PostingDate; "Posting Date")
//             {
//             }
//             column(QtyperUnitofMeasure; "Qty. per Unit of Measure")
//             {
//             }
//             column(Quantity; Quantity)
//             {
//             }
//             column(QuantityBase; "Quantity (Base)")
//             {
//             }
//             column(Reversed; Reversed)
//             {
//             }
//             column(SearchDescription; "Search Description")
//             {
//             }
//             column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
//             {
//             }
//             column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
//             {
//             }
//             column(SourceCode; "Source Code")
//             {
//             }
//             column(StartingDate; "Starting Date")
//             {
//             }
//             column(UnitCost; "Unit Cost")
//             {
//             }
//             column(UserID; "User ID")
//             {
//             }
//             column(VariantCode; "Variant Code")
//             {
//             }
//             column(UnitofMeasureCode; "Unit of Measure Code")
//             {
//             }
//             dataitem(Item_Ledger_Entry; "Item Ledger Entry")
//             {
//                 DataItemTableFilter = "Source Type" = const(Item), "Entry Type" = const("Assembly Output");
//                 DataItemLink = "Document No." = PostedAssemblyHeader."No.", "Source No." = PostedAssemblyHeader."Item No.", "Item No." = PostedAssemblyHeader."Item No.";
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

//     trigger OnBeforeOpen()
//     begin

//     end;
// }
