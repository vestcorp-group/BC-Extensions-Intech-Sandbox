// query 53032 SalesOrderLineWebAPI//T12370-Full Comment
// {
//     QueryType = Normal;

//     Caption = 'BI Sales Order Line';

//     elements
//     {
//         dataitem(Sales_Line; "Sales Line")
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
//             column(Unit_of_Measure; "Unit of Measure") { }
//             column(Quantity; Quantity) { }
//             column(Unit_Price; "Unit Price") { }
//             //       column(Unit_Cost__LCY_; "Unit Cost (LCY)") { }
//             column(Line_Discount_Amount; "Line Discount Amount") { }
//             column(Amount; Amount) { }
//             column(Amount_Including_VAT; "Amount Including VAT") { }
//             column(Line_Amount; "Line Amount") { }
//             //     column(Line_Discount__; "Line Discount %") { }
//             //   column(Gen__Prod__Posting_Group; "Gen. Prod. Posting Group") { }
//             //   column(Gen__Bus__Posting_Group; "Gen. Bus. Posting Group") { }
//             column(Gross_Weight; "Gross Weight") { }
//             column(Net_Weight; "Net Weight") { }
//             //   column(Item_Category_Code; "Item Category Code") { }
//             column(VAT__; "VAT %") { }
//             column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
//             column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code") { }
//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnBeforeOpen()
//     begin

//     end;
// }