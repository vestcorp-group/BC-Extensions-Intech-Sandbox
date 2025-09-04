// tableextension 58121 WHBasicCue extends "Warehouse Basic Cue"//T12370-Full Comment
// {
//     fields
//     {
//         field(58013; OpenSalesInvoice; Integer)
//         {
//             FieldClass = FlowField;
//             CalcFormula = count("Sales Header" where("Document Type" = filter(Invoice), "Payment Terms Code" = filter('<>FOC SAMPLE')));
//         }
//         field(58014; PendingTO; Integer)
//         {
//             FieldClass = FlowField;
//             CalcFormula = count("Transfer Header");
//         }
//         field(58015; TransferShipToday; Integer)
//         {
//             FieldClass = FlowField;
//             CalcFormula = count("Transfer Shipment Header" where("Posting Date" = filter('Workdate')));
//         }
//         field(58016; "Blanket Sales Orders"; Integer)
//         {
//             FieldClass = FlowField;
//             CalcFormula = count("Sales Header" where("Document Type" = filter("Blanket Order"), "Payment Terms Code" = filter('<>FOC SAMPLE')));
//         }
//         field(58017; "Blanket Purchase Orders"; Integer)
//         {
//             FieldClass = FlowField;
//             CalcFormula = count("Purchase Header" where("Document Type" = filter("Blanket Order")));
//         }
//         field(58019; "Released Sales Orders"; Integer)
//         {
//             FieldClass = FlowField;
//             CalcFormula = count("Sales Header" where("Document Type" = filter(Order), "Payment Terms Code" = filter('<>FOC SAMPLE'), Status = filter(Released), "Sell-to IC Partner Code" = filter('')));
//         }
//         field(58025; "Bill of Exit Pending SI"; Integer)
//         {
//             FieldClass = FlowField;
//             CalcFormula = count("Sales Invoice Header" where(BillOfExit = filter(''), "Payment Terms Code" = filter('<>FOC SAMPLE')));
//         }
//         field(58045; "Released Purchase Orders"; Integer)
//         {
//             FieldClass = FlowField;
//             CalcFormula = count("Purchase Header" where("Document Type" = filter("Order"), Status = filter(Released), "Buy-from IC Partner Code" = filter('')));
//         }
//         field(58046; "Intercompany Purchase Orders"; Integer)
//         {
//             FieldClass = FlowField;
//             CalcFormula = count("Purchase Header" where("Document Type" = filter("Order"), "Buy-from IC Partner Code" = filter(<> '')));
//         }
//         field(58047; "Intercompany Sales Orders"; Integer)
//         {
//             FieldClass = FlowField;
//             CalcFormula = count("Sales Header" where("Document Type" = filter(Order), "Sell-to IC Partner Code" = filter(<> '')));
//         }
//     }
//     var
//         X: Text;
// }