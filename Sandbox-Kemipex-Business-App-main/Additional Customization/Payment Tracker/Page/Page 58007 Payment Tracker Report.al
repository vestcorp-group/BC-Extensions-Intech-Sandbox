// page 58007 "Payment Tracker Report"//T12370-Full Comment
// {
//     //ApplicationArea = All;
//     Caption = 'Payment Tracker Report';
//     PageType = List;
//     SourceTable = "Payment Tracker Report";
//     Editable = false;
//     // UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Entry No."; Rec."Entry No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Entry No. field.';
//                 }
//                 field("Comp."; Rec."Comp.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Comp. field.';
//                 }
//                 field("Order Date"; Rec."Order Date")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Order Date field.';
//                 }
//                 field("PO No."; Rec."PO No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the PO No. field.';
//                 }
//                 field("Blanket Order No."; Rec."Blanket Order No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Blanket Order No. field.';
//                 }
//                 field("Vendor No."; Rec."Vendor No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Vendor No. field.';
//                 }
//                 field("Vendor Name"; Rec."Vendor Name")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Vendor Name field.';
//                 }
//                 field("Item No."; Rec."Item No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Item No. field.';
//                 }
//                 field("Item Description"; Rec."Item Description")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Item Description field.';
//                 }
//                 field("Vendor Item Name"; Rec."Vendor Item Name")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Vendor Item Name field.';
//                 }
//                 field(Warehouse; Rec.Warehouse)
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Warehouse field.';
//                 }
//                 field(Incoterm; Rec.Incoterm)
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Incoterm field.';
//                 }
//                 field("POL Description"; Rec."POL Description")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the POL Description field.';
//                 }
//                 field("POD Description"; Rec."POD Description")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the POD Description field.';
//                 }
//                 field("Base UOM"; Rec."Base UOM")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Base UOM field.';
//                 }
//                 field("Base UOM Qty."; Rec."Base UOM Qty.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Base UOM Qty. field.';
//                 }
//                 field("Qty. Invoiced"; Rec."Qty. Invoiced")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Qty. Invoiced field.';
//                 }
//                 field("GRN Quantity"; Rec."GRN Quantity")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the GRN Quantity field.';
//                 }
//                 field("GRN Date"; Rec."GRN Date")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the GRN Date field.';
//                 }
//                 field("Invoice Currency"; Rec."Invoice Currency")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Invoice Currency field.';
//                 }
//                 field("Unit Price"; Rec."Unit Price")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Unit Price field.';
//                 }
//                 field("Invoice Value (with VAT)"; Rec."Invoice Value (with VAT)")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Invoice Value (with VAT) field.';
//                 }
//                 field("Amount Payable (with VAT)"; Rec."Amount Payable (with VAT)")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Amount Payable (with VAT) field.';
//                 }
//                 field("Amount Payable  (in AED)"; Rec."Amount Payable  (in AED)")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Amount Payable  (in AED) field.';
//                 }
//                 field("Payment Term"; Rec."Payment Term")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Payment Term field.';
//                 }
//                 field("Prepayment %"; Rec."Prepayment %")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Prepayment % field.';
//                 }
//                 field("Prepayment Value"; Rec."Prepayment Value")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Prepayment Value field.';
//                 }
//                 field("Due Date"; Rec."Due Date")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Due Date field.';
//                 }
//                 field("Posted Purchase Invoice Date"; Rec."Posted Purchase Invoice Date")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Posted Purchase Invoice Date field.';
//                 }
//                 field("Posted Purchase Invoice Value"; Rec."Posted Purchase Invoice Value")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Posted Purchase Invoice Value field.';
//                 }
//                 field("Posted Purch. Credit Memo Date"; Rec."Posted Purch. Credit Memo Date")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Posted Purch. Credit Memo Date field.';
//                 }
//                 field("Posted Purch. Cred. Memo Value"; Rec."Posted Purch. Cred. Memo Value")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Posted Purch. Cred. Memo Value field.';
//                 }
//                 field("Balance payment"; Rec."Balance payment")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Balance payment field.';
//                 }
//                 field(ETD; Rec.ETD)
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the ETD field.';
//                 }
//                 field(ETA; Rec.ETA)
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the ETA field.';
//                 }
//                 field("R-ETD"; Rec."R-ETD")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the R-ETD field.';
//                 }
//                 field("R-ETA"; Rec."R-ETA")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the R-ETA field.';
//                 }
//                 field("BSO No"; Rec."BSO No")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the BSO No field.';
//                 }
//                 field("SO No"; Rec."SO No")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the SO No field.';
//                 }
//                 field("Sales Person"; Rec."Sales Person")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Sales Person field.';
//                 }
//                 field(Customer; Rec.Customer)
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Customer field.';
//                 }

//             }
//         }
//     }
// }
