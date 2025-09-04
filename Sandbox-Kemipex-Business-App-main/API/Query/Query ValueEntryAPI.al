// query 53008 ValueEntryAPI//T12370-Full Comment
// {
//     QueryType = Normal;

//     Caption = 'BI Value Entry';

//     elements
//     {
//         dataitem(Value_Entry; "Value Entry")
//         {
//             column(EntryNo_; "Entry No.")
//             {

//             }
//             column(Item_No_; "Item No.") { }
//             column(Posting_Date; "Posting Date") { }
//             column(Item_Ledger_Entry_Type; "Item Ledger Entry Type") { }
//             column(Source_No_; "Source No.") { }
//             column(Document_No_; "Document No.") { }
//             column(Description; Description) { }
//             column(Location_Code; "Location Code") { }
//             column(Inventory_Posting_Group; "Inventory Posting Group") { }
//             column(Item_Ledger_Entry_No_; "Item Ledger Entry No.") { }
//             column(Valued_Quantity; "Valued Quantity") { }
//             column(Item_Ledger_Entry_Quantity; "Item Ledger Entry Quantity") { }
//             column(Invoiced_Quantity; "Invoiced Quantity") { }
//             column(Cost_per_Unit; "Cost per Unit") { }
//             column(Sales_Amount__Actual_; "Sales Amount (Actual)") { }
//             column(Salespers__Purch__Code; "Salespers./Purch. Code") { }
//             column(Cost_Amount__Actual_; "Cost Amount (Actual)") { }
//             column(Cost_Amount__Non_Invtbl__; "Cost Amount (Non-Invtbl.)") { }
//             column(Entry_Type; "Entry Type") { }
//             column(Document_Type; "Document Type") { }
//             column(Document_Line_No_; "Document Line No.") { }
//             column(Item_Charge_No_; "Item Charge No.") { }
//             filter(Entry_No_; "Entry No.")
//             {

//             }
//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnBeforeOpen()
//     begin
//         /* if Entry_No_<>0 then
//             Setfilter(EntryNo_,'%1',Entry_No_); */
//     end;
// }