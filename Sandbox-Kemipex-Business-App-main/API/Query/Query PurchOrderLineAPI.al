// query 53034 PurchOrderLineWebAPI//T12370-Full Comment
// {
//     QueryType = Normal;

//     Caption = 'BI Purchase order Line';
//     elements
//     {
//         dataitem(Purchase_Line; "Purchase Line")
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
//             column(Unit_of_Measure; "Unit of Measure") { }
//             column(Quantity; Quantity) { }
//             column(Unit_Cost; "Unit Cost") { }
//             //column(Unit_Cost__LCY_; "Unit Cost (LCY)") { }
//             column(Line_Discount_Amount; "Line Discount Amount") { }
//             column(Amount; Amount) { }
//             column(Amount_Including_VAT; "Amount Including VAT") { }
//             column(Line_Amount; "Line Amount") { }
//             //column(Line_Discount__; "Line Discount %") { }
//             //column(Gen__Prod__Posting_Group; "Gen. Prod. Posting Group") { }
//             //column(Gen__Bus__Posting_Group; "Gen. Bus. Posting Group") { }
//             column(Gross_Weight; "Gross Weight") { }
//             column(Net_Weight; "Net Weight") { }
//             //column(Item_Category_Code; "Item Category Code") { }
//             column(VAT__; "VAT %") { }
//             column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
//             column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code") { }

//             // Added by bayas

//             column(Currency_Code; "Currency Code") { }
//             column(Qty__Received__Base_; "Qty. Received (Base)") { }
//             column(Quantity_Received; "Quantity Received") { }
//             column(Qty__Invoiced__Base_; "Qty. Invoiced (Base)") { }
//             column(Quantity_Invoiced; "Quantity Invoiced") { }

//             column(Prepayment__; "Prepayment %") { }
//             column(Prepmt__Line_Amount; "Prepmt. Line Amount") { }
//             column(CustomR_ETD; CustomR_ETD) { }
//             column(CustomR_ETA; CustomR_ETA) { }
//             column(Sales_Order_No_; "Sales Order No.") { }
//             column(Sales_Order_Line_No_; "Sales Order Line No.") { }
//             column(Salesperson_Code; "Salesperson Code") { }
//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnBeforeOpen()
//     begin

//     end;
// }