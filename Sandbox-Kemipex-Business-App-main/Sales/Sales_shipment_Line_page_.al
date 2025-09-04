// pageextension 58067 Sales_shipment_line extends "Sales Shipment Lines"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("Document No.")
//         {
//             field("Order No."; rec."Order No.")
//             {
//                 ApplicationArea = all;
//             }
//             field(Sales_invoice_No; Sales_invoice_No)
//             {
//                 Caption = 'Sales Invoice No.';
//                 ApplicationArea = all;
//                 Enabled = true;
//             }
//         }
//         addafter("Location Code")
//         {
//             field("Base UOM"; rec."Base UOM 2") //PackingListExtChange
//             {
//                 ApplicationArea = all;
//             }
//             field("Quantity (Base)"; rec."Quantity (Base)")
//             {
//                 ApplicationArea = all;
//             }
//             field("Qty. Invoiced (Base)"; rec."Qty. Invoiced (Base)")
//             {
//                 ApplicationArea = all;
//             }
//             field("Transaction Type"; rec."Transaction Type")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Order Type';
//             }
//             field("Container Size"; rec."Container Size")
//             {
//                 ApplicationArea = All;
//             }
//             field("Shipping Remarks"; rec."Shipping Remarks")
//             {
//                 ApplicationArea = All;
//             }
//             field("In-Out Instruction"; rec."In-Out Instruction")
//             {
//                 ApplicationArea = All;
//             }
//             field("Shipping Line"; rec."Shipping Line")
//             {
//                 ApplicationArea = All;
//             }
//             field("BL-AWB No."; rec."BL-AWB No.")
//             {
//                 ApplicationArea = All;
//             }
//             field("Vessel-Voyage No."; rec."Vessel-Voyage No.")
//             {
//                 ApplicationArea = all;
//             }
//             field("Freight Forwarder"; rec."Freight Forwarder")
//             {
//                 ApplicationArea = all;
//             }
//             field("Freight Charge"; rec."Freight Charge")
//             {
//                 ApplicationArea = all;
//             }
//         }
//         moveafter("Unit of Measure Code"; Quantity)
//     }
//     var
//         Sales_invoice_No: Code[20];

//     trigger OnAfterGetRecord()
//     var
//         Sales_invoice_line: Record "Sales Invoice Line";
//     begin
//         Clear(Sales_invoice_No);
//         Sales_invoice_line.SetRange("Shipment No.", rec."Document No.");
//         Sales_invoice_line.SetRange("Shipment Line No.", rec."Line No.");
//         if Sales_invoice_line.FindSet() then
//             Sales_invoice_No := Sales_invoice_line."Document No.";
//     end;
// }