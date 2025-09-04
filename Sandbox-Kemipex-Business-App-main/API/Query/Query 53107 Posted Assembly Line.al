// query 53107 "Posted Assembly Line"//T12370-Full Comment
// {
//     Caption = 'Posted Assembly Line';
//     QueryType = Normal;

//     elements
//     {
//         dataitem(PostedAssemblyLine; "Posted Assembly Line")
//         {
//             column(No; "No.")
//             {
//             }
//             column(DocumentNo; "Document No.")
//             {
//             }
//             column(LineNo; "Line No.")
//             {
//             }
//             column(OrderLineNo; "Order Line No.")
//             {
//             }
//             column(LocationCode; "Location Code")
//             {
//             }
//             column(OrderNo; "Order No.")
//             {
//             }
//             column(BinCode; "Bin Code")
//             {
//             }
//             column(BlanketAssOrderLineNo; "Blanket Ass. Order Line No.")
//             {
//             }
//             column(BlanketAssemblyOrderNo; "Blanket Assembly Order No.")
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
//             column(DimensionSetID; "Dimension Set ID")
//             {
//             }
//             column(DueDate; "Due Date")
//             {
//             }
//             column(GenProdPostingGroup; "Gen. Prod. Posting Group")
//             {
//             }
//             column(InventoryPostingGroup; "Inventory Posting Group")
//             {
//             }
//             column(Position; Position)
//             {
//             }
//             column(Position2; "Position 2")
//             {
//             }
//             column(Position3; "Position 3")
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
//             column(Quantityper; "Quantity per")
//             {
//             }
//             column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
//             {
//             }
//             column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
//             {
//             }
//             column("Type"; "Type")
//             {
//             }
//             column(UnitCost; "Unit Cost")
//             {
//             }
//             column(UnitofMeasureCode; "Unit of Measure Code")
//             {
//             }
//             column(VariantCode; "Variant Code")
//             {
//             }
//             column(ResourceUsageType; "Resource Usage Type")
//             {
//             }
//             column(LeadTimeOffset; "Lead-Time Offset")
//             {
//             }
//             column(ItemShptEntryNo; "Item Shpt. Entry No.")
//             {
//             }
//             dataitem(Item_Ledger_Entry; "Item Ledger Entry")
//             {
//                 DataItemTableFilter = "Source Type" = const(Item), "Entry Type" = const("Assembly Consumption");
//                 DataItemLink = "Document No." = PostedAssemblyLine."Document No.", "Source No." = PostedAssemblyLine."No.";
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
