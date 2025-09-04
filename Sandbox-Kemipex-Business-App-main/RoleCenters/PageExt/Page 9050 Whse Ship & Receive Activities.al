// pageextension 58122 logisitcsactivities extends "Whse Ship & Receive Activities"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("Inbound - Today")
//         {
//             cuegroup(Inventory)
//             {
//                 field(PendingTO; rec.PendingTO)
//                 {
//                     Caption = 'Pending Transfer Orders';
//                     ApplicationArea = all;
//                     DrillDownPageId = "Transfer Orders";
//                 }
//                 field(TransferShipToday; rec.TransferShipToday)
//                 {
//                     Caption = 'Posted Transfer Shipments Today';
//                     ApplicationArea = all;
//                     DrillDownPageId = "Posted Transfer Shipments";
//                 }
//             }
//             cuegroup(Intercompany)
//             {
//                 field("Intercompany Purchase Orders"; rec."Intercompany Purchase Orders")
//                 {
//                     Caption = 'Intercompany Purchase Orders';
//                     ApplicationArea = all;
//                     DrillDownPageId = "Purchase Order List";
//                 }
//                 field("Intercompany Sales Orders"; rec."Intercompany Sales Orders")
//                 {
//                     Caption = 'Intercompany Sales Orders';
//                     ApplicationArea = all;
//                     DrillDownPageId = "Sales Order List";
//                 }
//             }
//         }
//         modify(Internal)
//         {
//             Visible = false;
//         }
//         modify("Rlsd. Sales Orders Until Today")
//         {
//             Visible = false;
//         }
//         modify("Open Phys. Invt. Orders")
//         {
//             Visible = false;
//         }
//         modify("Invt. Picks Until Today")
//         {
//             Visible = false;
//         }
//         modify("Invt. Put-aways Until Today")
//         {
//             Visible = false;
//         }
//         modify("Exp. Purch. Orders Until Today")
//         {
//             Visible = false;
//         }
//         addafter("Posted Sales Shipments - Today")
//         {
//             field(OpenSalesInvoice; rec.OpenSalesInvoice)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Pending Sales Invoices';
//                 DrillDownPageId = "Sales Invoice List";
//                 Style = Favorable;
//             }
//             field("Bill of Exit Pending SI"; rec."Bill of Exit Pending SI")
//             {
//                 Caption = 'Declaration Pending Invoices';
//                 ApplicationArea = all;
//                 DrillDownPageId = "Posted Sales Invoices";
//                 StyleExpr = Style_E;
//                 Style = Favorable;
//             }
//         }
//         addbefore("Rlsd. Sales Orders Until Today")
//         {
//             field("Blanket Sales Orders"; rec."Blanket Sales Orders")
//             {
//                 ApplicationArea = all;
//                 DrillDownPageId = "Blanket Sales Orders";
//             }
//             field("Released Sales orders"; rec."Released Sales orders")
//             {
//                 ApplicationArea = all;
//                 DrillDownPageId = "Sales Order List";
//             }
//         }
//         addbefore("Exp. Purch. Orders Until Today")
//         {
//             field("Blanket Purchase Orders"; rec."Blanket Purchase Orders")
//             {
//                 Caption = 'Blanket Purchase Orders';
//                 ApplicationArea = all;
//                 DrillDownPageId = "Blanket Purchase Orders";
//             }
//             field("Released Purchase Orders"; rec."Released Purchase Orders")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Released Purchase Orders';
//                 DrillDownPageId = "Purchase Order List";
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     var
//         companies: Record Company;
//         cust_led: Record "Cust. Ledger Entry";
//         cust_array: array[10] of Decimal;
//     begin
//         if Rec."Bill of Exit Pending SI" <> 0 then
//             Style_E := 'attention' else
//             Style_E := 'strongaccent';
//     end;

//     var
//         Total_Sales: Decimal;
//         Style_E: Text;
// }